import { Request, Response } from "express";
import path from "path";
import * as fs from "fs";
import prisma from "../../../database";
import { SubscriptionService } from "../services/subscription.service";

export class FileController {
    // GET /files/public/:filename
    async AccessPublicFile(req: Request, res: Response): Promise<Response | void> {
        const { filename } = req.params;

        // intentional
        const filePath = path.join(process.cwd(), "files", "public", filename);

        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ error: "File not found" });
        }

        res.sendFile(filePath, { headers: { "X-Content-Type-Options": "nosniff" } });
    }

    // GET /files/private  (signed URL – no JWT needed)
    async AccessProtectedFile(req: Request, res: Response): Promise<Response | void> {
        const { token } = req.params;

        const tokenRecord = await prisma.fileToken.findUnique({
            where: { token },
            include: { Material_File: true },
        });

        if (!tokenRecord || tokenRecord.expireAt < new Date()) {
            return res.status(404).json({ error: "Link expired or invalid" });
        }

        const absolutePath = path.join(process.cwd(), tokenRecord.Material_File.path);
        if (!fs.existsSync(absolutePath)) {
            return res.status(404).json({ error: "File missing" });
        }

        res.sendFile(absolutePath, {
            headers: { "X-Content-Type-Options": "nosniff" },
        });
    }

    async DownloadFile(req: Request, res: Response): Promise<Response | void> {
        if (!req.user) {
            return res.status(401).json({ error: "Unauthorized" });
        }

        const { path: relativePath } = req.body;
        if (!relativePath || typeof relativePath !== "string") {
            return res.status(400).json({ error: "Invalid path" });
        }

        const normalized = path.normalize(relativePath);
        if (normalized.includes("..") || !normalized.startsWith("files/protected/")) {
            return res.status(400).json({ error: "Invalid path" });
        }

        const absolutePath = path.join(process.cwd(), normalized);
        if (!fs.existsSync(absolutePath)) {
            return res.status(404).json({ error: "File not found" });
        }

        const filename = path.basename(absolutePath);
        res.setHeader("Content-Disposition", `attachment; filename="${filename}"`);
        res.sendFile(absolutePath);
    }

    // GET /files/material/:materialId/:fileType
    // Protected endpoint for Material files (video_path, materialFilePath, ringkasanPath, templatePath)
    // Requires authentication + subscription verification
    async AccessMaterialFile(req: Request, res: Response): Promise<Response | void> {
        try {
            const userId = req.user?.id;
            if (!userId) {
                return res.status(401).json({ error: "Unauthorized" });
            }

            const { materialId, fileType } = req.params;

            // Validate fileType
            const validFileTypes = ["video", "material", "ringkasan", "template"];
            if (!validFileTypes.includes(fileType)) {
                return res.status(400).json({ error: "Invalid file type" });
            }

            // Get material from database
            const material = await prisma.material.findUnique({
                where: { id: parseInt(materialId) },
                include: {
                    Section: {
                        include: {
                            Class: {
                                include: {
                                    User_Class: {
                                        where: { userId }
                                    }
                                }
                            }
                        }
                    }
                }
            });

            if (!material) {
                return res.status(404).json({ error: "Material not found" });
            }

            // Check if user is enrolled in the class
            const isEnrolled = material.Section.Class.User_Class.length > 0;
            if (!isEnrolled) {
                return res.status(403).json({ error: "Not enrolled in this class" });
            }

            // Verify subscription (bypass for Teacher/Admin)
            const canBypass = await SubscriptionService.canBypassSubscription(userId);
            if (!canBypass) {
                const isActive = await SubscriptionService.isSubscriptionActive(userId);
                if (!isActive) {
                    return res.status(402).json({ error: "Active subscription required" });
                }
            }

            // Map fileType to Material field
            const filePathMap: Record<string, string> = {
                video: material.video_path,
                material: material.materialFilePath,
                ringkasan: material.ringkasanPath,
                template: material.templatePath
            };

            const relativePath = filePathMap[fileType];
            if (!relativePath) {
                return res.status(404).json({ error: "File path not configured" });
            }

            // Validate path to prevent directory traversal
            const normalized = path.normalize(relativePath);
            if (normalized.includes("..")) {
                return res.status(400).json({ error: "Invalid file path" });
            }

            const absolutePath = path.join(process.cwd(), normalized);
            if (!fs.existsSync(absolutePath)) {
                return res.status(404).json({ error: "File not found on server" });
            }

            // Send file with appropriate headers
            res.sendFile(absolutePath, {
                headers: {
                    "X-Content-Type-Options": "nosniff",
                    "Cache-Control": "private, max-age=3600"
                }
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Server error";
            return res.status(500).json({ error: message });
        }
    }
}

export default new FileController();
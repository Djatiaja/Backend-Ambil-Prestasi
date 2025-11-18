import { Request, Response } from "express";
import path from "path";
import * as fs from "fs";
import prisma from "../../../database";
import { SubscriptionService } from "../services/subscription.service";
import { verifyFileToken } from "../helpers/fileToken";

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

    // GET /files/protected/:token - JWT-based file access
    async AccessProtectedFile(req: Request, res: Response): Promise<Response | void> {
        const { token } = req.params;

        // Verify JWT token
        let decoded;
        try {
            decoded = verifyFileToken(token);
        } catch (error) {
            return res.status(401).json({
                error: error instanceof Error ? error.message : "Invalid token"
            });
        }

        // Extract file path from token
        const filePath = decoded.path;

        // Security check: ensure path doesn't contain directory traversal
        if (filePath.includes("..")) {
            return res.status(403).json({ error: "Invalid file path" });
        }

        // Security check: ensure path is within protected directory
        if (!filePath.startsWith("files/protected/")) {
            return res.status(403).json({ error: "Access denied" });
        }

        // Construct absolute file path
        const absolutePath = path.join(process.cwd(), filePath);

        // Check if file exists
        if (!fs.existsSync(absolutePath)) {
            return res.status(404).json({ error: "File not found" });
        }

        // Stream the file with security headers
        res.sendFile(absolutePath, { headers: { "X-Content-Type-Options": "nosniff" } });
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


}

export default new FileController();
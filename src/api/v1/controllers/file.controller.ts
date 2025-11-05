import { Request, Response } from "express";
import path from "path";
import * as fs from "fs";
import prisma from "../../../database";

export class FileController {
    // GET /files/public/:filename
    async AccessPublicFile(req: Request, res: Response) {
        const { filename } = req.params;

        // intentional
        const filePath = path.join(process.cwd(), "files", "public", filename);

        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ error: "File not found" });
        }

        res.sendFile(filePath, { headers: { "X-Content-Type-Options": "nosniff" } });
    }

    // GET /files/private/:token  (signed URL – no JWT needed)
    async AccessProtectedFile(req: Request, res: Response) {
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

    async DownloadFile(req: Request, res: Response) {
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
import fs from "fs";
import path from "path";
import { randomUUID as uuidv4 } from "crypto";


export function saveFile(
    file: Express.Multer.File,
    isProtected: boolean = false
): string {
    const uploadDir = path.join(
        process.cwd(),
        "files",
        isProtected ? "protected" : "public"
    );

    fs.mkdirSync(uploadDir, { recursive: true });

    const ext = path.extname(file.originalname);
    const baseName = path.basename(file.originalname, ext);
    const timestamp = new Date()
        .toISOString()
        .replace(/[:.]/g, "-");
    const uniqueName = `${baseName}-${timestamp}-${uuidv4()}${ext}`;
    const uploadPath = path.join(uploadDir, uniqueName);

    fs.writeFileSync(uploadPath, file.buffer);
    return path.relative(process.cwd(), uploadPath);
}

export function deleteFile(filePath: string): string {
    try {
        const absolutePath = path.resolve(filePath);
        if (fs.existsSync(absolutePath)) {
            fs.unlinkSync(absolutePath);
            console.log(`🗑️ File deleted: ${absolutePath}`);
            return `File deleted: ${absolutePath}`;
        } else {
            console.warn(`⚠️ File not found: ${absolutePath}`);
            return `File not found: ${absolutePath}`;
        }
    } catch (error) {
        console.error(`❌ Error deleting file:`, error);
        return `Error deleting file: ${error}`;
    }
}

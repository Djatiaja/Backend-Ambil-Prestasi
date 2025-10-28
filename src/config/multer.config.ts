import multer from "multer";

// ✅ Konfigurasi multer dengan memory storage
const storage = multer.memoryStorage();

const fileFilter = (req: Express.Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
    const allowedTypes = [
        "application/pdf",
        "image/jpeg",
        "image/png",
        "image/webp",
        "video/mp4",
        "video/webm",
        "video/quicktime",
    ];
    if (allowedTypes.includes(file.mimetype)) {
        cb(null, true);
    } else {
        cb(new Error("Invalid file type. Only PDF, JPEG, and PNG are allowed."));
    }
};

// ✅ Batas ukuran file (contoh: 500 MB)
const limits = {
    fileSize: 500 * 1024 * 1024, // 500 MB
};

// ✅ Export konfigurasi multer
const upload = multer({ storage, fileFilter, limits });

export default upload;
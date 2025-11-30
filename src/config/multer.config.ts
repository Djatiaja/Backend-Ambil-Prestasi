import multer from "multer";

const storage = multer.memoryStorage();

// ✅ Batas ukuran file (contoh: 1024 MB)
const limits = {
    fileSize: 1024 * 1024 * 1024, // 1024 MB
};

// ✅ Export konfigurasi multer
const upload = multer({ storage, limits });

export default upload;
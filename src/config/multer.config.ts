import multer from "multer";

const storage = multer.memoryStorage();

// ✅ Batas ukuran file (contoh: 500 MB)
const limits = {
    fileSize: 500 * 1024 * 1024, // 500 MB
};

// ✅ Export konfigurasi multer
const upload = multer({ storage, limits });

export default upload;
import { z } from "zod";

export const imageSchema = z
    .custom<Express.Multer.File>()
    .refine((file) => !!file, {
        message: "File harus disertakan.",
    })
    .refine(
        (file) =>
            !!file && ["image/jpeg", "image/png", "image/webp"].includes(file.mimetype),
        {
            message: "Format file tidak valid. Gunakan JPEG, PNG, atau WEBP.",
        }
    )
    .refine((file) => !!file && file.size <= 5 * 1024 * 1024, {
        message: "Ukuran file maksimal 5MB.",
    });

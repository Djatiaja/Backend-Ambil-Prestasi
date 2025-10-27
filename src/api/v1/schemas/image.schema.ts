import z from "zod";

export const imageSchema = z.object({
    file: z
        .any()
        .refine((file) => !!file, "File harus disertakan.")
        .refine((file) => ["image/jpeg", "image/png", "image/webp"].includes(file.mimetype), {
            message: "Format file tidak valid. Gunakan JPEG, PNG, atau WEBP.",
        })
        .refine((file) => file.size <= 5 * 1024 * 1024, {
            message: "Ukuran file maksimal 5MB.",
        }),
});


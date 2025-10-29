import { z } from "zod";

export const pdfSchema = z.any()
    .refine((file) => !!file, "File harus disertakan.")
    .refine((file) => ["application/pdf"].includes(file.mimetype), {
        message: "Format file tidak valid. Gunakan PDF.",
    })
    .refine((file) => file.size <= 100 * 1024 * 1024, {
        message: "Ukuran file maksimal 100MB.",
    });


export const createMaterialFileSchema = z.object({
    title: z.string().min(3, "Judul minimal 3 karakter."),
    file: pdfSchema
});

export const updateMaterialFileSchema = createMaterialFileSchema.partial();
export type CreateMaterialFileDto = z.infer<typeof createMaterialFileSchema>;
export type UpdateMaterialFileDto = z.infer<typeof updateMaterialFileSchema>;
import { z } from "zod";

export const materialFileSchema = z
    .custom<Express.Multer.File>()
    .refine((file) => !!file, {
        message: "File harus disertakan.",
    })
    .refine(
        (file) =>
            !!file && ["application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/vnd.openxmlformats-officedocument.presentationml.presentation"].includes(file.mimetype),
        {
            message: "Format file tidak valid. Gunakan PDF, docx, pptx.",
        }
    )
    .refine((file) => !!file && file.size <= 50 * 1024 * 1024, {
        message: "Ukuran file maksimal 5MB.",
    });


export const createMaterialFileSchema = z.object({
    title: z.string().min(3, "Judul minimal 3 karakter."),
    file: materialFileSchema
});

export const updateMaterialFileSchema = createMaterialFileSchema.partial();
export type CreateMaterialFileDto = z.infer<typeof createMaterialFileSchema>;
export type UpdateMaterialFileDto = z.infer<typeof updateMaterialFileSchema>;
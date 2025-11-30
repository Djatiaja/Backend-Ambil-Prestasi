import { z } from 'zod';
import { imageSchema } from './image.schema';

const MAX_MATERIAL_SIZE = 50 * 1024 * 1024; // 50MB
const MAX_VIDEO_SIZE = 1000 * 1024 * 1024; // 1000MB

const materialFileSchema = z
    .custom<Express.Multer.File>()
    .refine((f): f is Express.Multer.File => !!f, {
        message: "File harus disertakan.",
    })
    .refine((f) => f.mimetype !== undefined, {
        message: "file harus disertakan.",
    })
    .refine(
        (f) =>
            [
                "application/pdf",
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            ].includes(f.mimetype),
        { message: "Format file tidak valid. Gunakan PDF, DOCX, atau PPTX." }
    )
    .refine((f) => f.size <= MAX_MATERIAL_SIZE, {
        message: "Ukuran file maksimal 50MB.",
    });

const videoFileSchema = z
    .custom<Express.Multer.File>()
    .refine((f): f is Express.Multer.File => !!f, {
        message: "File video harus disertakan.",
    })
    .refine(
        (f) => ["video/mp4", "video/mpeg", "video/quicktime"].includes(f.mimetype),
        { message: "Format video tidak valid. Gunakan MP4, MPEG, atau MOV." }
    )
    .refine((f) => f.size <= MAX_VIDEO_SIZE, {
        message: "Ukuran video maksimal 100MB.",
    });

export const createMaterialSchema = z.object({
    title: z.string().min(1, "Judul wajib diisi").max(255, "Judul terlalu panjang"),
    content: z.string().min(1, "Konten wajib diisi"),
    thumnail: imageSchema,
    template: materialFileSchema,
    video: videoFileSchema,
    materialFile: materialFileSchema,
    ringkasan: materialFileSchema,
});

export const updateMaterialSchema = z.object({
    title: z.string().min(1).max(255).optional(),
    content: z.string().min(1).optional(),
    thumnail: imageSchema.optional(),
    template: materialFileSchema.optional(),
    video: videoFileSchema.optional(),
    materialFile: materialFileSchema.optional(),
    ringkasan: materialFileSchema.optional(),
});

export type CreateMaterialDto = z.infer<typeof createMaterialSchema>;
export type UpdateMaterialDto = z.infer<typeof updateMaterialSchema>;
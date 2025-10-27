import { z } from 'zod';

export const createMaterialSchema = z.object({
    title: z.string().min(1, 'Title is required').max(255, 'Title is too long'),
    content: z.string().min(1, 'Content is required'),
    xp: z.number().int().min(0, 'XP must be a positive number').optional(),
});

export const updateMaterialSchema = z.object({
    title: z.string().min(1, 'Title is required').max(255, 'Title is too long').optional(),
    content: z.string().min(1, 'Content is required').optional(),
    xp: z.number().int().min(0, 'XP must be a positive number').optional(),
});

export type CreateMaterialDto = z.infer<typeof createMaterialSchema>;
export type UpdateMaterialDto = z.infer<typeof updateMaterialSchema>;
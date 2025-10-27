import { z } from 'zod';

export const CreateSectionSchema = z.object({
    title: z.string()
        .min(10, 'Title cannot be less than 10 characters')
        .max(255, 'Title cannot exceed 255 characters'),

    description: z.string()
        .max(10000, 'Description cannot exceed 10000 characters')
        .optional()
        .nullable(),

    order: z.number()
        .int('Order must be an integer')
        .positive('Order must be positive')
        .optional(),
});


export const UpdateSectionSchema = CreateSectionSchema.partial();

export type CreateSectionInput = z.infer<typeof CreateSectionSchema>;
export type UpdateSectionInput = z.infer<typeof UpdateSectionSchema>;
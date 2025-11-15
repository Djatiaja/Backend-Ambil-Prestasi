import { z } from 'zod';

export const redeemCodeSchema = z.object({
    code: z.string().min(3).max(50).toUpperCase(),
});
export const createRedeemCodeSchema = z.object({
    durationDays: z.number().int().min(1).max(365).default(31),
    maxUses: z.number().int().min(1).max(10000).default(1),
    expiresAt: z.string().datetime().optional(),
});

export const updateRedeemCodeSchema = createRedeemCodeSchema.partial();

export type RedeemCodeDto = z.infer<typeof redeemCodeSchema>;
export type CreateRedeemCodeDto = z.infer<typeof createRedeemCodeSchema>;
export type UpdateRedeemCodeDto = z.infer<typeof updateRedeemCodeSchema>;

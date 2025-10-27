import z from "zod";
import { imageSchema } from "./image.schema";

export const createClassSchema = z.object({
    name: z.string().min(1, "Class name is required").max(100, "Class name must be at most 100 characters"),
    description: z.string().max(500, "Description must be at most 500 characters").optional(),
    // thumnail: imageSchema
});

export const updateClassSchema = createClassSchema.partial();
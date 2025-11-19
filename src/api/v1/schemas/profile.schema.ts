import { z } from "zod";
import { imageSchema } from "./image.schema";

export const updateProfileSchema = z.object({
    name: z.string().min(1, "Name cannot be empty").optional(),
    username: z.string().min(3, "Username must be at least 3 characters").optional(),
    telp: z.string().optional(),
    bio: z.string().optional(),
    file: imageSchema.optional(),
    specialization: z.string().optional(),
}).refine(
    (data) => Object.keys(data).length > 0,
    { message: "At least one field must be provided" }
);

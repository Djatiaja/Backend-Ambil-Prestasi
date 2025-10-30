import z from "zod";
import { imageSchema } from "./image.schema";
import prisma from "../../../database";

export const createClassSchema = z.object({
    name: z.string().min(1, "Class name is required").max(100, "Class name must be at most 100 characters"),
    description: z.string().max(500, "Description must be at most 500 characters").optional(),
    file: imageSchema,
    categoryId: z.number().int().min(1, "Category ID must be a positive integer"),
}).superRefine(async (data, ctx) => {

    const category = await prisma.category.findFirst({
        where: {
            id: data.categoryId
        }
    });
    if (!data.categoryId) {
        ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Category ID is required",
            path: ["categoryId"],
        });
    }
});

export const updateClassSchema = createClassSchema.partial();
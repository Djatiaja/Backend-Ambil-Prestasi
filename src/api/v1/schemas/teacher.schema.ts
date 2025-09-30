import z from "zod";
import { userRepository } from "../repositories/user.repository";

export const teacherCreateSchema = z.object({
    name: z.string().min(4).max(100),
    username: z.string().min(4).max(50).optional(),
    email: z.email(),
}).superRefine(async (data, context) => {
    // Check if email is already taken
    const existingEmail = await userRepository.getUser({ email: data.email });
    if (existingEmail) {
        context.addIssue({
            code: "custom",
            message: "Email is already in use",
            path: ["email"],
        });
    }

    // Check if username is already taken (if provided)
    if (data.username) {
        const existingUsername = await userRepository.getUser({ username: data.username });
        if (existingUsername) {
            context.addIssue({
                code: "custom",
                message: "Username is already in use",
                path: ["username"],
            });
        }
    }
});

// TODO: Add update schema
export const teacherUpdateSchema = z.object({
    name: z.string().min(4).max(100),
    username: z.string().min(4).max(50).optional(),
    email: z.email(),
}).superRefine(async (data, context) => {
    // Check if email is already taken
    const existingEmail = await userRepository.getUser({ email: data.email });
    if (existingEmail) {
        context.addIssue({
            code: "custom",
            message: "Email is already in use",
            path: ["email"],
        });
    }

    // Check if username is already taken (if provided)
    if (data.username) {
        const existingUsername = await userRepository.getUser({ username: data.username });
        if (existingUsername) {
            context.addIssue({
                code: "custom",
                message: "Username is already in use",
                path: ["username"],
            });
        }
    }
});
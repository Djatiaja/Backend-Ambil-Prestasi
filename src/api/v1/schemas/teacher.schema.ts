import z from "zod";
import { userRepository } from "../repositories/user.repository";

export const teacherCreateSchema = z.object({
    name: z.string().min(4).max(100),
    username: z.string().min(4).max(50),
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

export const teacherUpdateSchema = (userId: string) =>
    z.object({
        name: z.string().min(4).max(100).optional(),
        username: z.string().min(4).max(50).optional(),
        email: z.string().email().optional(),
    }).superRefine(async (data, context) => {
        // Check if email is already taken (but not by this user)
        if (data.email) {
            const existingEmail = await userRepository.getUser({ email: data.email });
            if (existingEmail && existingEmail.id !== userId) {
                context.addIssue({
                    code: "custom",
                    message: "Email is already in use",
                    path: ["email"],
                });
            }
        }

        // Check if username is already taken (but not by this user)
        if (data.username) {
            const existingUsername = await userRepository.getUser({ username: data.username });
            if (existingUsername && existingUsername.id !== userId) {
                context.addIssue({
                    code: "custom",
                    message: "Username is already in use",
                    path: ["username"],
                });
            }
        }
    });

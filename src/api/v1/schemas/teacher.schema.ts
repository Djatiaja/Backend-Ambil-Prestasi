import z from "zod";
import { userRepository } from "../repositories/user.repository";

export const teacherCreateSchema = z.object({
    name: z.string().min(4).max(100),
    username: z.string().min(4).max(50).optional(),
    email: z.string().email(),
    password: z.string().min(8).max(100),
    passwordConfirmation: z.string().min(8).max(100),
}).superRefine(async (data, context) => {
    if (data.password !== data.passwordConfirmation) {
        context.addIssue({
            code: "custom",
            message: "Passwords don't match",
            path: ["passwordConfirmation"],
        });
    }

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

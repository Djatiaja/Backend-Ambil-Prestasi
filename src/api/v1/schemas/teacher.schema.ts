import { z } from "zod";
import { userRepository } from "../repositories/user.repository";
import { PassThrough } from "stream";

export const teacherCreateSchema = z.object({
    name: z.string().min(4).max(100),
    username: z.string().min(4).max(50),
    email: z.string().email(),
    telp: z.string().min(10).max(15),
    status: z.enum(["ACTIVE", "INACTIVE"]),
    password: z.string().min(6).max(100),
    specialization: z.string().max(255),
    bio: z.string().max(1000),
}).superRefine(async (data, context) => {
    const existingEmail = await userRepository.getUser({ email: data.email });
    if (existingEmail) {
        context.addIssue({
            code: "custom",
            message: "Email is already in use",
            path: ["email"],
        });
    }

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
        telp: z.string().min(10).max(15).optional(),
        status: z.enum(["ACTIVE", "INACTIVE"]).optional(),
        specialization: z.string().max(255).optional(),
        bio: z.string().max(1000).optional(),
    }).superRefine(async (data, context) => {
        // Check email uniqueness
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

        // Check username uniqueness
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

export type TeacherCreateDTO = z.infer<typeof teacherCreateSchema>;
export type TeacherUpdateDTO = z.infer<ReturnType<typeof teacherUpdateSchema>>;

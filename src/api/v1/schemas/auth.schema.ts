import z from "zod";
import { userRepository } from "../repositories/user.repository";

export const loginSchema = z.object({
    usernameoremail: z.string().min(4, 'username or email is required'),
    password: z.string().min(8, 'Password is required'),
});

export const forgotPasswordSchema = z.object({
    email: z.email('Valid email is required'),
});

export const resetTokenSchema = z.object({
    reset_token: z.string().min(1, 'Token is required'),
});

export const resetPasswordSchema = z.object({
    reset_token: z.string().min(1, 'Token is required'),
    newPassword: z.string().min(6, 'Password must be at least 6 characters'),
    confirmPassword: z.string().min(6, 'Confirm password must be at least 6 characters'),
}).refine((data) => data.newPassword === data.confirmPassword, {
    message: 'Passwords must match',
    path: ['confirmPassword'],
});

export const registerSchema = z.object({
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

export const OTPSchema = z.object({
    email: z.email(),
    code: z.string().length(6),
});

export const resendOTPSchema = z.object({
    email: z.email(),
});


export type registerUserDto = z.infer<typeof registerSchema>;
export type OTPInput = z.infer<typeof OTPSchema>;

import z from "zod";

export const loginSchema = z.object({
    username: z.string().min(4, 'Username is required'),
    password: z.string().min(8, 'Password is required'),
});

export const forgotPasswordSchema = z.object({
    email: z.email('Valid email is required'),
});

export const resetTokenSchema = z.object({
    token: z.string().min(1, 'Token is required'),
});

export const resetPasswordSchema = z.object({
    token: z.string().min(1, 'Token is required'),
    newPassword: z.string().min(6, 'Password must be at least 6 characters'),
    confirmPassword: z.string().min(6, 'Confirm password must be at least 6 characters'),
}).refine((data) => data.newPassword === data.confirmPassword, {
    message: 'Passwords must match',
    path: ['confirmPassword'],
});


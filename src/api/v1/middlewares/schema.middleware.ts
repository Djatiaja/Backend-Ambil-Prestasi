import z from "zod";

const userSchema = z.object({
    name: z.string().min(1, "Name is required"),
    email: z.email("Invalid email format"),
    password: z.string().min(8, "Password must be at least 8 characters long"),
    username: z.string().optional(),
    profileImage: z.url("Invalid URL format").optional(),
});
import z from "zod";

const teacherSchema = z.object({
    id: z.string().uuid(),
    name: z.string().min(2).max(100),
    email: z.string().email(),
    subject: z.string().min(2).max(100),
    yearsOfExperience: z.number().min(0).optional()
});

export default teacherSchema;

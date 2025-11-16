import { z } from "zod";

// === Quiz ===
export const createQuizSchema = z.object({
    title: z.string().min(1, "Title is required"),
    description: z.string().min(1, "Description is required"),
    max_attempts: z.number().int().min(1, "Max attempts must be >= 1"),
    time_limit: z.number().int().min(1, "Time limit must be >= 1 minute"),
    passing_grade: z.number().int().min(0).max(100),
    xp: z.number().int().min(0).default(0),
});

export const updateQuizSchema = createQuizSchema.partial();

// === Question ===
const answerSchema = z.object({
    answer: z.string().min(1, "Answer text is required"),
    is_correct: z.boolean(),
});

export const createQuestionSchema = z.object({
    question: z.string().min(1, "Question is required"),
    type: z.enum(["MultipleChoice", "TrueFalse", "Essay"]),
    points: z.number().int().min(1, "Points must be >= 1"),
    answers: z
        .array(answerSchema)
        .min(1)
        .optional(),
}).superRefine((data, ctx) => {
    if (data.type === "Essay") return;
    const answers = data.answers;
    if (!answers || !answers.some((a) => a.is_correct)) {
        ctx.addIssue({
            code: "custom",
            message: "At least one correct answer required (except Essay)",
            path: ["answers"],
        });
    }
});

export const updateQuestionSchema = createQuestionSchema.partial();

// === Student: Start Quiz Attempt ===
export const startQuizAttemptSchema = z.object({
    quizId: z.number().int(),
});

// === Student: Save Answer (Auto-save) ===
export const saveAnswerSchema = z.object({
    attemptId: z.number().int(),
    questionId: z.number().int(),
    answer: z.string().optional(),
    filePath: z.string().optional(),
    selectedAnswerIds: z.array(z.number().int()).optional(),
});

// === Student: Submit Quiz (Final) ===
export const submitQuizSchema = z.object({
    attemptId: z.number().int(),
});

// === Student: Get Attempt Result ===
export const getAttemptResultSchema = z.object({
    attemptId: z.number().int(),
});
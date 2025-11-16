import prisma from "..";
import { class_role } from "@prisma/client";

export const quiz_attemptSeed = async () => {
    console.log("\n🌱 Seeding quiz attempts...");
    const users = await prisma.user.findMany({ include: { quiz_attempt: true, User_Class: true } });
    const quizzes = await prisma.quiz.findMany();

    if (users.length === 0) {
        throw new Error("Users must be seeded before seeding quiz attempts.");
    }

    if (quizzes.length === 0) {
        throw new Error("Quizzes must be seeded before seeding quiz attempts.");
    }

    for (const user of users) {
        for (const quiz of quizzes) {

            const flag = Math.random() < 0.3; // 30% chance to attempt

            if (user.quiz_attempt.length >= quiz.max_attempts) {
                continue;
            }

            // Skip if user is not enrolled in any class (removed time check)
            if (user.User_Class.length === 0) {
                continue;
            }

            if (!flag) {
                continue;
            }

            const attempts = Math.floor(Math.random() * quiz.max_attempts) + 1; // 1 to max_attempts

            for (let i = 0; i < attempts; i++) {
                const score = Math.floor(Math.random() * 101); // Score between 0 and 100

                await prisma.quiz_Attempt.create({
                    data: {
                        userId: user.id,
                        quizId: quiz.id,
                        score: score,
                    }
                });
            }
        }
    }

    console.log("✅ Quiz attempts seeded.");
}
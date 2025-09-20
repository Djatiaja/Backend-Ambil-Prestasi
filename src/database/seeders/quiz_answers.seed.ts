import prisma from "..";
import { randomInt } from "crypto";

export const quiz_answersSeed = async () => {
    console.log("\n🌱 Seeding quiz answers...");
    const questions = await prisma.quiz_Question.findMany();

    if (questions.length === 0) {
        throw new Error("Quiz questions must be seeded before seeding quiz answers.");
    }

    for (const question of questions) {
        if (question.type === "MultipleChoice") {
            const numChoices = 4;
            const correctIndex = randomInt(0, numChoices);

            for (let i = 0; i < numChoices; i++) {
                await prisma.quiz_Answer.create({
                    data: {
                        answer: `Choice ${i + 1} for question ${question.id}`,
                        is_correct: i === correctIndex,
                        questionId: question.id
                    }
                });
            }
        } else if (question.type === "TrueFalse") {
            const isTrueCorrect = randomInt(0, 2) === 0;

            await prisma.quiz_Answer.create({
                data: {
                    answer: "True",
                    is_correct: isTrueCorrect,
                    questionId: question.id
                }
            });
            await prisma.quiz_Answer.create({
                data: {
                    answer: "False",
                    is_correct: !isTrueCorrect,
                    questionId: question.id
                }
            });
        } else if (question.type === "Essay") {
            // Essay questions typically don't have predefined answers
            continue;
        }
    }

    console.log("✅ Quiz answers seeded.");
}
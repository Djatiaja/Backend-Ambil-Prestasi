import { quiz_question_type } from "@prisma/client";
import prisma from "..";

export const attemp_answersSeed = async () => {
    console.log("\n🌱 Seeding attempt answers...");

    const attempts = await prisma.quiz_Attempt.findMany();
    const questions = await prisma.quiz_Question.findMany({ include: { quiz_answer: true } });
    if (attempts.length === 0) {
        throw new Error("Quiz attempts must be seeded before seeding attempt answers.");
    }

    if (questions.length === 0) {
        throw new Error("Quiz questions must be seeded before seeding attempt answers.");
    }

    for (const attempt of attempts) {
        for (const question of questions) {
            const flag = Math.random() < 0.7; // 70% chance to answer each question
            if (!flag) {
                continue;
            }

            let answer;
            if (question.type === quiz_question_type.MultipleChoice) {

                const choices = question.quiz_answer;
                if (choices.length > 0) {
                    const randomChoice = choices[Math.floor(Math.random() * choices.length)];
                    answer = randomChoice.answer;
                } else {
                    answer = null;
                }

            } else if (question.type === quiz_question_type.TrueFalse) {
                answer = Math.random() < 0.5 ? "True" : "False";
            } else if (question.type === quiz_question_type.Essay) {
                answer = "This is a sample short answer.";
            } else {
                answer = null;
            }

            await prisma.attemp_Answer.create({
                data: {
                    attemptId: attempt.id,
                    questionId: question.id,
                    answer: answer
                }
            });
        }
    }

    // TODO : Add update score in quiz_Attempt based on correct answers

    console.log("✅ Attempt answers seeded.");
}
import { CreateQuestionInput, CreateQuizInput, UpdateQuestionInput } from '../types/quiz.type';
import prisma from '../../../database';
import { quiz_question_type } from '@prisma/client';

export class QuizRepository {
    static async getQuizzesByMaterial(materialId: number) {
        console.log('Fetching quizzes for materialId:', materialId);
        return prisma.quiz.findMany({
            where: { materialId },
            include: {
                quiz_question: {
                    include: { quiz_answer: true },
                    orderBy: { id: 'asc' },
                },
                _count: {
                    select: {
                        quiz_attempt: true,
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
        });
    }

    static async createQuiz(data: CreateQuizInput) {
        console.log('Creating quiz with data:', data);
        return prisma.quiz.create({
            data: {
                title: data.title,
                description: data.description,
                max_attempts: data.max_attempts,
                time_limit: data.time_limit,
                passing_grade: data.passing_grade,
                xp: data.xp,
                materialId: data.materialId,
            },
        });
    }

    static async getQuizById(id: number) {
        return prisma.quiz.findUnique({
            where: { id },
            include: {
                quiz_question: {
                    include: { quiz_answer: true },
                    orderBy: { id: 'asc' },
                },
            },
        });
    }

    static async updateQuiz(id: number, data: Partial<CreateQuizInput>) {
        return prisma.quiz.update({ where: { id }, data });
    }

    static async deleteQuiz(id: number) {
        return prisma.$transaction(async (tx) => {
            await tx.quiz_Question.deleteMany({ where: { quizId: id } });
            return tx.quiz.delete({ where: { id } });
        });
    }

    // === Question ===
    static async createQuestion(quizId: number, data: CreateQuestionInput) {
        return prisma.$transaction(async (tx) => {
            const question = await tx.quiz_Question.create({
                data: {
                    question: data.question,
                    type: data.type as quiz_question_type,
                    points: data.points,
                    quizId,
                },
            });

            if (data.type !== 'Essay' && data.answers) {
                await tx.quiz_Answer.createMany({
                    data: data.answers.map((a) => ({
                        answer: a.answer,
                        is_correct: a.is_correct,
                        questionId: question.id,
                    })),
                });
            }

            return tx.quiz_Question.findUnique({
                where: { id: question.id },
                include: { quiz_answer: true },
            });
        });
    }

    static async updateQuestion(questionId: number, data: UpdateQuestionInput) {
        return prisma.$transaction(async (tx) => {
            const updateData: Partial<CreateQuestionInput> = {};
            if (data.question) updateData.question = data.question;
            if (data.type) updateData.type = data.type;
            if (data.points) updateData.points = data.points;

            await tx.quiz_Question.update({
                where: { id: questionId },
                data: updateData,
            });

            if (data.answers !== undefined) {
                await tx.quiz_Answer.deleteMany({ where: { questionId } });
                if (data.type !== 'Essay' && data.answers.length > 0) {
                    await tx.quiz_Answer.createMany({
                        data: data.answers.map((a) => ({
                            answer: a.answer,
                            is_correct: a.is_correct,
                            questionId,
                        })),
                    });
                }
            }

            return tx.quiz_Question.findUnique({
                where: { id: questionId },
                include: { quiz_answer: true },
            });
        });
    }

    static async deleteQuestion(questionId: number) {
        return prisma.$transaction(async (tx) => {
            await tx.quiz_Answer.deleteMany({ where: { questionId } });
            return tx.quiz_Question.delete({ where: { id: questionId } });
        });
    }

    // === Submit ===
    static async startQuizAttempt(userId: string, quizId: number) {
        return prisma.quiz_Attempt.create({
            data: {
                userId,
                quizId,
                started_at: new Date(),
            },
            include: {
                quiz: {
                    include: {
                        quiz_question: {
                            include: { quiz_answer: true },
                            orderBy: { id: 'asc' },
                        },
                    },
                },
            },
        });
    }

    static async getAttemptById(attemptId: number) {
        return prisma.quiz_Attempt.findUnique({
            where: { id: attemptId },
            include: {
                quiz: {
                    include: {
                        quiz_question: {
                            include: { quiz_answer: true },
                            orderBy: { id: 'asc' },
                        },
                    },
                },
                attemp_answer: {
                    include: {
                        quiz_question: true,
                        attemp_multiple_answer: {
                            include: { quiz_answer: true },
                        },
                    },
                },
            },
        });
    }

    static async saveAnswer(data: {
        attemptId: number;
        questionId: number;
        answer?: string;
        filePath?: string;
        selectedAnswerIds?: number[];
    }) {
        return prisma.$transaction(async (tx) => {
            // Check if answer already exists
            const existing = await tx.attemp_Answer.findFirst({
                where: {
                    attemptId: data.attemptId,
                    questionId: data.questionId,
                },
            });

            let attempAnswer;
            if (existing) {
                // Update existing answer
                attempAnswer = await tx.attemp_Answer.update({
                    where: { id: existing.id },
                    data: {
                        answer: data.answer,
                        path: data.filePath,
                    },
                });

                // Delete old multiple choice answers
                await tx.attemp_Multiple_Answer.deleteMany({
                    where: { attempt_answerId: existing.id },
                });
            } else {
                // Create new answer
                attempAnswer = await tx.attemp_Answer.create({
                    data: {
                        attemptId: data.attemptId,
                        questionId: data.questionId,
                        answer: data.answer,
                        path: data.filePath,
                    },
                });
            }

            // Save multiple choice answers
            if (data.selectedAnswerIds && data.selectedAnswerIds.length > 0) {
                await tx.attemp_Multiple_Answer.createMany({
                    data: data.selectedAnswerIds.map((id) => ({
                        attempt_answerId: attempAnswer.id,
                        answerId: id,
                    })),
                });
            }

            return tx.attemp_Answer.findUnique({
                where: { id: attempAnswer.id },
                include: {
                    quiz_question: true,
                    attemp_multiple_answer: {
                        include: { quiz_answer: true },
                    },
                },
            });
        });
    }

    static async submitQuiz(attemptId: number) {
        return prisma.$transaction(async (tx) => {
            const attempt = await tx.quiz_Attempt.findUnique({
                where: { id: attemptId },
                include: {
                    quiz: {
                        include: {
                            quiz_question: {
                                include: { quiz_answer: true },
                            },
                        },
                    },
                    attemp_answer: {
                        include: {
                            quiz_question: true,
                            attemp_multiple_answer: {
                                include: { quiz_answer: true },
                            },
                        },
                    },
                },
            });

            if (!attempt) throw new Error('Attempt not found');

            // Calculate score
            let totalScore = 0;
            let hasEssay = false;

            for (const answer of attempt.attemp_answer) {
                const question = attempt.quiz.quiz_question.find(
                    (q) => q.id === answer.questionId
                );
                if (!question) continue;

                if (question.type === 'Essay') {
                    hasEssay = true;
                    continue;
                }

                if (question.type === 'MultipleChoice') {
                    const correctIds = question.quiz_answer
                        .filter((a) => a.is_correct)
                        .map((a) => a.id)
                        .sort();
                    const selectedIds = answer.attemp_multiple_answer
                        .map((a) => a.answerId)
                        .sort();
                    const isCorrect =
                        correctIds.length === selectedIds.length &&
                        correctIds.every((id, idx) => id === selectedIds[idx]);
                    if (isCorrect) totalScore += question.points;
                } else if (question.type === 'TrueFalse') {
                    const correctAnswer = question.quiz_answer.find((a) => a.is_correct);
                    if (correctAnswer && answer.answer === correctAnswer.answer) {
                        totalScore += question.points;
                    }
                }
            }

            // Update attempt
            return tx.quiz_Attempt.update({
                where: { id: attemptId },
                data: {
                    submitted_at: new Date(),
                    score: hasEssay ? null : totalScore,
                    is_graded: !hasEssay,
                },
                include: {
                    quiz: true,
                    attemp_answer: {
                        include: {
                            quiz_question: true,
                            attemp_multiple_answer: {
                                include: { quiz_answer: true },
                            },
                        },
                    },
                },
            });
        });
    }

    static async calculateScore(attemptId: number) {
        return prisma.$transaction(async (tx) => {
            const attempt = await tx.quiz_Attempt.findUnique({
                where: { id: attemptId },
                include: {
                    quiz: {
                        include: {
                            quiz_question: {
                                include: { quiz_answer: true },
                            },
                        },
                    },
                    attemp_answer: {
                        include: {
                            quiz_question: true,
                            attemp_multiple_answer: {
                                include: { quiz_answer: true },
                            },
                        },
                    },
                },
            });

            if (!attempt) throw new Error('Attempt not found');

            // Calculate score
            let totalScore = 0;
            let hasUngradedEssay = false;

            for (const answer of attempt.attemp_answer) {
                const question = attempt.quiz.quiz_question.find(
                    (q) => q.id === answer.questionId
                );
                if (!question) continue;

                if (question.type === 'Essay') {
                    // Check if essay has been graded manually
                    // If not graded, skip
                    hasUngradedEssay = true;
                    continue;
                }

                if (question.type === 'MultipleChoice') {
                    const correctIds = question.quiz_answer
                        .filter((a) => a.is_correct)
                        .map((a) => a.id)
                        .sort();
                    const selectedIds = answer.attemp_multiple_answer
                        .map((a) => a.answerId)
                        .sort();
                    const isCorrect =
                        correctIds.length === selectedIds.length &&
                        correctIds.every((id, idx) => id === selectedIds[idx]);
                    if (isCorrect) totalScore += question.points;
                } else if (question.type === 'TrueFalse') {
                    const correctAnswer = question.quiz_answer.find((a) => a.is_correct);
                    if (correctAnswer && answer.answer === correctAnswer.answer) {
                        totalScore += question.points;
                    }
                }
            }

            // Update score if all graded
            if (!hasUngradedEssay || attempt.is_graded) {
                await tx.quiz_Attempt.update({
                    where: { id: attemptId },
                    data: {
                        score: totalScore,
                        is_graded: true,
                    },
                });
            }

            return {
                attemptId,
                score: totalScore,
                isGraded: !hasUngradedEssay || attempt.is_graded,
            };
        });
    }

    static async getStudentAttempts(userId: string, quizId: number) {
        return prisma.quiz_Attempt.findMany({
            where: { userId, quizId },
            include: {
                attemp_answer: {
                    include: {
                        quiz_question: true,
                        attemp_multiple_answer: { include: { quiz_answer: true } },
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
}
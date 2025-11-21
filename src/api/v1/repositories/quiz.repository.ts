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

    static async getQuizzesByMaterialForStudent(materialId: number, userId: string) {
        const quizzes = await prisma.quiz.findMany({
            where: { materialId },
            select: {
                id: true,
                title: true,
                description: true,
                max_attempts: true,
                time_limit: true,
                passing_grade: true,
                xp: true,
                createdAt: true,
                _count: {
                    select: {
                        quiz_question: true,
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
        });

        // Get user's attempts for each quiz
        const quizzesWithAttempts = await Promise.all(
            quizzes.map(async (quiz) => {
                const attempts = await prisma.quiz_Attempt.findMany({
                    where: {
                        quizId: quiz.id,
                        userId,
                        submitted_at: { not: null },
                    },
                    select: {
                        id: true,
                        score: true,
                        is_graded: true,
                        submitted_at: true,
                    },
                    orderBy: { submitted_at: 'desc' },
                });

                const bestScore = attempts.length > 0
                    ? Math.max(...attempts.filter(a => a.score !== null).map(a => a.score!))
                    : null;

                return {
                    ...quiz,
                    totalQuestions: quiz._count.quiz_question,
                    attemptsUsed: attempts.length,
                    attemptsRemaining: quiz.max_attempts - attempts.length,
                    bestScore,
                    lastAttempt: attempts.length > 0 ? attempts[0] : null,
                };
            })
        );

        return quizzesWithAttempts;
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
        // Check if quiz exists first
        const quiz = await prisma.quiz.findUnique({ where: { id } });
        if (!quiz) {
            throw new Error(`Quiz with ID ${id} not found`);
        }

        // Delete quiz - cascade will handle quiz_questions, quiz_attempts, and their related records
        return prisma.quiz.delete({ where: { id } });
    }

    // === Question ===
    static async createQuestion(quizId: number, data: CreateQuestionInput) {
        return prisma.$transaction(async (tx) => {
            const question = await tx.quiz_Question.create({
                data: {
                    question: data.question,
                    type: data.type as quiz_question_type,
                    points: data.points,
                    explanation: data.explanation,
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
            const updateData: any = {};
            if (data.question !== undefined) updateData.question = data.question;
            if (data.type !== undefined) updateData.type = data.type;
            if (data.points !== undefined) updateData.points = data.points;
            if (data.explanation !== undefined) updateData.explanation = data.explanation;

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

    static async getAllQuestions(quizId: number, isStudent: boolean = false) {
        const questions = await prisma.quiz_Question.findMany({
            where: { quizId },
            include: {
                quiz_answer: {
                    select: {
                        id: true,
                        answer: true,
                        is_correct: !isStudent, // Hide is_correct for students
                        questionId: true,
                        createdAt: true,
                        updatedAt: true,
                    }
                }
            },
            orderBy: { id: 'asc' },
        });

        // Hide explanation for students
        if (isStudent) {
            return questions.map(q => ({
                ...q,
                explanation: undefined,
            }));
        }

        return questions;
    }

    static async getQuestionById(questionId: number, isStudent: boolean = false) {
        const question = await prisma.quiz_Question.findUnique({
            where: { id: questionId },
            include: {
                quiz_answer: {
                    select: {
                        id: true,
                        answer: true,
                        is_correct: !isStudent, // Hide is_correct for students
                        questionId: true,
                        createdAt: true,
                        updatedAt: true,
                    }
                }
            },
        });

        // Hide explanation for students
        if (question && isStudent) {
            return {
                ...question,
                explanation: undefined,
            };
        }

        return question;
    }

    // === Submit ===
    static async startQuizAttempt(userId: string, quizId: number) {
        const attempt = await prisma.quiz_Attempt.create({
            data: {
                userId,
                quizId,
                started_at: new Date(),
            },
            include: {
                quiz: {
                    include: {
                        quiz_question: {
                            include: {
                                quiz_answer: {
                                    select: {
                                        id: true,
                                        answer: true
                                    },
                                },
                            },
                            orderBy: { id: 'asc' },
                        },
                    },
                },
            },
        });

        // Filter out answers for Essay type questions
        if (attempt.quiz.quiz_question) {
            attempt.quiz.quiz_question = attempt.quiz.quiz_question.map((question) => ({
                ...question,
                quiz_answer: question.type === 'Essay' ? [] : question.quiz_answer,
            }));
        }

        return attempt;
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

    static async getAttemptQuestions(attemptId: number) {
        const attempt = await prisma.quiz_Attempt.findUnique({
            where: { id: attemptId },
            include: {
                quiz: {
                    include: {
                        quiz_question: {
                            include: {
                                quiz_answer: {
                                    select: {
                                        id: true,
                                        answer: true,
                                    },
                                },
                            },
                            orderBy: { id: 'asc' },
                        },
                    },
                },
                attemp_answer: {
                    include: {
                        quiz_question: true,
                        attemp_multiple_answer: {
                            include: {
                                quiz_answer: {
                                    select: {
                                        id: true,
                                        answer: true,
                                    },
                                },
                            },
                        },
                    },
                },
            },
        });

        if (!attempt) return null;

        // Return questions with saved answers
        return {
            attemptId: attempt.id,
            quizId: attempt.quizId,
            quizTitle: attempt.quiz.title,
            timeLimit: attempt.quiz.time_limit,
            startedAt: attempt.started_at,
            submittedAt: attempt.submitted_at,
            questions: attempt.quiz.quiz_question.map((question) => {
                const savedAnswer = attempt.attemp_answer.find(
                    (ans) => ans.questionId === question.id
                );

                return {
                    id: question.id,
                    question: question.question,
                    type: question.type,
                    points: question.points,
                    // Don't return answers for Essay type questions
                    answers: question.type === 'Essay' ? [] : question.quiz_answer.map((ans) => ({
                        id: ans.id,
                        answer: ans.answer,
                    })),
                    savedAnswer: savedAnswer
                        ? {
                            answer: savedAnswer.answer,
                            path: savedAnswer.path,
                            selectedAnswerIds: savedAnswer.attemp_multiple_answer.map(
                                (ma) => ma.answerId
                            ),
                        }
                        : null,
                };
            }),
        };
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

    static async getQuizReview(attemptId: number, userId: string) {
        const attempt = await prisma.quiz_Attempt.findFirst({
            where: { id: attemptId, userId },
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

        if (!attempt) throw new Error('Attempt not found or unauthorized');
        if (!attempt.submitted_at) throw new Error('Quiz not submitted yet');

        // Format review with correct answers and explanations
        const review = attempt.quiz.quiz_question.map((question) => {
            const userAnswer = attempt.attemp_answer.find(
                (ans) => ans.questionId === question.id
            );

            let isCorrect = false;
            let correctAnswers: any[] = [];
            let userAnswers: any[] = [];

            if (question.type === 'MultipleChoice') {
                correctAnswers = question.quiz_answer
                    .filter((a) => a.is_correct)
                    .map((a) => ({ id: a.id, answer: a.answer }));

                userAnswers = userAnswer?.attemp_multiple_answer.map((a) => ({
                    id: a.quiz_answer.id,
                    answer: a.quiz_answer.answer,
                })) || [];

                const correctIds = correctAnswers.map((a) => a.id).sort();
                const selectedIds = userAnswers.map((a) => a.id).sort();
                isCorrect =
                    correctIds.length === selectedIds.length &&
                    correctIds.every((id, idx) => id === selectedIds[idx]);
            } else if (question.type === 'TrueFalse') {
                const correctAnswer = question.quiz_answer.find((a) => a.is_correct);
                correctAnswers = correctAnswer ? [{ answer: correctAnswer.answer }] : [];
                userAnswers = userAnswer?.answer ? [{ answer: userAnswer.answer }] : [];
                isCorrect = userAnswer?.answer === correctAnswer?.answer;
            } else if (question.type === 'Essay') {
                userAnswers = userAnswer?.answer ? [{ answer: userAnswer.answer }] : [];
                // Essay questions need manual grading
                isCorrect = false;
            }

            return {
                questionId: question.id,
                question: question.question,
                type: question.type,
                points: question.points,
                explanation: question.explanation,
                correctAnswers,
                userAnswers,
                isCorrect,
            };
        });

        return {
            attemptId: attempt.id,
            score: attempt.score,
            totalScore: attempt.quiz.quiz_question.reduce((sum, q) => sum + q.points, 0),
            isGraded: attempt.is_graded,
            submittedAt: attempt.submitted_at,
            review,
        };
    }
}
import { Request, Response } from 'express';
import { sendResponse } from '../helpers/baseResponse';
import { QuizService } from '../services/quiz.service';
import materialService from '../services/material.service';

export class QuizController {
    // === TEACHER: Quiz ===
    static async getQuizzesByMaterial(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            if (isNaN(materialId)) {
                throw new Error('Invalid material ID');
            }
            const material = await materialService.getMaterialById(materialId);
            if (!material) {
                throw new Error('Material not found');
            }

            const quizzes = await QuizService.getQuizzesByMaterial(materialId);


            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quizzes retrieved',
                data: quizzes,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async createQuiz(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            const material = await materialService.getMaterialById(materialId);
            if (!material) {
                throw new Error('Material not found');
            }


            if (isNaN(materialId) || !materialId) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Material ID is required and must be a valid number',
                    data: null,
                });
            }

            const quiz = await QuizService.createQuiz({ ...req.body, materialId });
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'Quiz created',
                data: quiz,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getQuiz(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.id);
            if (isNaN(id)) {
                throw new Error('Invalid quiz ID');
            }
            const quiz = await QuizService.getQuizById(id);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quiz retrieved',
                data: quiz,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async updateQuiz(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.id);
            if (isNaN(id)) {
                throw new Error('Invalid quiz ID');
            }
            const quiz = await QuizService.updateQuiz(id, req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quiz updated',
                data: quiz,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async deleteQuiz(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.id);
            if (isNaN(id)) {
                throw new Error('Invalid quiz ID');
            }

            await QuizService.deleteQuiz(id);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quiz deleted',
                data: null,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    // === TEACHER: Question ===
    static async createQuestion(req: Request, res: Response) {
        try {
            const quizId = parseInt(req.params.quizId);
            if (isNaN(quizId)) {
                throw new Error('Invalid quiz ID');
            }

            const quiz = await QuizService.getQuizById(quizId);
            if (!quiz) {
                throw new Error('Quiz not found');
            }

            const question = await QuizService.createQuestion(quizId, req.body);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'Question added',
                data: question,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async updateQuestion(req: Request, res: Response) {
        try {
            const questionId = parseInt(req.params.questionId);
            if (isNaN(questionId)) {
                throw new Error('Invalid question ID');
            }
            const question = await QuizService.updateQuestion(questionId, req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Question updated',
                data: question,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async deleteQuestion(req: Request, res: Response) {
        try {
            const questionId = parseInt(req.params.questionId);
            if (isNaN(questionId)) {
                throw new Error('Invalid question ID');
            }
            await QuizService.deleteQuestion(questionId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Question deleted',
                data: null,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getAllQuestions(req: Request, res: Response) {
        try {
            const quizId = parseInt(req.params.quizId);
            if (isNaN(quizId)) {
                throw new Error('Invalid quiz ID');
            }
            // Check if user is student (hide answers and explanation)
            const isStudent = req.role === 'Student';
            const questions = await QuizService.getAllQuestions(quizId, isStudent);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Questions retrieved',
                data: questions,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getQuestionById(req: Request, res: Response) {
        try {
            const questionId = parseInt(req.params.questionId);
            if (isNaN(questionId)) {
                throw new Error('Invalid question ID');
            }
            // Check if user is student (hide answers and explanation)
            const isStudent = req.role === 'Student';
            const question = await QuizService.getQuestionById(questionId, isStudent);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Question retrieved',
                data: question,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    // === STUDENT ===
    static async startQuizAttempt(req: Request, res: Response) {
        try {
            const attempt = await QuizService.startQuizAttempt(req.user!.id!, req.body);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'Quiz attempt started',
                data: attempt,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async saveAnswer(req: Request, res: Response) {
        try {
            const answer = await QuizService.saveAnswer(req.user!.id!, req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Answer saved',
                data: answer,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async submitQuiz(req: Request, res: Response) {
        try {
            const attempt = await QuizService.submitQuiz(req.user!.id!, req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quiz submitted successfully',
                data: attempt,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getAttemptResult(req: Request, res: Response) {
        try {
            const attemptId = parseInt(req.params.attemptId);
            if (isNaN(attemptId)) {
                throw new Error('Invalid attempt ID');
            }
            const result = await QuizService.getAttemptResult(req.user!.id!, { attemptId });
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Attempt result retrieved',
                data: result,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getMyAttempts(req: Request, res: Response) {
        try {
            const quizId = parseInt(req.params.quizId);
            if (isNaN(quizId)) {
                throw new Error('Invalid quiz ID');
            }
            const attempts = await QuizService.getMyAttempts(req.user!.id!, quizId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Your attempts',
                data: attempts,
                meta: {
                    totalItems: attempts.length,
                    itemsPerPage: attempts.length,
                    totalPages: 1,
                    currentPage: 1,
                },
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getAttemptQuestions(req: Request, res: Response) {
        try {
            const attemptId = parseInt(req.params.attemptId);
            if (isNaN(attemptId)) {
                throw new Error('Invalid attempt ID');
            }
            const questions = await QuizService.getAttemptQuestions(req.user!.id!, attemptId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Attempt questions retrieved',
                data: questions,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }

    static async getQuizReview(req: Request, res: Response) {
        try {
            const attemptId = parseInt(req.params.attemptId);
            if (isNaN(attemptId)) {
                throw new Error('Invalid attempt ID');
            }
            const review = await QuizService.getQuizReview(req.user!.id!, attemptId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Quiz review retrieved',
                data: review,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: (error as Error).message,
                data: null,
            });
        }
    }
}
import { QuizRepository } from '../repositories/quiz.repository';
import prisma from '../../../database';
import {
    CreateQuestionInput,
    CreateQuizInput,
    StartQuizAttemptInput,
    SaveAnswerInput,
    SubmitQuizInput,
    GetAttemptResultInput,
    UpdateQuestionInput,
    UpdateQuizInput,
} from '../types/quiz.type';

export class QuizService {
    // === Quiz ===
    static async getQuizzesByMaterial(materialId: number) {
        return QuizRepository.getQuizzesByMaterial(materialId);
    }

    static async createQuiz(data: CreateQuizInput) {
        // Validate that material exists
        const material = await prisma.material.findUnique({
            where: { id: data.materialId },
        });

        if (!material) {
            throw new Error(`Material with ID ${data.materialId} not found`);
        }

        return QuizRepository.createQuiz(data);
    }

    static async getQuizById(id: number) {
        const quiz = await QuizRepository.getQuizById(id);
        if (!quiz) throw new Error('Quiz not found');
        return quiz;
    }

    static async updateQuiz(id: number, data: UpdateQuizInput) {
        return QuizRepository.updateQuiz(id, data);
    }

    static async deleteQuiz(id: number) {
        return QuizRepository.deleteQuiz(id);
    }

    // === Question ===
    static async createQuestion(quizId: number, data: CreateQuestionInput) {
        await this.getQuizById(quizId);
        return QuizRepository.createQuestion(quizId, data);
    }

    static async updateQuestion(questionId: number, data: UpdateQuestionInput) {
        return QuizRepository.updateQuestion(questionId, data);
    }

    static async deleteQuestion(questionId: number) {
        return QuizRepository.deleteQuestion(questionId);
    }

    // === Student ===
    static async startQuizAttempt(userId: string, data: StartQuizAttemptInput) {
        const quiz = await this.getQuizById(data.quizId);

        // Check max attempts
        const attempts = await QuizRepository.getStudentAttempts(userId, data.quizId);
        const submittedAttempts = attempts.filter((a) => a.submitted_at !== null);

        if (submittedAttempts.length >= quiz.max_attempts) {
            throw new Error('Maksimal percobaan telah tercapai');
        }

        // Check if there's an ongoing attempt
        const ongoingAttempt = attempts.find((a) => a.submitted_at === null);
        if (ongoingAttempt) {
            // Check if time limit exceeded
            const timeElapsed = now.getTime() - ongoingAttempt.started_at.getTime();
            const timeLimitMs = quiz.time_limit * 60 * 1000;

            if (timeElapsed < timeLimitMs) {
                // Return existing attempt
                return QuizRepository.getAttemptById(ongoingAttempt.id);
            } else {
                // Auto-submit expired attempt
                await QuizRepository.submitQuiz(ongoingAttempt.id);
            }
        }

        // Create new attempt
        return QuizRepository.startQuizAttempt(userId, data.quizId);
    }

    static async saveAnswer(userId: string, data: SaveAnswerInput) {
        const attempt = await QuizRepository.getAttemptById(data.attemptId);
        if (!attempt) {
            throw new Error('Attempt tidak ditemukan');
        }

        // Verify user owns this attempt
        if (attempt.userId !== userId) {
            throw new Error('Anda tidak memiliki akses ke attempt ini');
        }

        // Check if already submitted
        if (attempt.submitted_at) {
            throw new Error('Quiz sudah di-submit');
        }

        // Check time limit
        const now = new Date();
        const timeElapsed = now.getTime() - attempt.started_at.getTime();
        const timeLimitMs = attempt.quiz.time_limit * 60 * 1000;

        if (timeElapsed > timeLimitMs) {
            throw new Error('Waktu quiz telah habis');
        }

        // Save answer
        return QuizRepository.saveAnswer(data);
    }

    static async submitQuiz(userId: string, data: SubmitQuizInput) {
        const attempt = await QuizRepository.getAttemptById(data.attemptId);
        if (!attempt) {
            throw new Error('Attempt tidak ditemukan');
        }

        // Verify user owns this attempt
        if (attempt.userId !== userId) {
            throw new Error('Anda tidak memiliki akses ke attempt ini');
        }

        // Check if already submitted
        if (attempt.submitted_at) {
            throw new Error('Quiz sudah di-submit');
        }

        // Submit and calculate score
        return QuizRepository.submitQuiz(data.attemptId);
    }

    static async getAttemptResult(userId: string, data: GetAttemptResultInput) {
        const attempt = await QuizRepository.getAttemptById(data.attemptId);
        if (!attempt) {
            throw new Error('Attempt tidak ditemukan');
        }

        // Verify user owns this attempt
        if (attempt.userId !== userId) {
            throw new Error('Anda tidak memiliki akses ke attempt ini');
        }

        // Calculate score if not yet calculated
        if (attempt.submitted_at && !attempt.is_graded) {
            await QuizRepository.calculateScore(data.attemptId);
            // Refetch attempt with updated score
            return QuizRepository.getAttemptById(data.attemptId);
        }

        return attempt;
    }

    static async getMyAttempts(userId: string, quizId: number) {
        return QuizRepository.getStudentAttempts(userId, quizId);
    }
}
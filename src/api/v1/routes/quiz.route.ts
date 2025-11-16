import { Router } from 'express';
import { QuizController } from '../controllers/quiz.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { verifyRole } from '../middlewares/verifyrole.middleware';
import { validateBody } from '../middlewares/schema.middleware';
import {
    createQuizSchema,
    updateQuizSchema,
    createQuestionSchema,
    updateQuestionSchema,
    startQuizAttemptSchema,
    saveAnswerSchema,
    submitQuizSchema,
} from '../schemas/quiz.schema';

const router = Router({ mergeParams: true });

// === TEACHER ===
// Get all quizzes by material
router.get(
    '/',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    QuizController.getQuizzesByMaterial
);

// Create quiz
router.post(
    '/',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    validateBody(createQuizSchema),
    QuizController.createQuiz
);

// Get quiz by ID
router.get('/:id', authMiddleware, verifyRole(['Teacher', "Admin"]), QuizController.getQuiz);

router.put(
    '/:id',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    validateBody(updateQuizSchema),
    QuizController.updateQuiz
);

router.delete('/:id', authMiddleware, verifyRole(['Teacher', "Admin"]), QuizController.deleteQuiz);

router.post(
    '/:quizId/questions',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    validateBody(createQuestionSchema),
    QuizController.createQuestion
);
router.put(
    '/questions/:questionId',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    validateBody(updateQuestionSchema),
    QuizController.updateQuestion
);
router.delete(
    '/questions/:questionId',
    authMiddleware,
    verifyRole(['Teacher', "Admin"]),
    QuizController.deleteQuestion
);

// === STUDENT ===
// Start quiz attempt
router.post(
    '/start',
    authMiddleware,
    validateBody(startQuizAttemptSchema),
    QuizController.startQuizAttempt
);

// Save answer (auto-save)
router.post(
    '/save-answer',
    authMiddleware,
    validateBody(saveAnswerSchema),
    QuizController.saveAnswer
);

// Submit quiz (final)
router.post(
    '/submit',
    authMiddleware,
    validateBody(submitQuizSchema),
    QuizController.submitQuiz
);

// Get attempt result
router.get(
    '/attempts/:attemptId/result',
    authMiddleware,
    QuizController.getAttemptResult
);

// Get all my attempts for a quiz
router.get(
    '/my-attempts/:quizId',
    authMiddleware,
    QuizController.getMyAttempts
);

// Get all questions for an attempt (resume failed attempt)
router.get(
    '/attempts/:attemptId/questions',
    authMiddleware,
    QuizController.getAttemptQuestions
);

export default router;
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
    verifyRole(['Teacher']),
    QuizController.getQuizzesByMaterial
);

// Create quiz
router.post(
    '/',
    authMiddleware,
    verifyRole(['Teacher']),
    validateBody(createQuizSchema),
    QuizController.createQuiz
);

// Get quiz by ID
router.get('/:id', authMiddleware, verifyRole(['Teacher']), QuizController.getQuiz);

router.put(
    '/:id',
    authMiddleware,
    verifyRole(['Teacher']),
    validateBody(updateQuizSchema),
    QuizController.updateQuiz
);

router.delete('/:id', authMiddleware, verifyRole(['Teacher']), QuizController.deleteQuiz);

router.post(
    '/:quizId/questions',
    authMiddleware,
    verifyRole(['Teacher']),
    validateBody(createQuestionSchema),
    QuizController.createQuestion
);
router.put(
    '/questions/:questionId',
    authMiddleware,
    verifyRole(['Teacher']),
    validateBody(updateQuestionSchema),
    QuizController.updateQuestion
);
router.delete(
    '/questions/:questionId',
    authMiddleware,
    verifyRole(['Teacher']),
    QuizController.deleteQuestion
);

// === STUDENT ===
// Start quiz attempt
router.post(
    '/start',
    authMiddleware,
    verifyRole(['Student']),
    validateBody(startQuizAttemptSchema),
    QuizController.startQuizAttempt
);

// Save answer (auto-save)
router.post(
    '/save-answer',
    authMiddleware,
    verifyRole(['Student']),
    validateBody(saveAnswerSchema),
    QuizController.saveAnswer
);

// Submit quiz (final)
router.post(
    '/submit',
    authMiddleware,
    verifyRole(['Student']),
    validateBody(submitQuizSchema),
    QuizController.submitQuiz
);

// Get attempt result
router.get(
    '/attempts/:attemptId/result',
    authMiddleware,
    verifyRole(['Student']),
    QuizController.getAttemptResult
);

// Get all my attempts for a quiz
router.get(
    '/my-attempts/:quizId',
    authMiddleware,
    verifyRole(['Student']),
    QuizController.getMyAttempts
);

export default router;
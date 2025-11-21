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


// === STUDENT ===
// Get all quizzes by material (student view)
router.get(
    '/student',
    verifyRole(['Student']),
    QuizController.getQuizzesByMaterialForStudent
);

// Start quiz attempt
router.post(
    '/start',
    validateBody(startQuizAttemptSchema),
    QuizController.startQuizAttempt
);

// Save answer (auto-save)
router.post(
    '/save-answer',
    validateBody(saveAnswerSchema),
    QuizController.saveAnswer
);

// Submit quiz (final)
router.post(
    '/submit',
    validateBody(submitQuizSchema),
    QuizController.submitQuiz
);

// Get attempt result
router.get(
    '/attempts/:attemptId/result',
    QuizController.getAttemptResult
);

// Get all my attempts for a quiz
router.get(
    '/my-attempts/:quizId',
    QuizController.getMyAttempts
);

// Get all questions for an attempt (resume failed attempt)
router.get(
    '/attempts/:attemptId/questions',
    QuizController.getAttemptQuestions
);

// Get quiz review with explanations (after submission)
router.get(
    '/attempts/:attemptId/review',
    QuizController.getQuizReview
);



// === TEACHER ===
// Get all quizzes by material
router.get(
    '/',
    verifyRole(['Teacher', "Admin"]),
    QuizController.getQuizzesByMaterial
);

// Create quiz
router.post(
    '/',
    verifyRole(['Teacher', "Admin"]),
    validateBody(createQuizSchema),
    QuizController.createQuiz
);

// Get quiz by ID
router.get('/:id', verifyRole(['Teacher', "Admin"]), QuizController.getQuiz);

router.put(
    '/:id',
    verifyRole(['Teacher', "Admin"]),
    validateBody(updateQuizSchema),
    QuizController.updateQuiz
);

router.delete('/:id', verifyRole(['Teacher', "Admin"]), QuizController.deleteQuiz);

router.post(
    '/:quizId/questions',
    verifyRole(['Teacher', "Admin"]),
    validateBody(createQuestionSchema),
    QuizController.createQuestion
);

// Get all questions by quiz (Teacher sees answers, Student doesn't)
router.get(
    '/:quizId/questions',
    QuizController.getAllQuestions
);

// Get question by ID (Teacher sees answers, Student doesn't)
router.get(
    '/questions/:questionId',
    QuizController.getQuestionById
);

router.put(
    '/questions/:questionId',
    verifyRole(['Teacher', "Admin"]),
    validateBody(updateQuestionSchema),
    QuizController.updateQuestion
);
router.delete(
    '/questions/:questionId',
    verifyRole(['Teacher', "Admin"]),
    QuizController.deleteQuestion
);


export default router;
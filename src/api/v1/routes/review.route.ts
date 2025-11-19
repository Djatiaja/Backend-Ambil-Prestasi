import { Router } from 'express';
import { ReviewController } from '../controllers/review.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { requireActiveSubscription } from '../middlewares/verifySubscription.middleware';
import { validateBody } from '../middlewares/schema.middleware';
import { createReviewSchema, updateReviewSchema } from '../schemas/review.schema';
import { verifyRole } from '../middlewares/verifyrole.middleware';

const reviewRouter = Router();

reviewRouter.get('/my-review/class/:classId', authMiddleware, ReviewController.getMyReview);


reviewRouter.post(
    '/class/:classId',
    authMiddleware,
    requireActiveSubscription,
    validateBody(createReviewSchema),
    ReviewController.create
);

reviewRouter.patch(
    '/:id',
    authMiddleware,
    requireActiveSubscription,
    validateBody(updateReviewSchema),
    ReviewController.update
);

reviewRouter.delete('/:id', authMiddleware, requireActiveSubscription, ReviewController.delete);


reviewRouter.get('/admin/all', authMiddleware, verifyRole(['Admin']), ReviewController.getAll);

// Admin: Approve review
reviewRouter.patch(
    '/admin/:id/approve',
    authMiddleware,
    verifyRole(['Admin']),
    ReviewController.approveReview
);

// Admin: Unapprove review
reviewRouter.patch(
    '/admin/:id/unapprove',
    authMiddleware,
    verifyRole(['Admin']),
    ReviewController.unapproveReview
);

reviewRouter.delete(
    '/admin/:id',
    authMiddleware,
    verifyRole(['Admin']),
    ReviewController.deleteByAdmin
);

export default reviewRouter;

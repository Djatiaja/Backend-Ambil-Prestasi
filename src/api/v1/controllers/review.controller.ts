import { Request, Response } from 'express';
import { ReviewService } from '../services/review.service';
import { CreateReviewDto, UpdateReviewDto } from '../schemas/review.schema';
import { sendResponse } from '../helpers/baseResponse';

export class ReviewController {
    // Student: Create review (requires subscription)
    static async create(req: Request, res: Response): Promise<void> {
        try {
            const userId = req.user!.id!;
            const dto = req.body as CreateReviewDto;
            const classId = parseInt(req.params.classId);

            if (isNaN(classId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid class ID',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.createReview(userId, dto, classId);
            sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: result.message,
                data: result.data,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Student: Update own review (requires subscription)
    static async update(req: Request, res: Response): Promise<void> {
        try {
            const userId = req.user!.id!;
            const reviewId = parseInt(req.params.id);
            const dto = req.body as UpdateReviewDto;

            if (isNaN(reviewId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid review ID',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.updateReview(userId, reviewId, dto);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: result.message,
                data: result.data,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Student: Delete own review
    static async delete(req: Request, res: Response): Promise<void> {
        try {
            const userId = req.user!.id!;
            const reviewId = parseInt(req.params.id);

            if (isNaN(reviewId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid review ID',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.deleteReview(userId, reviewId);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: result.message,
                data: null,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Get reviews by class (public - no auth required)
    static async getByClass(req: Request, res: Response): Promise<void> {
        try {
            const classId = parseInt(req.params.classId);
            const page = Number(req.query.page ?? 1);
            const limit = Number(req.query.limit ?? 10);

            if (isNaN(classId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid class ID',
                    data: null,
                });
                return;
            }

            if (!Number.isInteger(page) || !Number.isInteger(limit) || page < 1 || limit < 1) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid page or limit parameter',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.getClassReviews(classId, limit, page);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Reviews retrieved successfully',
                data: result.reviews,
                meta: result.meta,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Student: Get own review for a class
    static async getMyReview(req: Request, res: Response): Promise<void> {
        try {
            const userId = req.user!.id!;
            const classId = parseInt(req.params.classId);

            if (isNaN(classId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid class ID',
                    data: null,
                });
                return;
            }

            const review = await ReviewService.getMyReview(userId, classId);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: review ? 'Review found' : 'No review found',
                data: review,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Admin: Get all reviews
    static async getAll(req: Request, res: Response): Promise<void> {
        try {
            const page = Number(req.query.page ?? 1);
            const limit = Number(req.query.limit ?? 10);
            const search = req.query.search !== undefined ? String(req.query.search) : undefined;

            if (!Number.isInteger(page) || !Number.isInteger(limit) || page < 1 || limit < 1) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid page or limit parameter',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.getAllReviews(limit, page, search);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'All reviews retrieved successfully',
                data: result.reviews,
                meta: result.meta,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Admin: Delete any review
    static async deleteByAdmin(req: Request, res: Response): Promise<void> {
        try {
            const reviewId = parseInt(req.params.id);

            if (isNaN(reviewId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid review ID',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.deleteReviewByAdmin(reviewId);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: result.message,
                data: null,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    // Get average rating for a class (public)
    static async getAverageRating(req: Request, res: Response): Promise<void> {
        try {
            const classId = parseInt(req.params.classId);

            if (isNaN(classId)) {
                sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid class ID',
                    data: null,
                });
                return;
            }

            const result = await ReviewService.getClassAverageRating(classId);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Average rating retrieved successfully',
                data: result,
            });
        } catch (err) {
            const error = err as Error;
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }
}

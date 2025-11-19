import { ReviewRepository } from '../repositories/review.repository';
import { CreateReviewDto, UpdateReviewDto } from '../schemas/review.schema';
import prisma from '../../../database';
import { Review } from '@prisma/client';

type ReviewWithRelations = Review & {
    User: {
        id: string;
        name: string;
        username: string;
        profileImage: string;
    };
    Class: {
        id: number;
        name: string;
    };
};

export class ReviewService {
    // Check if user is enrolled in class
    static async verifyEnrollment(userId: string, classId: number): Promise<boolean> {
        const enrollment = await prisma.user_Class.findFirst({
            where: {
                userId,
                classId,
                role: 'Student',
            },
        });
        return !!enrollment;
    }

    // Student: Create review
    static async createReview(
        userId: string,
        dto: CreateReviewDto,
        classId: number
    ): Promise<{
        message: string;
        data: ReviewWithRelations;
    }> {
        const { rating, comment } = dto;

        // Check if user already reviewed this class
        const existingReview = await ReviewRepository.findByUserAndClass(userId, classId);
        if (existingReview) {
            throw new Error('You have already reviewed this class. Use update instead.');
        }

        const review = await ReviewRepository.create({
            userId,
            classId,
            rating,
            comment,
        });

        return {
            message: 'Review created successfully. Waiting for admin approval.',
            data: review as ReviewWithRelations,
        };
    }

    // Student: Update own review
    static async updateReview(
        userId: string,
        reviewId: number,
        dto: UpdateReviewDto
    ): Promise<{
        message: string;
        data: ReviewWithRelations;
    }> {
        const review = await ReviewRepository.findById(reviewId);
        if (!review) {
            throw new Error('Review not found');
        }

        // Verify ownership
        if (review.userId !== userId) {
            throw new Error('You can only update your own reviews');
        }

        const updated = await ReviewRepository.update(reviewId, dto);

        return {
            message: 'Review updated successfully',
            data: updated as ReviewWithRelations,
        };
    }

    // Student: Delete own review
    static async deleteReview(userId: string, reviewId: number): Promise<{ message: string }> {
        const review = await ReviewRepository.findById(reviewId);
        if (!review) {
            throw new Error('Review not found');
        }

        // Verify ownership
        if (review.userId !== userId) {
            throw new Error('You can only delete your own reviews');
        }

        await ReviewRepository.delete(reviewId);

        return {
            message: 'Review deleted successfully',
        };
    }

    // Get reviews by class (public)
    static async getClassReviews(classId: number, limit: number = 10, page: number = 1): Promise<{
        reviews: Review[];
        meta: {
            totalItems: number;
            itemsPerPage: number;
            totalPages: number;
            currentPage: number;
            averageRating: number;
        };
    }> {
        const reviews = await ReviewRepository.getByClass(classId, limit, page);
        const totalItems = await ReviewRepository.countByClass(classId);
        const averageRating = await ReviewRepository.getAverageRating(classId);

        return {
            reviews,
            meta: {
                totalItems,
                itemsPerPage: limit,
                totalPages: Math.ceil(totalItems / limit),
                currentPage: page,
                averageRating: Number(averageRating.toFixed(2)),
            },
        };
    }

    // Student: Get own review for a class
    static async getMyReview(userId: string, classId: number): Promise<Omit<ReviewWithRelations, 'isApproved'> | null> {
        const review = await ReviewRepository.findByUserAndClass(userId, classId);

        if (!review) {
            return null;
        }

        // Remove isApproved field to hide approval status from student
        const { isApproved, ...reviewWithoutApproval } = review;

        return reviewWithoutApproval as Omit<ReviewWithRelations, 'isApproved'>;
    }

    // Admin: Get all reviews
    static async getAllReviews(
        limit: number = 10,
        page: number = 1,
        search?: string
    ): Promise<{
        reviews: Review[];
        meta: {
            totalItems: number;
            itemsPerPage: number;
            totalPages: number;
            currentPage: number;
        };
    }> {
        const reviews = await ReviewRepository.getAll(limit, page, search);
        const totalItems = await ReviewRepository.countAll(search);

        return {
            reviews,
            meta: {
                totalItems,
                itemsPerPage: limit,
                totalPages: Math.ceil(totalItems / limit),
                currentPage: page,
            },
        };
    }

    // Admin: Delete any review
    static async deleteReviewByAdmin(reviewId: number): Promise<{ message: string }> {
        const review = await ReviewRepository.findById(reviewId);
        if (!review) {
            throw new Error('Review not found');
        }

        await ReviewRepository.delete(reviewId);

        return {
            message: 'Review deleted successfully',
        };
    }

    // Get average rating for a class (public)
    static async getClassAverageRating(classId: number): Promise<{
        classId: number;
        averageRating: number;
        totalReviews: number;
    }> {
        const averageRating = await ReviewRepository.getAverageRating(classId);
        const totalReviews = await ReviewRepository.countByClass(classId);

        return {
            classId,
            averageRating: Number(averageRating.toFixed(2)),
            totalReviews,
        };
    }

    // Admin: Approve review
    static async approveReview(reviewId: number): Promise<{
        message: string;
        data: ReviewWithRelations;
    }> {
        const review = await ReviewRepository.findById(reviewId);
        if (!review) {
            throw new Error('Review not found');
        }

        const approved = await ReviewRepository.approve(reviewId);

        return {
            message: 'Review approved successfully',
            data: approved as ReviewWithRelations,
        };
    }

    // Admin: Unapprove/Reject review
    static async unapproveReview(reviewId: number): Promise<{
        message: string;
        data: ReviewWithRelations;
    }> {
        const review = await ReviewRepository.findById(reviewId);
        if (!review) {
            throw new Error('Review not found');
        }

        const unapproved = await ReviewRepository.unapprove(reviewId);

        return {
            message: 'Review unapproved successfully',
            data: unapproved as ReviewWithRelations,
        };
    }
}

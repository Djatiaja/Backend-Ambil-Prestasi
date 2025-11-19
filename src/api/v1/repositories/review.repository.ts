import { Review } from '@prisma/client';
import prisma from '../../../database';

export class ReviewRepository {
    // Student operations
    static async create(data: {
        userId: string;
        classId: number;
        rating: number;
        comment?: string;
    }): Promise<Review> {
        return prisma.review.create({
            data,
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    static async findById(id: number): Promise<Review | null> {
        return prisma.review.findUnique({
            where: { id },
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    static async findByUserAndClass(userId: string, classId: number): Promise<Review | null> {
        return prisma.review.findFirst({
            where: { userId, classId },
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    static async update(id: number, data: { rating?: number; comment?: string }): Promise<Review> {
        return prisma.review.update({
            where: { id },
            data,
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    static async delete(id: number): Promise<Review> {
        return prisma.review.delete({
            where: { id },
        });
    }

    static async getByClass(classId: number, limit: number, page: number): Promise<Review[]> {
        const skip = (page - 1) * limit;
        return prisma.review.findMany({
            where: {
                classId,
                isApproved: true // Only show approved reviews to public
            },
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
            skip,
            take: limit,
        });
    }

    static async countByClass(classId: number): Promise<number> {
        return prisma.review.count({
            where: {
                classId,
                isApproved: true // Only count approved reviews
            },
        });
    }

    static async getAverageRating(classId: number): Promise<number> {
        const result = await prisma.review.aggregate({
            where: {
                classId,
                isApproved: true // Only calculate from approved reviews
            },
            _avg: {
                rating: true,
            },
        });
        return result._avg.rating || 0;
    }

    // Admin operations
    static async getAll(limit: number, page: number, search?: string): Promise<Review[]> {
        const skip = (page - 1) * limit;
        const where = search
            ? {
                OR: [
                    { User: { name: { contains: search } } },
                    { User: { username: { contains: search } } },
                    { Class: { name: { contains: search } } },
                    { comment: { contains: search } },
                ],
            }
            : {};

        return prisma.review.findMany({
            where,
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
            skip,
            take: limit,
        });
    }

    static async countAll(search?: string): Promise<number> {
        const where = search
            ? {
                OR: [
                    { User: { name: { contains: search } } },
                    { User: { username: { contains: search } } },
                    { Class: { name: { contains: search } } },
                    { comment: { contains: search } },
                ],
            }
            : {};

        return prisma.review.count({ where });
    }

    // Admin: Approve review
    static async approve(id: number): Promise<Review> {
        return prisma.review.update({
            where: { id },
            data: { isApproved: true },
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    // Admin: Reject/Unapprove review
    static async unapprove(id: number): Promise<Review> {
        return prisma.review.update({
            where: { id },
            data: { isApproved: false },
            include: {
                User: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        profileImage: true,
                    },
                },
                Class: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }
}

import { User_Subscription, RedeemCode, RedeemHistory } from '@prisma/client';
import prisma from '../../../database';

export class SubscriptionRepository {
    static async getActiveSubscription(userId: string): Promise<User_Subscription | null> {
        return prisma.user_Subscription.findFirst({
            where: { userId, status: 'ACTIVE', endAt: { gte: new Date() } },
        });
    }

    static async upsertSubscription(userId: string, durationDays: number): Promise<User_Subscription> {
        const endAt = new Date();
        endAt.setDate(endAt.getDate() + durationDays);

        const existing = await this.getActiveSubscription(userId);
        if (existing) {
            // Extend existing subscription
            return prisma.user_Subscription.update({
                where: { id: existing.id },
                data: { endAt },
            });
        }

        // Create new subscription
        return prisma.user_Subscription.create({
            data: { userId, endAt },
        });
    }

    static async findRedeemCode(code: string): Promise<RedeemCode | null> {
        return prisma.redeemCode.findUnique({ where: { code } });
    }

    static async hasRedeemed(userId: string, codeId: number): Promise<boolean> {
        const history = await prisma.redeemHistory.findUnique({
            where: { userId_codeId: { userId, codeId } },
        });
        return !!history;
    }

    static async createRedeemHistory(userId: string, codeId: number): Promise<RedeemHistory> {
        return prisma.redeemHistory.create({
            data: { userId, codeId },
        });
    }

    static async incrementUsedCount(codeId: number): Promise<void> {
        await prisma.redeemCode.update({
            where: { id: codeId },
            data: { usedCount: { increment: 1 } },
        });
    }

    static async createRedeemCode(data: {
        code: string;
        durationDays: number;
        maxUses: number;
        usedCount?: number;
        expiresAt?: Date | null;
    }): Promise<RedeemCode> {
        return prisma.redeemCode.create({ data });
    }

    // === ADMIN CRUD ===
    static async getAllRedeemCodes(limit: number, page: number, search?: string): Promise<RedeemCode[]> {
        const skip = (page - 1) * limit;
        const where = search ? {
            code: { contains: search }
        } : {};

        return prisma.redeemCode.findMany({
            where,
            orderBy: { createdAt: 'desc' },
            skip,
            take: limit,
        });
    }

    static async countRedeemCodes(search?: string): Promise<number> {
        const where = search ? {
            code: { contains: search }
        } : {};

        return prisma.redeemCode.count({ where });
    }

    static async findRedeemCodeById(id: number): Promise<RedeemCode | null> {
        return prisma.redeemCode.findUnique({ where: { id } });
    }

    static async updateRedeemCode(
        id: number,
        data: { durationDays?: number; maxUses?: number; expiresAt?: Date | null }
    ): Promise<RedeemCode> {
        return prisma.redeemCode.update({
            where: { id },
            data,
        });
    }

    static async deleteRedeemCode(id: number): Promise<void> {
        await prisma.redeemCode.delete({ where: { id } });
    }
}
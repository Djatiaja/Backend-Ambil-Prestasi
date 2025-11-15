// src/modules/subscription/services/subscription.service.ts
import { SubscriptionRepository } from '../repositories/subscription.repository';
import { RedeemCode } from '@prisma/client';
import { RedeemCodeDto, CreateRedeemCodeDto, UpdateRedeemCodeDto } from '../schemas/redeem-code.schema';
import userService from './user.service';

export class SubscriptionService {
    private static generateRandomCode(length: number = 8): string {
        const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        let result = '';
        for (let i = 0; i < length; i++) {
            result += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return result;
    }

    static async redeemCode(userId: string, dto: RedeemCodeDto): Promise<{ message: string }> {
        const { code } = dto;

        const redeemCode = await SubscriptionRepository.findRedeemCode(code);
        if (!redeemCode) throw new Error('Kode tidak valid');

        if (redeemCode.expiresAt && redeemCode.expiresAt < new Date())
            throw new Error('Kode sudah kadaluarsa');

        if (redeemCode.usedCount >= redeemCode.maxUses)
            throw new Error('Batas penggunaan kode telah tercapai');

        if (await SubscriptionRepository.hasRedeemed(userId, redeemCode.id))
            throw new Error('Anda sudah menggunakan kode ini');

        await SubscriptionRepository.upsertSubscription(userId, redeemCode.durationDays);
        await SubscriptionRepository.createRedeemHistory(userId, redeemCode.id);
        await SubscriptionRepository.incrementUsedCount(redeemCode.id);

        return { message: 'Subscription berhasil diaktifkan/diperpanjang!' };
    }

    static async isSubscriptionActive(userId: string): Promise<boolean> {
        const sub = await SubscriptionRepository.getActiveSubscription(userId);
        return !!sub;
    }

    static async canBypassSubscription(userId: string): Promise<boolean> {
        const role = await userService.getUserById(userId).then(u => u?.role.name);
        return role === 'Teacher' || role === 'Admin';
    }

    static async createRedeemCodeByAdmin(
        dto: CreateRedeemCodeDto
    ): Promise<{
        code: string;
        durationDays: number;
        maxUses: number;
        expiresAt: Date | null;
        message: string;
    }> {
        const { durationDays, maxUses, expiresAt } = dto;

        let code = '';
        let isUnique = false;
        while (!isUnique) {
            code = this.generateRandomCode();
            const existing = await SubscriptionRepository.findRedeemCode(code);
            if (!existing) isUnique = true;
        }

        if (!code) throw new Error('Gagal membuat kode redeem');
        const data: Parameters<typeof SubscriptionRepository.createRedeemCode>[0] = {
            code,
            durationDays,
            maxUses,
            usedCount: 0,
            expiresAt: expiresAt ? new Date(expiresAt) : null,
        };

        const created: RedeemCode = await SubscriptionRepository.createRedeemCode(data);

        return {
            code: created.code,
            durationDays: created.durationDays,
            maxUses: created.maxUses,
            expiresAt: created.expiresAt,
            message: 'Redeem code berhasil dibuat!',
        };
    }

    static async getAllRedeemCodes(data: { limit?: number; page?: number; search?: string }): Promise<{
        codes: RedeemCode[];
        meta: {
            totalItems: number;
            itemsPerPage: number;
            totalPages: number;
            currentPage: number;
        };
    }> {
        const { limit = 10, page = 1, search } = data;
        const codes = await SubscriptionRepository.getAllRedeemCodes(limit, page, search);
        const totalItems = await SubscriptionRepository.countRedeemCodes(search);

        const meta = {
            totalItems,
            itemsPerPage: limit,
            totalPages: Math.ceil(totalItems / limit),
            currentPage: page
        };

        return { codes, meta };
    }

    static async getRedeemCodeById(id: number): Promise<RedeemCode | null> {
        return await SubscriptionRepository.findRedeemCodeById(id);
    }

    static async updateRedeemCode(id: number, dto: UpdateRedeemCodeDto): Promise<RedeemCode> {


        const { ...data } = dto;
        const existing = await SubscriptionRepository.findRedeemCodeById(id);
        if (!existing) throw new Error('Redeem code not found');

        const updateData: Partial<RedeemCode> = {
            durationDays: data.durationDays ?? existing.durationDays,
            maxUses: data.maxUses ?? existing.maxUses,
            expiresAt: data.expiresAt ? new Date(data.expiresAt) : existing.expiresAt,
        };

        return await SubscriptionRepository.updateRedeemCode(id, updateData);
    }

    static async deleteRedeemCode(id: number): Promise<void> {
        const existing = await SubscriptionRepository.findRedeemCodeById(id);
        if (!existing) throw new Error('Redeem code not found');
        await SubscriptionRepository.deleteRedeemCode(id);
    }
}
// src/modules/subscription/controllers/redeem.controller.ts
import { Request, Response } from 'express';
import { SubscriptionService } from '../services/subscription.service';
import { CreateRedeemCodeDto, RedeemCodeDto, UpdateRedeemCodeDto } from '../schemas/redeem-code.schema';
import { sendResponse } from '../helpers/baseResponse';

export class RedeemController {
    static async redeem(req: Request, res: Response): Promise<void> {
        const userId = req.user!.id!;
        const data = req.body as RedeemCodeDto;
        try {
            const result = await SubscriptionService.redeemCode(userId, data);
            sendResponse({ res, statusCode: 200, success: true, message: result.message, data: null });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 400, success: false, message: error.message, data: null });
        }
    }

    static async create(req: Request, res: Response): Promise<void> {
        const dto = req.body as CreateRedeemCodeDto;
        try {
            const result = await SubscriptionService.createRedeemCodeByAdmin(dto);
            sendResponse({ res, statusCode: 201, success: true, message: result.message, data: result });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 400, success: false, message: error.message, data: null });
        }
    }

    static async getAll(req: Request, res: Response): Promise<void> {
        try {
            const page = Number(req.query.page ?? 1);
            const limit = Number(req.query.limit ?? 10);
            const search = req.query.search !== undefined ? String(req.query.search) : undefined;

            if (!Number.isInteger(page) || !Number.isInteger(limit) || page < 1 || limit < 1) {
                sendResponse({ res, statusCode: 400, success: false, message: 'Invalid page or limit parameter', data: null });
                return;
            }

            const { codes, meta } = await SubscriptionService.getAllRedeemCodes({ limit, page, search });
            sendResponse({ res, statusCode: 200, success: true, message: 'Redeem codes retrieved successfully', data: codes, meta });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 500, success: false, message: error.message, data: null });
        }
    }

    static async getById(req: Request, res: Response): Promise<void> {
        const id = parseInt(req.params.id);
        if (isNaN(id)) {
            sendResponse({ res, statusCode: 400, success: false, message: 'Invalid ID', data: null });
            return;
        }
        try {
            const code = await SubscriptionService.getRedeemCodeById(id);
            if (!code) {
                sendResponse({ res, statusCode: 404, success: false, message: 'Redeem code not found', data: null });
                return;
            }
            sendResponse({ res, statusCode: 200, success: true, message: 'Redeem code retrieved successfully', data: code });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 500, success: false, message: error.message, data: null });
        }
    }

    static async update(req: Request, res: Response): Promise<void> {
        const id = parseInt(req.params.id);
        if (isNaN(id)) {
            sendResponse({ res, statusCode: 400, success: false, message: 'Invalid ID', data: null });
            return;
        }
        const dto = { id, ...req.body } as UpdateRedeemCodeDto;
        try {
            const updated = await SubscriptionService.updateRedeemCode(id, dto);
            sendResponse({ res, statusCode: 200, success: true, message: 'Redeem code updated successfully', data: updated });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 400, success: false, message: error.message, data: null });
        }
    }

    static async delete(req: Request, res: Response): Promise<void> {
        const id = parseInt(req.params.id);
        if (isNaN(id)) {
            sendResponse({ res, statusCode: 400, success: false, message: 'Invalid ID', data: null });
            return;
        }
        try {
            await SubscriptionService.deleteRedeemCode(id);
            sendResponse({ res, statusCode: 200, success: true, message: 'Redeem code deleted successfully', data: null });
        } catch (err) {
            const error = err as Error;
            sendResponse({ res, statusCode: 400, success: false, message: error.message, data: null });
        }
    }


}
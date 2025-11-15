// src/middleware/requireActiveSubscription.ts
import { Request, Response, NextFunction } from 'express';
import { SubscriptionService } from '../services/subscription.service';
import { sendResponse } from '../helpers/baseResponse';

export const requireActiveSubscription = async (
    req: Request,
    res: Response,
    next: NextFunction
): Promise<void> => {

    const userId = req.user!.id!;
    if (!userId) {
        await sendResponse({
            res,
            statusCode: 401,
            success: false,
            message: 'Unauthorized',
            data: null,
        });
        return;
    }

    try {
        const canBypass = await SubscriptionService.canBypassSubscription(userId);
        if (canBypass) return next();

        const isActive = await SubscriptionService.isSubscriptionActive(userId);
        if (!isActive) {
            await sendResponse({
                res,
                statusCode: 402,
                success: false,
                message: 'Subscription required',
                data: null,
            });
            return;
        }

        next();
    } catch {
        await sendResponse({
            res,
            statusCode: 500,
            success: false,
            message: 'Server error',
            data: null,
        });
    }
};
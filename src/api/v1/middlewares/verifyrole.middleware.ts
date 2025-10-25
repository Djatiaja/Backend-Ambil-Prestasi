import { NextFunction, Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";

export const verifyRole =
    (roles: string[]) => async (request: Request, response: Response, next: NextFunction) => {
        try {
            const user = request.body.user;
            if (!user || !roles.includes(user.role)) {
                return response.sendStatus(404);
            }
            next();
        } catch (err: unknown) {
            sendResponse({
                res: response,
                statusCode: 500,
                success: false,
                message: "Internal server error",
                data: null,
            });
        }
    };
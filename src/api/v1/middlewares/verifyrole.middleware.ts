import { NextFunction, Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";

export const verifyRole =
    (roles: string[]) => async (request: Request, response: Response, next: NextFunction) => {
        try {
            const role = request.role;
            if (!role || !roles.includes(role)) {
                return response.sendStatus(404);
            }
            next();
        } catch (err: unknown) {
            console.error("Role verification error:", err);
            sendResponse({
                res: response,
                statusCode: 500,
                success: false,
                message: "Internal server error",
                data: null,
            });
        }
    };
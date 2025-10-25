import jwt from "jsonwebtoken";
import { NextFunction, Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import { JwtPayload } from "../types/auth.type";
import { userRepository } from "../repositories/user.repository";
import roleRepository from "../repositories/role.repository";

const JWT_SECRET = process.env.JWT_SECRET ?? "";

export const authMiddleware = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader) {
            return sendResponse({
                res,
                statusCode: 401,
                success: false,
                message: "Authentication is required",
                data: null,
                errors: { authorization: ["Authorization header missing"] },
            });
        }

        const token = authHeader.startsWith("Bearer ")
            ? authHeader.split(" ")[1]
            : authHeader;

        let payload: JwtPayload;
        try {
            payload = jwt.verify(token, JWT_SECRET) as JwtPayload;
        } catch (err) {
            return sendResponse({
                res,
                statusCode: 401,
                success: false,
                message: "Invalid or expired token",
                data: null,
                errors: { token: [err instanceof Error ? err.message : String(err)] },
            });
        }

        const rootuser = await userRepository.findUserById(payload.user_id);
        const userRole = await userRepository.getUserRole(payload.user_id);

        if (!rootuser) {
            return sendResponse({
                res,
                statusCode: 401,
                success: false,
                message: "User not found",
                data: null,
            });
        }

        req.user = rootuser;
        req.token = token;
        req.role = userRole ?? "";
        next();
    } catch (error) {
        return sendResponse({
            res,
            statusCode: 500,
            success: false,
            message: "Internal server error",
            data: null,
            errors: { server: [error instanceof Error ? error.message : String(error)] },
        });
    }
};
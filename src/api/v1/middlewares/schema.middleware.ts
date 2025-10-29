import { NextFunction, Request, Response } from "express";
import { ZodError, ZodSchema } from "zod";
import { sendResponse } from "../helpers/baseResponse";

export const validateBody =
    (schema: ZodSchema) =>
        async (request: Request, response: Response, next: NextFunction) => {
            const payload = {
                ...request.body,
                ...(request.file ? { file: request.file } : {}),
            };

            const result = await schema.safeParseAsync(payload);

            if (!result.success) {
                const errors: Record<string, string[]> = {};

                result.error.issues.forEach((issue) => {
                    const field = issue.path.join(".") || "global";
                    if (!errors[field]) errors[field] = [];
                    errors[field].push(issue.message);
                });

                return sendResponse({
                    res: response,
                    statusCode: 400,
                    success: false,
                    message: "Request validation failed",
                    data: null,
                    errors,
                });
            }

            // ✅ Validation passed, attach parsed data to request for next handler
            request.body = result.data;
            next();
        };

import { NextFunction, Request, RequestHandler, Response } from "express";
import { ZodError, ZodSchema } from "zod";
import { sendResponse } from "../helpers/baseResponse";

export const validateBody =
    (schema: ZodSchema) => (request: Request, response: Response, next: NextFunction) => {
        try {
            schema.parse(request.body);
            next();
        } catch (err: unknown) {
            if (err instanceof ZodError) {

                // Group issues by field
                const errors: Record<string, string[]> = {};

                err.issues.forEach(issue => {
                    const field = issue.path.join(".") || "global";
                    if (!errors[field]) {
                        errors[field] = [];
                    }
                    errors[field].push(issue.message);
                });

                sendResponse({
                    res: response, statusCode: 500, success: false, message: "Request validation fail", data: null, errors: errors
                });
            }
        }
    };
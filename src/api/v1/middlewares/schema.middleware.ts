import { NextFunction, Request, Response } from "express";
import { ZodError, ZodSchema } from "zod";
import { sendResponse } from "../helpers/baseResponse";

export const validateBody =
    (schema: ZodSchema) => async (request: Request, response: Response, next: NextFunction) => {
        try {
            const data = await schema.parseAsync(request.body);
            request.body = data;
            next();
        } catch (err: unknown) {
            if (err instanceof ZodError) {
                const errors: Record<string, string[]> = {};
                console.log(err);
                console.log(request.body);
                err.issues.forEach(issue => {
                    const field = issue.path.join(".") || "global";
                    if (!errors[field]) {
                        errors[field] = [];
                    }
                    errors[field].push(issue.message);
                });

                sendResponse({
                    res: response, statusCode: 400, success: false, message: "Request validation fail", data: null, errors: errors
                });
            }
        }
    };
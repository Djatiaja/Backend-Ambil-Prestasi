// middlewares/schema.middleware.ts
import { NextFunction, Request, Response } from "express";
import { ZodError, ZodSchema } from "zod";
import { sendResponse } from "../helpers/baseResponse";

export const validateBody =
    (schema: ZodSchema) =>
        async (req: Request, res: Response, next: NextFunction) => {
            const payload: Record<string, any> = { ...req.body };

            // Handle upload.fields() → req.files is Record<string, Express.Multer.File[]>
            if (req.files && typeof req.files === "object" && !Array.isArray(req.files)) {
                Object.entries(req.files).forEach(([key, files]) => {
                    payload[key] = files[0]; // kita hanya izinkan 1 file per field
                });
            }

            // Handle upload.single()
            if (req.file) {
                payload.file = req.file;
            }
            console.log("Validation payload:", payload);

            const result = await schema.safeParseAsync(payload);
            if (!result.success) {
                const errors: Record<string, string[]> = {};
                result.error.issues.forEach((issue) => {
                    const path = issue.path.join(".") || "global";
                    errors[path] ??= [];
                    errors[path].push(issue.message);
                });

                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: "Validasi gagal",
                    data: null,
                    errors,
                });
            }

            req.body = result.data; // override body dengan data yang sudah divalidasi
            next();
        };
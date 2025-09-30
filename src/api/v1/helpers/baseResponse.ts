import { Response } from "express";
import { BaseResponse } from "../types/responseType";

type SendResponseParams<Tdata> = {
    res: Response;
    statusCode: number;
    success: boolean;
    message: string;
    data: Tdata;
    errors?: Record<string, string[]>;
    meta?: {
        totalItems: number;
        itemCount: number;
        itemsPerPage: number;
        totalPages: number;
        currentPage: number;
    };
};

export function sendResponse<Tdata>({
    res,
    statusCode,
    success,
    message,
    data,
    errors,
    meta,
}: SendResponseParams<Tdata>) {
    const response: BaseResponse<Tdata> = {
        success,
        message,
        data,
        meta,
        errors: errors ?? undefined,
    };
    return res.status(statusCode).json(response);
}
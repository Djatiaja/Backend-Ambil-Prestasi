import { BaseResponse } from "../types/responseType";

type SendResponseParams<Tdata> = {
    res: any;
    statusCode: number;
    success: boolean;
    message: string;
    data: Tdata;
    error?: string[];
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
    error,
    meta,
}: SendResponseParams<Tdata>) {
    const response: BaseResponse<Tdata> = {
        success,
        message,
        data,
        meta,
        error: error ? [...error] : [],
    };
    return res.status(statusCode).json(response);
}
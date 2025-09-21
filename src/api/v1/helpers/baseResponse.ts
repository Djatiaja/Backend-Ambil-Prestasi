import { BaseResponse } from "../types/responseType";


export function sendResponse<Tdata, Terror>(
    res: any,
    statusCode: number,
    success: boolean,
    message: string,
    data: Tdata,
    error?: string[],
    meta?: {
        totalItems: number;
        itemCount: number;
        itemsPerPage: number;
        totalPages: number;
        currentPage: number;
    }
) {
    const response: BaseResponse<Tdata> = {
        success: success,
        message: message,
        data: data,
        meta: meta,
        error: error ? [...error] : [],
    };
    return res.status(statusCode).json(response);
}   
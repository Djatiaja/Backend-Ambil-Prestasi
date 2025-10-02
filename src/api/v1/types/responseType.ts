export interface BaseResponse<Tdata> {
    success: boolean;
    message: string;
    data: Tdata;
    meta?: {
        totalItems: number;
        itemsPerPage: number;
        totalPages: number;
        currentPage: number;
    };
    errors?: Record<string, string[]>;
}
export interface BaseResponse<Tdata> {
    success: boolean;
    message: string;
    data: Tdata;
    meta?: {
        totalItems: number;
        itemCount: number;
        itemsPerPage: number;
        totalPages: number;
        currentPage: number;
    };
    error: string[];
}
import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import materialService from "../services/material.service";


class StudentController {

    async getMaterialById(req: Request, res: Response) {
        const materialId = req.params.id;
        if (Number.isNaN(Number(materialId))) {
            return sendResponse({ res, statusCode: 400, success: false, message: "Invalid material ID", data: null });
        }

        try {
            const material = await materialService.getMaterialById(Number(materialId));
            return sendResponse({ res, statusCode: 200, success: true, data: material, message: "Material retrieved successfully" });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Internal server error";
            return sendResponse({ res, statusCode: 500, success: false, message, data: null });
        }
    }
}

export default new StudentController();
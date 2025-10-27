import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import materialFileService from "../services/materialFile.service";
import { CreateMaterialFileDto, UpdateMaterialFileDto } from "../schemas/materialFile.schema";

export class MaterialFileController {

    async getAllMaterialFiles(req: Request, res: Response) {
        try {
            const materialFiles = await materialFileService.getAllMaterialFiles();
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material files retrieved successfully",
                data: materialFiles,
            });
        } catch (error: any) {
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: "Failed to retrieve material files",
                data: null,
                errors: { general: [error.message] },
            });
        }
    }

    async getMaterialFileById(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.fileID);
            const materialFile = await materialFileService.getMaterialFileById(id);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material file retrieved successfully",
                data: materialFile,
            });
        } catch (error: any) {
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [error.message] },
            });
        }
    }

    async createMaterialFile(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            const dto: CreateMaterialFileDto = req.body;
            const filePath = req.file ? `uploads/${req.file.filename}` : undefined;
            if (!filePath) {
                throw new Error("File upload failed");
            }
            const materialFile = await materialFileService.createMaterialFile(dto, filePath, materialId);
            sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: "Material file created successfully",
                data: materialFile,
            });
        } catch (error: any) {
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: "Failed to create material file",
                data: null,
                errors: { general: [error.message] },
            });
        }
    }

    async updateMaterialFile(req: Request, res: Response) {
        try {

            const id = parseInt(req.params.fileID);
            const dto: UpdateMaterialFileDto = req.body;
            const materialId = parseInt(req.params.materialId);
            const filePath = req.file ? `uploads/${req.file.filename}` : undefined;
            const materialFile = await materialFileService.updateMaterialFile(id, dto, materialId, filePath);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material file updated successfully",
                data: materialFile,
            });
        } catch (error: any) {
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [error.message] },
            });
        }
    }

    async deleteMaterialFile(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.fileID);
            await materialFileService.deleteMaterialFile(id);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material file deleted successfully",
                data: null,
            });
        } catch (error: any) {
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [error.message] },
            });
        }
    }
}

export default new MaterialFileController();
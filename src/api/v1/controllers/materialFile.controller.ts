import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import materialFileService from "../services/materialFile.service";
import { CreateMaterialFileDto, UpdateMaterialFileDto } from "../schemas/materialFile.schema";
import { imageType, optimizeImage } from "../helpers/imageCompress";
import { saveFile } from "../helpers/file";

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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: "Failed to retrieve material files",
                data: null,
                errors: { general: [msg] },
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [msg] },
            });
        }
    }

    async createMaterialFile(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            const dto: CreateMaterialFileDto = req.body;

            const file = req.file;

            if (!file) {
                return res.status(400).json({ error: "No file uploaded" });
            }

            const type = imageType.THUMBNAIL;

            const optimizedBuffer = await optimizeImage(file.buffer, file.mimetype, type);
            file.buffer = optimizedBuffer;

            const uploadPath = await saveFile(file);

            const materialFile = await materialFileService.createMaterialFile(dto, uploadPath, materialId);
            sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: "Material file created successfully",
                data: materialFile,
            });
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: "Failed to create material file",
                data: null,
                errors: { general: [msg] },
            });
        }
    }

    async updateMaterialFile(req: Request, res: Response) {
        try {

            const id = parseInt(req.params.fileID);
            const dto: UpdateMaterialFileDto = req.body;
            const file = req.file;
            let uploadPath: string | undefined = undefined;
            if (file) {

                const type = imageType.THUMBNAIL;

                const optimizedBuffer = await optimizeImage(file.buffer, file.mimetype, type);
                file.buffer = optimizedBuffer;

                uploadPath = await saveFile(file);

            }

            const materialId = parseInt(req.params.materialId);
            const materialFile = await materialFileService.updateMaterialFile(id, dto, materialId, uploadPath);
            sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material file updated successfully",
                data: materialFile,
            });
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [msg] },
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            sendResponse({
                res,
                statusCode: 404,
                success: false,
                message: "Material file not found",
                data: null,
                errors: { general: [msg] },
            });
        }
    }
}

export default new MaterialFileController();
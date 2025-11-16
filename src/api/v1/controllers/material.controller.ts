import { Request, Response } from 'express';
import { sendResponse } from '../helpers/baseResponse';
import { NotFoundError } from '../errors/notfound.error';
import materialService from '../services/material.service';
import sectionService from '../services/section.service';

export class MaterialController {

    async getAllMaterials(req: Request, res: Response) {
        try {
            const sectionId = parseInt(req.params.sectionId);

            const checkSection = await sectionService.getSectionById(req.params.sectionId);
            if (!checkSection) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Section not found',
                    data: null,
                });
            }

            const materials = await materialService.getAllMaterials(sectionId);
            if (!materials) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Materials not found',
                    data: null,
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Materials retrieved successfully',
                data: materials,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: 'Failed to retrieve materials',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async getMaterialById(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.materialId);
            if (Number.isNaN(id)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid material ID',
                    data: null,
                });
            }
            const material = await materialService.getMaterialById(id);
            if (!material) {
                sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Material not found',
                    data: null,
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Material retrieved successfully',
                data: material,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode,
                success: false,
                message: error instanceof NotFoundError ? error.message : 'Failed to retrieve material',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async createMaterial(req: Request, res: Response) {
        try {
            const sectionId = req.params.sectionId;
            const section = await sectionService.getSectionById(sectionId);
            if (!section)
                return sendResponse({ res, statusCode: 404, success: false, message: "Section not found", data: null });

            const material = await materialService.createMaterial(req.body, parseInt(sectionId));
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: "Material created successfully",
                data: material,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: "Failed to create material",
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async updateMaterial(req: Request, res: Response) {
        try {
            const id = req.params.materialId;
            if (Number.isNaN(parseInt(id))) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: "Invalid material ID",
                    data: null,
                });
            }
            const material = await materialService.updateMaterial(Number(id), req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Material updated successfully",
                data: material,
            });
        } catch (error) {
            const status = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode: status,
                success: false,
                message: error instanceof NotFoundError ? error.message : "Failed to update material",
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async deleteMaterial(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.materialId);
            await materialService.deleteMaterial(id);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Material deleted successfully',
                data: null,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode,
                success: false,
                message: error instanceof NotFoundError ? error.message : 'Failed to delete material',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async completeMaterial(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            const userId = req.user!.id!;

            if (Number.isNaN(materialId)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid material ID',
                    data: null,
                });
            }

            const result = await materialService.completeMaterial(userId, materialId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Material marked as completed',
                data: result,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode,
                success: false,
                message: error instanceof NotFoundError ? error.message : 'Failed to complete material',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async getMaterialProgress(req: Request, res: Response) {
        try {
            const materialId = parseInt(req.params.materialId);
            const userId = req.user!.id!;

            if (Number.isNaN(materialId)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'Invalid material ID',
                    data: null,
                });
            }

            const progress = await materialService.getMaterialProgress(userId, materialId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Material progress retrieved',
                data: progress || { is_completed: false },
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode,
                success: false,
                message: error instanceof NotFoundError ? error.message : 'Failed to get material progress',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }
}

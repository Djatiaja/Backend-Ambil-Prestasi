// controllers/materialController.ts
import { Request, Response } from 'express';
import { sendResponse } from '../helpers/baseResponse';
import { NotFoundError } from '../errors/notfound.error';
import materialService from '../services/material.service';

export class MaterialController {

    async getAllMaterials(req: Request, res: Response) {
        try {
            const sectionId = parseInt(req.params.sectionId);
            const materials = await materialService.getAllMaterials(sectionId);
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
            const material = await materialService.getMaterialById(id);
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
            const material = await materialService.createMaterial(req.body, parseInt(req.params.sectionId));
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'Material created successfully',
                data: material,
            });
        } catch (error) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: 'Failed to create material',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async updateMaterial(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.materialId);
            const material = await materialService.updateMaterial(id, req.body);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Material updated successfully',
                data: material,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            return sendResponse({
                res,
                statusCode,
                success: false,
                message: error instanceof NotFoundError ? error.message : 'Failed to update material',
                data: null,
                errors: { global: [(error as Error).message] },
            });
        }
    }

    async deleteMaterial(req: Request, res: Response) {
        try {
            const id = parseInt(req.params.materialId);
            const material = await materialService.deleteMaterial(id);
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
}


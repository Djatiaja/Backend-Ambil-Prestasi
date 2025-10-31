import { Request, Response } from 'express';
import { sendResponse } from '../helpers/baseResponse';
import { CreateSectionInput, UpdateSectionInput } from '../schemas/section.schema';
import sectionService from '../services/section.service';
import classService from '../services/class.service';

class SectionController {
    async getSections(req: Request, res: Response) {
        try {
            const { classId } = req.params;
            if (!classId || typeof classId !== 'string') {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: 'classId is required',
                    data: null,
                });
            }
            const classVar = await classService.getClassById(parseInt(classId));
            if (!classVar) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Class not found',
                    data: null,
                });
            }

            const sections = await sectionService.getAllSections(classId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Sections retrieved successfully',
                data: sections,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    async getSection(req: Request, res: Response) {
        try {
            const { sectionID } = req.params;
            const section = await sectionService.getSectionById(sectionID);
            if (!section) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Section not found',
                    data: null,
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Section retrieved successfully',
                data: section,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: error.message.includes('not found') ? 404 : 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    async createSection(req: Request, res: Response) {
        try {
            const { classId } = req.params;

            const classVar = await classService.getClassById(parseInt(classId));
            if (!classVar) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Class not found',
                    data: null,
                });
            }

            const section = await sectionService.createSection(req.body as CreateSectionInput, parseInt(classId));
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'Section created successfully',
                data: section,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    async updateSection(req: Request, res: Response) {
        try {
            const { sectionID } = req.params;
            const checkSection = await sectionService.getSectionById(sectionID);
            if (!checkSection) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Section not found',
                    data: null,
                });
            }
            const section = await sectionService.updateSection(sectionID, req.body as UpdateSectionInput);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Section updated successfully',
                data: section,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: error.message.includes('not found') ? 404 : 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }

    async deleteSection(req: Request, res: Response) {
        try {
            const { sectionID } = req.params;
            await sectionService.deleteSection(sectionID);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Section deleted successfully',
                data: null,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: error.message.includes('not found') ? 404 : 500,
                success: false,
                message: error.message,
                data: null,
            });
        }
    }
}

export default new SectionController();
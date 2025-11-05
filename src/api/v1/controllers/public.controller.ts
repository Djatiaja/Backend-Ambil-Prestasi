import { Request, Response } from "express";
import classService from "../services/class.service";
import { sendResponse } from "../helpers/baseResponse";
import categoryService from "../services/category.service";
import sectionService from "../services/section.service";
import materialService from "../services/material.service";



class PublicController {
    async getClasses(req: Request, res: Response) {
        const search = req.query.search as string | undefined;
        const page = Number(req.query.page ?? 1);
        const limit = Number(req.query.limit ?? 10);

        const classes = await classService.getAllClasses({ search: search || "", limit, page });
        sendResponse({ res, statusCode: 200, success: true, data: classes, message: "Classes retrieved successfully" });
    }

    async getClassById(req: Request, res: Response) {
        const classId = req.params.id;
        const classData = await classService.getClassById(Number(classId));
        if (!classData) {
            return sendResponse({ res, statusCode: 404, success: false, message: "Class not found", data: null });
        }
        const sections = await sectionService.getAllSections(classId);
        sections.forEach(section => {
            section.Material.forEach(material => {
                if (material.thumnail_path) {
                    material.thumnail_path = `${process.env.BASE_URL}/files/${material.thumnail_path}`;
                }
            });
        });

        const data = { ...classData, sections };

        sendResponse({ res, statusCode: 200, success: true, data, message: "Class retrieved successfully" });
    }

    async getBanners(req: Request, res: Response) {
        sendResponse({ res, statusCode: 200, success: true, data: "Public Banners Endpoint", message: "Banners retrieved successfully" });
    }

    async getCategories(req: Request, res: Response) {
        const categories = await categoryService.getAllCategories();
        sendResponse({ res, statusCode: 200, success: true, data: categories, message: "Categories retrieved successfully" });
    }

    async getMaterialById(req: Request, res: Response) {
        const materialId = req.params.id;
        if (Number.isNaN(Number(materialId))) {
            return sendResponse({ res, statusCode: 400, success: false, message: "Invalid material ID", data: null });
        }

        const material = await materialService.getMaterialById(Number(materialId));

        sendResponse({ res, statusCode: 200, success: true, data: material, message: "Material retrieved successfully" });
    }
}

export default new PublicController();
import { Request, Response } from "express";
import classService from "../services/class.service";
import { sendResponse } from "../helpers/baseResponse";
import categoryService from "../services/category.service";



class PublicController {
    async getClasses(req: Request, res: Response) {
        const search = req.query.search as string | undefined;
        const page = Number(req.query.page ?? 1);
        const limit = Number(req.query.limit ?? 10);

        const classes = await classService.getAllClasses({ search: search || "", limit, page });
        sendResponse({ res, statusCode: 200, success: true, data: classes, message: "Classes retrieved successfully" });
    }

    async getBanners(req: Request, res: Response) {
        sendResponse({ res, statusCode: 200, success: true, data: "Public Banners Endpoint", message: "Banners retrieved successfully" });
    }

    async getCategories(req: Request, res: Response) {
        const categories = await categoryService.getAllCategories();
        sendResponse({ res, statusCode: 200, success: true, data: categories, message: "Categories retrieved successfully" });
    }
}

export default new PublicController();
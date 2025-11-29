import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import categoryService from "../services/category.service";


class CategoryController {
    async getAllCategories(req: Request, res: Response) {
        try {
            const categories = await categoryService.getAllCategories();
            sendResponse({ res, statusCode: 200, success: true, message: "Get All Categories", data: categories });
        } catch {
            sendResponse({ res, statusCode: 500, success: false, message: "Failed to Get Categories", data: null });
        }
    }

    async getCategoryById(req: Request, res: Response) {
        try {
            const categoryId = parseInt(req.params.id);
            const category = await categoryService.getCategoryById(categoryId);
            if (!category) {
                return sendResponse({ res, statusCode: 404, success: false, message: "Category Not Found", data: null });
            }
            sendResponse({ res, statusCode: 200, success: true, message: "Get Category", data: category });
        } catch {
            sendResponse({ res, statusCode: 500, success: false, message: "Failed to Get Category", data: null });
        }
    }

    async createCategory(req: Request, res: Response) {
        try {
            const { name } = req.body;
            const newCategory = await categoryService.createCategory(name);
            sendResponse({ res, statusCode: 201, success: true, message: "Category Created", data: newCategory });
        } catch {
            sendResponse({ res, statusCode: 500, success: false, message: "Failed to Create Category", data: null });
        }
    }

    async updateCategory(req: Request, res: Response) {
        try {
            const categoryId = parseInt(req.params.id);
            const { name } = req.body;
            const updatedCategory = await categoryService.updateCategory(categoryId, name);
            if (!updatedCategory) {
                return sendResponse({ res, statusCode: 404, success: false, message: "Category Not Found", data: null });
            }
            sendResponse({ res, statusCode: 200, success: true, message: "Category Updated", data: updatedCategory });
        } catch {
            sendResponse({ res, statusCode: 500, success: false, message: "Failed to Update Category", data: null });
        }
    }

    async deleteCategory(req: Request, res: Response) {
        try {
            const categoryId = parseInt(req.params.id);
            const result = await categoryService.deleteCategory(categoryId);

            if (!result.canDelete) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: `Cannot delete category. There are ${result.totalClasses} class(es) in this category`,
                    data: {
                        totalClasses: result.totalClasses,
                        classes: result.classes,
                    }
                });
            }

            sendResponse({ res, statusCode: 200, success: true, message: "Category Deleted Permanently", data: null });
        } catch (error) {
            console.error("Error deleting category:", error);
            const errorMessage = (error as Error).message;

            if (errorMessage === 'Category not found') {
                return sendResponse({ res, statusCode: 404, success: false, message: errorMessage, data: null });
            }

            sendResponse({ res, statusCode: 500, success: false, message: "Failed to Delete Category", data: null });
        }
    }
}

export default new CategoryController();
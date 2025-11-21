import { Request, Response } from "express";
import classService from "../services/class.service";
import { BaseResponse } from "../types/responseType";
import { sendResponse } from "../helpers/baseResponse";
import prisma from "../../../database";
import { imageType, optimizeImage } from "../helpers/imageCompress";
import { saveFile } from "../helpers/file";

interface ClassDto {
    id: number;
    name: string;
    description: string;
    image_path: string;
    createdAt: string;
    updatedAt: string;
}

export async function getTestTeacher() {
    return await prisma.user.findFirst({
        where: {
            name: "teachertestacc"
        }
    })
}


export const getClasses = async (req: Request, res: Response) => {
    try {
        const page = parseInt(req.query.page as string) || 1;
        const limit = 10;
        const userId = req.user!.id!;

        const { classes, totalItems } = await classService.getClasses(userId, page, limit);
        const meta = {
            totalItems: totalItems,
            currentPage: page,
            totalPages: Math.ceil(totalItems / limit),
            itemsPerPage: limit
        }

        const data = classes.map(cls => ({
            id: cls.id,
            name: cls.name,
            description: cls.description,
            image_path: cls.image_path,
            image_path_relative: cls.image_path_relative,
            categoryId: cls.categoryId
        }))

        sendResponse({ res, statusCode: 200, success: true, message: "Get Classes", data: data, meta: meta })
    } catch (error) {
        console.error("Error fetching classes:", error);
        res.status(500).json({
            success: false,
            message: "Failed to retrieve classes",
            errors: {
                server: (error as Error).message,
            },
        });
    }
};

export const getClassById = async (req: Request, res: Response) => {
    try {
        const classId = parseInt(req.params.id);
        const userId = req.user?.id;
        const userRole = req.role;

        const classData = await classService.getClassById(classId, userId, userRole);

        if (!classData) {
            return res.status(404).json({
                success: false,
                message: "Class not found",
            });
        }
        const studentsInClass = await classService.getAllStudentsInClass(classId);


        const data = {
            id: classData.id,
            name: classData.name,
            description: classData.description,
            image_path: classData.image_path,
            image_path_relative: classData.image_path_relative,
            students: studentsInClass
        }

        sendResponse({ res, statusCode: 200, message: "Class found", success: true, data })
    } catch (error) {
        console.error("Error fetching class:", error);
        const errorMessage = (error as Error).message;

        if (errorMessage === 'You are not assigned to this class') {
            return res.status(403).json({
                success: false,
                message: errorMessage,
            });
        }

        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: errorMessage },
        });
    }
};

export const createClass = async (req: Request, res: Response) => {
    try {
        const { name, description, categoryId } = req.body;
        if (!name || !description) {
            return res.status(400).json({
                success: false,
                message: "Invalid input",
                errors: { validation: "Name and description are required" },
            });
        }
        const userId = req.user!.id

        const file = req.file;


        if (!file) {
            return res.status(400).json({ error: "No file uploaded" });
        }

        const type = imageType.THUMBNAIL;

        const optimizedBuffer = await optimizeImage(file.buffer, file.mimetype, type);
        file.buffer = optimizedBuffer;

        const uploadPath = await saveFile(file);

        const createdClass = await classService.createClass(userId!, { name, description, image_path: uploadPath, categoryId: parseInt(categoryId) });

        const response: BaseResponse<Partial<ClassDto> & { image_path_relative?: string, categoryId?: number }> = {
            success: true,
            message: "Class created successfully",
            data: {
                id: createdClass.id,
                name: createdClass.name,
                description: createdClass.description,
                image_path: createdClass.image_path,
                image_path_relative: createdClass.image_path_relative,
                categoryId: createdClass.categoryId
            },
        };

        res.status(201).json(response);
    } catch (error) {
        console.error("Error creating class:", error);
        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: (error as Error).message },
        });
    }
};

export const updateClass = async (req: Request, res: Response) => {
    try {
        const classId = parseInt(req.params.id);
        const { name, description } = req.body;
        const userId = req.user?.id;
        const userRole = req.role;

        const file = req.file;

        let uploadPath: string | undefined = undefined;
        if (file) {
            const type = imageType.THUMBNAIL;

            const optimizedBuffer = await optimizeImage(file.buffer, file.mimetype, type);
            file.buffer = optimizedBuffer;

            uploadPath = await saveFile(file);
        }

        const updatedClass = await classService.updateClass(classId, { name, description, image_path: uploadPath }, userId, userRole);

        if (!updatedClass) {
            return res.status(404).json({
                success: false,
                message: "Class not found",
            });
        }

        const response: BaseResponse<Partial<ClassDto>> = {
            success: true,
            message: "Class updated successfully",
            data: {
                id: updatedClass.id,
                name: updatedClass.name,
                description: updatedClass.description,
                image_path: updatedClass.image_path
            },
        };

        res.status(200).json(response);
    } catch (error) {
        const errorMessage = (error as Error).message;

        if (errorMessage === 'You are not assigned to this class') {
            return res.status(403).json({
                success: false,
                message: errorMessage,
            });
        }

        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: errorMessage },
        });
    }
};

export const deleteClass = async (req: Request, res: Response) => {
    try {
        const classId = parseInt(req.params.id);
        const userId = req.user?.id;
        const userRole = req.role;

        const deleted = await classService.deleteClass(classId, userId, userRole);

        if (!deleted) {
            return res.status(404).json({
                success: false,
                message: "Class not found",
            });
        }

        res.status(200).json({
            success: true,
            message: "Class deleted successfully",
        });
    } catch (error) {
        const errorMessage = (error as Error).message;

        if (errorMessage === 'You are not assigned to this class') {
            return res.status(403).json({
                success: false,
                message: errorMessage,
            });
        }

        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: errorMessage },
        });
    }
};
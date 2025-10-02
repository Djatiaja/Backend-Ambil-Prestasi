import { Request, Response } from "express";
import classService from "../services/class.service";
import { BaseResponse } from "../types/responseType";
import { sendResponse } from "../helpers/baseResponse";
import prisma from "../../../database";
import { error } from "console";

interface ClassDto {
    id: number;
    name: string;
    description: string;
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
        const teacher = await getTestTeacher();
        if (!teacher) {
            throw error
        }
        const userId = teacher.id

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
            createdAt: cls.createdAt.toISOString(),
            updatedAt: cls.updatedAt.toISOString(),
        }))

        sendResponse({ res, statusCode: 200, success: true, message: "Get Classes", data: data, meta: meta })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: (error as Error).message },
        });
    }
};

export const getClassById = async (req: Request, res: Response) => {
    try {
        const classId = parseInt(req.params.id);
        const classData = await classService.getClassById(classId);

        if (!classData) {
            return res.status(404).json({
                success: false,
                message: "Class not found",
            });
        }

        const data = {
            id: classData.id,
            name: classData.name,
            description: classData.description,
            createdAt: classData.createdAt.toISOString(),
            updatedAt: classData.updatedAt.toISOString(),
        }

        sendResponse({ res, statusCode: 200, message: "Class found", success: true, data })
    } catch (error) {
        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: (error as Error).message },
        });
    }
};

export const createClass = async (req: Request, res: Response) => {
    try {
        const { name, description } = req.body;
        if (!name || !description) {
            return res.status(400).json({
                success: false,
                message: "Invalid input",
                errors: { validation: "Name and description are required" },
            });
        }
        const teacher = await getTestTeacher();
        if (!teacher) {
            throw error
        }
        const userId = teacher.id

        const createdClass = await classService.createClass(userId, { name, description, image_url: "/image.png" });

        const response: BaseResponse<ClassDto> = {
            success: true,
            message: "Class created successfully",
            data: {
                id: createdClass.id,
                name: createdClass.name,
                description: createdClass.description,
                createdAt: createdClass.createdAt.toISOString(),
                updatedAt: createdClass.updatedAt.toISOString(),
            },
        };

        res.status(201).json(response);
    } catch (error) {
        console.log(error);

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

        const updatedClass = await classService.updateClass(classId, { name, description });

        if (!updatedClass) {
            return res.status(404).json({
                success: false,
                message: "Class not found",
            });
        }

        const response: BaseResponse<ClassDto> = {
            success: true,
            message: "Class updated successfully",
            data: {
                id: updatedClass.id,
                name: updatedClass.name,
                description: updatedClass.description,
                createdAt: updatedClass.createdAt.toISOString(),
                updatedAt: updatedClass.updatedAt.toISOString(),
            },
        };

        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: (error as Error).message },
        });
    }
};

export const deleteClass = async (req: Request, res: Response) => {
    try {
        const classId = parseInt(req.params.id);
        const deleted = await classService.deleteClass(classId);

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
        res.status(500).json({
            success: false,
            message: "Internal server error",
            errors: { server: (error as Error).message },
        });
    }
};
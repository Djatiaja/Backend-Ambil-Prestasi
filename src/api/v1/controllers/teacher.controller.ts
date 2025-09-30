import userService from "../services/user.service";
import { sendResponse } from "../helpers/baseResponse";
import { Request, Response } from "express";
import { User } from "@prisma/client";

// TODO: Implement zod for validation

export const getAllTeachers = async (req: Request, res: Response) => {
    try {
        const page = Number(req.query.page ?? 1);
        const limit = Number(req.query.limit ?? 10);
        const search = req.query.search !== undefined ? String(req.query.search) : ""

        if (!Number.isInteger(page) || !Number.isInteger(limit) || page < 1 || limit < 1) {
            return sendResponse({ res: res, statusCode: 400, success: false, message: "Invalid page number", data: null });
        }

        const { users: teachers, meta } = await userService.getAllUsers({ role: "Teacher", isDeleted: false, limit, page, search });

        sendResponse({ res: res, statusCode: 200, success: true, message: "Teachers fetched successfully", data: teachers, meta: meta });
    } catch (error) {
        sendResponse({ res: res, statusCode: 500, success: false, message: "Error fetching teachers", data: null });
    }
};

export const createTeacher = async (req: Request, res: Response) => {
    try {
        const { name, email, username } = req.body;

        const newTeacher = await userService.createUser({ name, email, password: username, role: "Teacher", username: username || email });
        sendResponse({ res, statusCode: 201, success: true, message: "Teacher created successfully", data: newTeacher });
    } catch (error) {
        console.error(req.body, error);
        sendResponse({ res, statusCode: 500, success: false, message: "Error creating teacher", data: null });
    }
};

export const getTeacherById = async (req: Request, res: Response) => {
    try {
        // TODO: add auth id validation to prevent accessing other user's data
        const { id } = req.params;
        const teacher = await userService.getUserById(id);

        if (!teacher || teacher.role.name !== "Teacher") {
            return sendResponse({ res, statusCode: 404, success: false, message: "Teacher not found", data: null });
        }
        sendResponse({ res, statusCode: 200, success: true, message: "Teacher fetched successfully", data: teacher });
    } catch (error) {
        sendResponse({ res, statusCode: 500, success: false, message: "Error fetching teacher", data: null });
    }

};

export const updateTeacher = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const { name, email, password, username, profileImage }: Partial<User> = req.body;

        if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            return sendResponse({ res, statusCode: 400, success: false, message: "Invalid email format", data: null });
        }
        const existingTeacher = await userService.getUserById(id);
        if (!existingTeacher || existingTeacher.role.name !== "Teacher") {
            return sendResponse({ res, statusCode: 404, success: false, message: "Teacher not found", data: null });
        }

        const updatedTeacher = await userService.updateUser(id, { name, email, password, username, profileImage });
        sendResponse({ res, statusCode: 200, success: true, message: "Teacher updated successfully", data: updatedTeacher });
    } catch (error) {
        sendResponse({ res, statusCode: 500, success: false, message: "Error updating teacher", data: null });
    }
};

export const deleteTeacher = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const existingTeacher = await userService.getUserById(id);
        if (!existingTeacher || existingTeacher.role.name !== "Teacher") {
            return sendResponse({ res, statusCode: 404, success: false, message: "Teacher not found", data: null });
        }

        await userService.deleteUser(id);
        sendResponse({ res, statusCode: 200, success: true, message: "Teacher deleted successfully", data: null });
    } catch (error) {
        sendResponse({ res, statusCode: 500, success: false, message: "Error deleting teacher", data: null });
    }

};

import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import materialService from "../services/material.service";
import studentService from "../services/student.service";
import { NotFoundError } from "../errors/notfound.error";
import classService from "../services/class.service";
import sectionService from "../services/section.service";


class StudentController {

    async getMaterialById(req: Request, res: Response) {
        const materialId = req.params.id;
        if (Number.isNaN(Number(materialId))) {
            return sendResponse({ res, statusCode: 400, success: false, message: "Invalid material ID", data: null });
        }

        try {
            const material = await materialService.getMaterialById(Number(materialId));
            return sendResponse({ res, statusCode: 200, success: true, data: material, message: "Material retrieved successfully" });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Internal server error";
            return sendResponse({ res, statusCode: 500, success: false, message, data: null });
        }
    }

    async enrollClass(req: Request, res: Response) {
        try {
            const classId = parseInt(req.params.classId);
            const userId = req.user!.id!;

            if (Number.isNaN(classId)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: "Invalid class ID",
                    data: null,
                });
            }

            const enrollment = await studentService.enrollClass(userId, classId);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: "Successfully enrolled in class",
                data: enrollment,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            const message = error instanceof Error ? error.message : "Failed to enroll in class";
            return sendResponse({
                res,
                statusCode,
                success: false,
                message,
                data: null,
            });
        }
    }

    async unenrollClass(req: Request, res: Response) {
        try {
            const classId = parseInt(req.params.classId);
            const userId = req.user!.id!;

            if (Number.isNaN(classId)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: "Invalid class ID",
                    data: null,
                });
            }

            await studentService.unenrollClass(userId, classId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Successfully unenrolled from class",
                data: null,
            });
        } catch (error) {
            const statusCode = error instanceof NotFoundError ? 404 : 500;
            const message = error instanceof Error ? error.message : "Failed to unenroll from class";
            return sendResponse({
                res,
                statusCode,
                success: false,
                message,
                data: null,
            });
        }
    }

    async getEnrolledClasses(req: Request, res: Response) {
        try {
            const userId = req.user!.id!;
            const enrollments = await studentService.getEnrolledClasses(userId);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Enrolled classes retrieved successfully",
                data: enrollments,
                meta: {
                    totalItems: enrollments.length,
                    itemsPerPage: enrollments.length,
                    totalPages: 1,
                    currentPage: 1,
                },
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to get enrolled classes";
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message,
                data: null,
            });
        }
    }

    async checkEnrollment(req: Request, res: Response) {
        try {
            const classId = parseInt(req.params.classId);
            const userId = req.user!.id!;

            if (Number.isNaN(classId)) {
                return sendResponse({
                    res,
                    statusCode: 400,
                    success: false,
                    message: "Invalid class ID",
                    data: null,
                });
            }

            const enrollment = await studentService.checkEnrollment(userId, classId);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Enrollment status retrieved",
                data: {
                    isEnrolled: !!enrollment,
                    enrollment: enrollment || null,
                },
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to check enrollment";
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message,
                data: null,
            });
        }
    }

    async getAllSectionsForStudent(req: Request, res: Response) {
        try {
            const classId = req.params.classId;
            const sections = await sectionService.getAllSections(classId);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Sections retrieved successfully",
                data: sections,
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to get sections";
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message,
                data: null,
            });
        }
    }
}

export default new StudentController();
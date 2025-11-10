import { NextFunction, Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import classRepository from "../repositories/class.repository";

export const verifyClass =
    () => async (request: Request, response: Response, next: NextFunction) => {
        try {
            const classId = request.params.classId;
            if (Number.isNaN(Number(classId))) {
                return response.sendStatus(404);
            }
            if (!classId) {
                return response.sendStatus(404);
            }
            const classExists = await classRepository.findClassById(Number(classId));
            if (!classExists) {
                return response.sendStatus(404);
            }
            const studentsInClass = await classRepository.getStudentsInClass(Number(classId));
            if (request.user!.id) {
                const isStudentInClass = studentsInClass.some(
                    (student) => student.id === request.user!.id
                );
                if (!isStudentInClass) {
                    return response.sendStatus(404);
                }
            }

            next();
        } catch (err: unknown) {
            console.error("Class verification error:", err);
            sendResponse({
                res: response,
                statusCode: 500,
                success: false,
                message: "Internal server error",
                data: null,
            });
        }
    };
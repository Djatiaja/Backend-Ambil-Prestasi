import { class_role } from "@prisma/client";
import classRepository from "../repositories/class.repository";
import userService from "./user.service";
import userClassService from "./userClass.service";
import { BaseResponse } from "../types/responseType";
import { ReviewRepository } from "../repositories/review.repository";

interface ClassData {
    name?: string;
    description?: string;
    image_path?: string;
}

class ClassService {
    async getClassCount() {
        return await classRepository.getCount();
    }

    async getClasses(userId: string, page: number, limit: number) {
        const skip = (page - 1) * limit;
        const [classes, totalItems] = await Promise.all([
            classRepository.getClasses(skip, limit, undefined, userId),
            classRepository.getCount(userId),
        ]);
        return { classes, totalItems };
    }

    async getClassById(classId: number) {
        const classData = await classRepository.findClassById(classId);
        if (!classData) {
            return null;
        }

        const averageRating = await ReviewRepository.getAverageRating(classId);
        const totalReviews = await ReviewRepository.countByClass(classId);

        return {
            ...classData,
            averageRating: Number(averageRating.toFixed(2)),
            totalReviews
        };
    }

    async createClass(teacherId: string, data: { name: string; description: string, image_path: string, categoryId: number }) {
        const user = await userService.getUserById(teacherId);
        if (!user) {
            throw new Error("User not found");
        }

        const createdClass = await classRepository.createClass(data.name, data.description, data.image_path, data.categoryId);
        await userClassService.assignClass(user.id, createdClass.id, class_role.Teacher);

        return createdClass;
    }

    async updateClass(classId: number, data: ClassData) {
        const existingClass = await classRepository.findClassById(classId);
        if (!existingClass) {
            return null;
        }

        return await classRepository.updateClass(classId, {
            name: data.name || existingClass.name,
            description: data.description || existingClass.description,
            image_path: data.image_path || existingClass.image_path,
        });
    }

    async deleteClass(classId: number) {
        const existingClass = await classRepository.findClassById(classId);
        if (!existingClass) {
            return false;
        }

        await classRepository.deleteClass(classId);
        return true;
    }

    async getAllStudentsInClass(classId: number) {
        return await classRepository.getStudentsInClass(classId);
    }

    async getAllClasses(data: { search?: string; limit?: number; page?: number }) {
        const { search, limit = 10, page = 1 } = data;
        const skip = (page - 1) * limit;
        const classes = await classRepository.getClasses(skip, limit, search);
        const totalItems = await classRepository.getCount(undefined, search);

        // Add average rating to each class
        const classesWithRating = await Promise.all(
            classes.map(async (classData) => {
                const averageRating = await ReviewRepository.getAverageRating(classData.id);
                const totalReviews = await ReviewRepository.countByClass(classData.id);
                return {
                    ...classData,
                    averageRating: Number(averageRating.toFixed(2)),
                    totalReviews
                };
            })
        );

        const meta: BaseResponse<unknown>["meta"] = {
            totalItems,
            itemsPerPage: limit,
            totalPages: limit ? Math.ceil(totalItems / limit) : 1,
            currentPage: page
        };

        return { classes: classesWithRating, meta };
    }
}

export default new ClassService();
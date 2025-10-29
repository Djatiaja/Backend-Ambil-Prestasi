import { class_role } from "@prisma/client";
import classRepository from "../repositories/class.repository";
import userService from "./user.service";
import userClassService from "./userClass.service";

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
            classRepository.getClasses(userId, skip, limit),
            classRepository.getCount(userId),
        ]);
        return { classes, totalItems };
    }

    async getClassById(classId: number) {
        return await classRepository.findClassById(classId);
    }

    async createClass(teacherId: string, data: { name: string; description: string, image_path: string }) {
        const user = await userService.getUserById(teacherId);
        if (!user) {
            throw new Error("User not found");
        }

        const createdClass = await classRepository.createClass(data.name, data.description, data.image_path);
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
}

export default new ClassService();
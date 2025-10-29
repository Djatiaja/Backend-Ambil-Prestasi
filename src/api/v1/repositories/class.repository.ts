import { class_role } from "@prisma/client";
import prisma from "../../../database";
import { safeUserFields } from "./user.repository";

class ClassRepository {
    async getCount(userId?: string) {
        if (!userId) {
            return await prisma.class.count({
            });
        }

        return await prisma.class.count({
            where: {
                User_Class: {
                    some: {
                        userId: userId
                    }
                }
            }
        });
    }

    async createClass(name: string, description: string, image_path: string) {
        const createdClass = await prisma.class.create({
            data: {
                name,
                description,
                image_path: image_path,
            },
        });

        return { ...createdClass, image_path_relative: `${(process.env.APP_URL || "http://localhost").replace(/\/$/, "")}:${process.env.PORT || 3001}/${createdClass.image_path}`.replace(/\/$/, "") };
    }


    async findClassById(classId: number) {
        const classData = await prisma.class.findFirst({
            where: { id: classId },
        });

        if (!classData) return null;

        const appUrl = (process.env.APP_URL || "http://localhost").replace(/\/$/, "") + `:${process.env.PORT || 3001}`;
        const imagePathRelative = `${appUrl}/${classData.image_path}`.replace(/\/$/, "");

        return { ...classData, image_path_relative: imagePathRelative };
    }

    async getClasses(userId: string, skip: number, take: number) {
        const classes = await prisma.class.findMany({
            where: {
                User_Class: {
                    some: {
                        userId: userId
                    }
                },
            },
            skip,
            take,
            orderBy: {
                createdAt: "desc",
            },
        });

        return classes.map((classData) => {
            const appUrl = (process.env.APP_URL || "http://localhost").replace(/\/$/, "") + `:${process.env.PORT || 3001}`;
            const imagePathRelative = `${appUrl}/${classData.image_path}`.replace(/\/$/, "");

            return { ...classData, image_path_relative: imagePathRelative };
        });
    }

    async updateClass(classId: number, data: { name: string; description: string, image_path: string }) {
        return await prisma.class.update({
            where: { id: classId },
            data,
        });
    }

    async deleteClass(classId: number) {
        await prisma.class.delete({
            where: { id: classId },
        });
    }

    async getStudentsInClass(classId: number) {
        const students = await prisma.user.findMany({
            where: {
                User_Class: {
                    some: {
                        classId: classId,
                        role: class_role.Student
                    },
                }
            },
            select: safeUserFields
        });

        return students;
    }
}

export default new ClassRepository();
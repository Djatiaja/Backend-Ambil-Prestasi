import { class_role } from "@prisma/client";
import prisma from "../../../database";


class UserClassRepository {
    async createUserClass(userId: string, classId: number, role: class_role) {
        return await prisma.user_Class.create({ data: { userId: userId, classId: classId, role: role } })
    }

    async enrollStudent(userId: string, classId: number) {
        return await prisma.user_Class.upsert({
            where: {
                userId_classId: {
                    userId,
                    classId,
                },
            },
            create: {
                userId,
                classId,
                role: class_role.Student,
            },
            update: {},
            select: {
                id: true,
                role: true,
                userId: true,
                classId: true,
                createdAt: true,
            },
        });
    }

    async unenrollStudent(userId: string, classId: number) {
        return await prisma.user_Class.deleteMany({
            where: {
                userId,
                classId,
                role: class_role.Student,
            },
        });
    }

    async checkEnrollment(userId: string, classId: number) {
        return await prisma.user_Class.findUnique({
            where: {
                userId_classId: {
                    userId,
                    classId,
                },
            },
        });
    }

    async getEnrolledClasses(userId: string) {
        return await prisma.user_Class.findMany({
            where: {
                userId,
                role: class_role.Student,
            },
            include: {
                class: {
                    select: {
                        id: true,
                        name: true,
                        description: true,
                        image_path: true,
                        categoryId: true,
                        createdAt: true,
                        updatedAt: true,
                    },
                },
            },
        });
    }
}

export default new UserClassRepository();
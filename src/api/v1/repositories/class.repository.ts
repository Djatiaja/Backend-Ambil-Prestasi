import prisma from "../../../database";

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
        return await prisma.class.create({
            data: {
                name,
                description,
                image_path: image_path,
            },
        });
    }

    async findClassById(classId: number) {
        return await prisma.class.findFirst({
            where: { id: classId },
        });
    }

    async getClasses(userId: string, skip: number, take: number) {
        return await prisma.class.findMany({
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
    }

    async updateClass(classId: number, data: { name: string; description: string }) {
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
}

export default new ClassRepository();
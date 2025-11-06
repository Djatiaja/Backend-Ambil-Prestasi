import { class_role } from "@prisma/client";
import prisma from "../../../database";
import { safeUserFields } from "./user.repository";

export const safeClassFields = {
    id: true,
    name: true,
    description: true,
    image_path: true,
    categoryId: true,
};

class ClassRepository {
    async getCount(userId?: string, search?: string) {
        if (!userId) {
            return await prisma.class.count({
                where: search ? {
                    OR: [
                        {
                            name: {
                                contains: search,
                            }
                        },
                        {
                            description: {
                                contains: search,
                            }
                        }
                    ]
                } : undefined,
            });
        }
        return await prisma.class.count({
            where: {
                User_Class: {
                    some: {
                        userId: userId
                    }
                }
                , OR: search ? [
                    {
                        name: {
                            contains: search,
                        }
                    },
                    {
                        description: {
                            contains: search,
                        }
                    }
                ] : [],
            },
        });
    }

    async createClass(name: string, description: string, image_path: string, categoryId: number) {
        const createdClass = await prisma.class.create({
            data: {
                name,
                description,
                image_path: image_path,
                categoryId: categoryId,
            },
            select: safeClassFields
        });

        return { ...createdClass, image_path_relative: `${(process.env.APP_URL || "http://localhost").replace(/\/$/, "")}/${createdClass.image_path}`.replace(/\/$/, "") };
    }


    async findClassById(classId: number) {
        const classData = await prisma.class.findFirst({
            where: { id: classId },
            select: safeClassFields,
        });

        if (!classData) return null;

        const appUrl = (process.env.APP_URL || "http://localhost").replace(/\/$/, "");
        const imagePathRelative = `${appUrl}/${classData.image_path}`.replace(/\/$/, "");

        return { ...classData, image_path_relative: imagePathRelative };
    }

    async getClasses(skip: number = 0, take: number = 10, search?: string, userId?: string) {
        let classes;

        if (!userId) {
            classes = await prisma.class.findMany({
                skip,
                take,
                orderBy: {
                    createdAt: "desc",
                },
                where: search ? {
                    OR: [
                        {
                            name: {
                                contains: search,
                            }
                        },
                        {
                            description: {
                                contains: search,
                            }
                        }
                    ]
                } : undefined,
                select: safeClassFields,
            });
        } else {
            classes = await prisma.class.findMany({
                where: {
                    User_Class: {
                        some: {
                            userId: userId
                        }
                    },
                    AND: search ? {
                        OR: [
                            {
                                name: {
                                    contains: search,
                                }
                            },
                            {
                                description: {
                                    contains: search,
                                }
                            },
                        ]
                    } : {}
                },
                skip,
                take,
                orderBy: {
                    createdAt: "desc",
                },
                select: safeClassFields,
            });
        }
        return classes.map((classData) => {
            const appUrl = (process.env.APP_URL || "http://localhost").replace(/\/$/, "");
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
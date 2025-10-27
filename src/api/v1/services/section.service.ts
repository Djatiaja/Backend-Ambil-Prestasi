import { PrismaClient, Section } from '@prisma/client';
import { CreateSectionInput, UpdateSectionInput } from '../schemas/section.schema';

const prisma = new PrismaClient();

class SectionService {
    async getAllSections(classId: string): Promise<Partial<Section>[]> {
        try {
            return await prisma.section.findMany({
                where: { classId: parseInt(classId) },
                orderBy: { order: 'asc' },
                select: {
                    id: true,
                    title: true,
                    description: true,
                    order: true,
                    Material: {
                        select: {
                            id: true,
                            title: true,
                            content: true,
                            Material_File: {
                                select: {
                                    id: true,
                                    path: true,
                                },
                            },
                        },
                    },
                    Assignment: {
                        select: {
                            id: true,
                            title: true,
                            description: true,
                            close_at: true,
                            open_at: true,
                        }

                    },
                    Quiz: {
                        select: {
                            id: true,
                            title: true,
                            description: true,
                            close_at: true,
                            open_at: true,
                        }
                    }
                }
            });
        } catch (error: any) {
            throw new Error(`Failed to fetch sections: ${error.message}`);
        }
    }

    async getSectionById(sectionId: string): Promise<Section> {
        try {
            const section = await prisma.section.findUnique({
                where: { id: parseInt(sectionId) },
                include: {
                    Material: true,
                    Assignment: true,
                    Quiz: true,
                },
            });
            if (!section) {
                throw new Error('Section not found');
            }
            return section;
        } catch (error: any) {
            throw new Error(`Failed to fetch section: ${error.message}`);
        }
    }

    async createSection(data: CreateSectionInput, classId: number): Promise<Section> {
        try {
            const lastSection = await prisma.section.findFirst({
                where: { classId },
                orderBy: { order: 'desc' },
            });

            const newOrder = lastSection ? lastSection.order + 1 : 1;

            return await prisma.section.create({
                data: {
                    title: data.title,
                    description: data.description,
                    classId,
                    order: newOrder,
                },
            });
        } catch (error: any) {
            throw new Error(`Failed to create section: ${error.message}`);
        }
    }

    async updateSection(sectionId: string, data: UpdateSectionInput): Promise<Section> {
        try {
            const section = await prisma.section.findUnique({
                where: { id: parseInt(sectionId) },
            });
            if (!section) {
                throw new Error('Section not found');
            }
            return await prisma.section.update({
                where: { id: parseInt(sectionId) },
                data,
            });
        } catch (error: any) {
            throw new Error(`Failed to update section: ${error.message}`);
        }
    }

    async deleteSection(sectionId: string): Promise<Section> {
        try {
            const section = await prisma.section.findUnique({
                where: { id: parseInt(sectionId) },
            });
            if (!section) {
                throw new Error('Section not found');
            }
            return await prisma.section.delete({
                where: { id: parseInt(sectionId) },
            });
        } catch (error: any) {
            throw new Error(`Failed to delete section: ${error.message}`);
        }
    }
}

export default new SectionService();
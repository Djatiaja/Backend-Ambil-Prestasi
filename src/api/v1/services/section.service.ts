import { PrismaClient, Section } from '@prisma/client';
import { CreateSectionInput, UpdateSectionInput } from '../schemas/section.schema';

const prisma = new PrismaClient();

class SectionService {
    async getAllSections(classId: string) {
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
                            thumnail_path: true,
                        },
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            throw new Error(`Failed to fetch sections: ${msg}`);
        }
    }

    async getSectionById(sectionId: string): Promise<Section | null> {
        try {
            const section = await prisma.section.findUnique({
                where: { id: parseInt(sectionId) },
                include: {
                    Material: true,
                    Assignment: true,
                    Quiz: true,
                },
            });
            return section;
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            throw new Error(`Failed to fetch section: ${msg}`);
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            throw new Error(`Failed to create section: ${msg}`);
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            throw new Error(`Failed to update section: ${msg}`);
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            throw new Error(`Failed to delete section: ${msg}`);
        }
    }
}

export default new SectionService();
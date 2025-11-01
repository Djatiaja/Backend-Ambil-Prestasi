import { Material } from '@prisma/client';
import prisma from '../../../database';

export class MaterialRepository {
    async findAll(sectionId: number): Promise<Material[]> {
        return await prisma.material.findMany({
            where: { sectionId },
        });
    }

    async findById(id: number): Promise<Material | null> {
        return await prisma.material.findFirst({
            where: { id },
        });
    }

    async create(data: {
        title: string;
        content: string;
        xp: number;
        sectionId: number;
        templatePath: string;
        video_path: string;
        materialFilePath: string;
        ringkasanPath: string;
        thumnail_path: string;
    }): Promise<Material> {
        return await prisma.material.create({
            data,
        });
    }

    async update(
        id: number,
        data: Partial<{
            title: string;
            content: string;
            xp: number;
            sectionId: number;
            templatePath: string;
            video_path: string;
            materialFilePath: string;
            ringkasanPath: string;
            thumnail_path: string;
        }>
    ): Promise<Material> {
        return await prisma.material.update({
            where: { id },
            data,
        });
    }

    async delete(id: number): Promise<Material> {
        return await prisma.material.delete({
            where: { id },
        });
    }

    async findTeacherByMaterialId(materialId: number) {
        return await prisma.material.findUnique({
            where: { id: materialId },
        }).Section().Class().User_Class({ where: { role: 'Teacher' } });
    }
}

export default new MaterialRepository();
import { Material } from '@prisma/client';
import prisma from '../../../database';

export class MaterialRepository {
    async findAll(sectionId: number): Promise<Material[]> {
        return await prisma.material.findMany({
            where: { sectionId },
            include: {
                Material_File: true,
            },
        });
    }

    async findById(id: number): Promise<Material | null> {
        return await prisma.material.findUnique({
            where: { id },
            include: {
                Section: true,
                Material_File: true,
            },
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
    }): Promise<Material> {
        return await prisma.material.create({
            data,
            include: {
                Material_File: true,
            },
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
        }>
    ): Promise<Material> {
        return await prisma.material.update({
            where: { id },
            data,
            include: {
                Material_File: true,
            },
        });
    }

    async delete(id: number): Promise<Material> {
        return await prisma.material.delete({
            where: { id },
        });
    }
}

export default new MaterialRepository();
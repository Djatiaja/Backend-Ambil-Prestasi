import { PrismaClient, Material_File } from "@prisma/client";
import prisma from "../../../database";


export class MaterialFileRepository {
    async findAll(): Promise<Material_File[]> {
        return await prisma.material_File.findMany();
    }

    async findById(id: number): Promise<Material_File | null> {
        return await prisma.material_File.findUnique({
            where: { id },
        });
    }

    async create(data: { title: string; path: string; materialId: number }): Promise<Material_File> {
        return await prisma.material_File.create({
            data,
        });
    }

    async update(id: number, data: Partial<{ title: string; path: string; materialId: number }>): Promise<Material_File | null> {
        return await prisma.material_File.update({
            where: { id },
            data,
        });
    }

    async delete(id: number): Promise<Material_File | null> {
        return await prisma.material_File.delete({
            where: { id },
        });
    }
}

export default new MaterialFileRepository();
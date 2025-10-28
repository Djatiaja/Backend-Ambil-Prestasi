
import { Material_File } from "@prisma/client";
import fs from "fs/promises";
import path from "path";
import materialFileRepository from "../repositories/materialFile.repository";
import prisma from "../../../database";
import { CreateMaterialFileDto, UpdateMaterialFileDto } from "../schemas/materialFile.schema";
import { deleteFile } from "../helpers/file";

export class MaterialFileService {
    async getAllMaterialFiles(): Promise<Material_File[]> {
        return materialFileRepository.findAll();
    }

    async getMaterialFileById(id: number): Promise<Material_File | null> {
        const materialFile = await materialFileRepository.findById(id);
        if (!materialFile) {
            throw new Error(`Material file with ID ${id} not found`);
        }
        return materialFile;
    }

    async createMaterialFile(dto: CreateMaterialFileDto, filePath: string, materialId: number): Promise<Material_File | null> {
        const materialExists = await prisma.material.findUnique({
            where: { id: materialId },
        });
        if (!materialExists) {
            throw new Error(`Material with ID ${materialId} not found`);
        }

        return await materialFileRepository.create({
            title: dto.title,
            path: filePath,
            materialId: materialId,
        });
    }

    async updateMaterialFile(id: number, dto: UpdateMaterialFileDto, materialId: number, filePath?: string): Promise<Material_File | null> {
        const materialFile = await materialFileRepository.findById(id);
        if (!materialFile) {
            throw new Error(`Material file with ID ${id} not found`);
        }

        if (filePath && materialFile.path) {
            try {
                deleteFile(materialFile.path);
            } catch (error) {
                console.warn(`Failed to delete old file: ${materialFile.path}`, error);
            }
        }

        const materialExists = await materialFileRepository.findById(materialId);
        if (!materialExists) {
            throw new Error(`Material with ID ${materialId} not found`);
        }

        return await materialFileRepository.update(id, {
            title: dto.title || materialFile.title,
            path: filePath || materialFile.path,
        });
    }

    async deleteMaterialFile(id: number): Promise<void> {
        const materialFile = await materialFileRepository.findById(id);
        if (!materialFile) {
            throw new Error(`Material file with ID ${id} not found`);
        }

        try {
            await fs.unlink(path.join(process.cwd(), materialFile.path));
        } catch (error) {
            console.warn(`Failed to delete file: ${materialFile.path}`, error);
        }

        await materialFileRepository.delete(id);
    }
}

export default new MaterialFileService();
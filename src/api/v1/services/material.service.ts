// src/services/material.service.ts
import { Material } from "@prisma/client";
import materialRepository from "../repositories/material.repository";
import { CreateMaterialDto, UpdateMaterialDto } from "../schemas/material.schema";
import { NotFoundError } from "../errors/notfound.error";
import { deleteFile, saveFile } from "../helpers/file";
import { generateFileToken } from "../helpers/fileToken";
import { env } from "process";

export class MaterialService {
    async getAllMaterials(sectionId: number): Promise<Material[]> {
        const materials = await materialRepository.findAll(sectionId);
        materials.forEach(material => {
            material.thumnail_path = `${env.APP_URL}/${material.thumnail_path}`;
            // Generate JWT tokens for protected files (valid for 60 minutes)
            material.templatePath = `${env.APP_URL}/files/protected/${generateFileToken(material.templatePath, 60)}`;
            material.video_path = `${env.APP_URL}/files/protected/${generateFileToken(material.video_path, 60)}`;
            material.materialFilePath = `${env.APP_URL}/files/protected/${generateFileToken(material.materialFilePath, 60)}`;
            material.ringkasanPath = `${env.APP_URL}/files/protected/${generateFileToken(material.ringkasanPath, 60)}`;
        });
        return materials;
    }

    async getMaterialById(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) throw new NotFoundError("Material not found");

        material.thumnail_path = `${env.APP_URL}/${material.thumnail_path}`;
        // Generate JWT tokens for protected files (valid for 60 minutes)
        material.templatePath = `${env.APP_URL}/files/protected/${generateFileToken(material.templatePath, 60)}`;
        material.video_path = `${env.APP_URL}/files/protected/${generateFileToken(material.video_path, 60)}`;
        material.materialFilePath = `${env.APP_URL}/files/protected/${generateFileToken(material.materialFilePath, 60)}`;
        material.ringkasanPath = `${env.APP_URL}/files/protected/${generateFileToken(material.ringkasanPath, 60)}`;
        return material;
    }

    /** CREATE */
    async createMaterial(
        data: CreateMaterialDto,
        sectionId: number
    ): Promise<Material> {
        const paths = {
            templatePath: data.template ? saveFile(data.template, true) : '',
            video_path: data.video ? saveFile(data.video, true) : '',
            materialFilePath: data.materialFile ? saveFile(data.materialFile, true) : '',
            ringkasanPath: data.ringkasan ? saveFile(data.ringkasan, true) : '',
            thumnail_path: saveFile(data.thumnail, false),
        };

        return await materialRepository.create({
            title: data.title,
            content: data.content,
            sectionId,
            xp: 10,
            ...paths,
        });
    }

    /** UPDATE – only replace files that are uploaded */
    async updateMaterial(id: number, data: UpdateMaterialDto): Promise<Material> {
        const existing = await materialRepository.findById(id);
        if (!existing) throw new NotFoundError("Material not found");

        const updatePayload: Partial<Material> = {};

        if (data.title) updatePayload.title = data.title;
        if (data.content) updatePayload.content = data.content;

        if (data.template) {
            deleteFile(existing.templatePath);
            updatePayload.templatePath = saveFile(data.template, true);
        }
        if (data.video) {
            deleteFile(existing.video_path);
            updatePayload.video_path = saveFile(data.video, true);
        }
        if (data.materialFile) {
            deleteFile(existing.materialFilePath);
            updatePayload.materialFilePath = saveFile(data.materialFile, true);
        }
        if (data.ringkasan) {
            deleteFile(existing.ringkasanPath);
            updatePayload.ringkasanPath = saveFile(data.ringkasan, true);
        }
        if (data.thumnail) {
            deleteFile(existing.thumnail_path);
            updatePayload.thumnail_path = saveFile(data.thumnail, false);
        }

        return await materialRepository.update(id, updatePayload);
    }

    /** DELETE */
    async deleteMaterial(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) throw new NotFoundError("Material not found");

        // delete physical files
        deleteFile(material.templatePath);
        deleteFile(material.video_path);
        deleteFile(material.materialFilePath);
        deleteFile(material.ringkasanPath);

        return await materialRepository.delete(id);
    }

    async getTeacherByMaterialId(materialId: number) {
        const teacher = await materialRepository.findTeacherByMaterialId(materialId);
        if (!teacher) throw new NotFoundError("Teacher not found for the given material ID");
    }

    async getMaterialProgress(userId: string, materialId: number): Promise<{ id: number; is_completed: boolean } | null> {
        return await materialRepository.getMaterialProgress(userId, materialId);
    }

    async completeMaterial(userId: string, materialId: number): Promise<{ id: number; is_completed: boolean }> {
        // Check if material exists
        const material = await materialRepository.findById(materialId);
        if (!material) throw new NotFoundError("Material not found");

        // Mark as completed
        return await materialRepository.completeMaterial(userId, materialId);
    }


}

export default new MaterialService();
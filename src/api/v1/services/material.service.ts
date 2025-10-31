// src/services/material.service.ts
import { Material } from "@prisma/client";
import materialRepository from "../repositories/material.repository";
import { CreateMaterialDto, UpdateMaterialDto } from "../schemas/material.schema";
import { NotFoundError } from "../errors/notfound.error";
import { deleteFile, saveFile } from "../helpers/file";
import { env } from "process";
export class MaterialService {
    async getAllMaterials(sectionId: number): Promise<Material[]> {
        const materials = await materialRepository.findAll(sectionId);
        materials.forEach(material => {
            material.thumnail_path = `${env.APP_URL}:${env.PORT}/${material.thumnail_path}`;
            material.templatePath = `${env.APP_URL}:${env.PORT}/${material.templatePath}`;
            material.video_path = `${env.APP_URL}:${env.PORT}/${material.video_path}`;
            material.materialFilePath = `${env.APP_URL}:${env.PORT}/${material.materialFilePath}`;
            material.ringkasanPath = `${env.APP_URL}:${env.PORT}/${material.ringkasanPath}`;
        });
        return materials;
    }

    async getMaterialById(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) throw new NotFoundError("Material not found");

        material.thumnail_path = `${env.APP_URL}:${env.PORT}/${material.thumnail_path}`;
        material.templatePath = `${env.APP_URL}:${env.PORT}/${material.templatePath}`;
        material.video_path = `${env.APP_URL}:${env.PORT}/${material.video_path}`;
        material.materialFilePath = `${env.APP_URL}:${env.PORT}/${material.materialFilePath}`;
        material.ringkasanPath = `${env.APP_URL}:${env.PORT}/${material.ringkasanPath}`;
        return material;
    }

    /** CREATE */
    async createMaterial(
        data: CreateMaterialDto,
        sectionId: number
    ): Promise<Material> {
        const paths = {
            templatePath: saveFile(data.template, false),
            video_path: saveFile(data.video, false),
            materialFilePath: saveFile(data.materialFile, false),
            ringkasanPath: saveFile(data.ringkasan, false),
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
            updatePayload.templatePath = saveFile(data.template, false);
        }
        if (data.video) {
            deleteFile(existing.video_path);
            updatePayload.video_path = saveFile(data.video, false);
        }
        if (data.materialFile) {
            deleteFile(existing.materialFilePath);
            updatePayload.materialFilePath = saveFile(data.materialFile, false);
        }
        if (data.ringkasan) {
            deleteFile(existing.ringkasanPath);
            updatePayload.ringkasanPath = saveFile(data.ringkasan, false);
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
}

export default new MaterialService();
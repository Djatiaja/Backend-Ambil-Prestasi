// src/services/material.service.ts
import { Material } from "@prisma/client";
import materialRepository from "../repositories/material.repository";
import { CreateMaterialDto, UpdateMaterialDto } from "../schemas/material.schema";
import { NotFoundError } from "../errors/notfound.error";
import { deleteFile, saveFile } from "../helpers/file";
export class MaterialService {
    async getAllMaterials(sectionId: number): Promise<Material[]> {
        return await materialRepository.findAll(sectionId);
    }

    async getMaterialById(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) throw new NotFoundError("Material not found");
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
        // const existing = await materialRepository.findById(id);
        // if (!existing) throw new NotFoundError("Material not found");

        // const updatePayload: Partial<Material> = {};

        // if (data.title) updatePayload.title = data.title;
        // if (data.content) updatePayload.content = data.content;

        // // ---- FILE REPLACEMENT ----
        // const replace = async (
        //   newFile: Express.Multer.File | undefined,
        //   oldPath: string | null,
        //   field: keyof Material
        // ) => {
        //   if (newFile) {
        //     deleteFile(oldPath ?? "");
        //     updatePayload[field] = saveFile(newFile, false);
        //   }
        // };

        // await replace(data.template, existing.templatePath, "templatePath");
        // await replace(data.video, existing.video_path, "video_path");
        // await replace(data.materialFile, existing.materialFilePath, "materialFilePath");
        // await replace(data.ringkasan, existing.ringkasanPath, "ringkasanPath");

        return await materialRepository.findById(id) as Material;
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
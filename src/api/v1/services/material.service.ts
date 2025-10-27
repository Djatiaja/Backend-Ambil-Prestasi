import { Material } from '@prisma/client';
import materialRepository from '../repositories/material.repository';
import { CreateMaterialDto, UpdateMaterialDto } from '../schemas/material.schema';
import { NotFoundError } from '../errors/notfound.error';

export class MaterialService {
    async getAllMaterials(): Promise<Material[]> {
        return await materialRepository.findAll();
    }

    async getMaterialById(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) {
            throw new NotFoundError('Material not found');
        }
        return material;
    }

    async createMaterial(data: CreateMaterialDto): Promise<Material> {
        return await materialRepository.create({ ...data, xp: 10 });
    }

    async updateMaterial(id: number, data: UpdateMaterialDto): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) {
            throw new NotFoundError('Material not found');
        }
        return await materialRepository.update(id, data);
    }

    async deleteMaterial(id: number): Promise<Material> {
        const material = await materialRepository.findById(id);
        if (!material) {
            throw new NotFoundError('Material not found');
        }
        return await materialRepository.delete(id);
    }
}

export default new MaterialService();
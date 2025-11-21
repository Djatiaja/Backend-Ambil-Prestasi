import prisma from "../../../database";

const safeCategoryFields = {
    id: true,
    name: true,
};

class CategoryRepository {
    async getAllCategory() {
        return await prisma.category.findMany({
            where: { deleted: false },
            select: safeCategoryFields,
        });
    }

    async getCategoryById(categoryId: number) {
        return await prisma.category.findUnique({
            where: { id: categoryId },
            select: safeCategoryFields,
        });
    }

    async createCategory(name: string) {
        return await prisma.category.create({
            data: {
                name,
            },
            select: safeCategoryFields,
        });
    }

    async updateCategory(categoryId: number, name: string) {
        return await prisma.category.update({
            where: { id: categoryId },
            data: { name },
            select: safeCategoryFields,
        });
    }

    async deleteCategory(categoryId: number) {
        return await prisma.category.update({
            where: { id: categoryId },
            data: { deleted: true },
            select: safeCategoryFields,
        });
    }

    async getDeletedCategories() {
        return await prisma.category.findMany({
            where: { deleted: true },
            select: safeCategoryFields,
        });
    }

    async restoreCategory(categoryId: number) {
        return await prisma.category.update({
            where: { id: categoryId },
            data: { deleted: false },
            select: safeCategoryFields,
        });
    }
}

export default new CategoryRepository();
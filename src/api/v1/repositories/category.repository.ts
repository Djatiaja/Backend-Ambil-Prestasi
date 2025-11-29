import prisma from "../../../database";

const safeCategoryFields = {
    id: true,
    name: true,
};

class CategoryRepository {
    async getAllCategory() {
        return await prisma.category.findMany({
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
        // Check if there are classes in this category
        const classes = await prisma.class.findMany({
            where: { categoryId },
            select: {
                id: true,
                name: true,
            },
        });

        if (classes.length > 0) {
            // Return classes info instead of throwing error
            return {
                canDelete: false,
                totalClasses: classes.length,
                classes,
            };
        }

        // Perform permanent deletion if no classes
        await prisma.category.delete({
            where: { id: categoryId },
        });

        return {
            canDelete: true,
        };
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
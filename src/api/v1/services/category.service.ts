import categoryRepository from "../repositories/category.repository";


class CategoryService {
    async getAllCategories() {
        return await categoryRepository.getAllCategory();
    }

    async getCategoryById(categoryId: number) {
        return await categoryRepository.getCategoryById(categoryId);
    }

    async createCategory(name: string) {
        return await categoryRepository.createCategory(name);
    }

    async updateCategory(categoryId: number, name: string) {
        return await categoryRepository.updateCategory(categoryId, name);
    }

    async deleteCategory(categoryId: number) {
        return await categoryRepository.deleteCategory(categoryId);
    }

}

export default new CategoryService();
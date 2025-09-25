import prisma from "../../../database";


class ClassRepository {
    async getCount() {
        return prisma.class.count()
    }
}


export const classRepository = new ClassRepository()
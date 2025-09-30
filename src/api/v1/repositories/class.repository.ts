import prisma from "../../../database";


class ClassRepository {
    async getCount() {
        return await prisma.class.count()
    }

    async createClass(name: string, description: string) {
        return await prisma.class.create({ data: { name: name, description: description } })
    }

    async findClassById(classId: number) {
        return await prisma.class.findFirst({ where: { id: classId } })
    }

}


export default new ClassRepository()
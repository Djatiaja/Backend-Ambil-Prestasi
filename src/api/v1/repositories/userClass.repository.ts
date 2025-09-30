import { class_role } from "@prisma/client";
import prisma from "../../../database";


class UserClassRepository {
    async createUserClass(userId: string, classId: number, role: class_role) {
        return await prisma.user_Class.create({ data: { userId: userId, classId: classId, role: role } })
    }
}

export default new UserClassRepository();
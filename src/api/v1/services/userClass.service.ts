import { class_role } from "@prisma/client";
import userClassRepository from "../repositories/userClass.repository";


class UserClassService {
    async assignClass(userId: string, classId: number, role: class_role) {
        return await userClassRepository.createUserClass(userId, classId, role)
    }
}

export default new UserClassService()
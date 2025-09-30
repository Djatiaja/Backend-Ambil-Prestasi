import { error } from "console";
import classRepository from "../repositories/class.repository";
import userService from "./user.service";
import userClassService from "./userClass.service";
import { class_role } from "@prisma/client";


class ClassService {

    async getClassCount() {
        return await classRepository.getCount()
    }

    async createClass(userid: string, data: { name: string, description: string }) {
        const user = await userService.getUserById(userid);
        const createdClass = await classRepository.createClass(data.name, data.description);
        if (!user) {
            throw error("User Not Found")
        }

        const userClass = await userClassService.assignClass(user.id, createdClass.id, class_role.Teacher)
        return
    }

}

export default new ClassService()
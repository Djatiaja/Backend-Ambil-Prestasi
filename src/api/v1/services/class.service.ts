import { classRepository } from "../repositories/class.repository";


class ClassService {

    async getClassCount() {
        return await classRepository.getCount()
    }

}

export default new ClassService()
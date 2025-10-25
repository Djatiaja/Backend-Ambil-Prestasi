import { Role } from "@prisma/client";
import prisma from "../../../database";


class roleRepository {

    async findRoleById(id: number): Promise<Role | null> {
        return await prisma.role.findUnique({ where: { id } });
    }
}

export default new roleRepository();
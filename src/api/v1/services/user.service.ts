import { User } from "@prisma/client";
import prisma from "../../../database";

class UserService {
    async getAllUsers() {
        return await prisma.user.findMany();
    }

    async getUserById(id: string) {
        return await prisma.user.findUnique({
            where: { id },
        });
    }

    async createUser(data: User) {
        return await prisma.user.create({
            data,
        });
    }

    async updateUser(id: string, data: Partial<User>) {
        return await prisma.user.update({
            where: { id },
            data,
        });
    }

    async deleteUser(id: string) {
        return await prisma.user.delete({
            where: { id },
        });
    }
}

export default new UserService();
import { User } from "@prisma/client";
import prisma from "../../../database";
import { BaseResponse } from "../types/responseType";
class UserService {
    async getAllUsers(data: { role: string, limit?: number, page?: number, isDeleted?: boolean }) {
        const { role, limit, page, isDeleted } = data;
        const users = await prisma.user.findMany({
            where: {
                role: {
                    name: role,
                },
            },
            include: { role: true }
        });

        const meta: BaseResponse<User>["meta"] = {
            itemCount: limit && page ? users.slice((page - 1) * limit, page * limit).length : users.length,
            totalItems: users.length,
            itemsPerPage: limit || users.length,
            totalPages: limit ? Math.ceil(users.length / limit) : 1,
            currentPage: page || 1
        };
        if (limit && page) {
            const startIndex = (page - 1) * limit;
            const endIndex = page * limit;
            return { users: users.slice(startIndex, endIndex), meta: meta };
        }

        return { users, meta };
    }

    async getUserById(id: string) {
        return await prisma.user.findUnique({
            where: { id },
            include: { role: true }
        });
    }

    async createUser(pdata: { name: string; email: string; password: string; role: string; username: string; profileImage?: string; }) {
        const { name, email, password, role, username, profileImage } = pdata;
        const roleData = await prisma.role.findUnique({ where: { name: role } });
        if (!roleData) throw new Error("Role not found");

        return await prisma.user.create({
            data: {
                name,
                email,
                password,
                username,
                profileImage: profileImage || "https://ui-avatars.com/api/?name=" + encodeURIComponent(name) + "&background=random",
                roleId: roleData.id,
            },
            include: { role: true }
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
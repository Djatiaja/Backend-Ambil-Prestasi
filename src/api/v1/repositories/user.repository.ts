import { User } from "@prisma/client";
import prisma from "../../../database";

class UserRepository {
    async findUserById(userId: string) {
        return await prisma.user.findUnique({
            where: { id: userId },
            include: { role: true }
        });
    }

    async getUsers(roleName?: string, limit: number = 10, page: number = 1, search?: string): Promise<User[]> {
        if (search) {

            return await prisma.user.findMany({
                take: limit,
                skip: page > 0 ? (page - 1) * limit : 0,
                where: {
                    role: {
                        name: roleName,
                    },
                    OR: [
                        { name: { contains: search } },
                        { email: { contains: search } },
                        { username: { contains: search } },
                    ],
                },
                include: { role: true }
            });

        }
        return await prisma.user.findMany({
            take: limit,
            skip: page > 0 ? (page - 1) * limit : 0,
            where: {
                role: {
                    name: roleName,
                },
            },
            include: { role: true }
        });
    }

    async getUser(data: { email?: string; username?: string; id?: string }): Promise<User | null> {
        return await prisma.user.findFirst({
            where: {
                OR: [
                    data.email ? { email: data.email } : {},
                    data.username ? { username: data.username } : {},
                    data.id ? { id: data.id } : {},
                ],
            },
        });
    }


    async createUser(data: { name: string; email: string; password: string; role: string; username: string; profileImage?: string; }) {
        const { name, email, password, role, username, profileImage } = data;
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

    async updateUser(userId: string, data: Partial<User>) {
        return await prisma.user.update({
            where: { id: userId },
            data,
            include: { role: true }
        });
    }

    async countUsers(data: { roleName?: string }): Promise<number> {
        if (data.roleName) {
            return await prisma.user.count({
                where: {
                    role: {
                        name: data.roleName,
                    },
                },
            });
        }

        return await prisma.user.count({});
    }
}

export const userRepository = new UserRepository();
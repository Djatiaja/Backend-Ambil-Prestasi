import { User } from "@prisma/client";
import prisma from "../../../database";
import { hash } from "bcrypt";


const SALT_ROUNDS = 10
class UserRepository {
    async findUserById(userId: string) {
        return await prisma.user.findUnique({
            where: { id: userId },
            select: {
                id: true,
                name: true,
                email: true,
                username: true,
                profileImage: true
            },
        });
    }

    async getUsers(roleName?: string, limit: number = 10, page: number = 1, search?: string): Promise<Partial<User>[]> {
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
                select: {
                    id: true,
                    name: true,
                    email: true,
                },
                orderBy: {
                    name: "asc"
                }
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
            select: {
                id: true,
                name: true,
                email: true,
            },
            orderBy: {
                name: "asc"
            }
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
        const hashedPassword = await hash(password, SALT_ROUNDS);

        return await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                username,
                profileImage: profileImage || "https://ui-avatars.com/api/?name=" + encodeURIComponent(name) + "&background=random",
                roleId: roleData.id,
            },
            select: {
                id: true,
                name: true,
                email: true,
                username: true
            },
        });
    }

    async updateUser(userId: string, data: Partial<User>) {
        return await prisma.user.update({
            where: { id: userId },
            data,
            select: {
                id: true,
                name: true,
                email: true,
                username: true
            },
        });
    }

    async countUsers(data: { roleName?: string; search?: string }): Promise<number> {
        return await prisma.user.count({
            where: {
                ...(data.roleName && {
                    role: {
                        name: data.roleName,
                    },
                }),
                ...(data.search && {
                    OR: [
                        { username: { contains: data.search } },
                        { name: { contains: data.search } },
                        { email: { contains: data.search } },
                    ],
                }),
            },
        });
    }

}

export const userRepository = new UserRepository();
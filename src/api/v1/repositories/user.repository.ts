import { User, user_status } from "@prisma/client";
import prisma from "../../../database";

export const safeUserFields = {
    id: true,
    name: true,
    email: true,
    username: true,
    profileImage: true,
    roleId: true,
    telp: true,
    status: true,
    specialization: true,
    bio: true,
};

const SALT_ROUNDS = 10
class UserRepository {
    async findUserById(userId: string) {
        return await prisma.user.findFirst({
            where: { id: userId },
            select: safeUserFields,
        });
    }

    async getUsers(roleName?: string, limit: number = 10, page: number = 1, search?: string, isActive?: boolean): Promise<Partial<User>[]> {
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
                    ...(isActive !== undefined && {
                        status: isActive ? user_status.ACTIVE : user_status.INACTIVE,
                    })
                },
                select: safeUserFields,
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
                ...(isActive !== undefined && {
                    status: isActive ? user_status.ACTIVE : user_status.INACTIVE,
                })
            },
            select: safeUserFields,
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


    async createUser(data: { name: string; email: string; password: string; role: string; username: string; profileImage?: string; telp?: string; status?: user_status; specialization?: string; bio?: string }): Promise<Partial<User>> {
        const { name, email, password, role, username, profileImage } = data;
        const roleData = await prisma.role.findUnique({ where: { name: role } });
        if (!roleData) throw new Error("Role not found");

        return await prisma.user.create({
            data: {
                name,
                email,
                password: password,
                username,
                profileImage: profileImage || "https://ui-avatars.com/api/?name=" + encodeURIComponent(name) + "&background=random",
                roleId: roleData.id,
                telp: data.telp,
                status: data.status ?? user_status.ACTIVE,
                specialization: data.specialization,
                bio: data.bio,
            },
            select: safeUserFields,
        });
    }

    async updateUser(userId: string, data: Partial<User>) {
        return await prisma.user.update({
            where: { id: userId },
            data,
            select: safeUserFields,
        });
    }

    async countUsers(data: { roleName?: string; search?: string, isActive?: boolean }): Promise<number> {
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
                ...(data.isActive !== undefined && {
                    status: data.isActive ? user_status.ACTIVE : user_status.INACTIVE,
                })
            },
        });
    }

    async getUserRole(userId: string): Promise<string> {
        const user = await prisma.user.findFirst({
            where: { id: userId },
            include: { role: true },
        });
        if (!user || !user.role) {
            throw new Error("User or role not found");
        }

        return user.role.name;
    }

}

export const userRepository = new UserRepository();
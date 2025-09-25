import { User } from "@prisma/client";
import prisma from "../../../database";
import { BaseResponse } from "../types/responseType";
import { userRepository } from "../repositories/user.repository";

class UserService {
    async getAllUsers(data: { role: string, limit?: number, page?: number, isDeleted?: boolean, search?: string }) {
        const { role, limit, page, isDeleted, search } = data;
        const users = await userRepository.getUsers(role, limit ?? 10, page ?? 1, search);
        const userCount = await userRepository.countUsers({ roleName: role, search });

        const meta: BaseResponse<User>["meta"] = {
            itemCount: userCount,
            totalItems: userCount,
            itemsPerPage: limit ?? 10,
            totalPages: limit ? Math.ceil(userCount / limit) : 1,
            currentPage: page || 1
        };

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
        const roleData = await prisma.role.findFirst({ where: { name: role } });
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

    async getUserCount(data: { roleName?: string }) {
        return await userRepository.countUsers({ roleName: data.roleName });
    }

    async getUserChart(data: { roleName?: string }) {
        const { roleName } = data;
        const currentYear = new Date().getFullYear();
        const startYear = currentYear - 4; // last 5 years

        // Base where clause
        const whereClause: any = {};
        if (roleName) {
            whereClause.role = { name: roleName };
        }

        // Fetch users for last 5 years
        const users = await prisma.user.findMany({
            where: {
                ...whereClause,
                createdAt: { gte: new Date(`${startYear}-01-01`) },
            },
            select: { createdAt: true },
        });

        // Initialize monthly counts for current year
        const monthlyCounts: Record<number, number> = {};
        for (let month = 1; month <= 12; month++) {
            monthlyCounts[month] = 0;
        }

        // Initialize yearly counts for last 5 years
        const yearlyCounts: Record<number, number> = {};
        for (let year = startYear; year <= currentYear; year++) {
            yearlyCounts[year] = 0;
        }

        // Populate counts
        users.forEach(user => {
            const created = user.createdAt;
            const year = created.getFullYear();
            const month = created.getMonth() + 1; // JS months: 0-11

            if (year === currentYear) {
                monthlyCounts[month] += 1;
            }

            if (year >= startYear) {
                yearlyCounts[year] += 1;
            }

        });

        return {
            oneYear: monthlyCounts,
            fiveYear: yearlyCounts,
        };
    }

}

export default new UserService();
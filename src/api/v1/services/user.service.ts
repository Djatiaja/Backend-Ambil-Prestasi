import { User, user_status } from "@prisma/client";
import bcrypt from 'bcrypt';

import prisma from "../../../database";
import { BaseResponse } from "../types/responseType";
import { userRepository } from "../repositories/user.repository";

class UserService {
    async getAllUsers(data: { role: string, limit?: number, page?: number, isDeleted?: boolean, search?: string, isActive?: boolean }) {
        const { role, limit, page, search, isActive } = data;
        const users = await userRepository.getUsers(role, limit ?? 10, page ?? 1, search, isActive);
        const userCount = await userRepository.countUsers({ roleName: role, search, isActive });

        const meta: BaseResponse<User>["meta"] = {
            totalItems: userCount,
            itemsPerPage: limit ?? 10,
            totalPages: limit ? Math.ceil(userCount / limit) : 1,
            currentPage: page || 1
        };

        return { users, meta };
    }

    async findUser(data: { username?: string; email?: string }) {
        const { username, email } = data;
        if (!username && !email) throw new Error("username or email is required");

        const where = username && email ? { OR: [{ username }, { email }] } :
            username ? { username } :
                { email };

        return await prisma.user.findFirst({
            where,
            include: { role: true }
        });
    }

    async getUserById(id: string) {
        return await prisma.user.findFirst({
            where: { id },
            include: { role: true }

        });
    }

    async createUser(pdata: { name: string; email: string; password: string; role: string; username: string; profileImage?: string; telp?: string; status?: user_status; specialization?: string; bio?: string }) {
        const { name, email, password, role, username, profileImage, telp, status, specialization, bio } = pdata;
        const hashedPassword = await bcrypt.hash(password, 10);
        const roleData = await prisma.role.findFirst({ where: { name: role } });
        if (!roleData) throw new Error("Role not found");
        if (await this.findUser({ email })) {
            throw new Error("Email already exists");
        }
        if (await this.findUser({ username })) {
            throw new Error("Username already exists");
        }

        return await userRepository.createUser({ name, email, password: hashedPassword, role, username, profileImage, telp, status, specialization, bio })
    }

    async updateUser(id: string, data: Partial<User>) {
        return await userRepository.updateUser(id, data)
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
        const whereClause: { role?: { name: string } } = {};
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
    };



}

export default new UserService();
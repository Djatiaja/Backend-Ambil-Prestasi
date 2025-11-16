import prisma from "../../../database";

class ProfileRepository {
    async getUserProfile(userId: string) {
        return await prisma.user.findUnique({
            where: { id: userId },
            select: {
                id: true,
                email: true,
                username: true,
                name: true,
                profileImage: true,
                telp: true,
                status: true,
                specialization: true,
                bio: true,
                verified_at: true,
                createdAt: true,
                updatedAt: true,
                role: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    }

    async getActiveSubscription(userId: string) {
        return await prisma.user_Subscription.findFirst({
            where: {
                userId,
                status: "ACTIVE",
            },
            orderBy: {
                endAt: "desc",
            },
            select: {
                id: true,
                status: true,
                startAt: true,
                endAt: true,
            },
        });
    }
}

export default new ProfileRepository();

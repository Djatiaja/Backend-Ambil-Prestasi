import prisma from "../../../database";


class OTPRepository {
    async findOTPByEmail(email: string) {
        return await prisma.oTP_Token.findFirst({
            where: { User: { email: email } },
            include: { User: true },
            orderBy: { createdAt: 'desc' },
        });
    }

    async createOTP(email: string, otp: string) {
        return await prisma.oTP_Token.create({
            data: {
                User: { connect: { email: email } },
                code: otp,
            },
        });
    }
}

export default new OTPRepository();
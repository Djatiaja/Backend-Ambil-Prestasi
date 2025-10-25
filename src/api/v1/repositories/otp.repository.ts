import { otp_type } from "@prisma/client";
import prisma from "../../../database";


class OTPRepository {
    async findOTPByEmail(email: string) {
        return await prisma.oTP_Token.findFirst({
            where: { User: { email: email } },
            include: { User: true },
            orderBy: { createdAt: 'desc' },
        });
    }

    async createOTP(email: string, otp: string, type: otp_type) {
        return await prisma.oTP_Token.create({
            data: {
                User: { connect: { email: email } },
                code: otp,
                type: type,
            },
        });
    }
}

export default new OTPRepository();
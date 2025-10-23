import { token, token_type } from "@prisma/client";
import prisma from "../../../database";


class TokenRepository {
    async createToken(userId: string, resetToken: string, tokenType: token_type) {
        const token = await prisma.token.create({ data: { userId, token: resetToken, type: tokenType } });
        return token;
    }

    async findToken(token: string): Promise<null | token> {
        const foundToken = await prisma.token.findUnique({ where: { token } });
        return foundToken;
    }

    async deleteToken(token: string) {
        await prisma.token.delete({ where: { token } });
    }
}

export default new TokenRepository();
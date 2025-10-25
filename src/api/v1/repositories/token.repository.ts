import { Reset_Token, token_type } from "@prisma/client";
import prisma from "../../../database";


class TokenRepository {
    async createToken(userId: string, resetToken: string, tokenType: token_type) {
        const token = await prisma.reset_Token.create({ data: { userId, token: resetToken, type: tokenType } });
        return token;
    }

    async findToken(token: string): Promise<null | Reset_Token> {
        const foundToken = await prisma.reset_Token.findUnique({ where: { token } });
        return foundToken;
    }

    async deleteToken(token: string) {
        await prisma.reset_Token.delete({ where: { token } });
    }
}

export default new TokenRepository();
import { Reset_Token, token_type, User } from "@prisma/client";
import { generateResetToken } from "../helpers/token";
import tokenRepository from "../repositories/token.repository";
import userService from "./user.service";


class TokenService {
    async generateToken(data: { userId: string, tokenType: token_type }) {
        const { userId, tokenType } = data;
        const user = await userService.getUserById(userId);

        if (!user) {
            throw new Error("User not found");
        }

        const resetToken = await generateResetToken();
        const token = await tokenRepository.createToken(user.id, resetToken, tokenType);

        return token;
    }

    async verifyToken(token: string) {
        const foundToken: Reset_Token | null = await tokenRepository.findToken(token);

        if (!foundToken) {
            throw new Error("Invalid or expired token");
        }

        const expiresAt = new Date(foundToken.createdAt.getTime() + 10 * 60 * 1000); // 10 minutes

        if (expiresAt < new Date()) {
            throw new Error("Invalid or expired token");
        }

        return true;
    }

    async findUserByToken(token: string) {
        const foundToken: Reset_Token | null = await tokenRepository.findToken(token);

        if (!foundToken) {
            return null;
        }

        const user = await userService.getUserById(foundToken.userId);
        return user;
    }
}

export default new TokenService();
import crypto from 'crypto';
import tokenRepository from '../repositories/token.repository';

export const generateResetToken = async (): Promise<string> => {
    const resetToken = crypto.randomBytes(32).toString('hex');

    const token = await tokenRepository.findToken(resetToken);

    if (token) {
        return generateResetToken();
    }

    return resetToken;
};

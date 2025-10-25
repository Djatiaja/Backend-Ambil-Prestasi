import bcrypt from 'bcrypt';
import { token_type, User } from '@prisma/client';
import { sendOTPEmail } from '../helpers/email';
import userService from './user.service';
import tokenService from './token.service';
import prisma from '../../../database';

export class AuthService {
    async login(username: string, password: string): Promise<{ user: User; isSameCredentials: boolean }> {
        const user = await userService.findUser({ username: username });
        if (!user || !(await bcrypt.compare(password, user.password))) {
            throw new Error('Invalid credentials');
        }
        const isSameCredentials = username === password;
        return { user, isSameCredentials };
    }

    async register(username: string, name: string, email: string, password: string): Promise<Partial<User>> {
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await userService.createUser({
            username,
            name,
            email,
            password: hashedPassword,
            role: "Student",
        });

        // await sendOTPEmail(email, token.token);

        return user;
    }

    async forgotPassword(email: string): Promise<void> {
        const user = await userService.findUser({ email: email });
        if (user) {
            const token = await tokenService.generateToken({ userId: user.id, tokenType: token_type.ResetPassword });
            await sendOTPEmail(email, token.token);
        }
    }

    async resetPassword(token: string, newPassword: string, confirmPassword: string): Promise<void> {
        if (newPassword !== confirmPassword) {
            throw new Error('Passwords do not match');
        }
        const user = await tokenService.findUserByToken(token);
        if (!user) {
            throw new Error('Invalid or expired token');
        }
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await userService.updateUser(user.id, { password: hashedPassword });
    }

    async verifyToken(token: string): Promise<boolean> {
        const isValid = await tokenService.verifyToken(token);
        if (!isValid) {
            throw new Error('Invalid or expired token');
        }
        return true;
    }
}
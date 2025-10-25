import bcrypt from 'bcrypt';
import { Reset_Token, token_type, User } from '@prisma/client';
import { sendOTPEmail } from '../helpers/email';
import userService from './user.service';
import tokenService from './token.service';
import otpService from './otp.service';

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

        const otp: string = await otpService.generateOTP(email);
        await sendOTPEmail(email, otp, "verify your account");
        return user;
    }

    async forgotPassword(email: string): Promise<void> {
        const user = await userService.findUser({ email: email });
        if (user) {
            const otp: string = await otpService.generateOTP(email);
            await sendOTPEmail(email, otp, "reset your password");
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

    async verifyOTP(email: string, otp: string): Promise<string> {
        const user = await userService.findUser({ email: email });
        if (!user) {
            throw new Error('User not found');
        }
        const isValidOTP = await otpService.verifyOTP(email, otp);

        const token: Reset_Token = await tokenService.generateToken({ userId: user.id, tokenType: token_type.ResetPassword });
        return token.token;
    }
}
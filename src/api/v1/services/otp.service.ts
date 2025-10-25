import { otp_type } from "@prisma/client";
import otpRepository from "../repositories/otp.repository";

class OTPService {
    async generateOTP(email: string, type: otp_type): Promise<string> {
        const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        const otpCode = Array.from({ length: 6 }, () => chars[Math.floor(Math.random() * chars.length)]).join('')
        await otpRepository.createOTP(email, otpCode, type);
        return otpCode;
    }

    async verifyOTP(email: string, otp: string): Promise<boolean> {
        const checkOTP = await otpRepository.findOTPByEmail(email);
        if (!checkOTP || checkOTP.code !== otp) {
            return false;
        }

        if (Date.now() - checkOTP.createdAt.getTime() > 5 * 60 * 1000) {
            return false;
        }

        return true;
    }

    findOTPByEmail(email: string) {
        return otpRepository.findOTPByEmail(email);
    }

}
export default new OTPService();
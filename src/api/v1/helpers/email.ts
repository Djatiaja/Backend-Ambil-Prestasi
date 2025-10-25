import nodemailer from 'nodemailer';

export const sendOTPEmail = async (email: string, otp: string): Promise<void> => {
    const transporter = nodemailer.createTransport({
        host: process.env.EMAIL_HOST,
        port: Number(process.env.EMAIL_PORT),
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS,
        },
    });

    await transporter.sendMail({
        from: process.env.EMAIL_FROM,
        to: email,
        subject: 'OTP',
        text: `Use this OTP: ${otp}`,
    });
};
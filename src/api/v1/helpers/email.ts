import nodemailer from 'nodemailer';

export const sendOTPEmail = async (email: string, otp: string, message: string): Promise<void> => {
    const transporter = nodemailer.createTransport({
        host: process.env.EMAIL_HOST,
        port: Number(process.env.EMAIL_PORT),
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS,
        },
    });

    const htmlContent = `
        <div style="
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f7f7f7;
            padding: 30px;
            text-align: center;
        ">
            <div style="
                background-color: #ffffff;
                border-radius: 12px;
                max-width: 400px;
                margin: auto;
                padding: 20px 30px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            ">
                <h2 style="color: #333;">🔐 Verifikasi Akun Anda</h2>
                <p style="color: #555; font-size: 15px;">
                    ${message}
                </p>
                <div style="
                    font-size: 28px;
                    letter-spacing: 6px;
                    font-weight: bold;
                    color: #2a9d8f;
                    background-color: #e9f7f5;
                    padding: 12px 0;
                    border-radius: 8px;
                    margin: 20px 0;
                ">
                    ${otp}
                </div>
                <p style="font-size: 13px; color: #777;">
                    Kode ini berlaku selama <b>5 menit</b>. Jangan bagikan kode ini kepada siapa pun.
                </p>
            </div>
            <p style="margin-top: 20px; font-size: 12px; color: #aaa;">
                © ${new Date().getFullYear()} Ambil Prestasi. All rights reserved.
            </p>
        </div>
    `;

    await transporter.sendMail({
        from: process.env.EMAIL_FROM,
        to: email,
        subject: '🔑 Kode OTP Anda',
        text: `${message}: ${otp}`, // fallback text jika email tidak mendukung HTML
        html: htmlContent,
    });
};

import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { AuthService } from '../services/auth.service';
import { sendResponse } from '../helpers/baseResponse';
import { JwtPayload } from '../types/auth.type';

export class AuthController {
    private authService: AuthService;

    constructor() {
        this.authService = new AuthService();
    }

    login = async (req: Request, res: Response) => {
        try {
            const { usernameoremail, password } = req.body;
            const { user, isSameCredentials } = await this.authService.login(usernameoremail, password);


            const payload: JwtPayload = { user_id: user.id };
            const token = jwt.sign(payload, process.env.JWT_SECRET!, { expiresIn: '1h' });

            if (isSameCredentials) {
                return sendResponse({
                    res,
                    statusCode: 200,
                    success: true,
                    message: 'Login successful, please update your password',
                    data: { token, isSameCredentials: true },
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Login successful',
                data: { token },
            });
        } catch (error: any) {
            console.log(error)
            return sendResponse({
                res,
                statusCode: 401,
                success: false,
                message: error.message || 'Invalid credentials',
                data: null,
            });
        }
    };

    forgotPassword = async (req: Request, res: Response) => {
        try {
            const { email } = req.body;
            const isSent = await this.authService.forgotPassword(email);
            if (!isSent) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'Invalid credentials',
                    data: null,
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Password reset OTP sent',
                data: null,
            });
        } catch (error: any) {
            console.log(error)
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: 'Server error',
                data: null,

            });
        }
    };

    verifyOTP = async (req: Request, res: Response) => {
        try {
            const { email, code } = req.body;
            const token = await this.authService.verifyOTP(email, code);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'OTP verified successfully',
                data: token ? { reset_token: token } : null,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message || 'Invalid or expired OTP',
                data: null,
            });
        }
    };

    resetPassword = async (req: Request, res: Response) => {
        try {
            const { reset_token, newPassword } = req.body;
            await this.authService.resetPassword(reset_token, newPassword);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Password reset successful',
                data: null,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message || 'Invalid or expired token',
                data: null,
            });
        }
    };


    register = async (req: Request, res: Response) => {
        try {
            const { username, name, email, password } = req.body;
            const user = await this.authService.register(username, name, email, password);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'User registered successfully',
                data: user,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: error.message || 'Server error',
                data: null,
            });
        }
    }

    resendOTP = async (req: Request, res: Response) => {
        try {
            const { email } = req.body;
            await this.authService.resendOTP(email);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'OTP resent successfully',
                data: null,
            });
        } catch (error: any) {
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: error.message || 'User not found',
                data: null,
            });
        }
    };
}
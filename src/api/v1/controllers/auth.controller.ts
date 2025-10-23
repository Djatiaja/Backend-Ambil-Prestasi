import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { JwtPayload } from '../types/auth.type';
import { AuthService } from '../services/auth.service';
import { sendResponse } from '../helpers/baseResponse';

export class AuthController {
    private authService: AuthService;

    constructor() {
        this.authService = new AuthService();
    }

    login = async (req: Request, res: Response) => {
        try {
            const { username, password } = req.body;
            const { user, isSameCredentials } = await this.authService.login(username, password);
            const token = jwt.sign({ user_id: user.id }, process.env.JWT_SECRET!, { expiresIn: '1h' });

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
            await this.authService.forgotPassword(email);
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'If the email exists, a reset link has been sent',
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

    verifyResetToken = async (req: Request, res: Response) => {
        try {
            const { token } = req.body;
            await this.authService.verifyToken(token);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Token is valid',
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

    resetPassword = async (req: Request, res: Response) => {
        try {
            const { token, newPassword, confirmPassword } = req.body;
            await this.authService.resetPassword(token, newPassword, confirmPassword);
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
            const { username, email } = req.body;
            // const user = await this.authService.register(username, email);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'User registered successfully',
                data: null, //user
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
}
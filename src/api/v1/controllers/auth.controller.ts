import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { AuthService } from '../services/auth.service';
import { sendResponse } from '../helpers/baseResponse';
import { JwtPayload } from '../types/auth.type';
import { registerUserDto } from '../schemas/auth.schema';
import roleRepository from '../repositories/role.repository';
import userService from '../services/user.service';

export class AuthController {
    private authService: AuthService;

    constructor() {
        this.authService = new AuthService();
    }

    login = async (req: Request, res: Response): Promise<Response> => {
        try {
            const { usernameoremail, password } = req.body;
            const { user, isSameCredentials } = await this.authService.login(usernameoremail, password);


            const payload: JwtPayload = { user_id: user.id };
            const token = jwt.sign(payload, process.env.JWT_SECRET!, { expiresIn: '24h' });
            const role = await roleRepository.findRoleById(user.roleId);
            if (isSameCredentials) {
                return sendResponse({
                    res,
                    statusCode: 200,
                    success: true,
                    message: 'Login successful, please update your password',
                    data: { token, isSameCredentials: true, role: role?.name || null },
                });
            }

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Login successful',
                data: { token, role: role?.name || null },
            });
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 401,
                success: false,
                message: msg || 'Invalid credentials',
                data: null,
            });
        }
    };

    forgotPassword = async (req: Request, res: Response): Promise<Response> => {
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: msg || 'Server error',
                data: null,
            });
        }
    };

    verifyOTP = async (req: Request, res: Response): Promise<Response> => {
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: msg || 'Invalid or expired OTP',
                data: null,
            });
        }
    };

    resetPassword = async (req: Request, res: Response): Promise<Response> => {
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: msg || 'Invalid or expired token',
                data: null,
            });
        }
    };


    register = async (req: Request, res: Response): Promise<Response> => {
        try {
            const user = await this.authService.register(req.body as registerUserDto);
            return sendResponse({
                res,
                statusCode: 201,
                success: true,
                message: 'User registered successfully',
                data: user,
            });
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: msg || 'Server error',
                data: null,
            });
        }
    }

    resendOTP = async (req: Request, res: Response): Promise<Response> => {
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
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message: msg || 'User not found',
                data: null,
            });
        }
    };

    checkRole = async (req: Request, res: Response): Promise<Response> => {
        try {
            const userId = (req.user as JwtPayload).user_id;
            const user = await userService.getUserById(userId);
            if (!user) {
                return sendResponse({
                    res,
                    statusCode: 404,
                    success: false,
                    message: 'User not found',
                    data: null,
                });
            }

            const role = req.role;
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'User role fetched successfully',
                data: { role: role || null },
            });
        }
        catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: msg || 'Server error',
                data: null,
            });
        }
    }

    // Logout endpoint - stateless JWTs used in this project, so logout simply instructs client to drop token.
    logout = async (req: Request, res: Response): Promise<Response> => {
        try {
            // If you later add refresh tokens or server-side session storage, revoke here.
            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: 'Logout successful',
                data: null,
            });
        } catch (error: unknown) {
            const msg = error instanceof Error ? error.message : String(error);
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message: msg || 'Server error',
                data: null,
            });
        }
    };
}
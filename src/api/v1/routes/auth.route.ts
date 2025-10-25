import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';
import { validateBody } from '../middlewares/schema.middleware';
import { forgotPasswordSchema, loginSchema, OTPSchema, registerSchema, resendOTPSchema, resetPasswordSchema } from '../schemas/auth.schema';

const authRouter = Router();
const authController = new AuthController();

authRouter.post('/login', validateBody(loginSchema), authController.login);
authRouter.post('/register', validateBody(registerSchema), authController.register);
authRouter.post('/verify-otp', validateBody(OTPSchema), authController.verifyOTP);
authRouter.post('/resend-otp', validateBody(resendOTPSchema), authController.resendOTP);
authRouter.post('/forgot-password', validateBody(forgotPasswordSchema), authController.forgotPassword);
authRouter.patch('/reset-password', validateBody(resetPasswordSchema), authController.resetPassword);

export default authRouter;
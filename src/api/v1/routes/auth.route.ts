import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';
import { validateBody } from '../middlewares/schema.middleware';
import { forgotPasswordSchema, loginSchema, resetPasswordSchema, resetTokenSchema } from '../schemas/auth.schema';

const authRouter = Router();
const authController = new AuthController();

authRouter.post('/login', validateBody(loginSchema), authController.login);
authRouter.post('/forgot-password', validateBody(forgotPasswordSchema), authController.forgotPassword);
authRouter.post('/verify-token', validateBody(resetTokenSchema), authController.verifyResetToken);
authRouter.patch('/reset-password', validateBody(resetPasswordSchema), authController.resetPassword);

export default authRouter;
import { Router } from 'express';
import { authMiddleware } from '../middlewares/auth.middleware';
import { createRedeemCodeSchema, redeemCodeSchema, updateRedeemCodeSchema } from '../schemas/redeem-code.schema';
import { RedeemController } from '../controllers/redeem.controller';
import { validateBody } from '../middlewares/schema.middleware';
import { verifyRole } from '../middlewares/verifyrole.middleware';

const redeemRouter = Router();

// --- STUDENT ROUTES ---
redeemRouter.post("/", authMiddleware, verifyRole(["Student"]), validateBody(redeemCodeSchema), RedeemController.redeem);

// --- ADMIN ROUTES ---
redeemRouter.get('/admin', authMiddleware, verifyRole(["Admin"]), RedeemController.getAll);
redeemRouter.get('/admin/:id', authMiddleware, verifyRole(["Admin"]), RedeemController.getById);
redeemRouter.post('/admin', authMiddleware, verifyRole(["Admin"]), validateBody(createRedeemCodeSchema), RedeemController.create);
redeemRouter.patch('/admin/:id', authMiddleware, verifyRole(["Admin"]), validateBody(updateRedeemCodeSchema), RedeemController.update);
redeemRouter.delete('/admin/:id', authMiddleware, verifyRole(["Admin"]), RedeemController.delete);

export default redeemRouter;
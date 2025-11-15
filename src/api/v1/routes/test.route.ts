import { Router } from "express";
import { authMiddleware } from "../middlewares/auth.middleware";
import { requireActiveSubscription } from "../middlewares/verifySubscription.middleware";


const testRouter = Router();

testRouter.get("/ping", authMiddleware, requireActiveSubscription, (req, res) => {
    res.status(200).json({
        status: 'success',
        message: 'pong',
        data: null,
    });
});

export default testRouter;
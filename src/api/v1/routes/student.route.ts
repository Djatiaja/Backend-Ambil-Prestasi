import { Router } from "express";
import studentController from "../controllers/student.controller";
import { authMiddleware } from "../middlewares/auth.middleware";
import { requireActiveSubscription } from "../middlewares/verifySubscription.middleware";


const studentRouter = Router();

studentRouter.get("/materials/:id", authMiddleware, requireActiveSubscription, studentController.getMaterialById);

export default studentRouter;
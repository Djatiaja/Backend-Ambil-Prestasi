import { Router } from "express";
import fileController from "../controllers/file.controller";
import { authMiddleware } from "../middlewares/auth.middleware";
import { requireActiveSubscription } from "../middlewares/verifySubscription.middleware";


const fileRouter = Router();

fileRouter.get("/public/:filename", fileController.AccessPublicFile);
fileRouter.get("/protected/:filename", authMiddleware, requireActiveSubscription, fileController.AccessProtectedFile);


export default fileRouter;
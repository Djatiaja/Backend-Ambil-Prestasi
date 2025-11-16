import { Router } from "express";
import profileController from "../controllers/profile.controller";
import { authMiddleware } from "../middlewares/auth.middleware";

const profileRouter = Router();

// Get current user profile (all roles)
profileRouter.get("/", authMiddleware, profileController.getProfile);

export default profileRouter;

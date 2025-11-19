import { Router } from "express";
import profileController from "../controllers/profile.controller";
import { authMiddleware } from "../middlewares/auth.middleware";
import { validateBody } from "../middlewares/schema.middleware";
import { updateProfileSchema } from "../schemas/profile.schema";
import multer from "multer";

const profileRouter = Router();
const upload = multer({ storage: multer.memoryStorage() });

// Get current user profile (all roles)
profileRouter.get("/", authMiddleware, profileController.getProfile);

// Update current user profile (all roles)
profileRouter.patch(
    "/",
    authMiddleware,
    upload.single("profileImage"),
    validateBody(updateProfileSchema),
    profileController.updateProfile
);

export default profileRouter;

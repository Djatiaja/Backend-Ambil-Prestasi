import { Router } from "express";
import teacherRouter from "./teacher.route";
import dashboardRouter from "./dashboard.route";
import classRouter from "./class.route";
import authRouter from "./auth.route";
import { authMiddleware } from "../middlewares/auth.middleware";
import { verifyRole } from "../middlewares/verifyrole.middleware";
import { User } from "@prisma/client";
import materialRouter from "./material.route";
import materialFileRouter from "./materialFile.route";
import sectionRouter from "./section.route";
import upload from "../../../config/multer.config";

const router = Router();
upload;
declare module "express-serve-static-core" {
    interface Request {
        user?: Partial<User>;
        token?: string;
        role?: string;
    }
}


router.use("/teachers", authMiddleware, verifyRole(["Admin", "Teacher"]), teacherRouter);
router.use("/dashboard", authMiddleware, verifyRole(["Admin"]), dashboardRouter);
router.use("/classes", authMiddleware, verifyRole(["Admin", "Teacher"]), classRouter);
router.use("/classes/:classId/sections", sectionRouter);
router.use("/classes/sections/:sectionId/materials", materialRouter);
router.use("/classes/sections/materials/:materialId/files", materialFileRouter);
router.use("/", authRouter)



export default router;

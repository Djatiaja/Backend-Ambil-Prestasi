import { Router } from "express";
import teacherRouter from "./teacher.route";
import dashboardRouter from "./dashboard.route";
import classRouter from "./class.route";
import authRouter from "./auth.route";
import { authMiddleware } from "../middlewares/auth.middleware";
import { verifyRole } from "../middlewares/verifyrole.middleware";

const router = Router();
router.use("/teachers", authMiddleware, verifyRole(["Admin", "Teacher"]), teacherRouter);
router.use("/dashboard", authMiddleware, verifyRole(["Admin"]), dashboardRouter);
router.use("/classes", authMiddleware, verifyRole(["Admin", "Teacher"]), classRouter);
router.use("/", authRouter)

export default router;

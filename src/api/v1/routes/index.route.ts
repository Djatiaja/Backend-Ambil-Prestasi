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
import publicRouter from "./public.route";
import categoryRouter from "./category.route";
import redeemRouter from "./redeem.route";
import testRouter from "./test.route";
import studentRouter from "./student.route";
import reviewRouter from "./review.route";
import fileRouter from "./file.route";
import quizRouter from "./quiz.route";

const router = Router();
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
router.use("/classes/sections/:sectionId/materials", authMiddleware, verifyRole(["Teacher", "Admin"]), materialRouter);
router.use("/classes/sections/materials/:materialId/quizzes", quizRouter);
router.use("/", authRouter)
router.use("/public", publicRouter)
router.use("/categories", authMiddleware, verifyRole(["Admin", "Teacher"]), categoryRouter);
router.use("/redeem", authMiddleware, verifyRole(["Admin", "Student"]), redeemRouter);

router.use("/students", authMiddleware, verifyRole(["Student"]), studentRouter);
router.use("/reviews", reviewRouter);
router.use("/files", fileRouter);
router.use("/test", testRouter);



export default router;

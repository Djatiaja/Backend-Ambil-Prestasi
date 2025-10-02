import { Router } from "express";
import teacherRouter from "./teacher.route";
import dashboardRouter from "./dashboard.route";
import classRouter from "./class.route";

const router = Router();
router.use("/teachers", teacherRouter);
router.use("/dashboard", dashboardRouter)
router.use("/classes", classRouter)

export default router;

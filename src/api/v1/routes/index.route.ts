import { Router } from "express";
import teacherRouter from "./teacher.route";
import dashboardRouter from "./dashboard.route";

const router = Router();
router.use("/teachers", teacherRouter);
router.use("/dashboard", dashboardRouter)

export default router;

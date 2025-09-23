import { Router } from "express";
import teacherRouter from "./teacher.router";

const router = Router();
router.use("/teachers", teacherRouter);

export default router;

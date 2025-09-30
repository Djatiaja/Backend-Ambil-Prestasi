import { Router } from "express";
import { getAllTeachers, createTeacher, getTeacherById, updateTeacher, deleteTeacher } from "../controllers/teacher.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { teacherCreateSchema, teacherUpdateSchema } from "../schemas/teacher.schema";
const router = Router();

router.get("/", (req, res) => getAllTeachers(req, res));

router.post("/", validateBody(teacherCreateSchema), (req, res) => createTeacher(req, res));

router.get("/:id", (req, res) => getTeacherById(req, res));

router.patch("/:id", (req, res) => validateBody(teacherUpdateSchema(req.params.id)), (req, res) => updateTeacher(req, res));

router.delete("/:id", (req, res) => deleteTeacher(req, res));

export default router;
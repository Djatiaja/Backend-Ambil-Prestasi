import { Router } from "express";
import publicController from "../controllers/public.controller";
import { getAllTeachers } from "../controllers/teacher.controller";
import { ReviewController } from "../controllers/review.controller";


const publicRouter = Router();
publicRouter.get("/classes", publicController.getClasses);
publicRouter.get("/classes/:id", publicController.getClassById);
publicRouter.get("/sections/:id", publicController.getSectionById);
publicRouter.get('/classes/:classId/reviews', ReviewController.getByClass);
publicRouter.get("/categories", publicController.getCategories);

publicRouter.get("/teachers", getAllTeachers);

export default publicRouter;
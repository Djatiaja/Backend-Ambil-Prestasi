import { Router } from "express";
import publicController from "../controllers/public.controller";


const publicRouter = Router();
publicRouter.get("/classes", publicController.getClasses);
publicRouter.get("/classes/:id", publicController.getClassById);
publicRouter.get("/categories", publicController.getCategories);

export default publicRouter;
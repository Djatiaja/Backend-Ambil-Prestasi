import { Router } from "express";
import studentController from "../controllers/student.controller";
import { authMiddleware } from "../middlewares/auth.middleware";
import { requireActiveSubscription } from "../middlewares/verifySubscription.middleware";
import classService from "../services/class.service";


const studentRouter = Router();

// Material routes
studentRouter.get("/materials/:id",
    authMiddleware,
    requireActiveSubscription,
    studentController.getMaterialById
);

studentRouter.get("/classes/sections/:classId",
    authMiddleware,
    requireActiveSubscription,
    studentController.getAllSectionsForStudent
);

export default studentRouter;
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

// Class enrollment routes
studentRouter.post("/classes/:classId/enroll",
    authMiddleware,
    studentController.enrollClass
);

studentRouter.delete("/classes/:classId/unenroll",
    authMiddleware,
    studentController.unenrollClass
);

studentRouter.get("/classes/enrolled",
    authMiddleware,
    studentController.getEnrolledClasses
);

studentRouter.get("/classes/:classId/enrollment-status",
    authMiddleware,
    studentController.checkEnrollment
);

studentRouter.get("/classes/sections",
    authMiddleware,
    requireActiveSubscription,
    studentController.getAllSectionsForStudent
);

export default studentRouter;
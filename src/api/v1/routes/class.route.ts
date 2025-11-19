import { Router } from "express";
import { getClasses, getClassById, createClass, updateClass, deleteClass } from "../controllers/class.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createClassSchema, updateClassSchema } from "../schemas/class.schema";
import upload from "../../../config/multer.config";
import { verifyRole } from "../middlewares/verifyrole.middleware";

const classRouter = Router();

classRouter.get("/", getClasses);
classRouter.get("/:id", getClassById, verifyRole(["Admin", "Teacher"]));
classRouter.post("/", verifyRole(["Admin", "Teacher"]), upload.single("file"), validateBody(createClassSchema), createClass);
classRouter.patch("/:id", verifyRole(["Admin", "Teacher"]), upload.single("file"), validateBody(updateClassSchema), updateClass);
classRouter.delete("/:id", verifyRole(["Admin", "Teacher"]), deleteClass);

export default classRouter;
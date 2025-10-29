import { Router } from "express";
import { getClasses, getClassById, createClass, updateClass, deleteClass } from "../controllers/class.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createClassSchema, updateClassSchema } from "../schemas/class.schema";
import upload from "../../../config/multer.config";

const classRouter = Router();

classRouter.get("/", getClasses);
classRouter.get("/:id", getClassById);
classRouter.post("/", upload.single("file"), validateBody(createClassSchema), createClass);
classRouter.patch("/:id", upload.single("file"), validateBody(updateClassSchema), updateClass);
classRouter.delete("/:id", deleteClass);

export default classRouter;
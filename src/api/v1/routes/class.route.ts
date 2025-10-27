import { Router } from "express";
import { getClasses, getClassById, createClass, updateClass, deleteClass } from "../controllers/class.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createClassSchema, updateClassSchema } from "../schemas/class.schema";

const classRouter = Router();

classRouter.get("/", getClasses);
classRouter.get("/:id", getClassById);
classRouter.post("/", validateBody(createClassSchema), createClass);
classRouter.patch("/:id", validateBody(updateClassSchema), updateClass);
classRouter.delete("/:id", deleteClass);

export default classRouter;
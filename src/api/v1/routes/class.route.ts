import { Router } from "express";
import { getClasses, getClassById, createClass, updateClass, deleteClass } from "../controllers/class.controller";

const classRouter = Router();

classRouter.get("/", getClasses);
classRouter.get("/:id", getClassById);
classRouter.post("/", createClass);
classRouter.patch("/:id", updateClass);
classRouter.delete("/:id", deleteClass);

export default classRouter;
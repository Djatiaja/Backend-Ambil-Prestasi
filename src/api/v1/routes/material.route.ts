import { Router } from "express";
import { MaterialController } from "../controllers/material.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createMaterialSchema, updateMaterialSchema } from "../schemas/material.schema";

const materialRouter = Router();
const materialController = new MaterialController();

materialRouter.get("/", (req, res) => materialController.getAllMaterials(req, res));
materialRouter.post("/", validateBody(createMaterialSchema), (req, res) => materialController.createMaterial(req, res));
materialRouter.patch("/:materialId", validateBody(updateMaterialSchema), (req, res) => materialController.updateMaterial(req, res));
materialRouter.delete("/:materialId", (req, res) => materialController.deleteMaterial(req, res));

export default materialRouter;
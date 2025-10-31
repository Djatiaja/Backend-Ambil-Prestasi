// routes/material.router.ts
import { Router } from "express";
import { validateBody } from "../middlewares/schema.middleware";
import { createMaterialSchema, updateMaterialSchema } from "../schemas/material.schema";
import { MaterialController } from "../controllers/material.controller";
import upload from "../../../config/multer.config";

const materialRouter = Router({ mergeParams: true });
const controller = new MaterialController();

// Limit 1 file per field → cegah client upload banyak file
const uploadMaterial = upload.fields([
    { name: "video", maxCount: 1 },
    { name: "materialFile", maxCount: 1 },
    { name: "ringkasan", maxCount: 1 },
    { name: "template", maxCount: 1 },
]);

materialRouter.get("/", controller.getAllMaterials.bind(controller));

materialRouter.post(
    "/",
    uploadMaterial,
    validateBody(createMaterialSchema),
    controller.createMaterial.bind(controller)
);

materialRouter.patch(
    "/:materialId",
    uploadMaterial,
    validateBody(updateMaterialSchema),
    controller.updateMaterial.bind(controller)
);

materialRouter.delete("/:materialId", controller.deleteMaterial.bind(controller));

export default materialRouter;
import { Router } from "express";
import materialFileController from "../controllers/materialFile.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createMaterialFileSchema, updateMaterialFileSchema } from "../schemas/materialFile.schema";
import { upload } from "../../../config/multer.config";

const materialFileRouter = Router({ mergeParams: true });

materialFileRouter.get("/", materialFileController.getAllMaterialFiles);
materialFileRouter.post("/", upload.single("file"), validateBody(createMaterialFileSchema), materialFileController.createMaterialFile);
materialFileRouter.patch("/:fileID", upload.single("file"), validateBody(updateMaterialFileSchema), materialFileController.updateMaterialFile);

materialFileRouter.delete("/:fileID", materialFileController.deleteMaterialFile);

export default materialFileRouter;
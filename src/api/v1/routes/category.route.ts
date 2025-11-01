import { Router } from "express";
import categoryController from "../controllers/category.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createCategorySchema, updateCategorySchema } from "../schemas/category.schema";
import { verifyRole } from "../middlewares/verifyrole.middleware";

const categoryRouter = Router();

categoryRouter.get("/", categoryController.getAllCategories);
categoryRouter.get("/:id", verifyRole(["Admin"]), categoryController.getCategoryById);
categoryRouter.post("/", verifyRole(["Admin"]), validateBody(createCategorySchema), categoryController.createCategory);
categoryRouter.patch("/:id", verifyRole(["Admin"]), validateBody(updateCategorySchema), categoryController.updateCategory);
categoryRouter.delete("/:id", verifyRole(["Admin"]), categoryController.deleteCategory);

export default categoryRouter;

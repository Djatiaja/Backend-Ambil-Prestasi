import { Router } from "express";
import categoryController from "../controllers/category.controller";
import { validateBody } from "../middlewares/schema.middleware";
import { createCategorySchema, updateCategorySchema } from "../schemas/category.schema";

const categoryRouter = Router();

categoryRouter.get("/", categoryController.getAllCategories);
categoryRouter.get("/:id", categoryController.getCategoryById);
categoryRouter.post("/", validateBody(createCategorySchema), categoryController.createCategory);
categoryRouter.patch("/:id", validateBody(updateCategorySchema), categoryController.updateCategory);
categoryRouter.delete("/:id", categoryController.deleteCategory);

export default categoryRouter;

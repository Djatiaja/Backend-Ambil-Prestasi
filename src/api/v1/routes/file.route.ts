import { Router } from "express";
import fileController from "../controllers/file.controller";


const fileRouter = Router();

fileRouter.get("/public/:filename", fileController.AccessPublicFile);
fileRouter.get("/private/:token", fileController.AccessProtectedFile);


export default fileRouter;
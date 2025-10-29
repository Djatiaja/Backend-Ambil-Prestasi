import { Router } from "express";
import publicController from "../controllers/public.controller";


const publicRouter = Router();
publicRouter.get("/classes", publicController.getClasses);
publicRouter.get("/banners", (req, res) => {
    res.send("Public Banners Endpoint");
});

export default publicRouter;
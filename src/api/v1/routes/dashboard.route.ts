import { Request, Response, Router } from "express";
import { getHomeData } from "../controllers/dashboard.controller";

const dashboardRouter = Router();

dashboardRouter.get("/", (req: Request, res: Response) => getHomeData(req, res));

export default dashboardRouter;
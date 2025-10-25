import { Request, Response, Router } from "express";
import { getHomeData } from "../controllers/dashboard.controller";
import { authMiddleware } from "../middlewares/auth.middleware";
import { verifyRole } from "../middlewares/verifyrole.middleware";

const dashboardRouter = Router();

dashboardRouter.get("/", (req: Request, res: Response) => getHomeData(req, res));

export default dashboardRouter;
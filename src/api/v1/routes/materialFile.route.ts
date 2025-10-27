import { Router } from "express";


const materialFileRouter = Router();

materialFileRouter.get("/", (req, res) => { });
materialFileRouter.post("/", (req, res) => { });
materialFileRouter.put("/:fileID", (req, res) => { });
materialFileRouter.delete("/:fileID", (req, res) => { });

export default materialFileRouter;
import express from "express";
import router from "./api/v1/routes/index.route";
import cors from "cors";
import fileRouter from "./api/v1/routes/file.route";

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true, limit: "500mb" }));

const allowedOrigins = [
    "http://localhost:3000",
];

app.use(
    cors({
        origin: (origin, callback) => {
            if (!origin || allowedOrigins.includes(origin)) {
                callback(null, true);
            } else {
                callback(new Error("Not allowed by CORS ❌"));
            }
        },
        credentials: true,
    })
);
app.use("/files", fileRouter);
app.use("/api/v1", router);


export default app;

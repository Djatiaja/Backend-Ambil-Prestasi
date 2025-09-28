import express from "express";
import router from "./api/v1/routes/index.route";
import cors from "cors";

const app = express();

app.use(express.json());
const allowedOrigins = [
    "http://localhost:3000",     // Dev
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

app.use(express.urlencoded({ extended: true }));
app.use("/api/v1", router);

export default app;

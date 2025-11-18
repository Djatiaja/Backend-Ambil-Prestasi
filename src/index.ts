import express from "express";
import router from "./api/v1/routes/index.route";
import cors from "cors";
import fileRouter from "./api/v1/routes/file.route";

const app = express();

// If running behind a proxy (like Vercel), trust proxy for correct req.origin handling
app.set("trust proxy", true);

app.use(express.json());
app.use(express.urlencoded({ extended: true, limit: "500mb" }));

const allowedOrigins = [
    "http://localhost:3000",
    "https://ambilprestasi.my.id",
];

// global CORS middleware with options success status for legacy browsers
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
        optionsSuccessStatus: 200,
    })
);

// Ensure CORS headers are set even for error responses and handle preflight
app.use((req, res, next) => {
    const origin = req.headers.origin as string | undefined;
    if (!origin || allowedOrigins.includes(origin)) {
        res.setHeader("Access-Control-Allow-Origin", origin || "");
        res.setHeader("Access-Control-Allow-Credentials", "true");
        res.setHeader(
            "Access-Control-Allow-Headers",
            "Origin, X-Requested-With, Content-Type, Accept, Authorization"
        );
        res.setHeader(
            "Access-Control-Allow-Methods",
            "GET,POST,PUT,PATCH,DELETE,OPTIONS"
        );
    }
    if (req.method === "OPTIONS") {
        return res.sendStatus(200);
    }
    next();
});

app.use("/files", fileRouter);
app.use("/api/v1", router);

export default app;

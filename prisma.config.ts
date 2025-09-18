
import { defineConfig } from "prisma/config";
import path from "node:path";
import "dotenv/config";
export default defineConfig({
    schema: path.join("src", "database", "schema.prisma"),
    migrations: {
        path: "src/database/migrations",
        seed: "ts-node src/database/seed.ts"
    },
});

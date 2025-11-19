import "dotenv/config"; // ⬅️ ini akan load .env
import { rolesSeed } from "./seeders/roles.seed";
import { usersSeed } from "./seeders/users.seed";
import { classesSeed } from "./seeders/classes.seed";
import { user_classesSeed } from "./seeders/user_classes.seed";
import prisma from "../database";
import { categorySeed } from "./seeders/category.seed";
async function main() {
    console.log("🌱 Seeding database...");

    await rolesSeed();
    await usersSeed();
    await categorySeed();
    await classesSeed();
    await user_classesSeed();

    console.log("✅ Seeding finished.");
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });

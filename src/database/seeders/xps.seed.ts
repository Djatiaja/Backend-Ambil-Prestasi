import { xp_source } from "@prisma/client";
import prisma from "..";


export const xpsSeed = async () => {
    console.log("\n🌱 Seeding xps...");

    // TODO : Seed XPs based on actual user activities
    for (let index = 0; index < 100; index++) {
        await prisma.xp.create({
            data: {
                source: xp_source.Quiz,
                sourceId: `quiz_${index + 1}`,
                points: Math.floor(Math.random() * 100),
                userId: `user_${index + 1}`
            }
        });
    }

    console.log("✅ Xps seeded.");
}
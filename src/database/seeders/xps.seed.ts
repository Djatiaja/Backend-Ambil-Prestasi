// import { xp_source } from "@prisma/client";
// import prisma from "..";


export const xpsSeed = async (): Promise<void> => {
    console.log("\n🌱 Seeding xps...");

    // for (let index = 0; index < 100; index++) {
    //     await prisma.xp.create({
    //         data: {
    //             source: xp_source.Quiz,
    //             sourceId: `quiz_${index + 1}`,
    //             points: Math.floor(Math.random() * 100),
    //             userId: `user_${index + 1}`
    //         }
    //     });
    // }

    console.log("✅ Xps seeded.");
}
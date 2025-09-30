import { randWord } from "@ngneat/falso";
import prisma from "..";

export const classesSeed = async () => {

    console.log("\n🌱 Seeding classes...");

    for (let i = 0; i < 10; i++) {
        await prisma.class.create({
            data: {
                name: randWord(),
                description: randWord({ length: 30 }).join(" ")
            }
        });
    }

    console.log("✅ Classes seeded.");
};

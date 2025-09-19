import { randWord } from "@ngneat/falso";
import prisma from "..";

export const sectionsSeeder = async () => {
    console.log("\n🌱 Seeding sections...");

    const classes = await prisma.class.findMany();

    if (classes.length === 0) {
        throw new Error("Classes must be seeded before seeding sections.");
    }

    for (const cls of classes) {
        const randCount = Math.floor(Math.random() * 6) + 1;
        for (let i = 1; i <= randCount; i++) {
            await prisma.section.create({
                data: {
                    title: randWord({ length: 5 }).join(' '),
                    description: randWord({ length: 15 }).join(' '),
                    classId: cls.id,
                    order: i
                }
            });
        }
    }

    console.log("✅ Sections seeded.");

};
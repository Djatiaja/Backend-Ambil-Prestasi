import { randomInt } from "crypto";
import prisma from "..";

export const assigmentsSeed = async () => {
    console.log("\n🌱 Seeding assignments...");
    const sections = await prisma.section.findMany();

    if (sections.length === 0) {
        throw new Error("Sections must be seeded before seeding assignments.");
    }

    for (const section of sections) {
        const assigmentCount = randomInt(0, 2);
        for (let i = 0; i < assigmentCount; i++) {
            await prisma.assignment.create({
                data: {
                    title: `Assignment ${i + 1} for Section ${section.id}`,
                    description: `Description for Assignment ${i + 1}`,
                    open_at: new Date(),
                    close_at: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 1 week later
                    xp: 100,
                    sectionId: section.id
                }
            });
        }
    }
    console.log("✅ Assignments seeded.");
};
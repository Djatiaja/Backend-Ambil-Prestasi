import { randWord } from "@ngneat/falso";
import prisma from "..";


export const materialsSeed = async () => {
    console.log("\n🌱 Seeding materials...");
    const sections = await prisma.section.findMany();

    if (sections.length === 0) {
        throw new Error("Sections must be seeded before seeding materials.");
    }

    for (const section of sections) {
        const randCount = Math.floor(Math.random() * 6) + 1;
        for (let i = 1; i <= randCount; i++) {
            await prisma.material.create({
                data: {
                    title: randWord({ length: 5 }).join(' '),
                    content: randWord({ length: 15 }).join(' '),
                    xp: Math.floor(Math.random() * 100) + 1,
                    sectionId: section.id,
                    thumnail_path: '',
                    video_path: '',
                    materialFilePath: '',
                    ringkasanPath: '',
                    templatePath: ''
                }
            });
        }
    }

    console.log("✅ Materials seeded.");
};
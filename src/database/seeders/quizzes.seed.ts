import prisma from "..";

export const quizzesSeed = async () => {
    console.log("\n🌱 Seeding quizzes...");
    const sections = await prisma.section.findMany();
    if (sections.length === 0) {
        throw new Error("Sections must be seeded before seeding quizzes.");
    }



    for (const section of sections) {
        const flag = Math.random() < 0.2;
        if (!flag) {
            continue;
        }
        const now = new Date();
        const openAt = new Date(now.getTime() + Math.floor(Math.random() * 3) * 24 * 60 * 60 * 1000); // open 0-2 days from now
        const closeAt = new Date(openAt.getTime() + (Math.floor(Math.random() * 5) + 1) * 24 * 60 * 60 * 1000); // close 1-5 days after open

        await prisma.quiz.create({
            data: {
                title: `Quiz for ${section.title}`,
                description: `This is a quiz for the section ${section.title}.`,
                xp: Math.floor(Math.random() * 51) + 50, // XP between 50 and 100
                max_attempts: Math.floor(Math.random() * 3) + 1, // 1-3 attempts
                time_limit: (Math.floor(Math.random() * 4) + 1) * 15, // 15, 30, 45, 60 minutes
                open_at: openAt,
                close_at: closeAt,
                sectionId: section.id,
                passing_grade: Math.floor(Math.random() * 31) + 50 // 50-80
            }
        });
    }
    console.log("✅ Quizzes seeded.");
};
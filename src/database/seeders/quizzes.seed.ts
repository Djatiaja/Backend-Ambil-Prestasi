import prisma from "..";

export const quizzesSeed = async () => {
    console.log("\n🌱 Seeding quizzes...");
    const materials = await prisma.material.findMany();
    if (materials.length === 0) {
        throw new Error("Materials must be seeded before seeding quizzes.");
    }

    for (const material of materials) {
        const flag = Math.random() < 0.3;
        if (!flag) {
            continue;
        }

        await prisma.quiz.create({
            data: {
                title: `Quiz for ${material.title}`,
                description: `This is a quiz for the material ${material.title}.`,
                xp: Math.floor(Math.random() * 51) + 50, // XP between 50 and 100
                max_attempts: Math.floor(Math.random() * 3) + 1, // 1-3 attempts
                time_limit: (Math.floor(Math.random() * 4) + 1) * 15, // 15, 30, 45, 60 minutes
                materialId: material.id,
                passing_grade: Math.floor(Math.random() * 31) + 50 // 50-80
            }
        });
    }
    console.log("✅ Quizzes seeded.");
};
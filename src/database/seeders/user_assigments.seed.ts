import prisma from "..";

export const user_assigmentsSeed = async () => {
    console.log("\n🌱 Seeding user assignments...");
    const users = await prisma.user.findMany();
    const assignments = await prisma.assignment.findMany();

    if (users.length === 0) {
        throw new Error("Users must be seeded before seeding user assignments.");
    }

    if (assignments.length === 0) {
        throw new Error("Assignments must be seeded before seeding user assignments.");
    }

    for (const user of users) {
        for (const assignment of assignments) {
            const flag = Math.random() < 0.5; // 50% chance to submit
            if (!flag) {
                continue;
            }

            await prisma.user_Assignment.create({
                data: {
                    userId: user.id,
                    assignmentId: assignment.id,
                    submitted_at: new Date(),
                    is_graded: true,
                    path: `https://example.com/submissions/user_${user.id}_assignment_${assignment.id}.pdf`,
                    grade: Math.floor(Math.random() * 101) // Grade between 0 and 100
                }
            });
        }
    }
    console.log("✅ User assignments seeded.");
};
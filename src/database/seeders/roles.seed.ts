import prisma from "..";

export const rolesSeed = async () => {
    console.log("\n🌱 Seeding roles...");

    await prisma.role.createMany(
        {
            data: [
                {
                    name: "Admin"
                },
                {
                    name: "Teacher"
                },
                {
                    name: "Student"
                }
            ]
        }
    );

    console.log("✅ Roles seeded.");
};

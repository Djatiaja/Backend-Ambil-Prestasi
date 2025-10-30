import prisma from ".."



export const categorySeed = async () => {
    console.log("\n🌱 Seeding category...");

    await prisma.category.createMany({
        data: [
            {
                name: "Essay"
            },
            {
                name: "Business Plan"
            },
            {
                name: "Penelitian"
            },
            {
                name: "Desain"
            }
        ]
    })

    console.log("✅ Category seeded.");

}
import prisma from "..";


export const material_filesSeed = async () => {
    console.log("\n🌱 Seeding material files...");

    const materials = await prisma.material.findMany();

    if (materials.length === 0) {
        throw new Error("Materials must be seeded before seeding material files.");
    }

    for (const material of materials) {
        const randCount = Math.floor(Math.random() * 4) + 1;
        for (let i = 1; i <= randCount; i++) {
            await prisma.material_File.create({
                data: {
                    path: `https://example.com/files/file_${i}.pdf`,
                    materialId: material.id
                }
            });
        }
    }
    console.log("✅ Material files seeded.");
}
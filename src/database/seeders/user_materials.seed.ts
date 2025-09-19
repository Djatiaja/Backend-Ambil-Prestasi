import { xp_source } from "@prisma/client";
import prisma from "..";

export const user_materialsSeed = async () => {
    console.log("\n🌱 Seeding user materials...");
    const users = await prisma.user.findMany();
    const materials = await prisma.material.findMany();

    if (users.length === 0) {
        throw new Error("Users must be seeded before seeding user materials.");
    }

    if (materials.length === 0) {
        throw new Error("Materials must be seeded before seeding user materials.");
    }

    for (const user of users) {
        for (const material of materials) {
            const flag = Math.random() < 0.3; // 30% chance to mark as completed
            if (flag) {
                await prisma.user_Material.create({
                    data: {
                        userId: user.id,
                        materialId: material.id,
                        is_completed: true
                    }
                });
                await prisma.xp.create({
                    data: {
                        source: xp_source.Material,
                        sourceId: (material.id).toString(),
                        userId: user.id,
                        points: material.xp,
                    }
                });
                continue;
            }
            await prisma.user_Material.create({
                data: {
                    userId: user.id,
                    materialId: material.id,
                    is_completed: false
                }
            });
        }
    }
    console.log("✅ User materials seeded.");
};
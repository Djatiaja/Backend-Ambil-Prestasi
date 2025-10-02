import { hash } from "crypto";
import prisma from "..";
import { randPastDate, randUserName } from "@ngneat/falso";

const hashedPassword = hash("sha256", "password123");

export const usersSeed = async () => {
    console.log("\n🌱 Seeding users...");

    const adminRole = await prisma.role.findUnique({ where: { name: "Admin" } });
    const teacherRole = await prisma.role.findUnique({ where: { name: "Teacher" } });
    const studentRole = await prisma.role.findUnique({ where: { name: "Student" } });

    if (!adminRole || !teacherRole || !studentRole) {
        throw new Error("Roles must be seeded before seeding users.");
    }

    await prisma.user.create({
        data: {
            username: "admin",
            email: "djamgt23@gmail.com",
            name: "Admin User",
            roleId: adminRole.id,
            profileImage: "https://ui-avatars.com/api/?name=Admin+User&background=random",
            password: hashedPassword,
            createdAt: randPastDate({ years: 1 }),
        }
    });

    for (let index = 0; index < 200; index++) {
        await prisma.user.create({
            data: {
                username: `teacher${index + 1}`,
                email: `teacher${index + 1}@example.com`,
                name: randUserName(),
                roleId: teacherRole.id,
                profileImage: `https://ui-avatars.com/api/?name=Teacher+${index + 1}&background=random`,
                password: hashedPassword,
                createdAt: randPastDate({ years: 5 }),
            }
        });
    }
    for (let index = 0; index < 1000; index++) {
        await prisma.user.create({
            data: {
                username: `student${index + 1}`,
                email: `student${index + 1}@example.com`,
                name: randUserName(),
                roleId: studentRole.id,
                profileImage: `https://ui-avatars.com/api/?name=Student+${index + 1}&background=random`,
                password: hashedPassword,
                createdAt: randPastDate({ years: 5 }),
            }
        });
    }

    // TODO: remove this after implementing auth
    await prisma.user.create({
        data: {
            username: `teachertestacc`,
            email: `teachertestaccexample.com`,
            name: 'teachertestacc',
            roleId: teacherRole.id,
            profileImage: `https://ui-avatars.com/api/?name=teachertestacc&background=random`,
            password: hashedPassword,
            createdAt: randPastDate({ years: 5 }),
        }
    })

    console.log("✅ Users seeded.");
};

import prisma from "..";
import { randPastDate, randUserName } from "@ngneat/falso";
import bcrypt from 'bcrypt';

export const usersSeed = async () => {

    console.log("\n🌱 Seeding users...");
    const hashedPassword = await bcrypt.hash('password123', 10);

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
            verified_at: new Date(),
            password: hashedPassword,
            createdAt: randPastDate({ years: 1 }),
        }
    });

    for (let index = 0; index < 4; index++) {
        await prisma.user.create({
            data: {
                username: `teacher${index + 1}`,
                email: `teacher${index + 1}@example.com`,
                name: randUserName(),
                roleId: teacherRole.id,
                profileImage: `https://ui-avatars.com/api/?name=Teacher+${index + 1}&background=random`,
                telp: '08123456789',
                specialization: 'Mathematics',
                bio: 'Experienced math teacher with a passion for helping students succeed.',
                verified_at: new Date(),
                password: hashedPassword,
                createdAt: randPastDate({ years: 5 }),
            }
        });
    }

    for (let index = 0; index < 50; index++) {
        await prisma.user.create({
            data: {
                username: `student${index + 1}`,
                email: `student${index + 1}@example.com`,
                name: randUserName(),
                roleId: studentRole.id,
                profileImage: `https://ui-avatars.com/api/?name=Student+${index + 1}&background=random`,
                verified_at: new Date(),
                password: hashedPassword,
                createdAt: randPastDate({ years: 5 }),
            }
        });
    }

    await prisma.user.create({
        data: {
            username: `teachertestacc`,
            email: `teachertestaccexample.com`,
            name: 'teachertestacc',
            roleId: teacherRole.id,
            profileImage: `https://ui-avatars.com/api/?name=teachertestacc&background=random`,
            verified_at: new Date(),
            password: hashedPassword,
            createdAt: randPastDate({ years: 5 }),
        }
    })

    console.log("✅ Users seeded.");
};

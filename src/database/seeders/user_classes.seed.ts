import { class_role } from "@prisma/client";
import prisma from "..";
import { matkuls } from "./classes.seed";
import { randWord } from "@ngneat/falso"; // ✅ use randWords instead of randWord

export const user_classesSeed = async () => {
    console.log("\n🌱 Seeding user_classes...");

    const students = await prisma.user.findMany({
        where: { role: { name: "Student" } },
    });
    const teachers = await prisma.user.findMany({
        where: { role: { name: "Teacher" } },
    });

    const classes = await prisma.class.findMany();

    if (students.length === 0 || classes.length === 0) {
        throw new Error("Students and Classes must be seeded before seeding user_classes.");
    }

    // Attach teachers + students to already existing classes
    for (const cls of classes) {
        const shuffledStudents = [...students].sort(() => 0.5 - Math.random());
        const selectedStudents = shuffledStudents.slice(0, 10);

        const selectedTeacher = teachers[Math.floor(Math.random() * teachers.length)];

        await prisma.user_Class.create({
            data: {
                userId: selectedTeacher.id,
                classId: cls.id,
                role: class_role.Teacher,
            },
        });

        for (const stu of selectedStudents) {
            await prisma.user_Class.create({
                data: {
                    userId: stu.id,
                    classId: cls.id,
                    role: class_role.Student,
                },
            });
        }
    }

    // ✅ Create new classes from matkuls
    const matakuliahs = [];
    for (const matkul of matkuls) {
        const newClass = await prisma.class.create({
            data: {
                name: matkul,
                description: randWord({ length: 30 }).join(" "),
                image_path: "",
            },
        });
        matakuliahs.push(newClass);
    }

    const testTeacher = await prisma.user.findFirst({
        where: { username: "teachertestacc" },
    });

    if (testTeacher) {
        for (const matkul of matakuliahs) {
            const shuffledStudents = [...students].sort(() => 0.5 - Math.random());
            const selectedStudents = shuffledStudents.slice(0, 10);

            await prisma.user_Class.create({
                data: {
                    userId: testTeacher.id,
                    classId: matkul.id,
                    role: class_role.Teacher,
                },
            });

            for (const stu of selectedStudents) {
                await prisma.user_Class.create({
                    data: {
                        userId: stu.id,
                        classId: matkul.id,
                        role: class_role.Student,
                    },
                });
            }
        }
    }

    console.log("✅ user_classes seeded.");
};

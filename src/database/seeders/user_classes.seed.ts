import { class_role } from "@prisma/client";
import prisma from "..";


export const user_classesSeed = async () => {
    console.log("\n🌱 Seeding user_classes...");

    const student = await prisma.user.findMany({ where: { role: { name: "Student" } } });
    const classes = await prisma.class.findMany();

    if (student.length === 0 || classes.length === 0) {
        throw new Error("Students and Classes must be seeded before seeding user_classes.");
    }

    for (const cls of classes) {
        // Assign 10 random students to each class
        const shuffledStudents = student.sort(() => 0.5 - Math.random());
        const selectedStudents = shuffledStudents.slice(0, 10);

        for (const stu of selectedStudents) {
            await prisma.user_Class.create({
                data: {
                    userId: stu.id,
                    classId: cls.id,
                    role: class_role.Student
                }
            });
        }
    }

    console.log("✅ user_classes seeded.");
};
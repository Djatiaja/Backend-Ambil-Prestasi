import prisma from "../../src/database";
export async function resetDatabase() {
    await prisma.$transaction([
        prisma.attemp_Multiple_Answer.deleteMany(),
        prisma.attemp_Answer.deleteMany(),
        prisma.quiz_Answer.deleteMany(),
        prisma.quiz_Question.deleteMany(),
        prisma.quiz_Attempt.deleteMany(),
        prisma.quiz.deleteMany(),
        prisma.user_Assignment.deleteMany(),
        prisma.assignment.deleteMany(),
        prisma.user_Material.deleteMany(),
        prisma.material_File.deleteMany(),
        prisma.material.deleteMany(),
        prisma.section.deleteMany(),
        prisma.user_Class.deleteMany(),
        prisma.class.deleteMany(),
        prisma.xp.deleteMany(),
        prisma.user.deleteMany(),
        prisma.role.deleteMany(),
    ]);
}

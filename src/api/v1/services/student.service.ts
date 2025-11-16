import { NotFoundError } from "../errors/notfound.error";
import classRepository from "../repositories/class.repository";
import userClassRepository from "../repositories/userClass.repository";

class StudentService {
    async enrollClass(userId: string, classId: number) {
        // Verify class exists
        const classData = await classRepository.findClassById(classId);
        if (!classData) {
            throw new NotFoundError("Class not found");
        }

        // Enroll student
        return await userClassRepository.enrollStudent(userId, classId);
    }

    async unenrollClass(userId: string, classId: number) {
        // Verify enrollment exists
        const enrollment = await userClassRepository.checkEnrollment(userId, classId);
        if (!enrollment) {
            throw new NotFoundError("You are not enrolled in this class");
        }

        // Unenroll student
        return await userClassRepository.unenrollStudent(userId, classId);
    }

    async getEnrolledClasses(userId: string) {
        const enrollments = await userClassRepository.getEnrolledClasses(userId);

        // Format image paths
        const appUrl = (process.env.APP_URL || "http://localhost").replace(/\/$/, "");
        return enrollments.map((enrollment) => ({
            ...enrollment,
            class: {
                ...enrollment.class,
                image_path_relative: `${appUrl}/${enrollment.class.image_path}`.replace(/\/$/, ""),
            },
        }));
    }

    async checkEnrollment(userId: string, classId: number) {
        return await userClassRepository.checkEnrollment(userId, classId);
    }
}

export default new StudentService();
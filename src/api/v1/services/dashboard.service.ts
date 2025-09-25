import classService from "./class.service"
import userService from "./user.service"

class DashboardService {

    async getDashboardData() {
        const teacherCount = await userService.getUserCount({ roleName: "Teacher" })
        const studentCount = await userService.getUserCount({ roleName: "Student" })
        const classCount = await classService.getClassCount()

        const { oneYear: studentOneYear, fiveYear: studentFiveYear } = await userService.getUserChart({ roleName: "Student" })
        const { oneYear: teacherOneYear, fiveYear: teacherFiveYear } = await userService.getUserChart({ roleName: "Teacher" })


        const data = {
            teacherCount: teacherCount,
            studentCount: studentCount,
            classCount: classCount,
            Chart: {
                teacher: {
                    oneYear: teacherOneYear,
                    fiveYear: teacherFiveYear
                },
                student: {
                    oneYear: studentOneYear,
                    fiveYear: studentFiveYear
                }
            }
        }
        return data

    }

}

export default new DashboardService()
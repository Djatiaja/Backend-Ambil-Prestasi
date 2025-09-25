import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import userService from "../services/user.service";


export const getHomeData = async (req: Request, res: Response) => {
    try {
        const teacherCount = userService.getUserCount({ roleName: "Teacher" })
        const studentCount = userService.getUserCount({ roleName: "Student" })



    } catch (error) {

    }
}
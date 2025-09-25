import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import dashboardService from "../services/dashboard.service";


export const getHomeData = async (req: Request, res: Response) => {
    try {
        const data = await dashboardService.getDashboardData();
        sendResponse({ res: res, statusCode: 200, success: true, message: "dashboard fetched successfully", data: data });
    } catch (error) {
        sendResponse({ res: res, statusCode: 500, success: false, message: "Error fetching dashboard", data: null });
    }
}
import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import profileService from "../services/profile.service";

class ProfileController {
    async getProfile(req: Request, res: Response) {
        try {
            const userId = req.user!.id!;
            const profile = await profileService.getProfile(userId);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Profile retrieved successfully",
                data: profile,
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to retrieve profile";
            return sendResponse({
                res,
                statusCode: 500,
                success: false,
                message,
                data: null,
            });
        }
    }
}

export default new ProfileController();

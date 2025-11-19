import { Request, Response } from "express";
import { sendResponse } from "../helpers/baseResponse";
import profileService from "../services/profile.service";
import { deleteFile, saveFile } from "../helpers/file";

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

    async updateProfile(req: Request, res: Response) {
        try {
            const userId = req.user!.id!;
            const updateData = { ...req.body };

            // Handle profile image upload if file exists
            if (req.file) {
                deleteFile(updateData.profileImage); // Delete old profile image
                const uploadPath = saveFile(req.file, false); // Save to public folder
                updateData.profileImage = uploadPath;
            }

            const data = {
                name: updateData.name,
                username: updateData.username,
                telp: updateData.telp,
                bio: updateData.bio,
                specialization: updateData.specialization,
                profileImage: updateData.profileImage,
            }

            const profile = await profileService.updateProfile(userId, data);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: "Profile updated successfully",
                data: profile,
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to update profile";
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message,
                data: null,
            });
        }
    }

    async deleteProfile(req: Request, res: Response) {
        try {
            const userId = req.user!.id!;
            const result = await profileService.deleteProfile(userId);

            return sendResponse({
                res,
                statusCode: 200,
                success: true,
                message: result.message,
                data: null,
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : "Failed to delete profile";
            return sendResponse({
                res,
                statusCode: 400,
                success: false,
                message,
                data: null,
            });
        }
    }
}

export default new ProfileController();

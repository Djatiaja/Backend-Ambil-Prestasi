import { NotFoundError } from "../errors/notfound.error";
import profileRepository from "../repositories/profile.repository";

class ProfileService {
    async getProfile(userId: string) {
        const user = await profileRepository.getUserProfile(userId);
        if (!user) {
            throw new NotFoundError("User not found");
        }

        // Base profile data
        const profile: Record<string, unknown> = {
            id: user.id,
            email: user.email,
            username: user.username,
            name: user.name,
            profileImage: user.profileImage,
            telp: user.telp,
            bio: user.bio,
            verified_at: user.verified_at,
            role: user.role.name,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
        };

        // Add subscription info for Students
        if (user.role.name === "Student") {
            const subscription = await profileRepository.getActiveSubscription(userId);

            if (subscription) {
                profile.subscriptionExpiredAt = subscription.endAt;
            } else {
                profile.subscriptionExpiredAt = null;
            }
        }

        return profile;
    }
}

export default new ProfileService();

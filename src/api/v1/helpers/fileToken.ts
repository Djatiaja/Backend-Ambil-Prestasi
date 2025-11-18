import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET ?? "";

interface FileTokenPayload {
    path: string;
    expiredAt: number; // Unix timestamp
}

/**
 * Generate a JWT token for accessing protected files
 * @param filePath - The relative file path (e.g., "files/protected/video.mp4")
 * @param expirationMinutes - Token expiration time in minutes (default: 60)
 * @returns JWT token string
 */
export const generateFileToken = (filePath: string, expirationMinutes: number = 60): string => {
    const expiredAt = Math.floor(Date.now() / 1000) + (expirationMinutes * 60);

    const payload: FileTokenPayload = {
        path: filePath,
        expiredAt
    };

    return jwt.sign(payload, JWT_SECRET, { expiresIn: `${expirationMinutes}m` });
};

/**
 * Verify and decode a file access token
 * @param token - JWT token string
 * @returns Decoded payload with file path and expiration
 * @throws Error if token is invalid or expired
 */
export const verifyFileToken = (token: string): FileTokenPayload => {
    try {
        const decoded = jwt.verify(token, JWT_SECRET) as FileTokenPayload;

        // Check if token is expired (double-check even though jwt.verify handles this)
        const now = Math.floor(Date.now() / 1000);
        if (decoded.expiredAt < now) {
            throw new Error('Token has expired');
        }

        return decoded;
    } catch (error) {
        if (error instanceof jwt.JsonWebTokenError) {
            throw new Error('Invalid token');
        }
        if (error instanceof jwt.TokenExpiredError) {
            throw new Error('Token has expired');
        }
        throw error;
    }
};

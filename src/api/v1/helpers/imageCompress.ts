import sharp, { Sharp } from "sharp";

export enum imageType {
    THUMBNAIL = "thumbnail",
    BANNER = "banner",
    ORIGINAL = "original",
}

/**
 * Optimize and compress an image based on its intended type.
 *
 * - `thumbnail`: smaller, lighter image for previews
 * - `banner`: large image with balanced quality
 * - `original`: same size, lightly compressed
 */
export async function optimizeImage(
    fileBuffer: Buffer,
    mimetype: string,
    type: imageType = imageType.ORIGINAL
): Promise<Buffer> {
    try {
        // Base sharp pipeline (no resize by default)
        let pipeline: Sharp = sharp(fileBuffer);

        // Define optimization presets
        const presets: Record<imageType, { width?: number; quality: number }> = {
            thumbnail: { width: 400, quality: 70 },
            banner: { width: 1920, quality: 85 },
            original: { quality: 80 },
        };

        const { width, quality } = presets[type];

        // Apply resizing only when a width is defined
        if (width) {
            pipeline = pipeline.resize({
                width,
                withoutEnlargement: true,
            });
        }

        // Apply compression based on file type
        switch (mimetype) {
            case "image/png":
                pipeline = pipeline.png({ compressionLevel: 9, adaptiveFiltering: true });
                break;

            case "image/jpeg":
                pipeline = pipeline.jpeg({ quality, mozjpeg: true });
                break;

            case "image/webp":
                pipeline = pipeline.webp({ quality });
                break;

            default:
                console.warn(`⚠️ Unsupported image type: ${mimetype}, returning original.`);
                return fileBuffer;
        }

        const compressedBuffer = await pipeline.toBuffer();

        console.log(
            `🗜️ Optimized (${type}) → ${(fileBuffer.length / 1024 / 1024).toFixed(2)} MB → ${(compressedBuffer.length / 1024 / 1024).toFixed(2)} MB`
        );

        return compressedBuffer;
    } catch (error) {
        console.error("❌ Image optimization failed:", error);
        // Fallback: return the original buffer if anything goes wrong
        return fileBuffer;
    }
}

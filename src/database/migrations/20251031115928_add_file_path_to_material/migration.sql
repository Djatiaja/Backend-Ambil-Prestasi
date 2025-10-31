/*
  Warnings:

  - Added the required column `materialFilePath` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ringkasanPath` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `templatePath` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `video_path` to the `Material` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Material` ADD COLUMN `materialFilePath` VARCHAR(191) NOT NULL,
    ADD COLUMN `ringkasanPath` VARCHAR(191) NOT NULL,
    ADD COLUMN `templatePath` VARCHAR(191) NOT NULL,
    ADD COLUMN `video_path` VARCHAR(191) NOT NULL;

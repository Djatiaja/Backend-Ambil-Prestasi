/*
  Warnings:

  - You are about to drop the column `materialId` on the `Review` table. All the data in the column will be lost.
  - Made the column `classId` on table `Review` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `Review` DROP FOREIGN KEY `Review_classId_fkey`;

-- DropForeignKey
ALTER TABLE `Review` DROP FOREIGN KEY `Review_materialId_fkey`;

-- DropIndex
DROP INDEX `Review_classId_fkey` ON `Review`;

-- DropIndex
DROP INDEX `Review_materialId_fkey` ON `Review`;

-- AlterTable
ALTER TABLE `Quiz_Attempt` ADD COLUMN `is_graded` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `started_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `submitted_at` DATETIME(3) NULL,
    MODIFY `score` INTEGER NULL;

-- AlterTable
ALTER TABLE `Review` DROP COLUMN `materialId`,
    MODIFY `classId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_classId_fkey` FOREIGN KEY (`classId`) REFERENCES `Class`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

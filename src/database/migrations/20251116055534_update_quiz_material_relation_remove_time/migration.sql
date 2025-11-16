/*
  Warnings:

  - You are about to drop the column `close_at` on the `Quiz` table. All the data in the column will be lost.
  - You are about to drop the column `open_at` on the `Quiz` table. All the data in the column will be lost.
  - You are about to drop the column `sectionId` on the `Quiz` table. All the data in the column will be lost.
  - Added the required column `materialId` to the `Quiz` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Quiz` DROP FOREIGN KEY `Quiz_sectionId_fkey`;

-- DropIndex
DROP INDEX `Quiz_sectionId_fkey` ON `Quiz`;

-- AlterTable
ALTER TABLE `Quiz` DROP COLUMN `close_at`,
    DROP COLUMN `open_at`,
    DROP COLUMN `sectionId`,
    ADD COLUMN `materialId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Quiz` ADD CONSTRAINT `Quiz_materialId_fkey` FOREIGN KEY (`materialId`) REFERENCES `Material`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

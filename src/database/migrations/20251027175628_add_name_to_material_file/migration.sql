/*
  Warnings:

  - Added the required column `title` to the `Material_File` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Material` MODIFY `xp` INTEGER NOT NULL DEFAULT 10;

-- AlterTable
ALTER TABLE `Material_File` ADD COLUMN `title` VARCHAR(191) NOT NULL;

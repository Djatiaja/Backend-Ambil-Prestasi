/*
  Warnings:

  - Added the required column `thumnail_path` to the `Material` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Material` ADD COLUMN `thumnail_path` VARCHAR(191) NOT NULL;

/*
  Warnings:

  - You are about to drop the column `planId` on the `User_Subscription` table. All the data in the column will be lost.
  - You are about to drop the `SubscriptionPlan` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `User_Subscription` DROP FOREIGN KEY `User_Subscription_planId_fkey`;

-- DropIndex
DROP INDEX `User_Subscription_planId_fkey` ON `User_Subscription`;

-- AlterTable
ALTER TABLE `User_Subscription` DROP COLUMN `planId`;

-- DropTable
DROP TABLE `SubscriptionPlan`;

/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sekolah_alam
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Assignment`
--

DROP TABLE IF EXISTS `Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `description` varchar(191) NOT NULL,
  `open_at` datetime(3) NOT NULL,
  `close_at` datetime(3) NOT NULL,
  `xp` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `sectionId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Assignment_sectionId_fkey` (`sectionId`),
  CONSTRAINT `Assignment_sectionId_fkey` FOREIGN KEY (`sectionId`) REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignment`
--

LOCK TABLES `Assignment` WRITE;
/*!40000 ALTER TABLE `Assignment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Assignment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Attemp_Answer`
--

DROP TABLE IF EXISTS `Attemp_Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Attemp_Answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(191) DEFAULT NULL,
  `answer` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `attemptId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Attemp_Answer_attemptId_fkey` (`attemptId`),
  KEY `Attemp_Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Attemp_Answer_attemptId_fkey` FOREIGN KEY (`attemptId`) REFERENCES `Quiz_Attempt` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Attemp_Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Quiz_Question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attemp_Answer`
--

LOCK TABLES `Attemp_Answer` WRITE;
/*!40000 ALTER TABLE `Attemp_Answer` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Attemp_Answer` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Attemp_Multiple_Answer`
--

DROP TABLE IF EXISTS `Attemp_Multiple_Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Attemp_Multiple_Answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `attempt_answerId` int(11) NOT NULL,
  `answerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Attemp_Multiple_Answer_attempt_answerId_fkey` (`attempt_answerId`),
  KEY `Attemp_Multiple_Answer_answerId_fkey` (`answerId`),
  CONSTRAINT `Attemp_Multiple_Answer_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `Quiz_Answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Attemp_Multiple_Answer_attempt_answerId_fkey` FOREIGN KEY (`attempt_answerId`) REFERENCES `Attemp_Answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attemp_Multiple_Answer`
--

LOCK TABLES `Attemp_Multiple_Answer` WRITE;
/*!40000 ALTER TABLE `Attemp_Multiple_Answer` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Attemp_Multiple_Answer` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `image_path` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Class_categoryId_fkey` (`categoryId`),
  CONSTRAINT `Class_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Class` VALUES
(1,1,'repellat','at voluptatem magnam omnis non repellat vel rerum at ipsum occaecati sunt doloribus quae blanditiis ducimus ipsum error unde exercitationem sit nostrum error consequatur quia omnis beatae nulla ipsum neque','files/public/placeholder.png','2025-11-15 12:07:00.666','2025-11-15 12:07:00.666'),
(2,1,'voluptate','nihil at quia possimus voluptatibus commodi voluptate voluptatibus sit omnis at quos dicta nemo tenetur fugiat sit consectetur exercitationem beatae consequatur blanditiis necessitatibus sunt sapiente nulla omnis sapiente enim sequi','files/public/placeholder.png','2025-11-15 12:07:00.668','2025-11-15 12:07:00.668'),
(3,1,'vel','deserunt enim esse nulla ullam voluptate commodi quaerat est ipsum hic doloribus excepturi exercitationem repellat hic occaecati sunt unde asperiores numquam error ullam sequi nulla consequatur occaecati nemo error labore','files/public/placeholder.png','2025-11-15 12:07:00.669','2025-11-15 12:07:00.669'),
(4,1,'asperiores','unde at eos doloribus nostrum et excepturi laborum consequuntur possimus asperiores sequi ipsum nihil beatae tenetur error commodi sequi doloribus possimus fugit sed exercitationem repellat neque ullam fugit nulla at','files/public/placeholder.png','2025-11-15 12:07:00.670','2025-11-15 12:07:00.670'),
(5,1,'repellat','error sapiente possimus ipsum ipsum sequi dolores repellat at consequuntur repellat at rerum voluptatem labore nulla possimus error labore sunt tenetur unde sequi aliquid nostrum repellat nulla fugit sunt voluptatibus','files/public/placeholder.png','2025-11-15 12:07:00.671','2025-11-15 12:07:00.671'),
(6,1,'ducimus','beatae quae vitae exercitationem vitae beatae et consectetur beatae cupiditate id hic et ipsum voluptate numquam doloribus sed aliquid numquam occaecati in necessitatibus in beatae qui sed nihil magnam asperiores','files/public/placeholder.png','2025-11-15 12:07:00.672','2025-11-15 12:07:00.672'),
(7,1,'ducimus','necessitatibus fugiat voluptatem quos dolores nihil quos quos maiores eos sit qui dolores aut nemo at dicta nostrum omnis at ipsum exercitationem sed dolores est esse id aliquid unde quae','files/public/placeholder.png','2025-11-15 12:07:00.673','2025-11-15 12:07:00.673'),
(8,1,'nostrum','sequi possimus fugit at maiores cupiditate beatae dolores hic neque deserunt laborum neque sed exercitationem deserunt voluptatem nemo dolores sed possimus et unde dicta ullam cupiditate sunt reiciendis nostrum blanditiis','files/public/placeholder.png','2025-11-15 12:07:00.674','2025-11-15 12:07:00.674'),
(9,1,'fugiat','beatae dicta occaecati ducimus rerum consequuntur in non omnis maiores quas quasi sequi non exercitationem non commodi aliquid nemo nostrum vel laborum cupiditate repellat in voluptatibus fugit non nihil nostrum','files/public/placeholder.png','2025-11-15 12:07:00.675','2025-11-15 12:07:00.675'),
(10,1,'dolores','reiciendis exercitationem beatae non tenetur consectetur voluptate enim nihil facilis sapiente possimus reiciendis aliquid reiciendis nihil non hic aliquid consectetur sed facilis qui quos blanditiis voluptate fugiat sit nulla sequi','files/public/placeholder.png','2025-11-15 12:07:00.677','2025-11-15 12:07:00.677'),
(11,2,'PPK','magnam aut asperiores sequi necessitatibus tenetur unde ipsum esse qui esse ipsum nulla vel error vitae quae ducimus voluptatibus id numquam ipsum numquam est sed aut exercitationem facilis magnam repellat','files/public/placeholder.png','2025-11-15 12:07:00.802','2025-11-15 12:07:00.802'),
(12,3,'Pancasila','rerum repellat sequi sed tenetur nulla est excepturi fugiat nihil nemo quia fugit vitae id occaecati asperiores possimus numquam asperiores vel consequatur consectetur esse possimus eos commodi in dicta maiores','files/public/placeholder.png','2025-11-15 12:07:00.803','2025-11-15 12:07:00.803'),
(13,3,'Agama','quaerat labore dolores quaerat voluptatem consectetur et sapiente quasi est cupiditate laborum fugiat dicta labore commodi nemo beatae qui sequi occaecati occaecati neque eos in in occaecati at in occaecati','files/public/placeholder.png','2025-11-15 12:07:00.804','2025-11-15 12:07:00.804'),
(14,3,'Bahasa Indonesia','vel enim neque blanditiis sed rerum quos necessitatibus voluptatem vitae beatae quae dicta consequuntur id consectetur sit ipsum laborum quaerat laborum laborum voluptate possimus possimus beatae laborum vitae error consectetur','files/public/placeholder.png','2025-11-15 12:07:00.805','2025-11-15 12:07:00.805');
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `FileToken`
--

DROP TABLE IF EXISTS `FileToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FileToken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(191) NOT NULL,
  `expireAt` datetime(3) NOT NULL,
  `materialFileId` int(11) NOT NULL,
  `userId` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `FileToken_token_key` (`token`),
  KEY `FileToken_materialFileId_fkey` (`materialFileId`),
  KEY `FileToken_userId_fkey` (`userId`),
  CONSTRAINT `FileToken_materialFileId_fkey` FOREIGN KEY (`materialFileId`) REFERENCES `Material_File` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FileToken_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FileToken`
--

LOCK TABLES `FileToken` WRITE;
/*!40000 ALTER TABLE `FileToken` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `FileToken` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Material`
--

DROP TABLE IF EXISTS `Material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `content` longtext NOT NULL,
  `xp` int(11) NOT NULL DEFAULT 10,
  `thumnail_path` varchar(191) NOT NULL,
  `video_path` varchar(191) NOT NULL,
  `materialFilePath` varchar(191) NOT NULL,
  `ringkasanPath` varchar(191) NOT NULL,
  `templatePath` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `sectionId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Material_sectionId_fkey` (`sectionId`),
  CONSTRAINT `Material_sectionId_fkey` FOREIGN KEY (`sectionId`) REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Material`
--

LOCK TABLES `Material` WRITE;
/*!40000 ALTER TABLE `Material` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Material` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Material_File`
--

DROP TABLE IF EXISTS `Material_File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Material_File` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `path` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `materialId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Material_File_materialId_fkey` (`materialId`),
  CONSTRAINT `Material_File_materialId_fkey` FOREIGN KEY (`materialId`) REFERENCES `Material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Material_File`
--

LOCK TABLES `Material_File` WRITE;
/*!40000 ALTER TABLE `Material_File` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Material_File` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `OTP_Token`
--

DROP TABLE IF EXISTS `OTP_Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OTP_Token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(191) NOT NULL,
  `type` enum('PasswordReset','EmailVerification') NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `userId` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `OTP_Token_userId_fkey` (`userId`),
  CONSTRAINT `OTP_Token_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OTP_Token`
--

LOCK TABLES `OTP_Token` WRITE;
/*!40000 ALTER TABLE `OTP_Token` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `OTP_Token` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Quiz`
--

DROP TABLE IF EXISTS `Quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `max_attempts` int(11) NOT NULL,
  `time_limit` int(11) NOT NULL,
  `open_at` datetime(3) NOT NULL,
  `close_at` datetime(3) NOT NULL,
  `passing_grade` int(11) NOT NULL,
  `xp` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `sectionId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Quiz_sectionId_fkey` (`sectionId`),
  CONSTRAINT `Quiz_sectionId_fkey` FOREIGN KEY (`sectionId`) REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quiz`
--

LOCK TABLES `Quiz` WRITE;
/*!40000 ALTER TABLE `Quiz` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Quiz` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Quiz_Answer`
--

DROP TABLE IF EXISTS `Quiz_Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quiz_Answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(191) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `questionId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Quiz_Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Quiz_Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Quiz_Question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quiz_Answer`
--

LOCK TABLES `Quiz_Answer` WRITE;
/*!40000 ALTER TABLE `Quiz_Answer` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Quiz_Answer` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Quiz_Attempt`
--

DROP TABLE IF EXISTS `Quiz_Attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quiz_Attempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `quizId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Quiz_Attempt_userId_fkey` (`userId`),
  KEY `Quiz_Attempt_quizId_fkey` (`quizId`),
  CONSTRAINT `Quiz_Attempt_quizId_fkey` FOREIGN KEY (`quizId`) REFERENCES `Quiz` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Quiz_Attempt_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quiz_Attempt`
--

LOCK TABLES `Quiz_Attempt` WRITE;
/*!40000 ALTER TABLE `Quiz_Attempt` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Quiz_Attempt` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Quiz_Question`
--

DROP TABLE IF EXISTS `Quiz_Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quiz_Question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(191) NOT NULL,
  `type` enum('MultipleChoice','TrueFalse','Essay') NOT NULL,
  `points` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `quizId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Quiz_Question_quizId_fkey` (`quizId`),
  CONSTRAINT `Quiz_Question_quizId_fkey` FOREIGN KEY (`quizId`) REFERENCES `Quiz` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quiz_Question`
--

LOCK TABLES `Quiz_Question` WRITE;
/*!40000 ALTER TABLE `Quiz_Question` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Quiz_Question` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `RedeemCode`
--

DROP TABLE IF EXISTS `RedeemCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `RedeemCode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(191) NOT NULL,
  `durationDays` int(11) NOT NULL,
  `maxUses` int(11) NOT NULL DEFAULT 1,
  `usedCount` int(11) NOT NULL DEFAULT 0,
  `expiresAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `RedeemCode_code_key` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedeemCode`
--

LOCK TABLES `RedeemCode` WRITE;
/*!40000 ALTER TABLE `RedeemCode` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `RedeemCode` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `RedeemHistory`
--

DROP TABLE IF EXISTS `RedeemHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `RedeemHistory` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `codeId` int(11) NOT NULL,
  `redeemedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `RedeemHistory_userId_codeId_key` (`userId`,`codeId`),
  KEY `RedeemHistory_codeId_fkey` (`codeId`),
  CONSTRAINT `RedeemHistory_codeId_fkey` FOREIGN KEY (`codeId`) REFERENCES `RedeemCode` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RedeemHistory_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedeemHistory`
--

LOCK TABLES `RedeemHistory` WRITE;
/*!40000 ALTER TABLE `RedeemHistory` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `RedeemHistory` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Reset_Token`
--

DROP TABLE IF EXISTS `Reset_Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reset_Token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Reset_Token_token_key` (`token`),
  KEY `Reset_Token_userId_fkey` (`userId`),
  CONSTRAINT `Reset_Token_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reset_Token`
--

LOCK TABLES `Reset_Token` WRITE;
/*!40000 ALTER TABLE `Reset_Token` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Reset_Token` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(191) NOT NULL,
  `materialId` int(11) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Review_userId_fkey` (`userId`),
  KEY `Review_materialId_fkey` (`materialId`),
  KEY `Review_classId_fkey` (`classId`),
  CONSTRAINT `Review_classId_fkey` FOREIGN KEY (`classId`) REFERENCES `Class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Review_materialId_fkey` FOREIGN KEY (`materialId`) REFERENCES `Material` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Review_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Role_name_key` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Role` VALUES
(1,'Admin','2025-11-15 12:07:00.482','2025-11-15 12:07:00.482'),
(2,'Teacher','2025-11-15 12:07:00.482','2025-11-15 12:07:00.482'),
(3,'Student','2025-11-15 12:07:00.482','2025-11-15 12:07:00.482');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Section`
--

DROP TABLE IF EXISTS `Section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `order` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `classId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Section_classId_fkey` (`classId`),
  CONSTRAINT `Section_classId_fkey` FOREIGN KEY (`classId`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Section`
--

LOCK TABLES `Section` WRITE;
/*!40000 ALTER TABLE `Section` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Section` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `profileImage` varchar(191) NOT NULL,
  `telp` varchar(191) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `specialization` varchar(191) DEFAULT NULL,
  `bio` varchar(191) DEFAULT NULL,
  `verified_at` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_email_key` (`email`),
  UNIQUE KEY `User_username_key` (`username`),
  KEY `User_roleId_fkey` (`roleId`),
  CONSTRAINT `User_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `Role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `User` VALUES
('00a1db28-f527-489d-9b19-229aea075f8d','student42@example.com','student42','Yoshiko.Einarsdóttir','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+42&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.631','2023-05-07 11:19:20.630','2025-11-15 12:07:00.632',3),
('016258fa-823b-41fa-a5ab-3196e3b7643a','student10@example.com','student10','Jianping_Óskarsdóttir45','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+10&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.582','2020-12-26 07:33:13.274','2025-11-15 12:07:00.582',3),
('01825d1b-e2b1-4a99-8649-5357f12049e8','student37@example.com','student37','Lilja_Gunnarsdóttir66','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+37&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.625','2023-04-25 12:59:40.209','2025-11-15 12:07:00.626',3),
('04575c88-2900-4023-a9a9-51e904f920c9','student28@example.com','student28','Jianping_Abdullahi','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+28&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.611','2023-10-02 11:49:08.368','2025-11-15 12:07:00.612',3),
('07678e68-aa0e-4427-955c-1a6adb088f19','student30@example.com','student30','Bartosz_Peña6','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+30&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.614','2022-09-29 22:46:58.076','2025-11-15 12:07:00.615',3),
('0a33c931-b888-409f-86ff-9e44164e29ad','student24@example.com','student24','Noam_Ayutthaya52','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+24&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.606','2021-05-16 20:09:55.150','2025-11-15 12:07:00.607',3),
('153c441e-244f-410c-ac49-8544883a6169','teacher4@example.com','teacher4','Lalita_Kimura74','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Teacher+4&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-15 12:07:00.564','2024-10-06 03:03:12.964','2025-11-15 12:07:00.565',2),
('26ceedf4-3a5c-4212-ae04-b3cee5aa8cb3','student17@example.com','student17','Sara.Harðardóttir','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+17&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.592','2025-05-30 21:01:35.521','2025-11-15 12:07:00.593',3),
('27f9c1dc-a916-42a9-9080-41619142727d','student39@example.com','student39','Laxmi_Ono','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+39&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.628','2022-12-03 12:22:15.671','2025-11-15 12:07:00.629',3),
('2c17cb62-974b-4514-8660-2e344d449852','teacher2@example.com','teacher2','Johannes_Þorsteinsdóttir52','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Teacher+2&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-15 12:07:00.560','2024-02-16 09:54:12.533','2025-11-15 12:07:00.561',2),
('2dcc3f7f-e521-45b4-a87b-07fa0e245fd0','student15@example.com','student15','Xiaoli.Méndez','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+15&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.590','2023-10-23 10:29:45.439','2025-11-15 12:07:00.590',3),
('314d1995-c264-4e30-bc88-6beff8384009','student43@example.com','student43','Bunmi.Pugh','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+43&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.633','2022-07-06 14:55:52.563','2025-11-15 12:07:00.634',3),
('35c56a8b-a3d5-40ab-98ae-cc6053f95eb1','student46@example.com','student46','Andrew_Greenberg21','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+46&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.657','2024-05-20 00:38:03.337','2025-11-15 12:07:00.657',3),
('382f08a0-3bb2-495c-a6b8-75cd7582e16c','student6@example.com','student6','Somsak_Achieng','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+6&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.576','2023-07-16 06:03:20.072','2025-11-15 12:07:00.576',3),
('3be66a89-7580-47d3-a3af-517cfc898d1a','student48@example.com','student48','Nobuko.Kristinsdóttir37','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+48&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.659','2024-06-22 10:36:47.974','2025-11-15 12:07:00.660',3),
('3ed80369-c765-4c40-938c-aa85a05c392d','student18@example.com','student18','Nadezhda_Brown','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+18&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.594','2022-08-10 17:20:21.093','2025-11-15 12:07:00.594',3),
('4701b457-9bb4-490c-8cdb-b2930da04a55','student22@example.com','student22','Svetlana.Łuczak54','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+22&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.603','2024-01-15 22:50:53.973','2025-11-15 12:07:00.603',3),
('47a3a58f-a8e8-4d49-81fa-b43503b96448','student36@example.com','student36','Lilian.Mandal38','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+36&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.623','2021-10-16 23:28:05.840','2025-11-15 12:07:00.624',3),
('4938f6af-2bcc-4f72-8fa2-06af89f4c855','djamgt23@gmail.com','admin','Admin User','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Admin+User&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.556','2025-05-14 16:55:26.580','2025-11-15 12:07:00.557',1),
('4c39703c-a678-4e29-9c09-6c3267e9552c','student5@example.com','student5','Darya_Þorsteinsson','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+5&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.574','2021-06-11 16:50:40.601','2025-11-15 12:07:00.575',3),
('4d5825ba-35b0-40da-9468-15efea65118d','student50@example.com','student50','Lalita_Jimenez','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+50&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.661','2024-05-20 15:33:09.287','2025-11-15 12:07:00.662',3),
('4e5cde11-117e-41fb-903c-510a8a47aa42','student35@example.com','student35','Hong.Romanova','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+35&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.622','2023-10-19 04:59:56.327','2025-11-15 12:07:00.622',3),
('4e6f17af-37b7-4a34-8c9b-15807b0bf660','student2@example.com','student2','Hui.Pérez45','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+2&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.567','2021-10-01 02:32:55.248','2025-11-15 12:07:00.568',3),
('51308de2-922e-49af-a913-4bc98ca9970d','student7@example.com','student7','Sharon_Krüger','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+7&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.577','2025-01-11 05:41:37.910','2025-11-15 12:07:00.578',3),
('58de52d6-9d49-4780-a0f2-81e39d5fb278','student26@example.com','student26','Somphon.Smirnov','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+26&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.608','2021-10-07 17:14:43.366','2025-11-15 12:07:00.609',3),
('5ed0d9e2-21c7-4f44-a948-57aa4d2841d4','student8@example.com','student8','Kristinn_Kučerová16','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+8&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.579','2024-10-27 22:01:08.594','2025-11-15 12:07:00.580',3),
('655d1b89-af84-47c0-8ead-a783e5d0fd67','teacher1@example.com','teacher1','Lan.Castillo98','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Teacher+1&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-15 12:07:00.559','2021-01-19 18:20:26.840','2025-11-15 12:07:00.560',2),
('675d034f-1d8f-463b-9b07-075396edcc6d','student3@example.com','student3','Manuel.Kovalenko85','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+3&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.570','2023-09-22 03:40:37.919','2025-11-15 12:07:00.571',3),
('68336206-7295-4ea3-b3e3-404c886ad68f','student16@example.com','student16','Yasuo.Bjarnadóttir44','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+16&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.591','2022-12-16 06:29:04.719','2025-11-15 12:07:00.592',3),
('7369af8f-b771-4003-8990-8a7fdd2b7a0f','teacher3@example.com','teacher3','Ewa_Jacobs','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Teacher+3&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-15 12:07:00.562','2021-01-11 18:06:08.504','2025-11-15 12:07:00.563',2),
('7675d25d-8a88-4ef6-8fc4-37375e331f49','student34@example.com','student34','Nushi.Magnúsdóttir','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+34&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.620','2023-06-09 06:33:50.527','2025-11-15 12:07:00.621',3),
('7c9780f0-676e-43dd-8c83-6e800416b67f','student23@example.com','student23','Qiang.Möller','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+23&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.604','2021-05-21 09:27:01.845','2025-11-15 12:07:00.605',3),
('7cd57487-ce37-44af-b26f-5bf49564fe87','student40@example.com','student40','Yael_Klein','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+40&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.629','2024-02-02 04:14:40.494','2025-11-15 12:07:00.630',3),
('7e3275a7-7257-4f8d-b323-a857afe346b4','student38@example.com','student38','Maria-Isabel.Shapiro80','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+38&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.627','2021-05-01 12:53:08.128','2025-11-15 12:07:00.627',3),
('85f06818-69f7-42f6-8ea8-5d6ede651457','student12@example.com','student12','Josef.Vazquez33','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+12&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.586','2022-08-11 19:58:16.701','2025-11-15 12:07:00.586',3),
('8cd306b7-0d45-442b-a802-12cef6cc0807','student25@example.com','student25','Samuel_Ram','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+25&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.607','2021-12-13 13:28:44.053','2025-11-15 12:07:00.608',3),
('8f000216-9769-4b9d-bd01-88e5bf99f22e','student49@example.com','student49','Fernando.Okeke','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+49&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.660','2024-04-04 09:09:43.787','2025-11-15 12:07:00.661',3),
('92c81c93-6017-4864-84ae-a5655844876c','student31@example.com','student31','Nadezhda.Jónsdóttir24','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+31&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.616','2025-04-06 21:08:20.540','2025-11-15 12:07:00.617',3),
('98b48ecc-ccc7-4163-b84a-2298bda6e167','student29@example.com','student29','Blessing_Ðekić','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+29&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.613','2025-09-28 05:26:14.414','2025-11-15 12:07:00.614',3),
('9e532807-03d4-4a0e-8ef7-3a8c9d65dea4','student45@example.com','student45','Luis.Hassan','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+45&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.655','2022-01-12 21:01:13.195','2025-11-15 12:07:00.656',3),
('a31e71d6-322c-4873-a36c-369c44f7db2e','student27@example.com','student27','Hiroko.Gómez','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+27&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.610','2025-03-19 07:00:50.522','2025-11-15 12:07:00.610',3),
('b599b0f6-897d-4064-bac1-09d32aead703','student1@example.com','student1','Jianping.Ueda43','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+1&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.566','2024-03-30 03:12:34.222','2025-11-15 12:07:00.567',3),
('b72359aa-e925-41c5-a055-10a9a97de906','student21@example.com','student21','Peng.Möller','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+21&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.601','2023-07-15 05:10:16.797','2025-11-15 12:07:00.602',3),
('b7355031-c57b-49f9-8127-8a860465a734','student32@example.com','student32','Grace_Green47','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+32&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.617','2022-10-31 15:07:59.142','2025-11-15 12:07:00.618',3),
('bdd51f18-5669-43dc-bc4d-21faf411c282','student19@example.com','student19','Maria_Kristinsson28','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+19&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.595','2022-10-01 22:16:12.400','2025-11-15 12:07:00.596',3),
('beaf132b-9511-49d7-a32d-8e98cb6a57af','student41@example.com','student41','Nittaya.Jabłoński','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+41&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.630','2022-08-21 03:46:21.785','2025-11-15 12:07:00.631',3),
('d0dbf0d4-a075-42b0-a779-ea19585307e7','student44@example.com','student44','Thulani_Yamada','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+44&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.634','2023-04-19 06:40:40.335','2025-11-15 12:07:00.635',3),
('d3c392c7-216a-4766-8e05-4d6f42c06327','student33@example.com','student33','Sri_Njuguna4','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+33&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.619','2025-06-10 00:10:09.894','2025-11-15 12:07:00.620',3),
('dd0e9f29-4e6d-449d-ad35-b0ad862733fd','student20@example.com','student20','Ryan.Novotný72','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+20&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.596','2021-02-13 12:53:09.625','2025-11-15 12:07:00.597',3),
('ec5e9db4-4c8e-42e2-86ea-0de6fe4a2bd1','student13@example.com','student13','Gita_Pillay67','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+13&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.587','2025-09-23 01:32:56.905','2025-11-15 12:07:00.588',3),
('f0755d5f-ce2b-408c-841f-074372d61944','student9@example.com','student9','Rekha_Fischer18','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+9&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.580','2021-02-01 03:52:42.569','2025-11-15 12:07:00.581',3),
('f6144b99-5e9e-43c9-ba03-e19500987b86','student4@example.com','student4','Klaus_Begam','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+4&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.573','2021-12-02 16:12:58.309','2025-11-15 12:07:00.574',3),
('fb1ef359-12e9-4b32-910c-e557fd11009b','student47@example.com','student47','Frank.Van-den-Berg44','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+47&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.658','2023-04-19 11:09:57.259','2025-11-15 12:07:00.659',3),
('fc199e0c-eb12-4230-868b-23e43abff0ef','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=teachertestacc&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.663','2024-09-06 12:19:14.132','2025-11-15 12:07:00.663',2),
('ffe0b8eb-6022-482d-939b-1c74b92b96cf','student11@example.com','student11','Tomiko_Pospíšil','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+11&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.584','2025-06-01 17:46:01.825','2025-11-15 12:07:00.585',3),
('fffeaa9f-d69f-4422-897e-ed5d16e2324a','student14@example.com','student14','Sawat.Einarsson','$2b$10$bocb6/CP3CabZt5rTJ.t7uMFJoE4egEFYYQLA36/4zmGrejISptqO','https://ui-avatars.com/api/?name=Student+14&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-15 12:07:00.588','2025-01-06 13:15:28.645','2025-11-15 12:07:00.589',3);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `User_Assignment`
--

DROP TABLE IF EXISTS `User_Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_graded` tinyint(1) NOT NULL DEFAULT 0,
  `grade` int(11) DEFAULT NULL,
  `path` varchar(191) DEFAULT NULL,
  `submitted_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `assignmentId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_Assignment_userId_assignmentId_key` (`userId`,`assignmentId`),
  KEY `User_Assignment_assignmentId_fkey` (`assignmentId`),
  CONSTRAINT `User_Assignment_assignmentId_fkey` FOREIGN KEY (`assignmentId`) REFERENCES `Assignment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `User_Assignment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Assignment`
--

LOCK TABLES `User_Assignment` WRITE;
/*!40000 ALTER TABLE `User_Assignment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `User_Assignment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `User_Class`
--

DROP TABLE IF EXISTS `User_Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` enum('Student','Teacher','Admin') NOT NULL,
  `userId` varchar(191) NOT NULL,
  `classId` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_Class_userId_classId_key` (`userId`,`classId`),
  KEY `User_Class_classId_fkey` (`classId`),
  CONSTRAINT `User_Class_classId_fkey` FOREIGN KEY (`classId`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `User_Class_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Class`
--

LOCK TABLES `User_Class` WRITE;
/*!40000 ALTER TABLE `User_Class` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `User_Class` VALUES
(1,'Teacher','153c441e-244f-410c-ac49-8544883a6169',1,'2025-11-15 12:07:00.684','2025-11-15 12:07:00.684'),
(2,'Student','9e532807-03d4-4a0e-8ef7-3a8c9d65dea4',1,'2025-11-15 12:07:00.686','2025-11-15 12:07:00.686'),
(3,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',1,'2025-11-15 12:07:00.688','2025-11-15 12:07:00.688'),
(4,'Student','3ed80369-c765-4c40-938c-aa85a05c392d',1,'2025-11-15 12:07:00.689','2025-11-15 12:07:00.689'),
(5,'Student','b7355031-c57b-49f9-8127-8a860465a734',1,'2025-11-15 12:07:00.690','2025-11-15 12:07:00.690'),
(6,'Student','dd0e9f29-4e6d-449d-ad35-b0ad862733fd',1,'2025-11-15 12:07:00.691','2025-11-15 12:07:00.691'),
(7,'Student','314d1995-c264-4e30-bc88-6beff8384009',1,'2025-11-15 12:07:00.692','2025-11-15 12:07:00.692'),
(8,'Student','675d034f-1d8f-463b-9b07-075396edcc6d',1,'2025-11-15 12:07:00.693','2025-11-15 12:07:00.693'),
(9,'Student','7cd57487-ce37-44af-b26f-5bf49564fe87',1,'2025-11-15 12:07:00.695','2025-11-15 12:07:00.695'),
(10,'Student','4e5cde11-117e-41fb-903c-510a8a47aa42',1,'2025-11-15 12:07:00.696','2025-11-15 12:07:00.696'),
(11,'Student','01825d1b-e2b1-4a99-8649-5357f12049e8',1,'2025-11-15 12:07:00.697','2025-11-15 12:07:00.697'),
(12,'Teacher','7369af8f-b771-4003-8990-8a7fdd2b7a0f',2,'2025-11-15 12:07:00.698','2025-11-15 12:07:00.698'),
(13,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',2,'2025-11-15 12:07:00.699','2025-11-15 12:07:00.699'),
(14,'Student','4d5825ba-35b0-40da-9468-15efea65118d',2,'2025-11-15 12:07:00.700','2025-11-15 12:07:00.700'),
(15,'Student','4e6f17af-37b7-4a34-8c9b-15807b0bf660',2,'2025-11-15 12:07:00.701','2025-11-15 12:07:00.701'),
(16,'Student','27f9c1dc-a916-42a9-9080-41619142727d',2,'2025-11-15 12:07:00.702','2025-11-15 12:07:00.702'),
(17,'Student','85f06818-69f7-42f6-8ea8-5d6ede651457',2,'2025-11-15 12:07:00.703','2025-11-15 12:07:00.703'),
(18,'Student','382f08a0-3bb2-495c-a6b8-75cd7582e16c',2,'2025-11-15 12:07:00.704','2025-11-15 12:07:00.704'),
(19,'Student','dd0e9f29-4e6d-449d-ad35-b0ad862733fd',2,'2025-11-15 12:07:00.705','2025-11-15 12:07:00.705'),
(20,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',2,'2025-11-15 12:07:00.706','2025-11-15 12:07:00.706'),
(21,'Student','51308de2-922e-49af-a913-4bc98ca9970d',2,'2025-11-15 12:07:00.707','2025-11-15 12:07:00.707'),
(22,'Student','7cd57487-ce37-44af-b26f-5bf49564fe87',2,'2025-11-15 12:07:00.708','2025-11-15 12:07:00.708'),
(23,'Teacher','655d1b89-af84-47c0-8ead-a783e5d0fd67',3,'2025-11-15 12:07:00.709','2025-11-15 12:07:00.709'),
(24,'Student','b7355031-c57b-49f9-8127-8a860465a734',3,'2025-11-15 12:07:00.710','2025-11-15 12:07:00.710'),
(25,'Student','2dcc3f7f-e521-45b4-a87b-07fa0e245fd0',3,'2025-11-15 12:07:00.711','2025-11-15 12:07:00.711'),
(26,'Student','ec5e9db4-4c8e-42e2-86ea-0de6fe4a2bd1',3,'2025-11-15 12:07:00.712','2025-11-15 12:07:00.712'),
(27,'Student','8cd306b7-0d45-442b-a802-12cef6cc0807',3,'2025-11-15 12:07:00.713','2025-11-15 12:07:00.713'),
(28,'Student','bdd51f18-5669-43dc-bc4d-21faf411c282',3,'2025-11-15 12:07:00.714','2025-11-15 12:07:00.714'),
(29,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',3,'2025-11-15 12:07:00.715','2025-11-15 12:07:00.715'),
(30,'Student','ffe0b8eb-6022-482d-939b-1c74b92b96cf',3,'2025-11-15 12:07:00.716','2025-11-15 12:07:00.716'),
(31,'Student','fffeaa9f-d69f-4422-897e-ed5d16e2324a',3,'2025-11-15 12:07:00.717','2025-11-15 12:07:00.717'),
(32,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',3,'2025-11-15 12:07:00.718','2025-11-15 12:07:00.718'),
(33,'Student','4d5825ba-35b0-40da-9468-15efea65118d',3,'2025-11-15 12:07:00.719','2025-11-15 12:07:00.719'),
(34,'Teacher','655d1b89-af84-47c0-8ead-a783e5d0fd67',4,'2025-11-15 12:07:00.720','2025-11-15 12:07:00.720'),
(35,'Student','85f06818-69f7-42f6-8ea8-5d6ede651457',4,'2025-11-15 12:07:00.720','2025-11-15 12:07:00.720'),
(36,'Student','d3c392c7-216a-4766-8e05-4d6f42c06327',4,'2025-11-15 12:07:00.721','2025-11-15 12:07:00.721'),
(37,'Student','dd0e9f29-4e6d-449d-ad35-b0ad862733fd',4,'2025-11-15 12:07:00.722','2025-11-15 12:07:00.722'),
(38,'Student','8cd306b7-0d45-442b-a802-12cef6cc0807',4,'2025-11-15 12:07:00.723','2025-11-15 12:07:00.723'),
(39,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',4,'2025-11-15 12:07:00.724','2025-11-15 12:07:00.724'),
(40,'Student','00a1db28-f527-489d-9b19-229aea075f8d',4,'2025-11-15 12:07:00.725','2025-11-15 12:07:00.725'),
(41,'Student','51308de2-922e-49af-a913-4bc98ca9970d',4,'2025-11-15 12:07:00.726','2025-11-15 12:07:00.726'),
(42,'Student','7675d25d-8a88-4ef6-8fc4-37375e331f49',4,'2025-11-15 12:07:00.727','2025-11-15 12:07:00.727'),
(43,'Student','01825d1b-e2b1-4a99-8649-5357f12049e8',4,'2025-11-15 12:07:00.728','2025-11-15 12:07:00.728'),
(44,'Student','bdd51f18-5669-43dc-bc4d-21faf411c282',4,'2025-11-15 12:07:00.729','2025-11-15 12:07:00.729'),
(45,'Teacher','655d1b89-af84-47c0-8ead-a783e5d0fd67',5,'2025-11-15 12:07:00.730','2025-11-15 12:07:00.730'),
(46,'Student','27f9c1dc-a916-42a9-9080-41619142727d',5,'2025-11-15 12:07:00.731','2025-11-15 12:07:00.731'),
(47,'Student','04575c88-2900-4023-a9a9-51e904f920c9',5,'2025-11-15 12:07:00.732','2025-11-15 12:07:00.732'),
(48,'Student','b72359aa-e925-41c5-a055-10a9a97de906',5,'2025-11-15 12:07:00.732','2025-11-15 12:07:00.732'),
(49,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',5,'2025-11-15 12:07:00.734','2025-11-15 12:07:00.734'),
(50,'Student','4e5cde11-117e-41fb-903c-510a8a47aa42',5,'2025-11-15 12:07:00.735','2025-11-15 12:07:00.735'),
(51,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',5,'2025-11-15 12:07:00.736','2025-11-15 12:07:00.736'),
(52,'Student','0a33c931-b888-409f-86ff-9e44164e29ad',5,'2025-11-15 12:07:00.737','2025-11-15 12:07:00.737'),
(53,'Student','314d1995-c264-4e30-bc88-6beff8384009',5,'2025-11-15 12:07:00.738','2025-11-15 12:07:00.738'),
(54,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',5,'2025-11-15 12:07:00.739','2025-11-15 12:07:00.739'),
(55,'Student','b599b0f6-897d-4064-bac1-09d32aead703',5,'2025-11-15 12:07:00.740','2025-11-15 12:07:00.740'),
(56,'Teacher','153c441e-244f-410c-ac49-8544883a6169',6,'2025-11-15 12:07:00.742','2025-11-15 12:07:00.742'),
(57,'Student','27f9c1dc-a916-42a9-9080-41619142727d',6,'2025-11-15 12:07:00.742','2025-11-15 12:07:00.742'),
(58,'Student','58de52d6-9d49-4780-a0f2-81e39d5fb278',6,'2025-11-15 12:07:00.743','2025-11-15 12:07:00.743'),
(59,'Student','bdd51f18-5669-43dc-bc4d-21faf411c282',6,'2025-11-15 12:07:00.744','2025-11-15 12:07:00.744'),
(60,'Student','b7355031-c57b-49f9-8127-8a860465a734',6,'2025-11-15 12:07:00.745','2025-11-15 12:07:00.745'),
(61,'Student','5ed0d9e2-21c7-4f44-a948-57aa4d2841d4',6,'2025-11-15 12:07:00.747','2025-11-15 12:07:00.747'),
(62,'Student','ffe0b8eb-6022-482d-939b-1c74b92b96cf',6,'2025-11-15 12:07:00.748','2025-11-15 12:07:00.748'),
(63,'Student','0a33c931-b888-409f-86ff-9e44164e29ad',6,'2025-11-15 12:07:00.749','2025-11-15 12:07:00.749'),
(64,'Student','dd0e9f29-4e6d-449d-ad35-b0ad862733fd',6,'2025-11-15 12:07:00.750','2025-11-15 12:07:00.750'),
(65,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',6,'2025-11-15 12:07:00.751','2025-11-15 12:07:00.751'),
(66,'Student','92c81c93-6017-4864-84ae-a5655844876c',6,'2025-11-15 12:07:00.752','2025-11-15 12:07:00.752'),
(67,'Teacher','153c441e-244f-410c-ac49-8544883a6169',7,'2025-11-15 12:07:00.753','2025-11-15 12:07:00.753'),
(68,'Student','0a33c931-b888-409f-86ff-9e44164e29ad',7,'2025-11-15 12:07:00.754','2025-11-15 12:07:00.754'),
(69,'Student','a31e71d6-322c-4873-a36c-369c44f7db2e',7,'2025-11-15 12:07:00.754','2025-11-15 12:07:00.754'),
(70,'Student','b7355031-c57b-49f9-8127-8a860465a734',7,'2025-11-15 12:07:00.755','2025-11-15 12:07:00.755'),
(71,'Student','68336206-7295-4ea3-b3e3-404c886ad68f',7,'2025-11-15 12:07:00.756','2025-11-15 12:07:00.756'),
(72,'Student','382f08a0-3bb2-495c-a6b8-75cd7582e16c',7,'2025-11-15 12:07:00.757','2025-11-15 12:07:00.757'),
(73,'Student','4d5825ba-35b0-40da-9468-15efea65118d',7,'2025-11-15 12:07:00.758','2025-11-15 12:07:00.758'),
(74,'Student','fb1ef359-12e9-4b32-910c-e557fd11009b',7,'2025-11-15 12:07:00.759','2025-11-15 12:07:00.759'),
(75,'Student','92c81c93-6017-4864-84ae-a5655844876c',7,'2025-11-15 12:07:00.760','2025-11-15 12:07:00.760'),
(76,'Student','58de52d6-9d49-4780-a0f2-81e39d5fb278',7,'2025-11-15 12:07:00.761','2025-11-15 12:07:00.761'),
(77,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',7,'2025-11-15 12:07:00.762','2025-11-15 12:07:00.762'),
(78,'Teacher','2c17cb62-974b-4514-8660-2e344d449852',8,'2025-11-15 12:07:00.764','2025-11-15 12:07:00.764'),
(79,'Student','314d1995-c264-4e30-bc88-6beff8384009',8,'2025-11-15 12:07:00.765','2025-11-15 12:07:00.765'),
(80,'Student','fb1ef359-12e9-4b32-910c-e557fd11009b',8,'2025-11-15 12:07:00.766','2025-11-15 12:07:00.766'),
(81,'Student','7c9780f0-676e-43dd-8c83-6e800416b67f',8,'2025-11-15 12:07:00.768','2025-11-15 12:07:00.768'),
(82,'Student','85f06818-69f7-42f6-8ea8-5d6ede651457',8,'2025-11-15 12:07:00.769','2025-11-15 12:07:00.769'),
(83,'Student','3ed80369-c765-4c40-938c-aa85a05c392d',8,'2025-11-15 12:07:00.770','2025-11-15 12:07:00.770'),
(84,'Student','5ed0d9e2-21c7-4f44-a948-57aa4d2841d4',8,'2025-11-15 12:07:00.771','2025-11-15 12:07:00.771'),
(85,'Student','00a1db28-f527-489d-9b19-229aea075f8d',8,'2025-11-15 12:07:00.773','2025-11-15 12:07:00.773'),
(86,'Student','d0dbf0d4-a075-42b0-a779-ea19585307e7',8,'2025-11-15 12:07:00.774','2025-11-15 12:07:00.774'),
(87,'Student','92c81c93-6017-4864-84ae-a5655844876c',8,'2025-11-15 12:07:00.775','2025-11-15 12:07:00.775'),
(88,'Student','fffeaa9f-d69f-4422-897e-ed5d16e2324a',8,'2025-11-15 12:07:00.775','2025-11-15 12:07:00.775'),
(89,'Teacher','655d1b89-af84-47c0-8ead-a783e5d0fd67',9,'2025-11-15 12:07:00.777','2025-11-15 12:07:00.777'),
(90,'Student','00a1db28-f527-489d-9b19-229aea075f8d',9,'2025-11-15 12:07:00.779','2025-11-15 12:07:00.779'),
(91,'Student','01825d1b-e2b1-4a99-8649-5357f12049e8',9,'2025-11-15 12:07:00.780','2025-11-15 12:07:00.780'),
(92,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',9,'2025-11-15 12:07:00.781','2025-11-15 12:07:00.781'),
(93,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',9,'2025-11-15 12:07:00.782','2025-11-15 12:07:00.782'),
(94,'Student','d0dbf0d4-a075-42b0-a779-ea19585307e7',9,'2025-11-15 12:07:00.783','2025-11-15 12:07:00.783'),
(95,'Student','04575c88-2900-4023-a9a9-51e904f920c9',9,'2025-11-15 12:07:00.785','2025-11-15 12:07:00.785'),
(96,'Student','5ed0d9e2-21c7-4f44-a948-57aa4d2841d4',9,'2025-11-15 12:07:00.787','2025-11-15 12:07:00.787'),
(97,'Student','675d034f-1d8f-463b-9b07-075396edcc6d',9,'2025-11-15 12:07:00.788','2025-11-15 12:07:00.788'),
(98,'Student','ec5e9db4-4c8e-42e2-86ea-0de6fe4a2bd1',9,'2025-11-15 12:07:00.789','2025-11-15 12:07:00.789'),
(99,'Student','7675d25d-8a88-4ef6-8fc4-37375e331f49',9,'2025-11-15 12:07:00.790','2025-11-15 12:07:00.790'),
(100,'Teacher','655d1b89-af84-47c0-8ead-a783e5d0fd67',10,'2025-11-15 12:07:00.791','2025-11-15 12:07:00.791'),
(101,'Student','3ed80369-c765-4c40-938c-aa85a05c392d',10,'2025-11-15 12:07:00.792','2025-11-15 12:07:00.792'),
(102,'Student','4c39703c-a678-4e29-9c09-6c3267e9552c',10,'2025-11-15 12:07:00.794','2025-11-15 12:07:00.794'),
(103,'Student','fb1ef359-12e9-4b32-910c-e557fd11009b',10,'2025-11-15 12:07:00.795','2025-11-15 12:07:00.795'),
(104,'Student','4d5825ba-35b0-40da-9468-15efea65118d',10,'2025-11-15 12:07:00.796','2025-11-15 12:07:00.796'),
(105,'Student','92c81c93-6017-4864-84ae-a5655844876c',10,'2025-11-15 12:07:00.796','2025-11-15 12:07:00.796'),
(106,'Student','4e5cde11-117e-41fb-903c-510a8a47aa42',10,'2025-11-15 12:07:00.797','2025-11-15 12:07:00.797'),
(107,'Student','0a33c931-b888-409f-86ff-9e44164e29ad',10,'2025-11-15 12:07:00.798','2025-11-15 12:07:00.798'),
(108,'Student','00a1db28-f527-489d-9b19-229aea075f8d',10,'2025-11-15 12:07:00.799','2025-11-15 12:07:00.799'),
(109,'Student','7cd57487-ce37-44af-b26f-5bf49564fe87',10,'2025-11-15 12:07:00.800','2025-11-15 12:07:00.800'),
(110,'Student','7c9780f0-676e-43dd-8c83-6e800416b67f',10,'2025-11-15 12:07:00.801','2025-11-15 12:07:00.801'),
(111,'Teacher','fc199e0c-eb12-4230-868b-23e43abff0ef',11,'2025-11-15 12:07:00.807','2025-11-15 12:07:00.807'),
(112,'Student','d3c392c7-216a-4766-8e05-4d6f42c06327',11,'2025-11-15 12:07:00.808','2025-11-15 12:07:00.808'),
(113,'Student','382f08a0-3bb2-495c-a6b8-75cd7582e16c',11,'2025-11-15 12:07:00.809','2025-11-15 12:07:00.809'),
(114,'Student','7c9780f0-676e-43dd-8c83-6e800416b67f',11,'2025-11-15 12:07:00.810','2025-11-15 12:07:00.810'),
(115,'Student','ffe0b8eb-6022-482d-939b-1c74b92b96cf',11,'2025-11-15 12:07:00.811','2025-11-15 12:07:00.811'),
(116,'Student','9e532807-03d4-4a0e-8ef7-3a8c9d65dea4',11,'2025-11-15 12:07:00.812','2025-11-15 12:07:00.812'),
(117,'Student','675d034f-1d8f-463b-9b07-075396edcc6d',11,'2025-11-15 12:07:00.813','2025-11-15 12:07:00.813'),
(118,'Student','b72359aa-e925-41c5-a055-10a9a97de906',11,'2025-11-15 12:07:00.814','2025-11-15 12:07:00.814'),
(119,'Student','fb1ef359-12e9-4b32-910c-e557fd11009b',11,'2025-11-15 12:07:00.815','2025-11-15 12:07:00.815'),
(120,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',11,'2025-11-15 12:07:00.816','2025-11-15 12:07:00.816'),
(121,'Student','92c81c93-6017-4864-84ae-a5655844876c',11,'2025-11-15 12:07:00.817','2025-11-15 12:07:00.817'),
(122,'Teacher','fc199e0c-eb12-4230-868b-23e43abff0ef',12,'2025-11-15 12:07:00.818','2025-11-15 12:07:00.818'),
(123,'Student','7e3275a7-7257-4f8d-b323-a857afe346b4',12,'2025-11-15 12:07:00.819','2025-11-15 12:07:00.819'),
(124,'Student','4e6f17af-37b7-4a34-8c9b-15807b0bf660',12,'2025-11-15 12:07:00.820','2025-11-15 12:07:00.820'),
(125,'Student','a31e71d6-322c-4873-a36c-369c44f7db2e',12,'2025-11-15 12:07:00.821','2025-11-15 12:07:00.821'),
(126,'Student','00a1db28-f527-489d-9b19-229aea075f8d',12,'2025-11-15 12:07:00.822','2025-11-15 12:07:00.822'),
(127,'Student','04575c88-2900-4023-a9a9-51e904f920c9',12,'2025-11-15 12:07:00.823','2025-11-15 12:07:00.823'),
(128,'Student','85f06818-69f7-42f6-8ea8-5d6ede651457',12,'2025-11-15 12:07:00.824','2025-11-15 12:07:00.824'),
(129,'Student','35c56a8b-a3d5-40ab-98ae-cc6053f95eb1',12,'2025-11-15 12:07:00.824','2025-11-15 12:07:00.824'),
(130,'Student','016258fa-823b-41fa-a5ab-3196e3b7643a',12,'2025-11-15 12:07:00.825','2025-11-15 12:07:00.825'),
(131,'Student','beaf132b-9511-49d7-a32d-8e98cb6a57af',12,'2025-11-15 12:07:00.826','2025-11-15 12:07:00.826'),
(132,'Student','b599b0f6-897d-4064-bac1-09d32aead703',12,'2025-11-15 12:07:00.827','2025-11-15 12:07:00.827'),
(133,'Teacher','fc199e0c-eb12-4230-868b-23e43abff0ef',13,'2025-11-15 12:07:00.828','2025-11-15 12:07:00.828'),
(134,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',13,'2025-11-15 12:07:00.829','2025-11-15 12:07:00.829'),
(135,'Student','4d5825ba-35b0-40da-9468-15efea65118d',13,'2025-11-15 12:07:00.830','2025-11-15 12:07:00.830'),
(136,'Student','27f9c1dc-a916-42a9-9080-41619142727d',13,'2025-11-15 12:07:00.831','2025-11-15 12:07:00.831'),
(137,'Student','3be66a89-7580-47d3-a3af-517cfc898d1a',13,'2025-11-15 12:07:00.832','2025-11-15 12:07:00.832'),
(138,'Student','01825d1b-e2b1-4a99-8649-5357f12049e8',13,'2025-11-15 12:07:00.833','2025-11-15 12:07:00.833'),
(139,'Student','26ceedf4-3a5c-4212-ae04-b3cee5aa8cb3',13,'2025-11-15 12:07:00.834','2025-11-15 12:07:00.834'),
(140,'Student','675d034f-1d8f-463b-9b07-075396edcc6d',13,'2025-11-15 12:07:00.835','2025-11-15 12:07:00.835'),
(141,'Student','bdd51f18-5669-43dc-bc4d-21faf411c282',13,'2025-11-15 12:07:00.835','2025-11-15 12:07:00.835'),
(142,'Student','382f08a0-3bb2-495c-a6b8-75cd7582e16c',13,'2025-11-15 12:07:00.836','2025-11-15 12:07:00.836'),
(143,'Student','04575c88-2900-4023-a9a9-51e904f920c9',13,'2025-11-15 12:07:00.837','2025-11-15 12:07:00.837'),
(144,'Teacher','fc199e0c-eb12-4230-868b-23e43abff0ef',14,'2025-11-15 12:07:00.838','2025-11-15 12:07:00.838'),
(145,'Student','51308de2-922e-49af-a913-4bc98ca9970d',14,'2025-11-15 12:07:00.839','2025-11-15 12:07:00.839'),
(146,'Student','7cd57487-ce37-44af-b26f-5bf49564fe87',14,'2025-11-15 12:07:00.840','2025-11-15 12:07:00.840'),
(147,'Student','5ed0d9e2-21c7-4f44-a948-57aa4d2841d4',14,'2025-11-15 12:07:00.841','2025-11-15 12:07:00.841'),
(148,'Student','7c9780f0-676e-43dd-8c83-6e800416b67f',14,'2025-11-15 12:07:00.842','2025-11-15 12:07:00.842'),
(149,'Student','dd0e9f29-4e6d-449d-ad35-b0ad862733fd',14,'2025-11-15 12:07:00.844','2025-11-15 12:07:00.844'),
(150,'Student','8f000216-9769-4b9d-bd01-88e5bf99f22e',14,'2025-11-15 12:07:00.845','2025-11-15 12:07:00.845'),
(151,'Student','9e532807-03d4-4a0e-8ef7-3a8c9d65dea4',14,'2025-11-15 12:07:00.846','2025-11-15 12:07:00.846'),
(152,'Student','0a33c931-b888-409f-86ff-9e44164e29ad',14,'2025-11-15 12:07:00.847','2025-11-15 12:07:00.847'),
(153,'Student','ec5e9db4-4c8e-42e2-86ea-0de6fe4a2bd1',14,'2025-11-15 12:07:00.848','2025-11-15 12:07:00.848'),
(154,'Student','ffe0b8eb-6022-482d-939b-1c74b92b96cf',14,'2025-11-15 12:07:00.849','2025-11-15 12:07:00.849');
/*!40000 ALTER TABLE `User_Class` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `User_Material`
--

DROP TABLE IF EXISTS `User_Material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_completed` tinyint(1) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `materialId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_Material_userId_materialId_key` (`userId`,`materialId`),
  KEY `User_Material_materialId_fkey` (`materialId`),
  CONSTRAINT `User_Material_materialId_fkey` FOREIGN KEY (`materialId`) REFERENCES `Material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `User_Material_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Material`
--

LOCK TABLES `User_Material` WRITE;
/*!40000 ALTER TABLE `User_Material` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `User_Material` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `User_Subscription`
--

DROP TABLE IF EXISTS `User_Subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Subscription` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `startAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `endAt` datetime(3) NOT NULL,
  `status` enum('ACTIVE','EXPIRED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `User_Subscription_userId_fkey` (`userId`),
  CONSTRAINT `User_Subscription_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Subscription`
--

LOCK TABLES `User_Subscription` WRITE;
/*!40000 ALTER TABLE `User_Subscription` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `User_Subscription` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Xp`
--

DROP TABLE IF EXISTS `Xp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Xp` (
  `id` varchar(191) NOT NULL,
  `source` enum('Quiz','Assignment','Material') NOT NULL,
  `sourceId` varchar(191) NOT NULL,
  `points` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Xp_userId_fkey` (`userId`),
  CONSTRAINT `Xp_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Xp`
--

LOCK TABLES `Xp` WRITE;
/*!40000 ALTER TABLE `Xp` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `Xp` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `_prisma_migrations` VALUES
('9654500e-fb6a-4743-8679-f22f719fcc37','330c558dd59e57f5be2e0b739af7e167005897877a1e9b870d17154fc31ad60e','2025-11-15 12:06:57.611','20251115092106_remove_subscription_plan',NULL,NULL,'2025-11-15 12:06:57.593',1),
('ddaad4c1-cfc0-4c30-8d3e-8ad6f9da1f4d','5d535f395498abb562d62c3d16a60924963a26c3c065d32a7a5e1f066075fcb1','2025-11-15 12:06:57.593','20251112144809_init',NULL,NULL,'2025-11-15 12:06:57.263',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_key` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `category` VALUES
(1,'Essay',0,'2025-11-15 12:07:00.665','2025-11-15 12:07:00.665'),
(2,'Business Plan',0,'2025-11-15 12:07:00.665','2025-11-15 12:07:00.665'),
(3,'Penelitian',0,'2025-11-15 12:07:00.665','2025-11-15 12:07:00.665'),
(4,'Desain',0,'2025-11-15 12:07:00.665','2025-11-15 12:07:00.665');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-11-15 19:07:54

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
(1,1,'nemo','possimus non cupiditate excepturi aut excepturi sed sit facilis labore dolores quia et ducimus omnis ipsum quas sit sunt nulla sed non facilis nulla aut sunt omnis nulla voluptate rerum','files/public/placeholder.png','2025-11-19 05:20:38.747','2025-11-19 05:20:38.747'),
(2,1,'occaecati','vel doloribus unde reiciendis beatae reiciendis in est sed quaerat sapiente at id vitae quos esse omnis unde dolores occaecati voluptatibus quaerat repellat numquam consequuntur voluptatem nostrum error est aliquid','files/public/placeholder.png','2025-11-19 05:20:38.749','2025-11-19 05:20:38.749'),
(3,1,'labore','sunt asperiores fugit quos unde consectetur quaerat sapiente necessitatibus consectetur quos voluptatibus hic ipsum maiores reiciendis qui occaecati commodi quas magnam labore voluptate sunt nostrum aut qui vel facilis quae','files/public/placeholder.png','2025-11-19 05:20:38.751','2025-11-19 05:20:38.751'),
(4,1,'aliquid','blanditiis quia quasi error dicta id nemo excepturi sit reiciendis vel sunt consequatur repellat quasi nostrum possimus ducimus voluptate esse sequi vitae fugit possimus commodi fugiat ducimus voluptatibus non sunt','files/public/placeholder.png','2025-11-19 05:20:38.752','2025-11-19 05:20:38.752'),
(5,1,'commodi','magnam dolores repellat quaerat ducimus unde magnam qui sit aliquid exercitationem hic quas et blanditiis asperiores nulla voluptate repellat sit tenetur in ducimus voluptate qui enim sit dolores cupiditate exercitationem','files/public/placeholder.png','2025-11-19 05:20:38.753','2025-11-19 05:20:38.753'),
(6,1,'quaerat','vel sunt et nostrum ipsum excepturi excepturi quas est fugiat voluptatem sequi consectetur voluptate rerum quas necessitatibus necessitatibus commodi cupiditate at cupiditate non consequuntur et possimus deserunt excepturi nemo occaecati','files/public/placeholder.png','2025-11-19 05:20:38.754','2025-11-19 05:20:38.754'),
(7,1,'fugiat','sequi consequuntur occaecati quas unde rerum ipsum vel aliquid nulla quas facilis quos repellat vitae quas ullam unde occaecati vel quae ullam nihil qui vel sequi sequi magnam enim quos','files/public/placeholder.png','2025-11-19 05:20:38.755','2025-11-19 05:20:38.755'),
(8,1,'excepturi','facilis consequuntur nostrum id fugit labore esse id unde omnis unde neque quaerat et sed maiores eos voluptate exercitationem quaerat possimus dicta dolores error et voluptate non dicta nulla qui','files/public/placeholder.png','2025-11-19 05:20:38.756','2025-11-19 05:20:38.756'),
(9,1,'repellat','omnis necessitatibus consequatur in error cupiditate quas sapiente nostrum vel facilis voluptate quos excepturi quas blanditiis ipsum enim voluptate asperiores magnam quas eos numquam esse necessitatibus doloribus fugit facilis cupiditate','files/public/placeholder.png','2025-11-19 05:20:38.757','2025-11-19 05:20:38.757'),
(10,1,'et','ipsum cupiditate nulla ducimus numquam est excepturi enim exercitationem error nostrum voluptatibus eos omnis nihil omnis numquam nemo nostrum error sapiente ipsum aut ullam est maiores laborum blanditiis eos unde','files/public/placeholder.png','2025-11-19 05:20:38.758','2025-11-19 05:20:38.758'),
(11,1,'PPK','vitae sequi nihil doloribus sunt vitae quae cupiditate vel quos quasi eos hic id consequuntur asperiores dicta unde hic neque sapiente consequuntur cupiditate vitae dolores sequi qui vel qui exercitationem','files/public/placeholder.png','2025-11-19 05:20:38.876','2025-11-19 05:20:38.876'),
(12,3,'Pancasila','dolores consequuntur sunt possimus sit beatae enim omnis consequatur laborum esse deserunt consequuntur nulla consectetur voluptate at beatae ullam quasi possimus voluptatibus quia tenetur repellat magnam excepturi in est neque','files/public/placeholder.png','2025-11-19 05:20:38.877','2025-11-19 05:20:38.877'),
(13,3,'Agama','excepturi unde cupiditate omnis nostrum et laborum hic eos nemo dicta sequi doloribus nemo vitae et consequuntur quia asperiores quia rerum nulla nihil fugiat quaerat dicta rerum nostrum facilis facilis','files/public/placeholder.png','2025-11-19 05:20:38.878','2025-11-19 05:20:38.878'),
(14,3,'Bahasa Indonesia','voluptate sapiente excepturi excepturi quia consequuntur rerum error dolores non sunt nemo vel vel aut sequi hic sapiente quos quaerat aut quae reiciendis sit dicta sed quasi deserunt voluptate fugiat','files/public/placeholder.png','2025-11-19 05:20:38.879','2025-11-19 05:20:38.879');
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
  `passing_grade` int(11) NOT NULL,
  `xp` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `materialId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Quiz_materialId_fkey` (`materialId`),
  CONSTRAINT `Quiz_materialId_fkey` FOREIGN KEY (`materialId`) REFERENCES `Material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `score` int(11) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `quizId` int(11) NOT NULL,
  `is_graded` tinyint(1) NOT NULL DEFAULT 0,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `submitted_at` datetime(3) DEFAULT NULL,
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
  `explanation` longtext DEFAULT NULL,
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
  `classId` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Review_userId_fkey` (`userId`),
  KEY `Review_classId_fkey` (`classId`),
  CONSTRAINT `Review_classId_fkey` FOREIGN KEY (`classId`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
(1,'Admin','2025-11-19 05:20:38.588','2025-11-19 05:20:38.588'),
(2,'Teacher','2025-11-19 05:20:38.588','2025-11-19 05:20:38.588'),
(3,'Student','2025-11-19 05:20:38.588','2025-11-19 05:20:38.588');
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
('0271e947-2bc2-49e3-990c-972e23e2839f','student8@example.com','student8','Yoshio_Dvořáková96','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+8&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.673','2021-07-16 01:53:31.855','2025-11-19 05:20:38.674',3),
('0c036393-cab7-4da9-91a1-f717476ef732','student46@example.com','student46','Lalita_Þórðardóttir','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+46&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.721','2022-12-23 23:56:34.284','2025-11-19 05:20:38.721',3),
('0c75567a-fb48-45db-9920-6954aed10d65','student10@example.com','student10','Yoko_Guzmán','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+10&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.676','2022-02-10 18:25:33.199','2025-11-19 05:20:38.677',3),
('115a7636-5d47-476b-b5f4-f45115141ef3','student17@example.com','student17','Usha.Árnadóttir14','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+17&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.685','2023-05-25 19:17:59.230','2025-11-19 05:20:38.686',3),
('14d7a70f-ba70-40ac-b198-7aa6df27688d','student44@example.com','student44','Francis_Mizrahi25','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+44&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.718','2022-11-26 13:47:00.757','2025-11-19 05:20:38.719',3),
('17bc3465-a808-4cb3-be5a-58d22495d2eb','student31@example.com','student31','Nicola.Yamaguchi6','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+31&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.702','2024-02-07 03:46:10.866','2025-11-19 05:20:38.703',3),
('23580dc8-86c2-4d8c-910f-7ac2580aa876','student38@example.com','student38','Andri_Björnsson46','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+38&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.711','2025-03-10 15:34:06.230','2025-11-19 05:20:38.712',3),
('2dc82389-dfc6-4418-9529-8d9cd7df0d1b','student25@example.com','student25','Joyce.Ólafsson','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+25&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.695','2021-12-18 17:40:51.430','2025-11-19 05:20:38.696',3),
('3594d869-911f-4d8c-b585-16b594c1d13c','student48@example.com','student48','Anah_Gutiérrez3','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+48&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.723','2022-03-05 23:21:07.673','2025-11-19 05:20:38.724',3),
('39875df8-c256-419e-a93a-5c205558289b','student45@example.com','student45','Suresh_Dahan99','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+45&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.719','2024-04-18 05:21:38.576','2025-11-19 05:20:38.720',3),
('3c9a04ca-396f-4d05-9684-22bcad14d070','student11@example.com','student11','Emma.Pospíšilová','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+11&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.677','2022-02-10 02:54:27.525','2025-11-19 05:20:38.678',3),
('42d5798a-a058-4250-b4bc-121a9cb6de88','student14@example.com','student14','Yong.Nakamura65','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+14&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.682','2022-10-24 06:37:23.937','2025-11-19 05:20:38.682',3),
('456701a9-0633-41d7-8363-ef6abf4e5fd1','student43@example.com','student43','Na_Óskarsdóttir94','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+43&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.717','2021-04-19 06:47:44.968','2025-11-19 05:20:38.718',3),
('553b8587-7fd7-4866-a334-3daa9a76d132','student9@example.com','student9','Emmanuel_Ota','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+9&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.675','2021-09-23 09:11:55.068','2025-11-19 05:20:38.675',3),
('55fea7f9-a38f-4cff-94e4-1c4916eeacff','student41@example.com','student41','Sunil_Gonzalez','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+41&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.715','2021-06-14 09:17:10.153','2025-11-19 05:20:38.715',3),
('577fc3d5-5bc2-4673-8264-c851a1e2b4d3','teacher3@example.com','teacher3','Thawi.Shimizu','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Teacher+3&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 05:20:38.660','2024-09-24 11:57:57.928','2025-11-19 05:20:38.661',2),
('57ef5231-fddb-4205-83ec-31a831308c95','student22@example.com','student22','Sombun_Smee33','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+22&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.691','2025-07-27 10:45:44.337','2025-11-19 05:20:38.692',3),
('5861ed5c-1e50-4575-8a72-62fec41220a6','student28@example.com','student28','Somchit_Isaac34','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+28&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.699','2021-10-15 01:04:10.309','2025-11-19 05:20:38.699',3),
('5c738ae3-2e40-4757-8b44-ce0d0a994d1e','student1@example.com','student1','Ying.Guðmundsson','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+1&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.663','2022-03-21 10:27:44.796','2025-11-19 05:20:38.664',3),
('66192dd5-3aa2-41da-bb6a-dba6670e3488','student26@example.com','student26','Berglind.Pawłowski26','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+26&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.696','2023-08-11 19:44:03.470','2025-11-19 05:20:38.697',3),
('67b1cae4-9de3-4e01-b464-65bc997a1e0d','student16@example.com','student16','Helmut_Llewellyn','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+16&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.684','2024-09-11 13:52:33.936','2025-11-19 05:20:38.685',3),
('6d6254a0-5a16-464c-8518-b1ec20a9d19b','student36@example.com','student36','Sawat.Zemanová38','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+36&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.709','2023-04-21 13:27:21.131','2025-11-19 05:20:38.709',3),
('6e17e2ef-a512-4b63-aea4-9245a6390dd3','student33@example.com','student33','Chen.Kozłowski68','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+33&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.705','2021-05-03 16:06:49.256','2025-11-19 05:20:38.705',3),
('7a5673c1-c5af-4b8d-98be-6731eb5f015f','student40@example.com','student40','Graham.Yaakv6','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+40&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.713','2024-03-07 18:09:33.467','2025-11-19 05:20:38.714',3),
('7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9','student37@example.com','student37','Sita.Gunnarsdóttir70','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+37&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.710','2022-01-01 02:22:23.170','2025-11-19 05:20:38.711',3),
('8491c4f0-9b84-4348-b17b-9935a31e11d0','student23@example.com','student23','Josefa_Pawłowski52','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+23&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.693','2021-09-05 15:12:14.268','2025-11-19 05:20:38.693',3),
('85877aeb-70be-4ce2-8594-6e315a2285dd','djamgt23@gmail.com','admin','Admin User','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Admin+User&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.653','2025-09-06 10:03:49.872','2025-11-19 05:20:38.655',1),
('8f8f2f36-6a5d-4a20-934f-1162be53b0f0','student13@example.com','student13','Jason.Duda','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+13&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.680','2023-03-07 13:45:37.035','2025-11-19 05:20:38.681',3),
('9045ce0b-2b05-4647-a105-099f7f1979ab','teacher2@example.com','teacher2','Nancy_Łukaszewski61','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Teacher+2&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 05:20:38.658','2023-03-16 01:19:17.210','2025-11-19 05:20:38.659',2),
('90b6d525-89b9-4167-9cde-595a8c8952e5','teacher4@example.com','teacher4','Sammy.Mahato2','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Teacher+4&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 05:20:38.661','2020-11-20 22:41:12.595','2025-11-19 05:20:38.662',2),
('91e1f827-76e8-4fca-bc36-bae4962fef08','student2@example.com','student2','Matt.Hayashi','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+2&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.664','2025-05-11 04:52:45.551','2025-11-19 05:20:38.665',3),
('93876f2a-e929-4fa8-9b71-f27141fe14a2','student39@example.com','student39','Xiaohong_Černý','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+39&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.712','2025-03-27 03:09:03.499','2025-11-19 05:20:38.713',3),
('9592eb0b-91fa-4344-9bbd-c12b63c0a2f4','student35@example.com','student35','Yhudah_Jabarin98','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+35&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.707','2021-12-24 18:23:35.919','2025-11-19 05:20:38.708',3),
('99e3e051-86a4-4499-beda-5b85b10c42fe','student19@example.com','student19','Dieter.Birgisson','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+19&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.688','2021-05-10 22:53:51.358','2025-11-19 05:20:38.689',3),
('aa7fd023-8103-45a9-b63e-989dda7d081d','student50@example.com','student50','Matt.Dominguez63','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+50&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.725','2023-11-01 02:39:30.693','2025-11-19 05:20:38.726',3),
('ae332c43-9429-46b0-b969-1f872910b92d','student4@example.com','student4','Matthew_Koech','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+4&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.667','2023-10-03 07:39:47.823','2025-11-19 05:20:38.668',3),
('afd4f6ef-1dd6-41c3-8b6b-a7cbba27e539','student30@example.com','student30','Sibusiso.James','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+30&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.701','2023-02-06 16:18:23.168','2025-11-19 05:20:38.702',3),
('b037562e-ca37-4821-a10d-2c0bf7445bb0','student18@example.com','student18','Rajesh_Kristjánsson','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+18&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.687','2021-03-15 02:28:27.337','2025-11-19 05:20:38.687',3),
('b22275f8-9b30-490a-be4c-477e1f6e46e4','student12@example.com','student12','Elke.Ochieng','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+12&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.679','2024-07-06 05:49:31.647','2025-11-19 05:20:38.679',3),
('b6702e96-f928-4b4b-b092-404be56072bd','student5@example.com','student5','Michal.Schmitz','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+5&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.669','2024-07-26 16:56:32.824','2025-11-19 05:20:38.669',3),
('ba288b62-82f4-45cb-9155-c02fc5d01f90','student21@example.com','student21','Ying.Muhammed84','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+21&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.690','2023-12-30 05:24:46.092','2025-11-19 05:20:38.691',3),
('bdcbaac3-5016-49b5-a0e9-41995c293aec','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=teachertestacc&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.727','2024-02-25 21:52:52.327','2025-11-19 05:20:38.728',2),
('c1d90d23-d74e-48d3-a124-47aee5230a7b','student15@example.com','student15','Andri.Žukauskas53','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+15&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.683','2025-01-16 15:43:12.305','2025-11-19 05:20:38.684',3),
('c5e9690d-4b55-41aa-800e-5e76efdf4430','student42@example.com','student42','Lijun_Vásquez95','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+42&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.716','2021-10-12 17:11:35.799','2025-11-19 05:20:38.717',3),
('c8ea060d-f421-4672-bc2c-7e6cb6dc99c5','student6@example.com','student6','Xiaohong.Göbel87','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+6&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.670','2025-09-16 14:38:35.144','2025-11-19 05:20:38.671',3),
('d24a64e5-63c6-434b-9aab-a4a5255e0417','student49@example.com','student49','Qing_Chebet','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+49&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.724','2024-03-08 03:17:33.067','2025-11-19 05:20:38.725',3),
('d7bfff1b-ec2c-4835-9447-1aba94aad3da','student7@example.com','student7','Lin.Pérez','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+7&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.671','2024-03-19 05:06:57.112','2025-11-19 05:20:38.672',3),
('dd9d68a3-439e-4d3c-899c-da0ce638c9ea','student24@example.com','student24','Sushila.Bowen','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+24&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.694','2024-01-22 10:10:49.446','2025-11-19 05:20:38.695',3),
('df3e7ec4-f81b-4cc6-8dec-7553f6273187','student47@example.com','student47','Sunday.Fialová47','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+47&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.722','2022-05-04 18:22:19.509','2025-11-19 05:20:38.723',3),
('eb2e202e-fc3e-4b97-940d-f4035e4aa925','student20@example.com','student20','Koichi_Krejčí','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+20&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.689','2023-07-15 23:32:24.908','2025-11-19 05:20:38.690',3),
('ec61138d-9e24-4800-9649-331a6b633e10','student34@example.com','student34','Eliyahu.Qiu','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+34&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.706','2022-01-04 22:14:06.823','2025-11-19 05:20:38.707',3),
('efdc5bd3-8a59-401f-ab6e-81ad5ee71b5d','student27@example.com','student27','Yasuo_Gunnarsdóttir','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+27&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.697','2021-11-11 18:07:00.043','2025-11-19 05:20:38.698',3),
('f7df51ec-6fe2-4c7d-abd2-397cb0f70f54','student29@example.com','student29','Masako_Pawłowski','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+29&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.700','2024-05-11 15:34:37.238','2025-11-19 05:20:38.700',3),
('f891f824-f1d1-4416-b788-8c091def31c4','teacher1@example.com','teacher1','Konstantin_David','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Teacher+1&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 05:20:38.656','2025-05-09 09:30:31.707','2025-11-19 05:20:38.657',2),
('ff2e91d5-c94e-4e5a-8d47-3e0d9f76f679','student32@example.com','student32','Thabo_Schouten','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+32&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.704','2023-05-05 23:21:34.615','2025-11-19 05:20:38.704',3),
('fff42303-4264-4da9-b560-25af88650154','student3@example.com','student3','Hui_López','$2b$10$NJz6.ayP7WicO4INN9BmG.ILbQxv8C0IEPNVhNd2Fo8hGfjYYaq6e','https://ui-avatars.com/api/?name=Student+3&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 05:20:38.666','2023-10-21 01:55:56.717','2025-11-19 05:20:38.667',3);
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
(1,'Teacher','f891f824-f1d1-4416-b788-8c091def31c4',1,'2025-11-19 05:20:38.765','2025-11-19 05:20:38.765'),
(2,'Student','fff42303-4264-4da9-b560-25af88650154',1,'2025-11-19 05:20:38.766','2025-11-19 05:20:38.766'),
(3,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',1,'2025-11-19 05:20:38.767','2025-11-19 05:20:38.767'),
(4,'Student','7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9',1,'2025-11-19 05:20:38.768','2025-11-19 05:20:38.768'),
(5,'Student','f7df51ec-6fe2-4c7d-abd2-397cb0f70f54',1,'2025-11-19 05:20:38.769','2025-11-19 05:20:38.769'),
(6,'Student','57ef5231-fddb-4205-83ec-31a831308c95',1,'2025-11-19 05:20:38.771','2025-11-19 05:20:38.771'),
(7,'Student','ba288b62-82f4-45cb-9155-c02fc5d01f90',1,'2025-11-19 05:20:38.772','2025-11-19 05:20:38.772'),
(8,'Student','c5e9690d-4b55-41aa-800e-5e76efdf4430',1,'2025-11-19 05:20:38.773','2025-11-19 05:20:38.773'),
(9,'Student','6e17e2ef-a512-4b63-aea4-9245a6390dd3',1,'2025-11-19 05:20:38.774','2025-11-19 05:20:38.774'),
(10,'Student','d24a64e5-63c6-434b-9aab-a4a5255e0417',1,'2025-11-19 05:20:38.775','2025-11-19 05:20:38.775'),
(11,'Student','67b1cae4-9de3-4e01-b464-65bc997a1e0d',1,'2025-11-19 05:20:38.776','2025-11-19 05:20:38.776'),
(12,'Teacher','f891f824-f1d1-4416-b788-8c091def31c4',2,'2025-11-19 05:20:38.778','2025-11-19 05:20:38.778'),
(13,'Student','2dc82389-dfc6-4418-9529-8d9cd7df0d1b',2,'2025-11-19 05:20:38.779','2025-11-19 05:20:38.779'),
(14,'Student','8491c4f0-9b84-4348-b17b-9935a31e11d0',2,'2025-11-19 05:20:38.780','2025-11-19 05:20:38.780'),
(15,'Student','c8ea060d-f421-4672-bc2c-7e6cb6dc99c5',2,'2025-11-19 05:20:38.781','2025-11-19 05:20:38.781'),
(16,'Student','67b1cae4-9de3-4e01-b464-65bc997a1e0d',2,'2025-11-19 05:20:38.782','2025-11-19 05:20:38.782'),
(17,'Student','d24a64e5-63c6-434b-9aab-a4a5255e0417',2,'2025-11-19 05:20:38.783','2025-11-19 05:20:38.783'),
(18,'Student','0c036393-cab7-4da9-91a1-f717476ef732',2,'2025-11-19 05:20:38.784','2025-11-19 05:20:38.784'),
(19,'Student','3c9a04ca-396f-4d05-9684-22bcad14d070',2,'2025-11-19 05:20:38.785','2025-11-19 05:20:38.785'),
(20,'Student','ae332c43-9429-46b0-b969-1f872910b92d',2,'2025-11-19 05:20:38.786','2025-11-19 05:20:38.786'),
(21,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',2,'2025-11-19 05:20:38.787','2025-11-19 05:20:38.787'),
(22,'Student','d7bfff1b-ec2c-4835-9447-1aba94aad3da',2,'2025-11-19 05:20:38.788','2025-11-19 05:20:38.788'),
(23,'Teacher','90b6d525-89b9-4167-9cde-595a8c8952e5',3,'2025-11-19 05:20:38.789','2025-11-19 05:20:38.789'),
(24,'Student','115a7636-5d47-476b-b5f4-f45115141ef3',3,'2025-11-19 05:20:38.790','2025-11-19 05:20:38.790'),
(25,'Student','91e1f827-76e8-4fca-bc36-bae4962fef08',3,'2025-11-19 05:20:38.791','2025-11-19 05:20:38.791'),
(26,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',3,'2025-11-19 05:20:38.792','2025-11-19 05:20:38.792'),
(27,'Student','8491c4f0-9b84-4348-b17b-9935a31e11d0',3,'2025-11-19 05:20:38.793','2025-11-19 05:20:38.793'),
(28,'Student','aa7fd023-8103-45a9-b63e-989dda7d081d',3,'2025-11-19 05:20:38.794','2025-11-19 05:20:38.794'),
(29,'Student','57ef5231-fddb-4205-83ec-31a831308c95',3,'2025-11-19 05:20:38.795','2025-11-19 05:20:38.795'),
(30,'Student','3c9a04ca-396f-4d05-9684-22bcad14d070',3,'2025-11-19 05:20:38.796','2025-11-19 05:20:38.796'),
(31,'Student','ec61138d-9e24-4800-9649-331a6b633e10',3,'2025-11-19 05:20:38.797','2025-11-19 05:20:38.797'),
(32,'Student','efdc5bd3-8a59-401f-ab6e-81ad5ee71b5d',3,'2025-11-19 05:20:38.798','2025-11-19 05:20:38.798'),
(33,'Student','c1d90d23-d74e-48d3-a124-47aee5230a7b',3,'2025-11-19 05:20:38.799','2025-11-19 05:20:38.799'),
(34,'Teacher','90b6d525-89b9-4167-9cde-595a8c8952e5',4,'2025-11-19 05:20:38.800','2025-11-19 05:20:38.800'),
(35,'Student','7a5673c1-c5af-4b8d-98be-6731eb5f015f',4,'2025-11-19 05:20:38.801','2025-11-19 05:20:38.801'),
(36,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',4,'2025-11-19 05:20:38.802','2025-11-19 05:20:38.802'),
(37,'Student','57ef5231-fddb-4205-83ec-31a831308c95',4,'2025-11-19 05:20:38.803','2025-11-19 05:20:38.803'),
(38,'Student','5c738ae3-2e40-4757-8b44-ce0d0a994d1e',4,'2025-11-19 05:20:38.804','2025-11-19 05:20:38.804'),
(39,'Student','0c036393-cab7-4da9-91a1-f717476ef732',4,'2025-11-19 05:20:38.805','2025-11-19 05:20:38.805'),
(40,'Student','df3e7ec4-f81b-4cc6-8dec-7553f6273187',4,'2025-11-19 05:20:38.806','2025-11-19 05:20:38.806'),
(41,'Student','efdc5bd3-8a59-401f-ab6e-81ad5ee71b5d',4,'2025-11-19 05:20:38.807','2025-11-19 05:20:38.807'),
(42,'Student','ff2e91d5-c94e-4e5a-8d47-3e0d9f76f679',4,'2025-11-19 05:20:38.808','2025-11-19 05:20:38.808'),
(43,'Student','7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9',4,'2025-11-19 05:20:38.809','2025-11-19 05:20:38.809'),
(44,'Student','c5e9690d-4b55-41aa-800e-5e76efdf4430',4,'2025-11-19 05:20:38.810','2025-11-19 05:20:38.810'),
(45,'Teacher','9045ce0b-2b05-4647-a105-099f7f1979ab',5,'2025-11-19 05:20:38.811','2025-11-19 05:20:38.811'),
(46,'Student','3c9a04ca-396f-4d05-9684-22bcad14d070',5,'2025-11-19 05:20:38.812','2025-11-19 05:20:38.812'),
(47,'Student','17bc3465-a808-4cb3-be5a-58d22495d2eb',5,'2025-11-19 05:20:38.813','2025-11-19 05:20:38.813'),
(48,'Student','2dc82389-dfc6-4418-9529-8d9cd7df0d1b',5,'2025-11-19 05:20:38.814','2025-11-19 05:20:38.814'),
(49,'Student','3594d869-911f-4d8c-b585-16b594c1d13c',5,'2025-11-19 05:20:38.815','2025-11-19 05:20:38.815'),
(50,'Student','7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9',5,'2025-11-19 05:20:38.816','2025-11-19 05:20:38.816'),
(51,'Student','5c738ae3-2e40-4757-8b44-ce0d0a994d1e',5,'2025-11-19 05:20:38.817','2025-11-19 05:20:38.817'),
(52,'Student','91e1f827-76e8-4fca-bc36-bae4962fef08',5,'2025-11-19 05:20:38.818','2025-11-19 05:20:38.818'),
(53,'Student','aa7fd023-8103-45a9-b63e-989dda7d081d',5,'2025-11-19 05:20:38.819','2025-11-19 05:20:38.819'),
(54,'Student','553b8587-7fd7-4866-a334-3daa9a76d132',5,'2025-11-19 05:20:38.820','2025-11-19 05:20:38.820'),
(55,'Student','d24a64e5-63c6-434b-9aab-a4a5255e0417',5,'2025-11-19 05:20:38.821','2025-11-19 05:20:38.821'),
(56,'Teacher','90b6d525-89b9-4167-9cde-595a8c8952e5',6,'2025-11-19 05:20:38.822','2025-11-19 05:20:38.822'),
(57,'Student','66192dd5-3aa2-41da-bb6a-dba6670e3488',6,'2025-11-19 05:20:38.823','2025-11-19 05:20:38.823'),
(58,'Student','3c9a04ca-396f-4d05-9684-22bcad14d070',6,'2025-11-19 05:20:38.824','2025-11-19 05:20:38.824'),
(59,'Student','ff2e91d5-c94e-4e5a-8d47-3e0d9f76f679',6,'2025-11-19 05:20:38.825','2025-11-19 05:20:38.825'),
(60,'Student','c5e9690d-4b55-41aa-800e-5e76efdf4430',6,'2025-11-19 05:20:38.826','2025-11-19 05:20:38.826'),
(61,'Student','b22275f8-9b30-490a-be4c-477e1f6e46e4',6,'2025-11-19 05:20:38.827','2025-11-19 05:20:38.827'),
(62,'Student','ba288b62-82f4-45cb-9155-c02fc5d01f90',6,'2025-11-19 05:20:38.828','2025-11-19 05:20:38.828'),
(63,'Student','39875df8-c256-419e-a93a-5c205558289b',6,'2025-11-19 05:20:38.829','2025-11-19 05:20:38.829'),
(64,'Student','aa7fd023-8103-45a9-b63e-989dda7d081d',6,'2025-11-19 05:20:38.830','2025-11-19 05:20:38.830'),
(65,'Student','b6702e96-f928-4b4b-b092-404be56072bd',6,'2025-11-19 05:20:38.831','2025-11-19 05:20:38.831'),
(66,'Student','d7bfff1b-ec2c-4835-9447-1aba94aad3da',6,'2025-11-19 05:20:38.832','2025-11-19 05:20:38.832'),
(67,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',7,'2025-11-19 05:20:38.833','2025-11-19 05:20:38.833'),
(68,'Student','55fea7f9-a38f-4cff-94e4-1c4916eeacff',7,'2025-11-19 05:20:38.834','2025-11-19 05:20:38.834'),
(69,'Student','91e1f827-76e8-4fca-bc36-bae4962fef08',7,'2025-11-19 05:20:38.835','2025-11-19 05:20:38.835'),
(70,'Student','14d7a70f-ba70-40ac-b198-7aa6df27688d',7,'2025-11-19 05:20:38.836','2025-11-19 05:20:38.836'),
(71,'Student','efdc5bd3-8a59-401f-ab6e-81ad5ee71b5d',7,'2025-11-19 05:20:38.837','2025-11-19 05:20:38.837'),
(72,'Student','5861ed5c-1e50-4575-8a72-62fec41220a6',7,'2025-11-19 05:20:38.838','2025-11-19 05:20:38.838'),
(73,'Student','f7df51ec-6fe2-4c7d-abd2-397cb0f70f54',7,'2025-11-19 05:20:38.839','2025-11-19 05:20:38.839'),
(74,'Student','d24a64e5-63c6-434b-9aab-a4a5255e0417',7,'2025-11-19 05:20:38.840','2025-11-19 05:20:38.840'),
(75,'Student','d7bfff1b-ec2c-4835-9447-1aba94aad3da',7,'2025-11-19 05:20:38.841','2025-11-19 05:20:38.841'),
(76,'Student','115a7636-5d47-476b-b5f4-f45115141ef3',7,'2025-11-19 05:20:38.841','2025-11-19 05:20:38.841'),
(77,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',7,'2025-11-19 05:20:38.842','2025-11-19 05:20:38.842'),
(78,'Teacher','90b6d525-89b9-4167-9cde-595a8c8952e5',8,'2025-11-19 05:20:38.843','2025-11-19 05:20:38.843'),
(79,'Student','3c9a04ca-396f-4d05-9684-22bcad14d070',8,'2025-11-19 05:20:38.844','2025-11-19 05:20:38.844'),
(80,'Student','67b1cae4-9de3-4e01-b464-65bc997a1e0d',8,'2025-11-19 05:20:38.845','2025-11-19 05:20:38.845'),
(81,'Student','42d5798a-a058-4250-b4bc-121a9cb6de88',8,'2025-11-19 05:20:38.846','2025-11-19 05:20:38.846'),
(82,'Student','553b8587-7fd7-4866-a334-3daa9a76d132',8,'2025-11-19 05:20:38.847','2025-11-19 05:20:38.847'),
(83,'Student','b22275f8-9b30-490a-be4c-477e1f6e46e4',8,'2025-11-19 05:20:38.848','2025-11-19 05:20:38.848'),
(84,'Student','d7bfff1b-ec2c-4835-9447-1aba94aad3da',8,'2025-11-19 05:20:38.849','2025-11-19 05:20:38.849'),
(85,'Student','ae332c43-9429-46b0-b969-1f872910b92d',8,'2025-11-19 05:20:38.850','2025-11-19 05:20:38.850'),
(86,'Student','eb2e202e-fc3e-4b97-940d-f4035e4aa925',8,'2025-11-19 05:20:38.851','2025-11-19 05:20:38.851'),
(87,'Student','f7df51ec-6fe2-4c7d-abd2-397cb0f70f54',8,'2025-11-19 05:20:38.852','2025-11-19 05:20:38.852'),
(88,'Student','14d7a70f-ba70-40ac-b198-7aa6df27688d',8,'2025-11-19 05:20:38.853','2025-11-19 05:20:38.853'),
(89,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',9,'2025-11-19 05:20:38.854','2025-11-19 05:20:38.854'),
(90,'Student','115a7636-5d47-476b-b5f4-f45115141ef3',9,'2025-11-19 05:20:38.855','2025-11-19 05:20:38.855'),
(91,'Student','9592eb0b-91fa-4344-9bbd-c12b63c0a2f4',9,'2025-11-19 05:20:38.856','2025-11-19 05:20:38.856'),
(92,'Student','ba288b62-82f4-45cb-9155-c02fc5d01f90',9,'2025-11-19 05:20:38.857','2025-11-19 05:20:38.857'),
(93,'Student','c1d90d23-d74e-48d3-a124-47aee5230a7b',9,'2025-11-19 05:20:38.858','2025-11-19 05:20:38.858'),
(94,'Student','3594d869-911f-4d8c-b585-16b594c1d13c',9,'2025-11-19 05:20:38.859','2025-11-19 05:20:38.859'),
(95,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',9,'2025-11-19 05:20:38.860','2025-11-19 05:20:38.860'),
(96,'Student','aa7fd023-8103-45a9-b63e-989dda7d081d',9,'2025-11-19 05:20:38.861','2025-11-19 05:20:38.861'),
(97,'Student','c5e9690d-4b55-41aa-800e-5e76efdf4430',9,'2025-11-19 05:20:38.862','2025-11-19 05:20:38.862'),
(98,'Student','553b8587-7fd7-4866-a334-3daa9a76d132',9,'2025-11-19 05:20:38.863','2025-11-19 05:20:38.863'),
(99,'Student','efdc5bd3-8a59-401f-ab6e-81ad5ee71b5d',9,'2025-11-19 05:20:38.864','2025-11-19 05:20:38.864'),
(100,'Teacher','577fc3d5-5bc2-4673-8264-c851a1e2b4d3',10,'2025-11-19 05:20:38.865','2025-11-19 05:20:38.865'),
(101,'Student','2dc82389-dfc6-4418-9529-8d9cd7df0d1b',10,'2025-11-19 05:20:38.866','2025-11-19 05:20:38.866'),
(102,'Student','7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9',10,'2025-11-19 05:20:38.867','2025-11-19 05:20:38.867'),
(103,'Student','ae332c43-9429-46b0-b969-1f872910b92d',10,'2025-11-19 05:20:38.868','2025-11-19 05:20:38.868'),
(104,'Student','456701a9-0633-41d7-8363-ef6abf4e5fd1',10,'2025-11-19 05:20:38.869','2025-11-19 05:20:38.869'),
(105,'Student','93876f2a-e929-4fa8-9b71-f27141fe14a2',10,'2025-11-19 05:20:38.870','2025-11-19 05:20:38.870'),
(106,'Student','afd4f6ef-1dd6-41c3-8b6b-a7cbba27e539',10,'2025-11-19 05:20:38.871','2025-11-19 05:20:38.871'),
(107,'Student','6d6254a0-5a16-464c-8518-b1ec20a9d19b',10,'2025-11-19 05:20:38.872','2025-11-19 05:20:38.872'),
(108,'Student','115a7636-5d47-476b-b5f4-f45115141ef3',10,'2025-11-19 05:20:38.873','2025-11-19 05:20:38.873'),
(109,'Student','8f8f2f36-6a5d-4a20-934f-1162be53b0f0',10,'2025-11-19 05:20:38.874','2025-11-19 05:20:38.874'),
(110,'Student','9592eb0b-91fa-4344-9bbd-c12b63c0a2f4',10,'2025-11-19 05:20:38.875','2025-11-19 05:20:38.875'),
(111,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',11,'2025-11-19 05:20:38.882','2025-11-19 05:20:38.882'),
(112,'Student','553b8587-7fd7-4866-a334-3daa9a76d132',11,'2025-11-19 05:20:38.883','2025-11-19 05:20:38.883'),
(113,'Student','66192dd5-3aa2-41da-bb6a-dba6670e3488',11,'2025-11-19 05:20:38.884','2025-11-19 05:20:38.884'),
(114,'Student','57ef5231-fddb-4205-83ec-31a831308c95',11,'2025-11-19 05:20:38.885','2025-11-19 05:20:38.885'),
(115,'Student','17bc3465-a808-4cb3-be5a-58d22495d2eb',11,'2025-11-19 05:20:38.885','2025-11-19 05:20:38.885'),
(116,'Student','c1d90d23-d74e-48d3-a124-47aee5230a7b',11,'2025-11-19 05:20:38.886','2025-11-19 05:20:38.886'),
(117,'Student','8f8f2f36-6a5d-4a20-934f-1162be53b0f0',11,'2025-11-19 05:20:38.888','2025-11-19 05:20:38.888'),
(118,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',11,'2025-11-19 05:20:38.889','2025-11-19 05:20:38.889'),
(119,'Student','0c036393-cab7-4da9-91a1-f717476ef732',11,'2025-11-19 05:20:38.890','2025-11-19 05:20:38.890'),
(120,'Student','42d5798a-a058-4250-b4bc-121a9cb6de88',11,'2025-11-19 05:20:38.891','2025-11-19 05:20:38.891'),
(121,'Student','456701a9-0633-41d7-8363-ef6abf4e5fd1',11,'2025-11-19 05:20:38.892','2025-11-19 05:20:38.892'),
(122,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',12,'2025-11-19 05:20:38.893','2025-11-19 05:20:38.893'),
(123,'Student','0c036393-cab7-4da9-91a1-f717476ef732',12,'2025-11-19 05:20:38.894','2025-11-19 05:20:38.894'),
(124,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',12,'2025-11-19 05:20:38.895','2025-11-19 05:20:38.895'),
(125,'Student','67b1cae4-9de3-4e01-b464-65bc997a1e0d',12,'2025-11-19 05:20:38.896','2025-11-19 05:20:38.896'),
(126,'Student','c1d90d23-d74e-48d3-a124-47aee5230a7b',12,'2025-11-19 05:20:38.897','2025-11-19 05:20:38.897'),
(127,'Student','553b8587-7fd7-4866-a334-3daa9a76d132',12,'2025-11-19 05:20:38.898','2025-11-19 05:20:38.898'),
(128,'Student','dd9d68a3-439e-4d3c-899c-da0ce638c9ea',12,'2025-11-19 05:20:38.899','2025-11-19 05:20:38.899'),
(129,'Student','b037562e-ca37-4821-a10d-2c0bf7445bb0',12,'2025-11-19 05:20:38.900','2025-11-19 05:20:38.900'),
(130,'Student','afd4f6ef-1dd6-41c3-8b6b-a7cbba27e539',12,'2025-11-19 05:20:38.900','2025-11-19 05:20:38.900'),
(131,'Student','5c738ae3-2e40-4757-8b44-ce0d0a994d1e',12,'2025-11-19 05:20:38.901','2025-11-19 05:20:38.901'),
(132,'Student','b22275f8-9b30-490a-be4c-477e1f6e46e4',12,'2025-11-19 05:20:38.903','2025-11-19 05:20:38.903'),
(133,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',13,'2025-11-19 05:20:38.903','2025-11-19 05:20:38.903'),
(134,'Student','7d5cdd19-780e-4cb7-a87f-5b285e2ac1e9',13,'2025-11-19 05:20:38.904','2025-11-19 05:20:38.904'),
(135,'Student','ec61138d-9e24-4800-9649-331a6b633e10',13,'2025-11-19 05:20:38.905','2025-11-19 05:20:38.905'),
(136,'Student','fff42303-4264-4da9-b560-25af88650154',13,'2025-11-19 05:20:38.906','2025-11-19 05:20:38.906'),
(137,'Student','456701a9-0633-41d7-8363-ef6abf4e5fd1',13,'2025-11-19 05:20:38.907','2025-11-19 05:20:38.907'),
(138,'Student','0c036393-cab7-4da9-91a1-f717476ef732',13,'2025-11-19 05:20:38.908','2025-11-19 05:20:38.908'),
(139,'Student','c5e9690d-4b55-41aa-800e-5e76efdf4430',13,'2025-11-19 05:20:38.909','2025-11-19 05:20:38.909'),
(140,'Student','8491c4f0-9b84-4348-b17b-9935a31e11d0',13,'2025-11-19 05:20:38.910','2025-11-19 05:20:38.910'),
(141,'Student','0271e947-2bc2-49e3-990c-972e23e2839f',13,'2025-11-19 05:20:38.911','2025-11-19 05:20:38.911'),
(142,'Student','39875df8-c256-419e-a93a-5c205558289b',13,'2025-11-19 05:20:38.912','2025-11-19 05:20:38.912'),
(143,'Student','2dc82389-dfc6-4418-9529-8d9cd7df0d1b',13,'2025-11-19 05:20:38.913','2025-11-19 05:20:38.913'),
(144,'Teacher','bdcbaac3-5016-49b5-a0e9-41995c293aec',14,'2025-11-19 05:20:38.914','2025-11-19 05:20:38.914'),
(145,'Student','c8ea060d-f421-4672-bc2c-7e6cb6dc99c5',14,'2025-11-19 05:20:38.915','2025-11-19 05:20:38.915'),
(146,'Student','115a7636-5d47-476b-b5f4-f45115141ef3',14,'2025-11-19 05:20:38.917','2025-11-19 05:20:38.917'),
(147,'Student','ec61138d-9e24-4800-9649-331a6b633e10',14,'2025-11-19 05:20:38.918','2025-11-19 05:20:38.918'),
(148,'Student','b6702e96-f928-4b4b-b092-404be56072bd',14,'2025-11-19 05:20:38.919','2025-11-19 05:20:38.919'),
(149,'Student','66192dd5-3aa2-41da-bb6a-dba6670e3488',14,'2025-11-19 05:20:38.919','2025-11-19 05:20:38.919'),
(150,'Student','afd4f6ef-1dd6-41c3-8b6b-a7cbba27e539',14,'2025-11-19 05:20:38.920','2025-11-19 05:20:38.920'),
(151,'Student','d7bfff1b-ec2c-4835-9447-1aba94aad3da',14,'2025-11-19 05:20:38.921','2025-11-19 05:20:38.921'),
(152,'Student','57ef5231-fddb-4205-83ec-31a831308c95',14,'2025-11-19 05:20:38.922','2025-11-19 05:20:38.922'),
(153,'Student','42d5798a-a058-4250-b4bc-121a9cb6de88',14,'2025-11-19 05:20:38.923','2025-11-19 05:20:38.923'),
(154,'Student','dd9d68a3-439e-4d3c-899c-da0ce638c9ea',14,'2025-11-19 05:20:38.924','2025-11-19 05:20:38.924');
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
('0aec0b95-8a7e-4d1d-aabc-0b323dcd6f2b','5d535f395498abb562d62c3d16a60924963a26c3c065d32a7a5e1f066075fcb1','2025-11-19 05:20:35.733','20251112144809_init',NULL,NULL,'2025-11-19 05:20:35.399',1),
('2b0c0604-45b9-4a91-b85e-860cf33991c8','bde564d470fab41c136f8a2dc30030d38d8c0d5e42255b3cae1c4f9ee617b761','2025-11-19 05:20:35.794','20251116040034_init',NULL,NULL,'2025-11-19 05:20:35.753',1),
('56bf9f16-a8f5-4c23-97d9-13c95e96845b','852a4e2c166c689df64fa4b1e82bf527de22bffa0e6ace5b8e479414c9ec21aa','2025-11-19 05:20:35.817','20251116055534_update_quiz_material_relation_remove_time',NULL,NULL,'2025-11-19 05:20:35.794',1),
('9b8a620a-4dd3-4819-b1d1-83df55d5645c','fa3516f81a29e403ca89eb0070f5b30e4a3152ff883a8bcff53ca3de09b31936','2025-11-19 05:20:35.823','20251119020719_add_explanation_to_quiz_question',NULL,NULL,'2025-11-19 05:20:35.818',1),
('afced5b4-da7d-45fb-a6e2-b254d883392f','330c558dd59e57f5be2e0b739af7e167005897877a1e9b870d17154fc31ad60e','2025-11-19 05:20:35.752','20251115092106_remove_subscription_plan',NULL,NULL,'2025-11-19 05:20:35.734',1),
('fbb73642-4adf-429e-932e-bbbcc6edee97','dd880ed9473fac179e200018e3be5ebfc5e494f876cafc92f1384b874b1dc398','2025-11-19 05:20:35.830','20251119050010_add_is_approved_to_review',NULL,NULL,'2025-11-19 05:20:35.824',1);
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
(1,'Essay',0,'2025-11-19 05:20:38.730','2025-11-19 05:20:38.730'),
(2,'Business Plan',0,'2025-11-19 05:20:38.730','2025-11-19 05:20:38.730'),
(3,'Penelitian',0,'2025-11-19 05:20:38.730','2025-11-19 05:20:38.730'),
(4,'Desain',0,'2025-11-19 05:20:38.730','2025-11-19 05:20:38.730');
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

-- Dump completed on 2025-11-19 12:29:48

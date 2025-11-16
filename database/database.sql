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
(1,1,'unde','sunt et et fugit possimus quae fugiat est error necessitatibus voluptatibus omnis dicta quaerat voluptatibus repellat in esse fugiat quia nihil id sit magnam consectetur rerum esse quasi fugiat omnis','files/public/placeholder.png','2025-11-16 06:51:17.425','2025-11-16 06:51:17.425'),
(2,1,'neque','quae necessitatibus rerum nostrum commodi vitae quasi quia blanditiis tenetur fugiat deserunt quos possimus exercitationem cupiditate cupiditate quae error nihil at sit nihil excepturi fugit sapiente asperiores beatae sunt nihil','files/public/placeholder.png','2025-11-16 06:51:17.426','2025-11-16 06:51:17.426'),
(3,1,'sunt','neque ducimus quia quia occaecati sed nulla nulla neque consequuntur voluptatem beatae nostrum quaerat nulla fugit ullam ullam facilis deserunt omnis possimus neque sit quae necessitatibus aliquid numquam rerum reiciendis','files/public/placeholder.png','2025-11-16 06:51:17.428','2025-11-16 06:51:17.428'),
(4,1,'commodi','fugit quae aut consequuntur eos sapiente laborum occaecati nulla aliquid voluptatibus deserunt consequatur necessitatibus cupiditate non consectetur rerum facilis dolores voluptate numquam sed repellat labore quas maiores error error nemo','files/public/placeholder.png','2025-11-16 06:51:17.429','2025-11-16 06:51:17.429'),
(5,1,'repellat','sunt voluptatem neque commodi labore sequi possimus sequi nihil at repellat reiciendis et sed esse necessitatibus quasi tenetur fugiat non quasi consequuntur labore sit in enim unde eos quae quos','files/public/placeholder.png','2025-11-16 06:51:17.430','2025-11-16 06:51:17.430'),
(6,1,'possimus','qui quaerat labore quae aliquid dicta possimus doloribus omnis ducimus hic voluptate enim qui neque labore blanditiis exercitationem enim blanditiis in ipsum laborum sapiente eos labore nostrum voluptate repellat dolores','files/public/placeholder.png','2025-11-16 06:51:17.431','2025-11-16 06:51:17.431'),
(7,1,'id','esse quae at quos sequi omnis dicta exercitationem non neque sunt non omnis voluptate sapiente numquam quas numquam fugit blanditiis necessitatibus at nulla occaecati consequuntur quae eos excepturi dicta at','files/public/placeholder.png','2025-11-16 06:51:17.432','2025-11-16 06:51:17.432'),
(8,1,'non','commodi voluptatibus asperiores nihil dicta asperiores sed aliquid ducimus hic consequatur asperiores quia fugiat at dicta hic unde maiores dicta quasi id quas numquam hic nemo quasi ipsum rerum excepturi','files/public/placeholder.png','2025-11-16 06:51:17.433','2025-11-16 06:51:17.433'),
(9,1,'qui','maiores enim reiciendis dicta aut fugiat esse quasi neque quia sunt vitae blanditiis at ullam possimus quos id magnam aut blanditiis tenetur quos excepturi occaecati quasi asperiores sunt quia sed','files/public/placeholder.png','2025-11-16 06:51:17.434','2025-11-16 06:51:17.434'),
(10,1,'tenetur','id et consequuntur tenetur in necessitatibus excepturi labore maiores vitae consequuntur neque ullam eos numquam non in dolores in consequuntur voluptatem quaerat occaecati enim necessitatibus dicta sit omnis fugiat magnam','files/public/placeholder.png','2025-11-16 06:51:17.435','2025-11-16 06:51:17.435'),
(11,2,'PPK','dolores enim ipsum error maiores fugiat esse consequuntur quaerat fugit ducimus neque numquam deserunt doloribus voluptatem in quos exercitationem commodi commodi quaerat sed magnam voluptate ipsum sit nostrum neque enim','files/public/placeholder.png','2025-11-16 06:51:17.557','2025-11-16 06:51:17.557'),
(12,3,'Pancasila','vel et blanditiis sapiente vel id labore reiciendis consequuntur fugit neque quos quae facilis aliquid vitae nostrum voluptate doloribus quasi nulla facilis facilis quasi sequi nihil consectetur sunt voluptatem labore','files/public/placeholder.png','2025-11-16 06:51:17.558','2025-11-16 06:51:17.558'),
(13,3,'Agama','exercitationem repellat sunt quaerat maiores ducimus sapiente beatae id rerum unde beatae voluptate labore fugit maiores est dicta cupiditate sit sequi tenetur ipsum possimus deserunt tenetur enim aut ipsum sapiente','files/public/placeholder.png','2025-11-16 06:51:17.559','2025-11-16 06:51:17.559'),
(14,2,'Bahasa Indonesia','sunt quia non quas quasi reiciendis quasi reiciendis nulla dolores vel sunt facilis numquam ipsum et possimus dicta unde nihil et quas nulla nihil repellat consequatur in labore aliquid vel','files/public/placeholder.png','2025-11-16 06:51:17.560','2025-11-16 06:51:17.560');
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
(1,'Admin','2025-11-16 06:51:17.266','2025-11-16 06:51:17.266'),
(2,'Teacher','2025-11-16 06:51:17.266','2025-11-16 06:51:17.266'),
(3,'Student','2025-11-16 06:51:17.266','2025-11-16 06:51:17.266');
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
('0b10545f-a795-4576-a412-343f77b37676','student22@example.com','student22','Jianhua.Magnúsdóttir41','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+22&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.383','2024-12-05 17:17:56.600','2025-11-16 06:51:17.384',3),
('0c997c35-8008-4196-b3b0-cebc871bbcf8','student40@example.com','student40','Elizabeth_Ðorðić86','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+40&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.406','2024-05-17 14:10:21.704','2025-11-16 06:51:17.407',3),
('0ceda10c-7d57-462c-a0c8-1fbd343ca2d5','student47@example.com','student47','Lan.Ríos50','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+47&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.415','2020-12-16 03:34:07.296','2025-11-16 06:51:17.416',3),
('11ac7168-27cf-43c4-8ce0-b4d7f978150f','student23@example.com','student23','Noam_Price','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+23&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.384','2025-10-06 23:16:37.869','2025-11-16 06:51:17.385',3),
('1241826e-a8d5-4305-8559-42e37de6057d','student13@example.com','student13','Gary_Mofokeng','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+13&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.371','2022-04-30 00:34:42.245','2025-11-16 06:51:17.372',3),
('12663332-7596-43ea-b468-4b80e81620c8','student24@example.com','student24','Ning_Groß','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+24&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.385','2025-08-02 01:13:11.722','2025-11-16 06:51:17.386',3),
('1452bbc7-a141-472d-81e5-8fa967aeaef2','student39@example.com','student39','Li_Begam58','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+39&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.405','2025-09-20 12:42:34.959','2025-11-16 06:51:17.406',3),
('150eba20-e901-46d8-90ee-944cb1a4ddae','student26@example.com','student26','Aleksandr_Amadi93','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+26&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.388','2021-02-03 08:28:33.572','2025-11-16 06:51:17.389',3),
('1b1b1c37-0ac0-4f01-8f38-1e04bec4db7a','student45@example.com','student45','Koji_Gísladóttir','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+45&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.413','2021-08-04 23:38:15.561','2025-11-16 06:51:17.413',3),
('23ba062b-551f-4c29-bd1d-c4eeb1941139','student46@example.com','student46','Yael.Gao','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+46&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.414','2024-06-28 20:15:14.628','2025-11-16 06:51:17.415',3),
('27cbea38-f69c-4a9f-b3ea-de06df237d66','student6@example.com','student6','Thawi_Pospíšil','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+6&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.347','2024-04-14 02:44:16.116','2025-11-16 06:51:17.348',3),
('33950119-b616-4e52-85f6-13af993562ac','student29@example.com','student29','Cheng.Pokorná65','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+29&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.391','2023-02-25 01:22:51.031','2025-11-16 06:51:17.392',3),
('446844b1-dabb-4ce4-ac40-113eecc80ca7','student17@example.com','student17','Lihua_Sigurðardóttir82','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+17&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.377','2022-09-18 23:07:23.035','2025-11-16 06:51:17.378',3),
('484c6775-8caf-42c7-bf66-f274e8aa2435','student11@example.com','student11','Raju.Einarsdóttir90','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+11&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.353','2024-12-18 17:50:27.592','2025-11-16 06:51:17.353',3),
('4bba387d-d710-47c4-8dc8-dff9cb69e242','teacher1@example.com','teacher1','Jianguo_Köhler','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Teacher+1&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-16 06:51:17.334','2025-10-28 15:40:38.685','2025-11-16 06:51:17.335',2),
('5cc0daa0-0176-4b42-a013-27f8f6ad81b3','student2@example.com','student2','Ming.Őllösová38','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+2&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.342','2025-10-31 02:53:40.514','2025-11-16 06:51:17.343',3),
('5daa0172-5f1e-4125-bc47-79a947bf7b83','student18@example.com','student18','Elizabeth.López','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+18&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.378','2024-08-25 02:35:54.776','2025-11-16 06:51:17.379',3),
('64a9a17b-0a49-45ba-902b-0d9605726f8c','student7@example.com','student7','Rajesh.Jiménez','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+7&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.348','2025-02-14 20:15:59.716','2025-11-16 06:51:17.349',3),
('667a823a-b0a4-4895-aff9-419bfd2320a9','student50@example.com','student50','Lucy.Þórðarson19','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+50&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.419','2024-05-18 08:42:49.150','2025-11-16 06:51:17.419',3),
('6e38a602-35ac-45a5-9cd8-6edb16aca169','student44@example.com','student44','Yosef.Szewczyk','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+44&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.412','2021-05-06 09:40:21.671','2025-11-16 06:51:17.412',3),
('7016f05c-b862-41aa-8fe8-646c96e1a7bd','student32@example.com','student32','Li_Marek','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+32&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.395','2022-03-12 00:23:58.135','2025-11-16 06:51:17.396',3),
('720d7a5b-cfc3-4e21-b324-63f015e24231','student8@example.com','student8','Jianping_Ahmad3','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+8&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.349','2021-02-09 11:01:55.561','2025-11-16 06:51:17.350',3),
('7849a656-411d-4f73-b662-fa207344b2d2','student48@example.com','student48','Renate_Őrségi-Zölderdő34','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+48&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.416','2021-12-10 03:18:58.422','2025-11-16 06:51:17.417',3),
('7aa21340-826d-40c5-a2a1-fea13699ce04','student4@example.com','student4','Cheng_Van-den-Berg80','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+4&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.344','2025-05-12 04:09:17.930','2025-11-16 06:51:17.345',3),
('7d4fe457-7ec6-4167-89c9-936af53684d8','teacher4@example.com','teacher4','Emiko_Adri','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Teacher+4&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-16 06:51:17.339','2022-03-09 18:55:13.200','2025-11-16 06:51:17.340',2),
('7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc','student41@example.com','student41','Ann.Magnússon33','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+41&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.408','2023-10-12 02:48:40.867','2025-11-16 06:51:17.408',3),
('81e01f21-ac54-490e-8000-d839a5a141ad','student19@example.com','student19','Anan_Robinson1','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+19&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.379','2025-10-19 18:13:30.791','2025-11-16 06:51:17.380',3),
('8b2cacd3-a43c-4e7b-b6ff-079e6c9e213d','djamgt23@gmail.com','admin','Admin User','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Admin+User&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.329','2025-01-17 13:28:12.908','2025-11-16 06:51:17.331',1),
('8e2dffcf-586b-4936-a5d4-7d5fc8c26efa','student49@example.com','student49','Masao.Óskarsson','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+49&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.418','2023-09-07 14:11:20.436','2025-11-16 06:51:17.418',3),
('8e79d714-28d3-4624-9510-b748373f5e9b','student21@example.com','student21','Bin_Shehu','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+21&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.382','2022-02-13 00:51:38.188','2025-11-16 06:51:17.383',3),
('91b981ba-3038-460f-b354-f5c62ab41ecc','teacher2@example.com','teacher2','Asha.Sanz65','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Teacher+2&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-16 06:51:17.336','2025-09-07 18:02:48.878','2025-11-16 06:51:17.337',2),
('989202b3-86c5-4402-b056-cd410b64234c','student15@example.com','student15','Anong_Álvarez','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+15&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.375','2023-07-12 17:58:03.964','2025-11-16 06:51:17.376',3),
('9a4a484a-de92-416d-b00e-775d85ea9844','student25@example.com','student25','Toshio_Árnadóttir11','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+25&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.387','2022-07-12 12:25:30.925','2025-11-16 06:51:17.387',3),
('a4f7c148-dacc-4928-8cfa-abe6baeb08a4','student1@example.com','student1','Jianguo.Ūsas31','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+1&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.341','2021-03-08 03:21:48.226','2025-11-16 06:51:17.341',3),
('ae8d2693-cd0b-4783-954d-7497b4dc2c9d','student16@example.com','student16','Wolfgang_Suarez','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+16&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.376','2025-06-10 12:50:21.740','2025-11-16 06:51:17.377',3),
('b58f6d8c-aef9-4245-8069-5203628b6b2f','student42@example.com','student42','Dieter_Olszewski','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+42&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.409','2025-11-11 15:58:26.882','2025-11-16 06:51:17.410',3),
('ba223ced-9ae1-46bc-934a-36651bb86838','student37@example.com','student37','Ping.Einarsdóttir2','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+37&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.402','2025-06-26 09:57:29.538','2025-11-16 06:51:17.403',3),
('bdc8cea1-6424-4a4a-8be2-0935ff36fbd7','student20@example.com','student20','Radha.Botha','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+20&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.381','2022-09-28 15:19:53.718','2025-11-16 06:51:17.381',3),
('be1e9650-d81d-425d-9de5-9d0debd27499','student31@example.com','student31','Somkhit_Murakami64','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+31&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.394','2021-05-16 15:58:11.078','2025-11-16 06:51:17.394',3),
('bf9cfbfc-743e-45f9-bc4b-0d6a992679bc','student9@example.com','student9','Zhen_Bjarnason20','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+9&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.350','2021-04-28 17:47:09.130','2025-11-16 06:51:17.351',3),
('c2fbd307-40d4-4b57-8def-aa67cc978843','student10@example.com','student10','Wichai.Maas','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+10&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.351','2021-06-20 00:37:22.020','2025-11-16 06:51:17.352',3),
('c87ee46e-3dcb-4cb3-b571-209b4aaa3d5a','student3@example.com','student3','Abubakar_Isa13','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+3&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.343','2024-03-01 08:20:44.390','2025-11-16 06:51:17.344',3),
('cbb70acc-8765-4ac5-80a6-e4d2ac5aa2dc','student34@example.com','student34','Shankar.Nowak1','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+34&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.398','2022-05-21 12:50:53.644','2025-11-16 06:51:17.398',3),
('cbc7277c-b496-4524-ad87-a27c0c1cc794','student27@example.com','student27','Jean_Halldórsson50','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+27&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.389','2021-06-18 17:56:55.869','2025-11-16 06:51:17.390',3),
('cd5b7194-c20e-43e0-b88e-d2e0f93e6344','student5@example.com','student5','Miyoko_Núñez','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+5&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.346','2024-04-17 08:53:01.152','2025-11-16 06:51:17.346',3),
('d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=teachertestacc&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.420','2022-03-05 00:45:43.581','2025-11-16 06:51:17.421',2),
('d1d4ec67-9bbf-4d19-8ef3-42f0a408b53a','student12@example.com','student12','Jerzy.Jónsson55','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+12&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.354','2023-05-13 02:47:17.336','2025-11-16 06:51:17.355',3),
('dd1caca5-166c-46de-9a55-97a021811e91','student43@example.com','student43','Helgi_Pawłowski2','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+43&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.410','2025-07-08 18:39:09.440','2025-11-16 06:51:17.411',3),
('de24693d-1725-4826-af1f-3512feeda254','student28@example.com','student28','Elizabeth_Hájek','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+28&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.390','2022-08-13 11:48:53.140','2025-11-16 06:51:17.391',3),
('e43aca7a-2ef9-4cf7-a98f-e25be76be9b7','student36@example.com','student36','Bongani_Chen','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+36&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.401','2022-11-10 07:15:26.778','2025-11-16 06:51:17.402',3),
('e4c17e4c-a5d4-4cdc-ba9d-192e162faa27','student33@example.com','student33','Michael_Álvarez','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+33&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.397','2024-06-15 12:24:13.822','2025-11-16 06:51:17.397',3),
('e6dcb863-6b23-45a9-938a-bf94b4081c0d','student14@example.com','student14','Michal.Adan','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+14&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.373','2024-01-10 17:45:06.375','2025-11-16 06:51:17.374',3),
('e946e725-0f92-40dd-9114-2f350bd43417','student35@example.com','student35','Victor.Žáková52','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+35&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.399','2021-11-17 16:44:34.726','2025-11-16 06:51:17.400',3),
('f6ba9c5d-19f7-413f-aec3-0fdc0d30bd3f','student38@example.com','student38','Sabine_Harle-Cowan','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+38&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.404','2021-04-24 23:38:30.250','2025-11-16 06:51:17.405',3),
('f7968341-ad86-4ec8-b814-bdae92e1105c','teacher3@example.com','teacher3','Mark.Stefánsdóttir','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Teacher+3&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-16 06:51:17.338','2024-08-05 18:30:20.031','2025-11-16 06:51:17.339',2),
('fb6ca352-3fbe-44b9-95dc-1a9e0f654240','student30@example.com','student30','Mateusz_Jónsson','$2b$10$GISAvTWVpJmVTFp6G9vOAOyU.yb6Gmbpe6AbcbH6c/8NrLJphr/52','https://ui-avatars.com/api/?name=Student+30&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-16 06:51:17.392','2022-11-09 12:48:02.826','2025-11-16 06:51:17.393',3);
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
(1,'Teacher','4bba387d-d710-47c4-8dc8-dff9cb69e242',1,'2025-11-16 06:51:17.440','2025-11-16 06:51:17.440'),
(2,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',1,'2025-11-16 06:51:17.441','2025-11-16 06:51:17.441'),
(3,'Student','150eba20-e901-46d8-90ee-944cb1a4ddae',1,'2025-11-16 06:51:17.443','2025-11-16 06:51:17.443'),
(4,'Student','1b1b1c37-0ac0-4f01-8f38-1e04bec4db7a',1,'2025-11-16 06:51:17.444','2025-11-16 06:51:17.444'),
(5,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',1,'2025-11-16 06:51:17.445','2025-11-16 06:51:17.445'),
(6,'Student','27cbea38-f69c-4a9f-b3ea-de06df237d66',1,'2025-11-16 06:51:17.446','2025-11-16 06:51:17.446'),
(7,'Student','989202b3-86c5-4402-b056-cd410b64234c',1,'2025-11-16 06:51:17.447','2025-11-16 06:51:17.447'),
(8,'Student','ae8d2693-cd0b-4783-954d-7497b4dc2c9d',1,'2025-11-16 06:51:17.448','2025-11-16 06:51:17.448'),
(9,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',1,'2025-11-16 06:51:17.449','2025-11-16 06:51:17.449'),
(10,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',1,'2025-11-16 06:51:17.450','2025-11-16 06:51:17.450'),
(11,'Student','d1d4ec67-9bbf-4d19-8ef3-42f0a408b53a',1,'2025-11-16 06:51:17.451','2025-11-16 06:51:17.451'),
(12,'Teacher','f7968341-ad86-4ec8-b814-bdae92e1105c',2,'2025-11-16 06:51:17.452','2025-11-16 06:51:17.452'),
(13,'Student','c87ee46e-3dcb-4cb3-b571-209b4aaa3d5a',2,'2025-11-16 06:51:17.453','2025-11-16 06:51:17.453'),
(14,'Student','ae8d2693-cd0b-4783-954d-7497b4dc2c9d',2,'2025-11-16 06:51:17.454','2025-11-16 06:51:17.454'),
(15,'Student','8e79d714-28d3-4624-9510-b748373f5e9b',2,'2025-11-16 06:51:17.454','2025-11-16 06:51:17.454'),
(16,'Student','cd5b7194-c20e-43e0-b88e-d2e0f93e6344',2,'2025-11-16 06:51:17.455','2025-11-16 06:51:17.455'),
(17,'Student','bdc8cea1-6424-4a4a-8be2-0935ff36fbd7',2,'2025-11-16 06:51:17.456','2025-11-16 06:51:17.456'),
(18,'Student','8e2dffcf-586b-4936-a5d4-7d5fc8c26efa',2,'2025-11-16 06:51:17.457','2025-11-16 06:51:17.457'),
(19,'Student','be1e9650-d81d-425d-9de5-9d0debd27499',2,'2025-11-16 06:51:17.458','2025-11-16 06:51:17.458'),
(20,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',2,'2025-11-16 06:51:17.459','2025-11-16 06:51:17.459'),
(21,'Student','64a9a17b-0a49-45ba-902b-0d9605726f8c',2,'2025-11-16 06:51:17.460','2025-11-16 06:51:17.460'),
(22,'Student','5cc0daa0-0176-4b42-a013-27f8f6ad81b3',2,'2025-11-16 06:51:17.461','2025-11-16 06:51:17.461'),
(23,'Teacher','f7968341-ad86-4ec8-b814-bdae92e1105c',3,'2025-11-16 06:51:17.462','2025-11-16 06:51:17.462'),
(24,'Student','bf9cfbfc-743e-45f9-bc4b-0d6a992679bc',3,'2025-11-16 06:51:17.463','2025-11-16 06:51:17.463'),
(25,'Student','de24693d-1725-4826-af1f-3512feeda254',3,'2025-11-16 06:51:17.463','2025-11-16 06:51:17.463'),
(26,'Student','0b10545f-a795-4576-a412-343f77b37676',3,'2025-11-16 06:51:17.464','2025-11-16 06:51:17.464'),
(27,'Student','0c997c35-8008-4196-b3b0-cebc871bbcf8',3,'2025-11-16 06:51:17.465','2025-11-16 06:51:17.465'),
(28,'Student','e4c17e4c-a5d4-4cdc-ba9d-192e162faa27',3,'2025-11-16 06:51:17.466','2025-11-16 06:51:17.466'),
(29,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',3,'2025-11-16 06:51:17.467','2025-11-16 06:51:17.467'),
(30,'Student','fb6ca352-3fbe-44b9-95dc-1a9e0f654240',3,'2025-11-16 06:51:17.468','2025-11-16 06:51:17.468'),
(31,'Student','9a4a484a-de92-416d-b00e-775d85ea9844',3,'2025-11-16 06:51:17.469','2025-11-16 06:51:17.469'),
(32,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',3,'2025-11-16 06:51:17.470','2025-11-16 06:51:17.470'),
(33,'Student','0ceda10c-7d57-462c-a0c8-1fbd343ca2d5',3,'2025-11-16 06:51:17.471','2025-11-16 06:51:17.471'),
(34,'Teacher','4bba387d-d710-47c4-8dc8-dff9cb69e242',4,'2025-11-16 06:51:17.472','2025-11-16 06:51:17.472'),
(35,'Student','1241826e-a8d5-4305-8559-42e37de6057d',4,'2025-11-16 06:51:17.472','2025-11-16 06:51:17.472'),
(36,'Student','5daa0172-5f1e-4125-bc47-79a947bf7b83',4,'2025-11-16 06:51:17.473','2025-11-16 06:51:17.473'),
(37,'Student','989202b3-86c5-4402-b056-cd410b64234c',4,'2025-11-16 06:51:17.474','2025-11-16 06:51:17.474'),
(38,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',4,'2025-11-16 06:51:17.475','2025-11-16 06:51:17.475'),
(39,'Student','bf9cfbfc-743e-45f9-bc4b-0d6a992679bc',4,'2025-11-16 06:51:17.476','2025-11-16 06:51:17.476'),
(40,'Student','5cc0daa0-0176-4b42-a013-27f8f6ad81b3',4,'2025-11-16 06:51:17.477','2025-11-16 06:51:17.477'),
(41,'Student','150eba20-e901-46d8-90ee-944cb1a4ddae',4,'2025-11-16 06:51:17.478','2025-11-16 06:51:17.478'),
(42,'Student','1452bbc7-a141-472d-81e5-8fa967aeaef2',4,'2025-11-16 06:51:17.479','2025-11-16 06:51:17.479'),
(43,'Student','1b1b1c37-0ac0-4f01-8f38-1e04bec4db7a',4,'2025-11-16 06:51:17.480','2025-11-16 06:51:17.480'),
(44,'Student','b58f6d8c-aef9-4245-8069-5203628b6b2f',4,'2025-11-16 06:51:17.481','2025-11-16 06:51:17.481'),
(45,'Teacher','f7968341-ad86-4ec8-b814-bdae92e1105c',5,'2025-11-16 06:51:17.481','2025-11-16 06:51:17.481'),
(46,'Student','dd1caca5-166c-46de-9a55-97a021811e91',5,'2025-11-16 06:51:17.482','2025-11-16 06:51:17.482'),
(47,'Student','1241826e-a8d5-4305-8559-42e37de6057d',5,'2025-11-16 06:51:17.483','2025-11-16 06:51:17.483'),
(48,'Student','e946e725-0f92-40dd-9114-2f350bd43417',5,'2025-11-16 06:51:17.484','2025-11-16 06:51:17.484'),
(49,'Student','ae8d2693-cd0b-4783-954d-7497b4dc2c9d',5,'2025-11-16 06:51:17.485','2025-11-16 06:51:17.485'),
(50,'Student','1452bbc7-a141-472d-81e5-8fa967aeaef2',5,'2025-11-16 06:51:17.486','2025-11-16 06:51:17.486'),
(51,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',5,'2025-11-16 06:51:17.487','2025-11-16 06:51:17.487'),
(52,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',5,'2025-11-16 06:51:17.488','2025-11-16 06:51:17.488'),
(53,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',5,'2025-11-16 06:51:17.489','2025-11-16 06:51:17.489'),
(54,'Student','27cbea38-f69c-4a9f-b3ea-de06df237d66',5,'2025-11-16 06:51:17.491','2025-11-16 06:51:17.491'),
(55,'Student','ba223ced-9ae1-46bc-934a-36651bb86838',5,'2025-11-16 06:51:17.493','2025-11-16 06:51:17.493'),
(56,'Teacher','7d4fe457-7ec6-4167-89c9-936af53684d8',6,'2025-11-16 06:51:17.494','2025-11-16 06:51:17.494'),
(57,'Student','e946e725-0f92-40dd-9114-2f350bd43417',6,'2025-11-16 06:51:17.495','2025-11-16 06:51:17.495'),
(58,'Student','bf9cfbfc-743e-45f9-bc4b-0d6a992679bc',6,'2025-11-16 06:51:17.496','2025-11-16 06:51:17.496'),
(59,'Student','ae8d2693-cd0b-4783-954d-7497b4dc2c9d',6,'2025-11-16 06:51:17.502','2025-11-16 06:51:17.502'),
(60,'Student','1241826e-a8d5-4305-8559-42e37de6057d',6,'2025-11-16 06:51:17.504','2025-11-16 06:51:17.504'),
(61,'Student','c87ee46e-3dcb-4cb3-b571-209b4aaa3d5a',6,'2025-11-16 06:51:17.505','2025-11-16 06:51:17.505'),
(62,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',6,'2025-11-16 06:51:17.506','2025-11-16 06:51:17.506'),
(63,'Student','cbc7277c-b496-4524-ad87-a27c0c1cc794',6,'2025-11-16 06:51:17.507','2025-11-16 06:51:17.507'),
(64,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',6,'2025-11-16 06:51:17.508','2025-11-16 06:51:17.508'),
(65,'Student','11ac7168-27cf-43c4-8ce0-b4d7f978150f',6,'2025-11-16 06:51:17.509','2025-11-16 06:51:17.509'),
(66,'Student','ba223ced-9ae1-46bc-934a-36651bb86838',6,'2025-11-16 06:51:17.510','2025-11-16 06:51:17.510'),
(67,'Teacher','f7968341-ad86-4ec8-b814-bdae92e1105c',7,'2025-11-16 06:51:17.512','2025-11-16 06:51:17.512'),
(68,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',7,'2025-11-16 06:51:17.513','2025-11-16 06:51:17.513'),
(69,'Student','bdc8cea1-6424-4a4a-8be2-0935ff36fbd7',7,'2025-11-16 06:51:17.514','2025-11-16 06:51:17.514'),
(70,'Student','cd5b7194-c20e-43e0-b88e-d2e0f93e6344',7,'2025-11-16 06:51:17.515','2025-11-16 06:51:17.515'),
(71,'Student','c87ee46e-3dcb-4cb3-b571-209b4aaa3d5a',7,'2025-11-16 06:51:17.516','2025-11-16 06:51:17.516'),
(72,'Student','7849a656-411d-4f73-b662-fa207344b2d2',7,'2025-11-16 06:51:17.517','2025-11-16 06:51:17.517'),
(73,'Student','a4f7c148-dacc-4928-8cfa-abe6baeb08a4',7,'2025-11-16 06:51:17.518','2025-11-16 06:51:17.518'),
(74,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',7,'2025-11-16 06:51:17.519','2025-11-16 06:51:17.519'),
(75,'Student','c2fbd307-40d4-4b57-8def-aa67cc978843',7,'2025-11-16 06:51:17.520','2025-11-16 06:51:17.520'),
(76,'Student','0c997c35-8008-4196-b3b0-cebc871bbcf8',7,'2025-11-16 06:51:17.521','2025-11-16 06:51:17.521'),
(77,'Student','ba223ced-9ae1-46bc-934a-36651bb86838',7,'2025-11-16 06:51:17.522','2025-11-16 06:51:17.522'),
(78,'Teacher','d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d',8,'2025-11-16 06:51:17.523','2025-11-16 06:51:17.523'),
(79,'Student','5daa0172-5f1e-4125-bc47-79a947bf7b83',8,'2025-11-16 06:51:17.524','2025-11-16 06:51:17.524'),
(80,'Student','0b10545f-a795-4576-a412-343f77b37676',8,'2025-11-16 06:51:17.525','2025-11-16 06:51:17.525'),
(81,'Student','cbb70acc-8765-4ac5-80a6-e4d2ac5aa2dc',8,'2025-11-16 06:51:17.526','2025-11-16 06:51:17.526'),
(82,'Student','0c997c35-8008-4196-b3b0-cebc871bbcf8',8,'2025-11-16 06:51:17.527','2025-11-16 06:51:17.527'),
(83,'Student','23ba062b-551f-4c29-bd1d-c4eeb1941139',8,'2025-11-16 06:51:17.529','2025-11-16 06:51:17.529'),
(84,'Student','150eba20-e901-46d8-90ee-944cb1a4ddae',8,'2025-11-16 06:51:17.530','2025-11-16 06:51:17.530'),
(85,'Student','bdc8cea1-6424-4a4a-8be2-0935ff36fbd7',8,'2025-11-16 06:51:17.531','2025-11-16 06:51:17.531'),
(86,'Student','c2fbd307-40d4-4b57-8def-aa67cc978843',8,'2025-11-16 06:51:17.532','2025-11-16 06:51:17.532'),
(87,'Student','fb6ca352-3fbe-44b9-95dc-1a9e0f654240',8,'2025-11-16 06:51:17.532','2025-11-16 06:51:17.532'),
(88,'Student','e4c17e4c-a5d4-4cdc-ba9d-192e162faa27',8,'2025-11-16 06:51:17.533','2025-11-16 06:51:17.533'),
(89,'Teacher','7d4fe457-7ec6-4167-89c9-936af53684d8',9,'2025-11-16 06:51:17.535','2025-11-16 06:51:17.535'),
(90,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',9,'2025-11-16 06:51:17.536','2025-11-16 06:51:17.536'),
(91,'Student','8e79d714-28d3-4624-9510-b748373f5e9b',9,'2025-11-16 06:51:17.537','2025-11-16 06:51:17.537'),
(92,'Student','23ba062b-551f-4c29-bd1d-c4eeb1941139',9,'2025-11-16 06:51:17.538','2025-11-16 06:51:17.538'),
(93,'Student','c87ee46e-3dcb-4cb3-b571-209b4aaa3d5a',9,'2025-11-16 06:51:17.539','2025-11-16 06:51:17.539'),
(94,'Student','be1e9650-d81d-425d-9de5-9d0debd27499',9,'2025-11-16 06:51:17.540','2025-11-16 06:51:17.540'),
(95,'Student','5daa0172-5f1e-4125-bc47-79a947bf7b83',9,'2025-11-16 06:51:17.541','2025-11-16 06:51:17.541'),
(96,'Student','de24693d-1725-4826-af1f-3512feeda254',9,'2025-11-16 06:51:17.542','2025-11-16 06:51:17.542'),
(97,'Student','81e01f21-ac54-490e-8000-d839a5a141ad',9,'2025-11-16 06:51:17.543','2025-11-16 06:51:17.543'),
(98,'Student','0b10545f-a795-4576-a412-343f77b37676',9,'2025-11-16 06:51:17.543','2025-11-16 06:51:17.543'),
(99,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',9,'2025-11-16 06:51:17.544','2025-11-16 06:51:17.544'),
(100,'Teacher','91b981ba-3038-460f-b354-f5c62ab41ecc',10,'2025-11-16 06:51:17.545','2025-11-16 06:51:17.545'),
(101,'Student','33950119-b616-4e52-85f6-13af993562ac',10,'2025-11-16 06:51:17.546','2025-11-16 06:51:17.546'),
(102,'Student','8e79d714-28d3-4624-9510-b748373f5e9b',10,'2025-11-16 06:51:17.547','2025-11-16 06:51:17.547'),
(103,'Student','cbc7277c-b496-4524-ad87-a27c0c1cc794',10,'2025-11-16 06:51:17.549','2025-11-16 06:51:17.549'),
(104,'Student','989202b3-86c5-4402-b056-cd410b64234c',10,'2025-11-16 06:51:17.550','2025-11-16 06:51:17.550'),
(105,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',10,'2025-11-16 06:51:17.551','2025-11-16 06:51:17.551'),
(106,'Student','1241826e-a8d5-4305-8559-42e37de6057d',10,'2025-11-16 06:51:17.552','2025-11-16 06:51:17.552'),
(107,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',10,'2025-11-16 06:51:17.553','2025-11-16 06:51:17.553'),
(108,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',10,'2025-11-16 06:51:17.554','2025-11-16 06:51:17.554'),
(109,'Student','7aa21340-826d-40c5-a2a1-fea13699ce04',10,'2025-11-16 06:51:17.555','2025-11-16 06:51:17.555'),
(110,'Student','a4f7c148-dacc-4928-8cfa-abe6baeb08a4',10,'2025-11-16 06:51:17.556','2025-11-16 06:51:17.556'),
(111,'Teacher','d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d',11,'2025-11-16 06:51:17.562','2025-11-16 06:51:17.562'),
(112,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',11,'2025-11-16 06:51:17.563','2025-11-16 06:51:17.563'),
(113,'Student','6e38a602-35ac-45a5-9cd8-6edb16aca169',11,'2025-11-16 06:51:17.564','2025-11-16 06:51:17.564'),
(114,'Student','e6dcb863-6b23-45a9-938a-bf94b4081c0d',11,'2025-11-16 06:51:17.565','2025-11-16 06:51:17.565'),
(115,'Student','5daa0172-5f1e-4125-bc47-79a947bf7b83',11,'2025-11-16 06:51:17.566','2025-11-16 06:51:17.566'),
(116,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',11,'2025-11-16 06:51:17.567','2025-11-16 06:51:17.567'),
(117,'Student','e4c17e4c-a5d4-4cdc-ba9d-192e162faa27',11,'2025-11-16 06:51:17.568','2025-11-16 06:51:17.568'),
(118,'Student','1452bbc7-a141-472d-81e5-8fa967aeaef2',11,'2025-11-16 06:51:17.570','2025-11-16 06:51:17.570'),
(119,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',11,'2025-11-16 06:51:17.571','2025-11-16 06:51:17.571'),
(120,'Student','484c6775-8caf-42c7-bf66-f274e8aa2435',11,'2025-11-16 06:51:17.572','2025-11-16 06:51:17.572'),
(121,'Student','64a9a17b-0a49-45ba-902b-0d9605726f8c',11,'2025-11-16 06:51:17.573','2025-11-16 06:51:17.573'),
(122,'Teacher','d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d',12,'2025-11-16 06:51:17.574','2025-11-16 06:51:17.574'),
(123,'Student','cbb70acc-8765-4ac5-80a6-e4d2ac5aa2dc',12,'2025-11-16 06:51:17.575','2025-11-16 06:51:17.575'),
(124,'Student','7e07bd84-3ad2-44bf-a1e9-421da4d7d8dc',12,'2025-11-16 06:51:17.576','2025-11-16 06:51:17.576'),
(125,'Student','ae8d2693-cd0b-4783-954d-7497b4dc2c9d',12,'2025-11-16 06:51:17.577','2025-11-16 06:51:17.577'),
(126,'Student','27cbea38-f69c-4a9f-b3ea-de06df237d66',12,'2025-11-16 06:51:17.578','2025-11-16 06:51:17.578'),
(127,'Student','446844b1-dabb-4ce4-ac40-113eecc80ca7',12,'2025-11-16 06:51:17.579','2025-11-16 06:51:17.579'),
(128,'Student','8e2dffcf-586b-4936-a5d4-7d5fc8c26efa',12,'2025-11-16 06:51:17.579','2025-11-16 06:51:17.579'),
(129,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',12,'2025-11-16 06:51:17.580','2025-11-16 06:51:17.580'),
(130,'Student','bf9cfbfc-743e-45f9-bc4b-0d6a992679bc',12,'2025-11-16 06:51:17.581','2025-11-16 06:51:17.581'),
(131,'Student','11ac7168-27cf-43c4-8ce0-b4d7f978150f',12,'2025-11-16 06:51:17.582','2025-11-16 06:51:17.582'),
(132,'Student','0ceda10c-7d57-462c-a0c8-1fbd343ca2d5',12,'2025-11-16 06:51:17.584','2025-11-16 06:51:17.584'),
(133,'Teacher','d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d',13,'2025-11-16 06:51:17.584','2025-11-16 06:51:17.584'),
(134,'Student','989202b3-86c5-4402-b056-cd410b64234c',13,'2025-11-16 06:51:17.585','2025-11-16 06:51:17.585'),
(135,'Student','720d7a5b-cfc3-4e21-b324-63f015e24231',13,'2025-11-16 06:51:17.586','2025-11-16 06:51:17.586'),
(136,'Student','8e79d714-28d3-4624-9510-b748373f5e9b',13,'2025-11-16 06:51:17.587','2025-11-16 06:51:17.587'),
(137,'Student','e43aca7a-2ef9-4cf7-a98f-e25be76be9b7',13,'2025-11-16 06:51:17.588','2025-11-16 06:51:17.588'),
(138,'Student','be1e9650-d81d-425d-9de5-9d0debd27499',13,'2025-11-16 06:51:17.589','2025-11-16 06:51:17.589'),
(139,'Student','e946e725-0f92-40dd-9114-2f350bd43417',13,'2025-11-16 06:51:17.590','2025-11-16 06:51:17.590'),
(140,'Student','150eba20-e901-46d8-90ee-944cb1a4ddae',13,'2025-11-16 06:51:17.591','2025-11-16 06:51:17.591'),
(141,'Student','5cc0daa0-0176-4b42-a013-27f8f6ad81b3',13,'2025-11-16 06:51:17.592','2025-11-16 06:51:17.592'),
(142,'Student','1241826e-a8d5-4305-8559-42e37de6057d',13,'2025-11-16 06:51:17.593','2025-11-16 06:51:17.593'),
(143,'Student','0b10545f-a795-4576-a412-343f77b37676',13,'2025-11-16 06:51:17.594','2025-11-16 06:51:17.594'),
(144,'Teacher','d0a38ba5-b419-40b9-ab2e-fd2e1fb9d81d',14,'2025-11-16 06:51:17.595','2025-11-16 06:51:17.595'),
(145,'Student','0ceda10c-7d57-462c-a0c8-1fbd343ca2d5',14,'2025-11-16 06:51:17.596','2025-11-16 06:51:17.596'),
(146,'Student','7016f05c-b862-41aa-8fe8-646c96e1a7bd',14,'2025-11-16 06:51:17.597','2025-11-16 06:51:17.597'),
(147,'Student','33950119-b616-4e52-85f6-13af993562ac',14,'2025-11-16 06:51:17.598','2025-11-16 06:51:17.598'),
(148,'Student','9a4a484a-de92-416d-b00e-775d85ea9844',14,'2025-11-16 06:51:17.599','2025-11-16 06:51:17.599'),
(149,'Student','e946e725-0f92-40dd-9114-2f350bd43417',14,'2025-11-16 06:51:17.600','2025-11-16 06:51:17.600'),
(150,'Student','cd5b7194-c20e-43e0-b88e-d2e0f93e6344',14,'2025-11-16 06:51:17.601','2025-11-16 06:51:17.601'),
(151,'Student','27cbea38-f69c-4a9f-b3ea-de06df237d66',14,'2025-11-16 06:51:17.602','2025-11-16 06:51:17.602'),
(152,'Student','6e38a602-35ac-45a5-9cd8-6edb16aca169',14,'2025-11-16 06:51:17.603','2025-11-16 06:51:17.603'),
(153,'Student','be1e9650-d81d-425d-9de5-9d0debd27499',14,'2025-11-16 06:51:17.603','2025-11-16 06:51:17.603'),
(154,'Student','cbc7277c-b496-4524-ad87-a27c0c1cc794',14,'2025-11-16 06:51:17.604','2025-11-16 06:51:17.604');
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
('1e9a05d1-0e9e-4dbd-8679-801859443053','330c558dd59e57f5be2e0b739af7e167005897877a1e9b870d17154fc31ad60e','2025-11-16 06:51:14.702','20251115092106_remove_subscription_plan',NULL,NULL,'2025-11-16 06:51:14.683',1),
('517aaa9d-927c-4d79-8e61-073f7c6200de','5d535f395498abb562d62c3d16a60924963a26c3c065d32a7a5e1f066075fcb1','2025-11-16 06:51:14.682','20251112144809_init',NULL,NULL,'2025-11-16 06:51:14.345',1),
('6f886a92-6623-450e-998f-c2a42b411741','852a4e2c166c689df64fa4b1e82bf527de22bffa0e6ace5b8e479414c9ec21aa','2025-11-16 06:51:14.766','20251116055534_update_quiz_material_relation_remove_time',NULL,NULL,'2025-11-16 06:51:14.744',1),
('e7cc7dcc-c2a5-4b23-b899-9a649cc60c6d','bde564d470fab41c136f8a2dc30030d38d8c0d5e42255b3cae1c4f9ee617b761','2025-11-16 06:51:14.744','20251116040034_init',NULL,NULL,'2025-11-16 06:51:14.703',1);
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
(1,'Essay',0,'2025-11-16 06:51:17.423','2025-11-16 06:51:17.423'),
(2,'Business Plan',0,'2025-11-16 06:51:17.423','2025-11-16 06:51:17.423'),
(3,'Penelitian',0,'2025-11-16 06:51:17.423','2025-11-16 06:51:17.423'),
(4,'Desain',0,'2025-11-16 06:51:17.423','2025-11-16 06:51:17.423');
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

-- Dump completed on 2025-11-16 13:54:08

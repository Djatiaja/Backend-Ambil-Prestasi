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
(1,1,'et','fugiat doloribus voluptatibus sit repellat sed consequuntur et quae repellat quas quaerat dolores quae quas eos voluptatibus nulla voluptate asperiores voluptatem vel sapiente consectetur sit quasi vitae dicta consectetur nulla','files/public/placeholder.png','2025-11-18 11:35:58.028','2025-11-18 11:35:58.028'),
(2,1,'fugiat','blanditiis id fugit ullam error blanditiis hic nihil dolores nihil ullam omnis quia vitae quaerat sapiente unde quasi in hic unde fugiat rerum dolores sequi dolores dicta facilis reiciendis sequi','files/public/placeholder.png','2025-11-18 11:35:58.030','2025-11-18 11:35:58.030'),
(3,1,'quasi','excepturi quia quasi quaerat fugiat magnam error sed nemo sed cupiditate aliquid esse aliquid sit enim nostrum sequi nihil dolores consequuntur maiores reiciendis excepturi occaecati ipsum ducimus quaerat vel error','files/public/placeholder.png','2025-11-18 11:35:58.032','2025-11-18 11:35:58.032'),
(4,1,'non','exercitationem voluptatibus commodi voluptatibus aliquid dolores blanditiis vitae vel voluptatibus aut quae enim nostrum fugiat labore doloribus asperiores beatae maiores neque aut non ipsum aut maiores numquam quae sequi dolores','files/public/placeholder.png','2025-11-18 11:35:58.033','2025-11-18 11:35:58.033'),
(5,1,'error','facilis id quaerat at ullam consectetur id nemo numquam cupiditate occaecati sit ipsum quasi enim excepturi excepturi ipsum vel sequi consequatur sequi sed commodi id rerum numquam ipsum unde exercitationem','files/public/placeholder.png','2025-11-18 11:35:58.035','2025-11-18 11:35:58.035'),
(6,1,'quos','in reiciendis non dolores numquam ipsum dolores nemo numquam sit fugit dicta occaecati nulla doloribus magnam non unde est unde tenetur consequuntur maiores excepturi doloribus fugit quasi omnis id nemo','files/public/placeholder.png','2025-11-18 11:35:58.036','2025-11-18 11:35:58.036'),
(7,1,'voluptatibus','voluptate cupiditate repellat aliquid nihil quasi fugiat quos voluptatem eos sequi excepturi neque sed aliquid quia quasi enim est aut magnam fugit sunt tenetur in necessitatibus sed sed consectetur sapiente','files/public/placeholder.png','2025-11-18 11:35:58.037','2025-11-18 11:35:58.037'),
(8,1,'vitae','facilis numquam fugiat vel excepturi omnis enim ducimus exercitationem asperiores deserunt at qui vel tenetur possimus et dicta labore omnis omnis est neque nostrum nemo vitae aut esse nihil aut','files/public/placeholder.png','2025-11-18 11:35:58.039','2025-11-18 11:35:58.039'),
(9,1,'fugit','qui commodi sequi tenetur quia voluptatem commodi commodi est exercitationem nemo possimus quia commodi dicta beatae quos non in id aliquid consequuntur laborum unde at commodi facilis deserunt cupiditate error','files/public/placeholder.png','2025-11-18 11:35:58.040','2025-11-18 11:35:58.040'),
(10,1,'ducimus','magnam deserunt occaecati error sequi blanditiis exercitationem sapiente id est deserunt sunt ipsum reiciendis nemo sequi quia fugit nulla quos maiores neque voluptate hic voluptate voluptate id non quos blanditiis','files/public/placeholder.png','2025-11-18 11:35:58.042','2025-11-18 11:35:58.042'),
(11,2,'PPK','quaerat quaerat consequuntur quasi neque exercitationem doloribus sunt excepturi nostrum in occaecati nulla hic non consequatur ducimus quae sapiente rerum error cupiditate quae qui nulla nihil numquam beatae in necessitatibus','files/public/placeholder.png','2025-11-18 11:35:58.185','2025-11-18 11:35:58.185'),
(12,3,'Pancasila','tenetur blanditiis ullam ullam non exercitationem consectetur excepturi est vitae laborum ullam sequi dolores qui voluptate rerum nostrum labore voluptatibus voluptatibus sunt quae ullam unde facilis labore deserunt unde labore','files/public/placeholder.png','2025-11-18 11:35:58.187','2025-11-18 11:35:58.187'),
(13,3,'Agama','eos magnam eos ipsum hic fugiat omnis et possimus nihil nostrum esse possimus enim quae dolores est ullam enim non doloribus dicta id consectetur qui ducimus consequuntur et sed voluptatibus','files/public/placeholder.png','2025-11-18 11:35:58.188','2025-11-18 11:35:58.188'),
(14,3,'Bahasa Indonesia','sequi deserunt in qui in sed dicta occaecati voluptatibus nulla quas cupiditate consectetur nulla vitae dolores quae voluptatem nulla consectetur excepturi laborum et labore ducimus sed consequatur quas unde rerum','files/public/placeholder.png','2025-11-18 11:35:58.190','2025-11-18 11:35:58.190');
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
(1,'Admin','2025-11-18 11:35:57.830','2025-11-18 11:35:57.830'),
(2,'Teacher','2025-11-18 11:35:57.830','2025-11-18 11:35:57.830'),
(3,'Student','2025-11-18 11:35:57.830','2025-11-18 11:35:57.830');
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
('0f49ece1-40cf-4fe8-808b-5e23f054f8ec','student50@example.com','student50','Ester_Lim49','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+50&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.022','2021-04-26 03:39:13.852','2025-11-18 11:35:58.023',3),
('120d337e-8904-4516-ac54-d39c645fc206','student31@example.com','student31','Phonthip.Lewis','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+31&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.989','2025-02-17 18:48:54.820','2025-11-18 11:35:57.990',3),
('13c966ff-8fa6-424b-b8ec-62949613d62b','student49@example.com','student49','Inga_Omondi','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+49&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.021','2023-09-17 00:53:15.922','2025-11-18 11:35:58.021',3),
('147dfec4-d7ba-41c1-ab13-b537466dc838','student42@example.com','student42','Salisu_Ikeda','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+42&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.007','2023-05-09 08:43:18.965','2025-11-18 11:35:58.008',3),
('14ad3a68-5173-413a-b9c7-59f608ffbbf9','student24@example.com','student24','Somphon.Ūžien89','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+24&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.976','2024-10-04 00:19:28.214','2025-11-18 11:35:57.977',3),
('16a6a3ca-bb28-4fe9-957e-35ae8c7bcb90','student2@example.com','student2','Nittaya.Ramírez37','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+2&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.937','2023-01-13 15:52:15.571','2025-11-18 11:35:57.938',3),
('1b80a1e9-31c2-4012-90cb-842965dea959','teacher3@example.com','teacher3','Sara.Vos','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Teacher+3&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-18 11:35:57.917','2025-08-05 15:45:54.138','2025-11-18 11:35:57.918',2),
('1d164f13-ac09-4c6a-adaa-02759740d6ea','student4@example.com','student4','Shimon_Ruiz','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+4&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.942','2025-01-01 05:07:41.060','2025-11-18 11:35:57.943',3),
('2ab525f6-d8d5-4965-91ce-a02cbd0744b9','student23@example.com','student23','Graham.Hernández30','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+23&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.974','2024-08-10 20:02:56.090','2025-11-18 11:35:57.975',3),
('2c2b14f9-883f-4c92-95bf-98aa2adfc041','djamgt23@gmail.com','admin','Admin User','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Admin+User&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.909','2025-08-24 18:15:37.804','2025-11-18 11:35:57.910',1),
('2d034027-399e-4203-8f74-a3cb623e152d','student29@example.com','student29','Elisabeth_Procházka','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+29&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.985','2024-01-28 02:07:41.293','2025-11-18 11:35:57.986',3),
('3452f9a0-b58a-4412-9fdb-f8613b1de89d','student16@example.com','student16','Lilian_Őri','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+16&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.962','2023-03-10 17:29:42.209','2025-11-18 11:35:57.963',3),
('377da4c8-edb2-4b7b-8bfb-496e7c66e61b','student17@example.com','student17','Nonhlanhla_Guðmundsdóttir54','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+17&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.964','2024-09-28 04:32:12.819','2025-11-18 11:35:57.965',3),
('3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f','student22@example.com','student22','Yue.Vasilev25','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+22&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.972','2022-12-23 12:20:44.261','2025-11-18 11:35:57.973',3),
('4b210e72-ce1e-489e-919d-0810cac30362','student32@example.com','student32','Sani_Pospíšil','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+32&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.991','2025-08-23 14:40:06.148','2025-11-18 11:35:57.991',3),
('4bae7891-01d7-44c2-bd65-90b672e7ba60','student48@example.com','student48','Karin_Yuan','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+48&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.019','2022-03-26 07:51:31.368','2025-11-18 11:35:58.020',3),
('5049eede-8de0-4307-88d8-331e08cd2c37','student43@example.com','student43','Daniel_Olszewski65','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+43&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.010','2023-02-28 08:09:53.267','2025-11-18 11:35:58.010',3),
('5083e1ad-46e1-4ae6-b20d-57c51a9db38e','student3@example.com','student3','Nkosinathi.Pétursdóttir','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+3&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.939','2024-06-30 16:03:23.464','2025-11-18 11:35:57.940',3),
('55a2f1c2-7b32-4c99-9b2b-c18ce9651a1f','student30@example.com','student30','Somnuek.Fialová','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+30&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.987','2023-01-19 22:23:34.190','2025-11-18 11:35:57.988',3),
('586b764a-7042-471e-a9b1-a0d51406c2a5','student8@example.com','student8','Keiko.Aguilar38','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+8&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.949','2025-11-05 18:53:53.800','2025-11-18 11:35:57.950',3),
('5d9b3a7a-910b-409f-9f74-92b33343e3c0','student26@example.com','student26','Radha_Deng','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+26&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.979','2024-05-04 20:40:11.343','2025-11-18 11:35:57.980',3),
('616b64e4-33c4-48a5-b65d-a2ab5029aa29','student47@example.com','student47','Haruna.Karlsdóttir','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+47&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.017','2025-10-01 12:51:12.921','2025-11-18 11:35:58.018',3),
('618a5d4a-c1f7-474c-8355-98f88ed869a1','student18@example.com','student18','Anil.Bauer18','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+18&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.966','2022-01-10 11:43:47.338','2025-11-18 11:35:57.967',3),
('63b78a01-cda1-4926-b397-76587ae5bddd','teacher1@example.com','teacher1','Radha.Őzse','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Teacher+1&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-18 11:35:57.912','2024-11-08 20:59:25.190','2025-11-18 11:35:57.913',2),
('69a61947-d13e-4970-ab9b-3aedf8cbb7e9','student40@example.com','student40','Isaac.Van-Beek','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+40&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.003','2021-06-11 14:32:08.423','2025-11-18 11:35:58.004',3),
('761d9c5d-241d-48e0-bff8-dc130ee4cc2d','student14@example.com','student14','Rebecca.Díaz','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+14&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.959','2023-12-01 17:15:22.803','2025-11-18 11:35:57.960',3),
('7d9d1502-a865-4786-85ff-33c1c1b3ad99','student44@example.com','student44','Shimon_Jóhannesdóttir','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+44&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.012','2021-03-13 17:08:44.126','2025-11-18 11:35:58.013',3),
('81dfa56a-5b91-44f8-bca1-c420d2a0f52e','student12@example.com','student12','Lyubov_Thompson15','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+12&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.956','2024-06-25 13:14:50.987','2025-11-18 11:35:57.957',3),
('884100d4-f9f7-4ddf-a38f-55d0fbdabbce','student46@example.com','student46','Mei_Ivanov','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+46&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.015','2023-10-28 10:34:27.201','2025-11-18 11:35:58.016',3),
('8bfd1f6f-acd3-41e1-9e02-af8f53366b35','student5@example.com','student5','Alina_Smirnova','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+5&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.944','2024-11-15 16:04:10.148','2025-11-18 11:35:57.945',3),
('8cb5046b-c42a-49b1-a01c-aafce475c9bf','student25@example.com','student25','Jane.Bos','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+25&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.978','2023-07-23 16:47:32.897','2025-11-18 11:35:57.978',3),
('926a361b-ad86-4213-b2d3-bd999f4f6c09','student1@example.com','student1','Andrew.Bennett57','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+1&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.921','2025-03-28 06:59:41.816','2025-11-18 11:35:57.922',3),
('9410f2d8-80ac-416a-b9df-cb4a326d66a5','student36@example.com','student36','Lihua_Isah','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+36&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.997','2021-08-04 09:18:39.956','2025-11-18 11:35:57.998',3),
('a68311fc-ec7d-4b2a-b95b-7a0e8776bc54','student34@example.com','student34','Xiaoli_Harle-Cowan','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+34&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.994','2021-02-27 17:26:59.732','2025-11-18 11:35:57.994',3),
('a8f77397-7f04-4027-8d71-be3764a35c7b','student39@example.com','student39','Karen_Fialová','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+39&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.002','2025-08-16 16:19:04.850','2025-11-18 11:35:58.002',3),
('ac837453-3165-40fa-b842-5637b4914359','student13@example.com','student13','Martha.Stepanov','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+13&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.958','2025-08-24 02:38:41.809','2025-11-18 11:35:57.958',3),
('acd05a16-7935-4603-9e77-0eae65d01706','student15@example.com','student15','Isaac_Rungrueang','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+15&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.961','2025-04-15 07:35:23.839','2025-11-18 11:35:57.961',3),
('b321547e-cbb4-4dee-821b-511af9435f61','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=teachertestacc&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.024','2022-09-15 03:03:00.904','2025-11-18 11:35:58.025',2),
('b57cc648-6eb8-4c93-90c0-6514a9bafa62','student28@example.com','student28','Noam.Őrségi-Zölderdő20','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+28&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.983','2021-06-15 13:44:49.386','2025-11-18 11:35:57.983',3),
('b89eb2c4-873f-4c7f-9aaf-d9d911a9bcf0','teacher2@example.com','teacher2','Beata_Kristinsdóttir','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Teacher+2&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-18 11:35:57.915','2023-04-19 00:05:05.645','2025-11-18 11:35:57.916',2),
('b8f8c2d2-be6c-4a4a-a575-7ef7737a2b0b','teacher4@example.com','teacher4','Samuel.García74','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Teacher+4&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-18 11:35:57.919','2021-04-25 04:36:27.590','2025-11-18 11:35:57.920',2),
('b918bba1-9e53-449c-ae05-96baac327bfb','student11@example.com','student11','Omer_Kato90','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+11&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.954','2025-05-04 11:42:22.033','2025-11-18 11:35:57.955',3),
('bca1d95f-75a5-4cd5-9d5e-9848f75b8954','student38@example.com','student38','Eva_Bunmi68','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+38&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.000','2024-10-26 22:50:19.197','2025-11-18 11:35:58.001',3),
('bcdb5db5-b0fc-438b-a82f-422022638703','student41@example.com','student41','Linda_Nuñez','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+41&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.005','2022-02-26 21:55:33.600','2025-11-18 11:35:58.006',3),
('c1be1e5f-0e32-488a-8f18-29f9cd6c281c','student45@example.com','student45','Somkhit_Tan19','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+45&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:58.014','2022-09-18 23:33:43.864','2025-11-18 11:35:58.015',3),
('c4d8d821-a0f5-41dd-b647-557f2897341c','student27@example.com','student27','Yael.Zulu','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+27&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.981','2023-09-11 17:57:47.249','2025-11-18 11:35:57.981',3),
('c7d44840-da80-486c-90ef-38e46acf2efa','student19@example.com','student19','Karen_Cohen','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+19&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.968','2022-04-08 06:46:23.537','2025-11-18 11:35:57.968',3),
('ca3774f8-bf26-416a-8b7a-466b86f755e0','student33@example.com','student33','Xolani.Morozova20','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+33&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.992','2025-03-17 13:29:30.789','2025-11-18 11:35:57.993',3),
('d3797947-1482-4728-8832-1d7c3b32466f','student21@example.com','student21','Igor_Karanja','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+21&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.971','2022-01-31 17:18:22.854','2025-11-18 11:35:57.972',3),
('d3b3475c-dbab-4463-b602-2c015184fac8','student9@example.com','student9','Yaakv_Æbelø','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+9&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.951','2022-09-13 11:38:36.402','2025-11-18 11:35:57.952',3),
('e6f380e2-144e-4978-89f4-8a82fda3638f','student20@example.com','student20','Busisiwe.Sekh56','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+20&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.969','2021-10-04 17:15:31.433','2025-11-18 11:35:57.970',3),
('ed3c2c85-81f5-4d5d-ad79-2bd1510a1dbd','student7@example.com','student7','Cristina_Þórðardóttir26','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+7&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.947','2022-08-11 09:07:09.728','2025-11-18 11:35:57.948',3),
('f60284bd-6f29-4111-acc8-85bd6b5cbe5c','student37@example.com','student37','Wirat_Egorov52','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+37&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.998','2022-03-06 09:03:45.523','2025-11-18 11:35:57.999',3),
('f67d5137-cf9d-4f1c-8e79-6a83852baf50','student10@example.com','student10','Sam.Guðmundsdóttir','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+10&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.953','2024-11-16 21:05:11.775','2025-11-18 11:35:57.954',3),
('f8aa2643-d9d4-419a-8bd2-6606b32b0dd7','student6@example.com','student6','Yuko.Möller','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+6&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.946','2025-06-09 09:22:47.045','2025-11-18 11:35:57.946',3),
('fca92a4a-cbb0-47cf-a866-60e27c041c4a','student35@example.com','student35','Tatyana_Jóhannesson','$2b$10$4w2wN0isMGBoMx3gKCKj7egE/QJZPU7eS8r2CcUGlpSgI.AL91wHq','https://ui-avatars.com/api/?name=Student+35&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-18 11:35:57.995','2024-07-21 23:33:18.411','2025-11-18 11:35:57.996',3);
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
(1,'Teacher','b8f8c2d2-be6c-4a4a-a575-7ef7737a2b0b',1,'2025-11-18 11:35:58.048','2025-11-18 11:35:58.048'),
(2,'Student','d3b3475c-dbab-4463-b602-2c015184fac8',1,'2025-11-18 11:35:58.050','2025-11-18 11:35:58.050'),
(3,'Student','55a2f1c2-7b32-4c99-9b2b-c18ce9651a1f',1,'2025-11-18 11:35:58.052','2025-11-18 11:35:58.052'),
(4,'Student','e6f380e2-144e-4978-89f4-8a82fda3638f',1,'2025-11-18 11:35:58.053','2025-11-18 11:35:58.053'),
(5,'Student','bca1d95f-75a5-4cd5-9d5e-9848f75b8954',1,'2025-11-18 11:35:58.054','2025-11-18 11:35:58.054'),
(6,'Student','2d034027-399e-4203-8f74-a3cb623e152d',1,'2025-11-18 11:35:58.056','2025-11-18 11:35:58.056'),
(7,'Student','3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f',1,'2025-11-18 11:35:58.057','2025-11-18 11:35:58.057'),
(8,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',1,'2025-11-18 11:35:58.058','2025-11-18 11:35:58.058'),
(9,'Student','4bae7891-01d7-44c2-bd65-90b672e7ba60',1,'2025-11-18 11:35:58.060','2025-11-18 11:35:58.060'),
(10,'Student','b918bba1-9e53-449c-ae05-96baac327bfb',1,'2025-11-18 11:35:58.061','2025-11-18 11:35:58.061'),
(11,'Student','1d164f13-ac09-4c6a-adaa-02759740d6ea',1,'2025-11-18 11:35:58.062','2025-11-18 11:35:58.062'),
(12,'Teacher','b8f8c2d2-be6c-4a4a-a575-7ef7737a2b0b',2,'2025-11-18 11:35:58.063','2025-11-18 11:35:58.063'),
(13,'Student','9410f2d8-80ac-416a-b9df-cb4a326d66a5',2,'2025-11-18 11:35:58.064','2025-11-18 11:35:58.064'),
(14,'Student','4b210e72-ce1e-489e-919d-0810cac30362',2,'2025-11-18 11:35:58.066','2025-11-18 11:35:58.066'),
(15,'Student','0f49ece1-40cf-4fe8-808b-5e23f054f8ec',2,'2025-11-18 11:35:58.067','2025-11-18 11:35:58.067'),
(16,'Student','884100d4-f9f7-4ddf-a38f-55d0fbdabbce',2,'2025-11-18 11:35:58.068','2025-11-18 11:35:58.068'),
(17,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',2,'2025-11-18 11:35:58.070','2025-11-18 11:35:58.070'),
(18,'Student','120d337e-8904-4516-ac54-d39c645fc206',2,'2025-11-18 11:35:58.071','2025-11-18 11:35:58.071'),
(19,'Student','13c966ff-8fa6-424b-b8ec-62949613d62b',2,'2025-11-18 11:35:58.072','2025-11-18 11:35:58.072'),
(20,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',2,'2025-11-18 11:35:58.073','2025-11-18 11:35:58.073'),
(21,'Student','f8aa2643-d9d4-419a-8bd2-6606b32b0dd7',2,'2025-11-18 11:35:58.074','2025-11-18 11:35:58.074'),
(22,'Student','b57cc648-6eb8-4c93-90c0-6514a9bafa62',2,'2025-11-18 11:35:58.075','2025-11-18 11:35:58.075'),
(23,'Teacher','1b80a1e9-31c2-4012-90cb-842965dea959',3,'2025-11-18 11:35:58.076','2025-11-18 11:35:58.076'),
(24,'Student','ca3774f8-bf26-416a-8b7a-466b86f755e0',3,'2025-11-18 11:35:58.078','2025-11-18 11:35:58.078'),
(25,'Student','4bae7891-01d7-44c2-bd65-90b672e7ba60',3,'2025-11-18 11:35:58.079','2025-11-18 11:35:58.079'),
(26,'Student','3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f',3,'2025-11-18 11:35:58.080','2025-11-18 11:35:58.080'),
(27,'Student','8cb5046b-c42a-49b1-a01c-aafce475c9bf',3,'2025-11-18 11:35:58.081','2025-11-18 11:35:58.081'),
(28,'Student','618a5d4a-c1f7-474c-8355-98f88ed869a1',3,'2025-11-18 11:35:58.083','2025-11-18 11:35:58.083'),
(29,'Student','2ab525f6-d8d5-4965-91ce-a02cbd0744b9',3,'2025-11-18 11:35:58.084','2025-11-18 11:35:58.084'),
(30,'Student','9410f2d8-80ac-416a-b9df-cb4a326d66a5',3,'2025-11-18 11:35:58.085','2025-11-18 11:35:58.085'),
(31,'Student','13c966ff-8fa6-424b-b8ec-62949613d62b',3,'2025-11-18 11:35:58.086','2025-11-18 11:35:58.086'),
(32,'Student','616b64e4-33c4-48a5-b65d-a2ab5029aa29',3,'2025-11-18 11:35:58.087','2025-11-18 11:35:58.087'),
(33,'Student','f67d5137-cf9d-4f1c-8e79-6a83852baf50',3,'2025-11-18 11:35:58.089','2025-11-18 11:35:58.089'),
(34,'Teacher','63b78a01-cda1-4926-b397-76587ae5bddd',4,'2025-11-18 11:35:58.090','2025-11-18 11:35:58.090'),
(35,'Student','f67d5137-cf9d-4f1c-8e79-6a83852baf50',4,'2025-11-18 11:35:58.091','2025-11-18 11:35:58.091'),
(36,'Student','0f49ece1-40cf-4fe8-808b-5e23f054f8ec',4,'2025-11-18 11:35:58.092','2025-11-18 11:35:58.092'),
(37,'Student','5049eede-8de0-4307-88d8-331e08cd2c37',4,'2025-11-18 11:35:58.093','2025-11-18 11:35:58.093'),
(38,'Student','a8f77397-7f04-4027-8d71-be3764a35c7b',4,'2025-11-18 11:35:58.094','2025-11-18 11:35:58.094'),
(39,'Student','f8aa2643-d9d4-419a-8bd2-6606b32b0dd7',4,'2025-11-18 11:35:58.095','2025-11-18 11:35:58.095'),
(40,'Student','5d9b3a7a-910b-409f-9f74-92b33343e3c0',4,'2025-11-18 11:35:58.096','2025-11-18 11:35:58.096'),
(41,'Student','926a361b-ad86-4213-b2d3-bd999f4f6c09',4,'2025-11-18 11:35:58.098','2025-11-18 11:35:58.098'),
(42,'Student','14ad3a68-5173-413a-b9c7-59f608ffbbf9',4,'2025-11-18 11:35:58.099','2025-11-18 11:35:58.099'),
(43,'Student','3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f',4,'2025-11-18 11:35:58.100','2025-11-18 11:35:58.100'),
(44,'Student','c4d8d821-a0f5-41dd-b647-557f2897341c',4,'2025-11-18 11:35:58.101','2025-11-18 11:35:58.101'),
(45,'Teacher','63b78a01-cda1-4926-b397-76587ae5bddd',5,'2025-11-18 11:35:58.102','2025-11-18 11:35:58.102'),
(46,'Student','d3b3475c-dbab-4463-b602-2c015184fac8',5,'2025-11-18 11:35:58.104','2025-11-18 11:35:58.104'),
(47,'Student','f8aa2643-d9d4-419a-8bd2-6606b32b0dd7',5,'2025-11-18 11:35:58.105','2025-11-18 11:35:58.105'),
(48,'Student','b918bba1-9e53-449c-ae05-96baac327bfb',5,'2025-11-18 11:35:58.106','2025-11-18 11:35:58.106'),
(49,'Student','14ad3a68-5173-413a-b9c7-59f608ffbbf9',5,'2025-11-18 11:35:58.107','2025-11-18 11:35:58.107'),
(50,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',5,'2025-11-18 11:35:58.108','2025-11-18 11:35:58.108'),
(51,'Student','c1be1e5f-0e32-488a-8f18-29f9cd6c281c',5,'2025-11-18 11:35:58.109','2025-11-18 11:35:58.109'),
(52,'Student','926a361b-ad86-4213-b2d3-bd999f4f6c09',5,'2025-11-18 11:35:58.111','2025-11-18 11:35:58.111'),
(53,'Student','4bae7891-01d7-44c2-bd65-90b672e7ba60',5,'2025-11-18 11:35:58.112','2025-11-18 11:35:58.112'),
(54,'Student','5d9b3a7a-910b-409f-9f74-92b33343e3c0',5,'2025-11-18 11:35:58.113','2025-11-18 11:35:58.113'),
(55,'Student','ed3c2c85-81f5-4d5d-ad79-2bd1510a1dbd',5,'2025-11-18 11:35:58.115','2025-11-18 11:35:58.115'),
(56,'Teacher','b8f8c2d2-be6c-4a4a-a575-7ef7737a2b0b',6,'2025-11-18 11:35:58.116','2025-11-18 11:35:58.116'),
(57,'Student','5d9b3a7a-910b-409f-9f74-92b33343e3c0',6,'2025-11-18 11:35:58.117','2025-11-18 11:35:58.117'),
(58,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',6,'2025-11-18 11:35:58.118','2025-11-18 11:35:58.118'),
(59,'Student','ca3774f8-bf26-416a-8b7a-466b86f755e0',6,'2025-11-18 11:35:58.119','2025-11-18 11:35:58.119'),
(60,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',6,'2025-11-18 11:35:58.121','2025-11-18 11:35:58.121'),
(61,'Student','14ad3a68-5173-413a-b9c7-59f608ffbbf9',6,'2025-11-18 11:35:58.122','2025-11-18 11:35:58.122'),
(62,'Student','d3797947-1482-4728-8832-1d7c3b32466f',6,'2025-11-18 11:35:58.123','2025-11-18 11:35:58.123'),
(63,'Student','16a6a3ca-bb28-4fe9-957e-35ae8c7bcb90',6,'2025-11-18 11:35:58.125','2025-11-18 11:35:58.125'),
(64,'Student','1d164f13-ac09-4c6a-adaa-02759740d6ea',6,'2025-11-18 11:35:58.126','2025-11-18 11:35:58.126'),
(65,'Student','884100d4-f9f7-4ddf-a38f-55d0fbdabbce',6,'2025-11-18 11:35:58.127','2025-11-18 11:35:58.127'),
(66,'Student','377da4c8-edb2-4b7b-8bfb-496e7c66e61b',6,'2025-11-18 11:35:58.129','2025-11-18 11:35:58.129'),
(67,'Teacher','b321547e-cbb4-4dee-821b-511af9435f61',7,'2025-11-18 11:35:58.131','2025-11-18 11:35:58.131'),
(68,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',7,'2025-11-18 11:35:58.133','2025-11-18 11:35:58.133'),
(69,'Student','2ab525f6-d8d5-4965-91ce-a02cbd0744b9',7,'2025-11-18 11:35:58.134','2025-11-18 11:35:58.134'),
(70,'Student','761d9c5d-241d-48e0-bff8-dc130ee4cc2d',7,'2025-11-18 11:35:58.136','2025-11-18 11:35:58.136'),
(71,'Student','586b764a-7042-471e-a9b1-a0d51406c2a5',7,'2025-11-18 11:35:58.137','2025-11-18 11:35:58.137'),
(72,'Student','5d9b3a7a-910b-409f-9f74-92b33343e3c0',7,'2025-11-18 11:35:58.138','2025-11-18 11:35:58.138'),
(73,'Student','ed3c2c85-81f5-4d5d-ad79-2bd1510a1dbd',7,'2025-11-18 11:35:58.140','2025-11-18 11:35:58.140'),
(74,'Student','bca1d95f-75a5-4cd5-9d5e-9848f75b8954',7,'2025-11-18 11:35:58.141','2025-11-18 11:35:58.141'),
(75,'Student','b57cc648-6eb8-4c93-90c0-6514a9bafa62',7,'2025-11-18 11:35:58.142','2025-11-18 11:35:58.142'),
(76,'Student','0f49ece1-40cf-4fe8-808b-5e23f054f8ec',7,'2025-11-18 11:35:58.143','2025-11-18 11:35:58.143'),
(77,'Student','c4d8d821-a0f5-41dd-b647-557f2897341c',7,'2025-11-18 11:35:58.145','2025-11-18 11:35:58.145'),
(78,'Teacher','1b80a1e9-31c2-4012-90cb-842965dea959',8,'2025-11-18 11:35:58.146','2025-11-18 11:35:58.146'),
(79,'Student','4b210e72-ce1e-489e-919d-0810cac30362',8,'2025-11-18 11:35:58.147','2025-11-18 11:35:58.147'),
(80,'Student','3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f',8,'2025-11-18 11:35:58.149','2025-11-18 11:35:58.149'),
(81,'Student','bcdb5db5-b0fc-438b-a82f-422022638703',8,'2025-11-18 11:35:58.150','2025-11-18 11:35:58.150'),
(82,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',8,'2025-11-18 11:35:58.151','2025-11-18 11:35:58.151'),
(83,'Student','120d337e-8904-4516-ac54-d39c645fc206',8,'2025-11-18 11:35:58.152','2025-11-18 11:35:58.152'),
(84,'Student','0f49ece1-40cf-4fe8-808b-5e23f054f8ec',8,'2025-11-18 11:35:58.153','2025-11-18 11:35:58.153'),
(85,'Student','b918bba1-9e53-449c-ae05-96baac327bfb',8,'2025-11-18 11:35:58.155','2025-11-18 11:35:58.155'),
(86,'Student','16a6a3ca-bb28-4fe9-957e-35ae8c7bcb90',8,'2025-11-18 11:35:58.156','2025-11-18 11:35:58.156'),
(87,'Student','5049eede-8de0-4307-88d8-331e08cd2c37',8,'2025-11-18 11:35:58.157','2025-11-18 11:35:58.157'),
(88,'Student','d3b3475c-dbab-4463-b602-2c015184fac8',8,'2025-11-18 11:35:58.158','2025-11-18 11:35:58.158'),
(89,'Teacher','b8f8c2d2-be6c-4a4a-a575-7ef7737a2b0b',9,'2025-11-18 11:35:58.160','2025-11-18 11:35:58.160'),
(90,'Student','5049eede-8de0-4307-88d8-331e08cd2c37',9,'2025-11-18 11:35:58.161','2025-11-18 11:35:58.161'),
(91,'Student','2ab525f6-d8d5-4965-91ce-a02cbd0744b9',9,'2025-11-18 11:35:58.162','2025-11-18 11:35:58.162'),
(92,'Student','e6f380e2-144e-4978-89f4-8a82fda3638f',9,'2025-11-18 11:35:58.163','2025-11-18 11:35:58.163'),
(93,'Student','586b764a-7042-471e-a9b1-a0d51406c2a5',9,'2025-11-18 11:35:58.164','2025-11-18 11:35:58.164'),
(94,'Student','69a61947-d13e-4970-ab9b-3aedf8cbb7e9',9,'2025-11-18 11:35:58.166','2025-11-18 11:35:58.166'),
(95,'Student','4bae7891-01d7-44c2-bd65-90b672e7ba60',9,'2025-11-18 11:35:58.167','2025-11-18 11:35:58.167'),
(96,'Student','8cb5046b-c42a-49b1-a01c-aafce475c9bf',9,'2025-11-18 11:35:58.168','2025-11-18 11:35:58.168'),
(97,'Student','884100d4-f9f7-4ddf-a38f-55d0fbdabbce',9,'2025-11-18 11:35:58.169','2025-11-18 11:35:58.169'),
(98,'Student','b918bba1-9e53-449c-ae05-96baac327bfb',9,'2025-11-18 11:35:58.170','2025-11-18 11:35:58.170'),
(99,'Student','14ad3a68-5173-413a-b9c7-59f608ffbbf9',9,'2025-11-18 11:35:58.171','2025-11-18 11:35:58.171'),
(100,'Teacher','b89eb2c4-873f-4c7f-9aaf-d9d911a9bcf0',10,'2025-11-18 11:35:58.172','2025-11-18 11:35:58.172'),
(101,'Student','5049eede-8de0-4307-88d8-331e08cd2c37',10,'2025-11-18 11:35:58.173','2025-11-18 11:35:58.173'),
(102,'Student','3eae573a-7e39-4c2e-81c9-beaf6fbf1e7f',10,'2025-11-18 11:35:58.174','2025-11-18 11:35:58.174'),
(103,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',10,'2025-11-18 11:35:58.175','2025-11-18 11:35:58.175'),
(104,'Student','ed3c2c85-81f5-4d5d-ad79-2bd1510a1dbd',10,'2025-11-18 11:35:58.176','2025-11-18 11:35:58.176'),
(105,'Student','55a2f1c2-7b32-4c99-9b2b-c18ce9651a1f',10,'2025-11-18 11:35:58.177','2025-11-18 11:35:58.177'),
(106,'Student','586b764a-7042-471e-a9b1-a0d51406c2a5',10,'2025-11-18 11:35:58.179','2025-11-18 11:35:58.179'),
(107,'Student','884100d4-f9f7-4ddf-a38f-55d0fbdabbce',10,'2025-11-18 11:35:58.180','2025-11-18 11:35:58.180'),
(108,'Student','ac837453-3165-40fa-b842-5637b4914359',10,'2025-11-18 11:35:58.181','2025-11-18 11:35:58.181'),
(109,'Student','8cb5046b-c42a-49b1-a01c-aafce475c9bf',10,'2025-11-18 11:35:58.182','2025-11-18 11:35:58.182'),
(110,'Student','a8f77397-7f04-4027-8d71-be3764a35c7b',10,'2025-11-18 11:35:58.184','2025-11-18 11:35:58.184'),
(111,'Teacher','b321547e-cbb4-4dee-821b-511af9435f61',11,'2025-11-18 11:35:58.193','2025-11-18 11:35:58.193'),
(112,'Student','616b64e4-33c4-48a5-b65d-a2ab5029aa29',11,'2025-11-18 11:35:58.194','2025-11-18 11:35:58.194'),
(113,'Student','8bfd1f6f-acd3-41e1-9e02-af8f53366b35',11,'2025-11-18 11:35:58.196','2025-11-18 11:35:58.196'),
(114,'Student','c7d44840-da80-486c-90ef-38e46acf2efa',11,'2025-11-18 11:35:58.197','2025-11-18 11:35:58.197'),
(115,'Student','2ab525f6-d8d5-4965-91ce-a02cbd0744b9',11,'2025-11-18 11:35:58.198','2025-11-18 11:35:58.198'),
(116,'Student','b918bba1-9e53-449c-ae05-96baac327bfb',11,'2025-11-18 11:35:58.199','2025-11-18 11:35:58.199'),
(117,'Student','b57cc648-6eb8-4c93-90c0-6514a9bafa62',11,'2025-11-18 11:35:58.201','2025-11-18 11:35:58.201'),
(118,'Student','c4d8d821-a0f5-41dd-b647-557f2897341c',11,'2025-11-18 11:35:58.202','2025-11-18 11:35:58.202'),
(119,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',11,'2025-11-18 11:35:58.203','2025-11-18 11:35:58.203'),
(120,'Student','e6f380e2-144e-4978-89f4-8a82fda3638f',11,'2025-11-18 11:35:58.204','2025-11-18 11:35:58.204'),
(121,'Student','13c966ff-8fa6-424b-b8ec-62949613d62b',11,'2025-11-18 11:35:58.206','2025-11-18 11:35:58.206'),
(122,'Teacher','b321547e-cbb4-4dee-821b-511af9435f61',12,'2025-11-18 11:35:58.207','2025-11-18 11:35:58.207'),
(123,'Student','1d164f13-ac09-4c6a-adaa-02759740d6ea',12,'2025-11-18 11:35:58.208','2025-11-18 11:35:58.208'),
(124,'Student','7d9d1502-a865-4786-85ff-33c1c1b3ad99',12,'2025-11-18 11:35:58.210','2025-11-18 11:35:58.210'),
(125,'Student','377da4c8-edb2-4b7b-8bfb-496e7c66e61b',12,'2025-11-18 11:35:58.211','2025-11-18 11:35:58.211'),
(126,'Student','618a5d4a-c1f7-474c-8355-98f88ed869a1',12,'2025-11-18 11:35:58.215','2025-11-18 11:35:58.215'),
(127,'Student','e6f380e2-144e-4978-89f4-8a82fda3638f',12,'2025-11-18 11:35:58.218','2025-11-18 11:35:58.218'),
(128,'Student','bcdb5db5-b0fc-438b-a82f-422022638703',12,'2025-11-18 11:35:58.220','2025-11-18 11:35:58.220'),
(129,'Student','81dfa56a-5b91-44f8-bca1-c420d2a0f52e',12,'2025-11-18 11:35:58.222','2025-11-18 11:35:58.222'),
(130,'Student','ed3c2c85-81f5-4d5d-ad79-2bd1510a1dbd',12,'2025-11-18 11:35:58.223','2025-11-18 11:35:58.223'),
(131,'Student','14ad3a68-5173-413a-b9c7-59f608ffbbf9',12,'2025-11-18 11:35:58.225','2025-11-18 11:35:58.225'),
(132,'Student','9410f2d8-80ac-416a-b9df-cb4a326d66a5',12,'2025-11-18 11:35:58.226','2025-11-18 11:35:58.226'),
(133,'Teacher','b321547e-cbb4-4dee-821b-511af9435f61',13,'2025-11-18 11:35:58.228','2025-11-18 11:35:58.228'),
(134,'Student','bcdb5db5-b0fc-438b-a82f-422022638703',13,'2025-11-18 11:35:58.229','2025-11-18 11:35:58.229'),
(135,'Student','9410f2d8-80ac-416a-b9df-cb4a326d66a5',13,'2025-11-18 11:35:58.230','2025-11-18 11:35:58.230'),
(136,'Student','d3797947-1482-4728-8832-1d7c3b32466f',13,'2025-11-18 11:35:58.232','2025-11-18 11:35:58.232'),
(137,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',13,'2025-11-18 11:35:58.233','2025-11-18 11:35:58.233'),
(138,'Student','81dfa56a-5b91-44f8-bca1-c420d2a0f52e',13,'2025-11-18 11:35:58.234','2025-11-18 11:35:58.234'),
(139,'Student','c4d8d821-a0f5-41dd-b647-557f2897341c',13,'2025-11-18 11:35:58.237','2025-11-18 11:35:58.237'),
(140,'Student','f8aa2643-d9d4-419a-8bd2-6606b32b0dd7',13,'2025-11-18 11:35:58.238','2025-11-18 11:35:58.238'),
(141,'Student','4bae7891-01d7-44c2-bd65-90b672e7ba60',13,'2025-11-18 11:35:58.241','2025-11-18 11:35:58.241'),
(142,'Student','1d164f13-ac09-4c6a-adaa-02759740d6ea',13,'2025-11-18 11:35:58.243','2025-11-18 11:35:58.243'),
(143,'Student','120d337e-8904-4516-ac54-d39c645fc206',13,'2025-11-18 11:35:58.245','2025-11-18 11:35:58.245'),
(144,'Teacher','b321547e-cbb4-4dee-821b-511af9435f61',14,'2025-11-18 11:35:58.246','2025-11-18 11:35:58.246'),
(145,'Student','d3797947-1482-4728-8832-1d7c3b32466f',14,'2025-11-18 11:35:58.247','2025-11-18 11:35:58.247'),
(146,'Student','2ab525f6-d8d5-4965-91ce-a02cbd0744b9',14,'2025-11-18 11:35:58.248','2025-11-18 11:35:58.248'),
(147,'Student','f60284bd-6f29-4111-acc8-85bd6b5cbe5c',14,'2025-11-18 11:35:58.250','2025-11-18 11:35:58.250'),
(148,'Student','5d9b3a7a-910b-409f-9f74-92b33343e3c0',14,'2025-11-18 11:35:58.251','2025-11-18 11:35:58.251'),
(149,'Student','9410f2d8-80ac-416a-b9df-cb4a326d66a5',14,'2025-11-18 11:35:58.252','2025-11-18 11:35:58.252'),
(150,'Student','bcdb5db5-b0fc-438b-a82f-422022638703',14,'2025-11-18 11:35:58.253','2025-11-18 11:35:58.253'),
(151,'Student','147dfec4-d7ba-41c1-ab13-b537466dc838',14,'2025-11-18 11:35:58.254','2025-11-18 11:35:58.254'),
(152,'Student','55a2f1c2-7b32-4c99-9b2b-c18ce9651a1f',14,'2025-11-18 11:35:58.259','2025-11-18 11:35:58.259'),
(153,'Student','2d034027-399e-4203-8f74-a3cb623e152d',14,'2025-11-18 11:35:58.261','2025-11-18 11:35:58.261'),
(154,'Student','8cb5046b-c42a-49b1-a01c-aafce475c9bf',14,'2025-11-18 11:35:58.263','2025-11-18 11:35:58.263');
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
('0e89fc2c-1e56-4c35-8900-6162f8356879','bde564d470fab41c136f8a2dc30030d38d8c0d5e42255b3cae1c4f9ee617b761','2025-11-18 11:35:51.928','20251116040034_init',NULL,NULL,'2025-11-18 11:35:51.861',1),
('79153cd7-55fb-49b6-bd40-a96c18c2cba2','852a4e2c166c689df64fa4b1e82bf527de22bffa0e6ace5b8e479414c9ec21aa','2025-11-18 11:35:51.966','20251116055534_update_quiz_material_relation_remove_time',NULL,NULL,'2025-11-18 11:35:51.929',1),
('ba9f68aa-a8e1-47ec-a1fb-10d72369a532','330c558dd59e57f5be2e0b739af7e167005897877a1e9b870d17154fc31ad60e','2025-11-18 11:35:51.860','20251115092106_remove_subscription_plan',NULL,NULL,'2025-11-18 11:35:51.831',1),
('bf343957-5b3b-4b80-9ff5-b8b7e86cabc8','5d535f395498abb562d62c3d16a60924963a26c3c065d32a7a5e1f066075fcb1','2025-11-18 11:35:51.831','20251112144809_init',NULL,NULL,'2025-11-18 11:35:51.319',1);
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
(1,'Essay',0,'2025-11-18 11:35:58.026','2025-11-18 11:35:58.026'),
(2,'Business Plan',0,'2025-11-18 11:35:58.026','2025-11-18 11:35:58.026'),
(3,'Penelitian',0,'2025-11-18 11:35:58.026','2025-11-18 11:35:58.026'),
(4,'Desain',0,'2025-11-18 11:35:58.026','2025-11-18 11:35:58.026');
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

-- Dump completed on 2025-11-18 18:36:13

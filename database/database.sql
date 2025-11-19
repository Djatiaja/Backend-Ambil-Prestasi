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
(1,1,'voluptatem','fugit voluptatibus consequuntur commodi et error qui labore esse quasi voluptatem aut sequi occaecati reiciendis eos vitae commodi eos vel et magnam excepturi sequi quasi neque blanditiis repellat consequuntur fugiat','files/public/placeholder.png','2025-11-19 04:14:52.665','2025-11-19 04:14:52.665'),
(2,1,'at','nostrum nemo nihil ipsum magnam excepturi in consequatur quaerat necessitatibus at asperiores hic deserunt tenetur labore ducimus omnis facilis quae et ipsum laborum vitae est facilis quia eos fugit voluptate','files/public/placeholder.png','2025-11-19 04:14:52.667','2025-11-19 04:14:52.667'),
(3,1,'blanditiis','repellat fugit aliquid consequuntur fugiat maiores eos quia necessitatibus commodi cupiditate quae sunt repellat ducimus enim aut aliquid esse voluptatibus aliquid quas quas at qui id in numquam exercitationem deserunt','files/public/placeholder.png','2025-11-19 04:14:52.668','2025-11-19 04:14:52.668'),
(4,1,'non','sit enim fugiat excepturi voluptate enim rerum et vitae voluptate magnam laborum omnis at reiciendis ipsum cupiditate in ullam vitae sapiente sunt hic dolores consequuntur blanditiis voluptatem quos quia possimus','files/public/placeholder.png','2025-11-19 04:14:52.669','2025-11-19 04:14:52.669'),
(5,1,'nemo','quas doloribus nemo doloribus deserunt ullam neque hic non voluptatem numquam deserunt vel commodi quae esse neque voluptate blanditiis tenetur nemo dolores quasi vitae sequi fugit consequatur sapiente magnam consequuntur','files/public/placeholder.png','2025-11-19 04:14:52.670','2025-11-19 04:14:52.670'),
(6,1,'neque','blanditiis rerum numquam quae unde quas dicta exercitationem et blanditiis exercitationem dolores labore id at qui deserunt voluptatibus enim reiciendis cupiditate fugit quia consequatur est et laborum deserunt nemo hic','files/public/placeholder.png','2025-11-19 04:14:52.671','2025-11-19 04:14:52.671'),
(7,1,'est','eos hic esse necessitatibus at consequatur non voluptate occaecati repellat doloribus et cupiditate labore magnam rerum possimus occaecati rerum ipsum unde facilis doloribus et consequatur vitae nemo omnis est nulla','files/public/placeholder.png','2025-11-19 04:14:52.672','2025-11-19 04:14:52.672'),
(8,1,'consectetur','aliquid deserunt vitae enim quos fugit quasi et sunt consequuntur nulla sequi nihil voluptate deserunt exercitationem vitae repellat at dolores unde consequuntur consequuntur necessitatibus numquam qui dolores voluptate aut fugit','files/public/placeholder.png','2025-11-19 04:14:52.674','2025-11-19 04:14:52.674'),
(9,1,'sequi','sed quaerat in sit hic excepturi numquam maiores consequatur nostrum nemo voluptatibus qui consequatur tenetur unde magnam aut magnam qui deserunt necessitatibus quos consequatur sequi hic vel qui reiciendis labore','files/public/placeholder.png','2025-11-19 04:14:52.675','2025-11-19 04:14:52.675'),
(10,1,'cupiditate','sapiente cupiditate facilis consequatur tenetur eos aliquid excepturi rerum sapiente quia sed fugiat quos facilis deserunt nulla ducimus neque eos reiciendis numquam reiciendis deserunt sapiente repellat nemo tenetur error doloribus','files/public/placeholder.png','2025-11-19 04:14:52.676','2025-11-19 04:14:52.676'),
(11,1,'PPK','ipsum maiores vel asperiores eos magnam vitae facilis qui neque non vel in quaerat enim reiciendis quia fugiat ducimus voluptatem esse reiciendis quae tenetur at sed beatae possimus voluptate quaerat','files/public/placeholder.png','2025-11-19 04:14:52.793','2025-11-19 04:14:52.793'),
(12,2,'Pancasila','rerum laborum deserunt id quaerat sit sit labore excepturi quasi blanditiis vel numquam enim ipsum sed sit blanditiis error tenetur facilis omnis repellat dolores excepturi hic necessitatibus est est quae','files/public/placeholder.png','2025-11-19 04:14:52.794','2025-11-19 04:14:52.794'),
(13,3,'Agama','aut magnam necessitatibus ducimus tenetur blanditiis eos necessitatibus error qui tenetur dolores vel consequuntur nemo quas dolores magnam at dolores occaecati nostrum aliquid est eos rerum dicta est cupiditate asperiores','files/public/placeholder.png','2025-11-19 04:14:52.795','2025-11-19 04:14:52.795'),
(14,2,'Bahasa Indonesia','commodi voluptatem voluptate qui reiciendis voluptatem aut quia in ducimus neque nostrum voluptatem cupiditate omnis aliquid facilis sit rerum fugiat ipsum vel cupiditate beatae nihil consectetur consequatur voluptatibus exercitationem neque','files/public/placeholder.png','2025-11-19 04:14:52.796','2025-11-19 04:14:52.796');
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
(1,'Admin','2025-11-19 04:14:52.482','2025-11-19 04:14:52.482'),
(2,'Teacher','2025-11-19 04:14:52.482','2025-11-19 04:14:52.482'),
(3,'Student','2025-11-19 04:14:52.482','2025-11-19 04:14:52.482');
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
('01a01141-234f-4d70-9c40-27f632fd43ef','student37@example.com','student37','Yhudiyt_Żak6','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+37&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.643','2021-08-14 20:29:45.957','2025-11-19 04:14:52.644',3),
('02a52c74-f7ef-4c71-9203-4223468b7bf7','student22@example.com','student22','Thawi_Huang','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+22&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.610','2024-10-31 09:10:01.218','2025-11-19 04:14:52.610',3),
('06a90f08-f867-4284-b626-e1aea63e4630','student8@example.com','student8','Anton_Kamiński','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+8&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.587','2024-08-01 16:24:36.943','2025-11-19 04:14:52.588',3),
('06dec8fc-2338-439d-96db-58e5f48e1371','student29@example.com','student29','Suphaphon.Sokołowski','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+29&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.634','2022-10-11 18:12:59.353','2025-11-19 04:14:52.635',3),
('089478d4-2943-4f6e-aa24-06ca57602c21','student13@example.com','student13','Nittaya_Huber20','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+13&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.595','2022-02-16 11:58:17.617','2025-11-19 04:14:52.595',3),
('107c1cff-458a-4045-a2a1-8a1296292d33','teacher1@example.com','teacher1','Xiang_Őhlschlägerová46','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Teacher+1&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 04:14:52.563','2024-01-15 19:49:36.755','2025-11-19 04:14:52.564',2),
('13c3620d-bf19-45fb-8ece-28866a00e8c6','student5@example.com','student5','Aleksey.Gísladóttir','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+5&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.581','2023-01-29 21:01:37.321','2025-11-19 04:14:52.581',3),
('16420600-8509-40e4-b2ed-a6cee5b76586','student23@example.com','student23','Igor_Jäger','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+23&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.611','2024-02-09 09:04:00.121','2025-11-19 04:14:52.612',3),
('1eba4735-1ff6-4bec-8776-5eefe4b5218f','djamgt23@gmail.com','admin','Admin User','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Admin+User&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.549','2025-10-24 20:09:18.373','2025-11-19 04:14:52.551',1),
('1efc4f48-d4dc-4b7d-b817-9520e7b07c41','student40@example.com','student40','Moses.Werner','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+40&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.647','2023-05-22 06:06:25.967','2025-11-19 04:14:52.648',3),
('2146dbe6-5991-470e-9cd7-aa5f1524053d','student45@example.com','student45','Jacobus_Pétursson','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+45&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.654','2025-01-25 11:20:53.514','2025-11-19 04:14:52.654',3),
('24c3aa03-08c5-4c1e-9278-ea5ec4c552db','student27@example.com','student27','Karen_Carter','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+27&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.632','2024-10-27 18:50:17.156','2025-11-19 04:14:52.632',3),
('27784591-6370-4a02-be60-99939ed1a8c6','student32@example.com','student32','Sunita_Guzmán11','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+32&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.638','2025-02-16 00:05:07.157','2025-11-19 04:14:52.638',3),
('2a52a0f5-ea46-4492-a740-7510faf42549','student6@example.com','student6','Eugenia_Mahagna','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+6&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.582','2025-03-20 05:36:58.739','2025-11-19 04:14:52.583',3),
('2dcfdcc6-5727-4c59-931d-20fe51568d5e','student43@example.com','student43','Johanna.Olszewski61','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+43&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.651','2025-01-12 12:29:01.454','2025-11-19 04:14:52.651',3),
('467476bd-e9ea-4cab-aef3-fcbab30c4d2f','student14@example.com','student14','Hadiza.Harle-Cowan','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+14&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.596','2021-12-05 05:58:31.818','2025-11-19 04:14:52.596',3),
('4a22e997-41f8-48dc-b9d0-4a30954b6eea','student33@example.com','student33','Akira_Collins','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+33&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.639','2023-02-05 07:01:15.536','2025-11-19 04:14:52.639',3),
('50c21929-22fa-4f24-97bb-ea166917a591','student24@example.com','student24','Xiaoli_Hoekstra8','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+24&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.628','2025-10-27 10:36:44.866','2025-11-19 04:14:52.628',3),
('52f50a31-c329-46d4-b393-2300d5d7a566','student38@example.com','student38','Chayah_König58','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+38&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.645','2024-03-24 09:31:55.794','2025-11-19 04:14:52.645',3),
('55ad0298-1275-473e-b4ac-f6717ecff3c4','student34@example.com','student34','Katsumi_Fröhlich68','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+34&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.640','2022-01-02 15:50:19.392','2025-11-19 04:14:52.641',3),
('5e042d84-b99e-4cbf-9e56-0e13bf478a19','student17@example.com','student17','Kai.Mahato','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+17&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.600','2024-05-11 03:17:25.956','2025-11-19 04:14:52.600',3),
('5e7d2b4c-9c7b-4231-86b6-29506a783139','student1@example.com','student1','Noam.Njuguna74','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+1&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.572','2023-02-09 09:29:48.536','2025-11-19 04:14:52.573',3),
('60594712-6cc4-4ecf-ae31-bb5a3b4c9fbb','student44@example.com','student44','Steinunn_Helgadóttir','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+44&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.652','2024-07-17 06:42:20.632','2025-11-19 04:14:52.653',3),
('617211f8-49a6-43de-b4a1-46f0f209b03f','student16@example.com','student16','Watsana.Horák21','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+16&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.598','2024-05-27 20:07:17.128','2025-11-19 04:14:52.599',3),
('62865831-8334-4bb5-a0fc-77ed413f4c30','student19@example.com','student19','Isaac_Æbelø','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+19&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.604','2025-09-26 01:37:08.744','2025-11-19 04:14:52.605',3),
('69ffc999-3b15-4fff-ac9c-a8824c3c47ab','student39@example.com','student39','Nkosinathi.Zajac','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+39&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.646','2021-10-28 21:06:00.958','2025-11-19 04:14:52.647',3),
('7235332e-1683-4249-a5b3-87d8fe56ac24','student48@example.com','student48','Paulina.Jónasdóttir','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+48&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.658','2022-05-16 07:50:24.114','2025-11-19 04:14:52.658',3),
('73baed1d-345f-4a13-b6c9-6fe384865c3c','student46@example.com','student46','Jin_Dahan','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+46&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.655','2024-04-12 01:42:42.555','2025-11-19 04:14:52.656',3),
('78a61336-34f7-41af-8b78-e9d39b44d41c','student10@example.com','student10','Julie_Ríos75','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+10&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.591','2024-10-05 11:50:48.321','2025-11-19 04:14:52.592',3),
('7a83db2f-69ac-4f04-9309-2e5df45a74cf','student26@example.com','student26','Guy.Procházková62','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+26&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.630','2021-08-19 09:53:13.939','2025-11-19 04:14:52.631',3),
('7b2fbaac-5cc9-476a-84b8-54466684d98c','student18@example.com','student18','Lakshmi.Kariuki35','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+18&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.602','2021-03-17 08:05:56.434','2025-11-19 04:14:52.603',3),
('7b52133d-7af2-45a8-a084-20cce0e25fcc','student31@example.com','student31','Kai.Mazibuko22','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+31&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.636','2022-05-25 03:41:31.225','2025-11-19 04:14:52.637',3),
('847435c7-9f31-4cb7-8892-d4915666153c','student25@example.com','student25','Yong_Marková','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+25&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.629','2021-08-28 00:59:08.022','2025-11-19 04:14:52.630',3),
('893d8088-ce88-4b24-a48d-9ac3e3d82e95','student42@example.com','student42','Nan.Novotný','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+42&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.650','2025-06-01 16:09:50.028','2025-11-19 04:14:52.650',3),
('89550352-5f5c-47ab-bf65-efc7cc2c10b0','student21@example.com','student21','Jakub.Egorov90','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+21&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.608','2021-03-22 23:01:12.434','2025-11-19 04:14:52.609',3),
('938336e9-bb0e-46df-a17f-520147c992bf','student36@example.com','student36','Heike_Meißner','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+36&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.642','2022-04-24 23:25:45.875','2025-11-19 04:14:52.643',3),
('97026abb-800d-475d-afd2-b219a641ef1c','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=teachertestacc&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.662','2022-12-10 22:40:27.210','2025-11-19 04:14:52.662',2),
('99c963a9-2fd7-443e-9e73-0b84c787db4e','student20@example.com','student20','Zbigniew.Schmid1','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+20&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.606','2024-10-14 06:37:24.500','2025-11-19 04:14:52.607',3),
('9a034945-4b77-4f7a-9fe1-da0fe52befc7','student4@example.com','student4','Alexey.Sah','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+4&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.579','2022-08-08 15:13:38.667','2025-11-19 04:14:52.579',3),
('9a0622e2-9288-40a3-9f17-20552bac0280','student47@example.com','student47','Xolani_Davies50','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+47&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.656','2021-05-16 04:37:49.457','2025-11-19 04:14:52.657',3),
('9fad6441-c2fc-4f74-a2e9-3e31cea8061e','teacher3@example.com','teacher3','Liping.Baker','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Teacher+3&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 04:14:52.569','2025-10-15 05:50:56.654','2025-11-19 04:14:52.570',2),
('9fd931b4-0bd3-4225-95ed-4836fa138f28','student2@example.com','student2','Simon.Þorsteinsdóttir81','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+2&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.574','2021-12-07 21:10:52.038','2025-11-19 04:14:52.575',3),
('a5169597-f3c3-4926-8ab2-f8706b7bec33','student50@example.com','student50','Tal.Cui13','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+50&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.660','2020-11-20 05:01:04.251','2025-11-19 04:14:52.661',3),
('a5324c2d-c3c7-4f4f-8ed1-2630762140a5','student12@example.com','student12','Ibrahim_Mor','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+12&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.594','2025-04-19 09:50:45.724','2025-11-19 04:14:52.594',3),
('acdb65e1-9206-41f9-bc29-0b9669a55779','student7@example.com','student7','Mahmood.Őhlschlägerová14','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+7&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.584','2024-12-15 16:30:41.403','2025-11-19 04:14:52.585',3),
('b0f72cf5-9e1d-464b-8a5f-d9d3845e148f','student35@example.com','student35','Suresh.Udo77','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+35&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.641','2023-08-03 20:32:45.256','2025-11-19 04:14:52.642',3),
('b15f9a75-a92d-4c26-90ee-14ce741e6609','student49@example.com','student49','Keiko.Hernández79','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+49&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.659','2021-11-20 18:39:12.108','2025-11-19 04:14:52.660',3),
('bb6ca350-ab89-43e1-b3ad-9236cd07f228','student28@example.com','student28','Lin_Schmitt64','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+28&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.633','2022-06-19 15:16:22.504','2025-11-19 04:14:52.633',3),
('c0dc06f2-4402-469f-a0fb-c86515243c65','student3@example.com','student3','Claire_Prieto97','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+3&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.575','2023-09-15 03:01:27.500','2025-11-19 04:14:52.576',3),
('ce163b8d-34f2-49e8-8e26-2685d497b4cb','student11@example.com','student11','Samran.Okada5','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+11&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.592','2022-03-23 21:02:31.313','2025-11-19 04:14:52.593',3),
('d00a2bdb-ec48-4bd9-8c48-642ef0118450','teacher2@example.com','teacher2','Nancy.Abubakar30','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Teacher+2&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 04:14:52.567','2021-08-17 08:54:23.275','2025-11-19 04:14:52.568',2),
('dca27f76-c5ee-45fa-a7bc-a5a36a386512','student41@example.com','student41','Andrey_Rabiu','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+41&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.648','2022-04-08 21:11:43.104','2025-11-19 04:14:52.649',3),
('de2ede8c-680a-407e-a2f4-e0c4e68cc8e5','teacher4@example.com','teacher4','Chao.Sikora','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Teacher+4&background=random','08123456789','ACTIVE','Mathematics','Experienced math teacher with a passion for helping students succeed.','2025-11-19 04:14:52.571','2021-03-19 09:21:03.243','2025-11-19 04:14:52.572',2),
('e7943a12-0757-4cc1-b61c-6410f99a4cc0','student15@example.com','student15','Horst.Mtshali20','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+15&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.597','2021-09-25 15:22:09.994','2025-11-19 04:14:52.598',3),
('ed6b89ff-ba24-41d2-9da3-82a9b418a0a2','student9@example.com','student9','Somsak_Zakharova','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+9&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.589','2022-04-29 05:29:24.101','2025-11-19 04:14:52.590',3),
('f8f53100-657c-417e-a018-8a06044ddc17','student30@example.com','student30','Ajay.Göbel','$2b$10$2LmoC.WZiO7OTylHG3dUYOeY2oiG2g93ur0Dhfm.9msXaO25V8dAG','https://ui-avatars.com/api/?name=Student+30&background=random',NULL,'ACTIVE',NULL,NULL,'2025-11-19 04:14:52.635','2022-06-03 12:05:24.167','2025-11-19 04:14:52.636',3);
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
(1,'Teacher','9fad6441-c2fc-4f74-a2e9-3e31cea8061e',1,'2025-11-19 04:14:52.683','2025-11-19 04:14:52.683'),
(2,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',1,'2025-11-19 04:14:52.685','2025-11-19 04:14:52.685'),
(3,'Student','02a52c74-f7ef-4c71-9203-4223468b7bf7',1,'2025-11-19 04:14:52.687','2025-11-19 04:14:52.687'),
(4,'Student','5e042d84-b99e-4cbf-9e56-0e13bf478a19',1,'2025-11-19 04:14:52.688','2025-11-19 04:14:52.688'),
(5,'Student','50c21929-22fa-4f24-97bb-ea166917a591',1,'2025-11-19 04:14:52.689','2025-11-19 04:14:52.689'),
(6,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',1,'2025-11-19 04:14:52.690','2025-11-19 04:14:52.690'),
(7,'Student','7b2fbaac-5cc9-476a-84b8-54466684d98c',1,'2025-11-19 04:14:52.691','2025-11-19 04:14:52.691'),
(8,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',1,'2025-11-19 04:14:52.692','2025-11-19 04:14:52.692'),
(9,'Student','2146dbe6-5991-470e-9cd7-aa5f1524053d',1,'2025-11-19 04:14:52.693','2025-11-19 04:14:52.693'),
(10,'Student','e7943a12-0757-4cc1-b61c-6410f99a4cc0',1,'2025-11-19 04:14:52.694','2025-11-19 04:14:52.694'),
(11,'Student','938336e9-bb0e-46df-a17f-520147c992bf',1,'2025-11-19 04:14:52.695','2025-11-19 04:14:52.695'),
(12,'Teacher','97026abb-800d-475d-afd2-b219a641ef1c',2,'2025-11-19 04:14:52.697','2025-11-19 04:14:52.697'),
(13,'Student','73baed1d-345f-4a13-b6c9-6fe384865c3c',2,'2025-11-19 04:14:52.698','2025-11-19 04:14:52.698'),
(14,'Student','7235332e-1683-4249-a5b3-87d8fe56ac24',2,'2025-11-19 04:14:52.700','2025-11-19 04:14:52.700'),
(15,'Student','16420600-8509-40e4-b2ed-a6cee5b76586',2,'2025-11-19 04:14:52.701','2025-11-19 04:14:52.701'),
(16,'Student','62865831-8334-4bb5-a0fc-77ed413f4c30',2,'2025-11-19 04:14:52.702','2025-11-19 04:14:52.702'),
(17,'Student','9fd931b4-0bd3-4225-95ed-4836fa138f28',2,'2025-11-19 04:14:52.703','2025-11-19 04:14:52.703'),
(18,'Student','50c21929-22fa-4f24-97bb-ea166917a591',2,'2025-11-19 04:14:52.704','2025-11-19 04:14:52.704'),
(19,'Student','5e7d2b4c-9c7b-4231-86b6-29506a783139',2,'2025-11-19 04:14:52.705','2025-11-19 04:14:52.705'),
(20,'Student','9a034945-4b77-4f7a-9fe1-da0fe52befc7',2,'2025-11-19 04:14:52.706','2025-11-19 04:14:52.706'),
(21,'Student','ce163b8d-34f2-49e8-8e26-2685d497b4cb',2,'2025-11-19 04:14:52.707','2025-11-19 04:14:52.707'),
(22,'Student','467476bd-e9ea-4cab-aef3-fcbab30c4d2f',2,'2025-11-19 04:14:52.708','2025-11-19 04:14:52.708'),
(23,'Teacher','de2ede8c-680a-407e-a2f4-e0c4e68cc8e5',3,'2025-11-19 04:14:52.709','2025-11-19 04:14:52.709'),
(24,'Student','893d8088-ce88-4b24-a48d-9ac3e3d82e95',3,'2025-11-19 04:14:52.710','2025-11-19 04:14:52.710'),
(25,'Student','7b2fbaac-5cc9-476a-84b8-54466684d98c',3,'2025-11-19 04:14:52.711','2025-11-19 04:14:52.711'),
(26,'Student','ed6b89ff-ba24-41d2-9da3-82a9b418a0a2',3,'2025-11-19 04:14:52.712','2025-11-19 04:14:52.712'),
(27,'Student','78a61336-34f7-41af-8b78-e9d39b44d41c',3,'2025-11-19 04:14:52.713','2025-11-19 04:14:52.713'),
(28,'Student','c0dc06f2-4402-469f-a0fb-c86515243c65',3,'2025-11-19 04:14:52.714','2025-11-19 04:14:52.714'),
(29,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',3,'2025-11-19 04:14:52.715','2025-11-19 04:14:52.715'),
(30,'Student','9a034945-4b77-4f7a-9fe1-da0fe52befc7',3,'2025-11-19 04:14:52.716','2025-11-19 04:14:52.716'),
(31,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',3,'2025-11-19 04:14:52.717','2025-11-19 04:14:52.717'),
(32,'Student','9a0622e2-9288-40a3-9f17-20552bac0280',3,'2025-11-19 04:14:52.718','2025-11-19 04:14:52.718'),
(33,'Student','1efc4f48-d4dc-4b7d-b817-9520e7b07c41',3,'2025-11-19 04:14:52.719','2025-11-19 04:14:52.719'),
(34,'Teacher','d00a2bdb-ec48-4bd9-8c48-642ef0118450',4,'2025-11-19 04:14:52.719','2025-11-19 04:14:52.719'),
(35,'Student','7b52133d-7af2-45a8-a084-20cce0e25fcc',4,'2025-11-19 04:14:52.720','2025-11-19 04:14:52.720'),
(36,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',4,'2025-11-19 04:14:52.721','2025-11-19 04:14:52.721'),
(37,'Student','847435c7-9f31-4cb7-8892-d4915666153c',4,'2025-11-19 04:14:52.722','2025-11-19 04:14:52.722'),
(38,'Student','89550352-5f5c-47ab-bf65-efc7cc2c10b0',4,'2025-11-19 04:14:52.723','2025-11-19 04:14:52.723'),
(39,'Student','2a52a0f5-ea46-4492-a740-7510faf42549',4,'2025-11-19 04:14:52.724','2025-11-19 04:14:52.724'),
(40,'Student','02a52c74-f7ef-4c71-9203-4223468b7bf7',4,'2025-11-19 04:14:52.725','2025-11-19 04:14:52.725'),
(41,'Student','50c21929-22fa-4f24-97bb-ea166917a591',4,'2025-11-19 04:14:52.726','2025-11-19 04:14:52.726'),
(42,'Student','5e042d84-b99e-4cbf-9e56-0e13bf478a19',4,'2025-11-19 04:14:52.727','2025-11-19 04:14:52.727'),
(43,'Student','60594712-6cc4-4ecf-ae31-bb5a3b4c9fbb',4,'2025-11-19 04:14:52.727','2025-11-19 04:14:52.727'),
(44,'Student','06a90f08-f867-4284-b626-e1aea63e4630',4,'2025-11-19 04:14:52.728','2025-11-19 04:14:52.728'),
(45,'Teacher','9fad6441-c2fc-4f74-a2e9-3e31cea8061e',5,'2025-11-19 04:14:52.729','2025-11-19 04:14:52.729'),
(46,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',5,'2025-11-19 04:14:52.730','2025-11-19 04:14:52.730'),
(47,'Student','4a22e997-41f8-48dc-b9d0-4a30954b6eea',5,'2025-11-19 04:14:52.731','2025-11-19 04:14:52.731'),
(48,'Student','06dec8fc-2338-439d-96db-58e5f48e1371',5,'2025-11-19 04:14:52.732','2025-11-19 04:14:52.732'),
(49,'Student','089478d4-2943-4f6e-aa24-06ca57602c21',5,'2025-11-19 04:14:52.733','2025-11-19 04:14:52.733'),
(50,'Student','acdb65e1-9206-41f9-bc29-0b9669a55779',5,'2025-11-19 04:14:52.734','2025-11-19 04:14:52.734'),
(51,'Student','847435c7-9f31-4cb7-8892-d4915666153c',5,'2025-11-19 04:14:52.735','2025-11-19 04:14:52.735'),
(52,'Student','99c963a9-2fd7-443e-9e73-0b84c787db4e',5,'2025-11-19 04:14:52.735','2025-11-19 04:14:52.735'),
(53,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',5,'2025-11-19 04:14:52.736','2025-11-19 04:14:52.736'),
(54,'Student','467476bd-e9ea-4cab-aef3-fcbab30c4d2f',5,'2025-11-19 04:14:52.737','2025-11-19 04:14:52.737'),
(55,'Student','7b52133d-7af2-45a8-a084-20cce0e25fcc',5,'2025-11-19 04:14:52.738','2025-11-19 04:14:52.738'),
(56,'Teacher','9fad6441-c2fc-4f74-a2e9-3e31cea8061e',6,'2025-11-19 04:14:52.739','2025-11-19 04:14:52.739'),
(57,'Student','24c3aa03-08c5-4c1e-9278-ea5ec4c552db',6,'2025-11-19 04:14:52.740','2025-11-19 04:14:52.740'),
(58,'Student','7b2fbaac-5cc9-476a-84b8-54466684d98c',6,'2025-11-19 04:14:52.741','2025-11-19 04:14:52.741'),
(59,'Student','dca27f76-c5ee-45fa-a7bc-a5a36a386512',6,'2025-11-19 04:14:52.742','2025-11-19 04:14:52.742'),
(60,'Student','7b52133d-7af2-45a8-a084-20cce0e25fcc',6,'2025-11-19 04:14:52.743','2025-11-19 04:14:52.743'),
(61,'Student','2146dbe6-5991-470e-9cd7-aa5f1524053d',6,'2025-11-19 04:14:52.744','2025-11-19 04:14:52.744'),
(62,'Student','a5324c2d-c3c7-4f4f-8ed1-2630762140a5',6,'2025-11-19 04:14:52.745','2025-11-19 04:14:52.745'),
(63,'Student','467476bd-e9ea-4cab-aef3-fcbab30c4d2f',6,'2025-11-19 04:14:52.746','2025-11-19 04:14:52.746'),
(64,'Student','13c3620d-bf19-45fb-8ece-28866a00e8c6',6,'2025-11-19 04:14:52.747','2025-11-19 04:14:52.747'),
(65,'Student','ce163b8d-34f2-49e8-8e26-2685d497b4cb',6,'2025-11-19 04:14:52.748','2025-11-19 04:14:52.748'),
(66,'Student','99c963a9-2fd7-443e-9e73-0b84c787db4e',6,'2025-11-19 04:14:52.749','2025-11-19 04:14:52.749'),
(67,'Teacher','d00a2bdb-ec48-4bd9-8c48-642ef0118450',7,'2025-11-19 04:14:52.750','2025-11-19 04:14:52.750'),
(68,'Student','847435c7-9f31-4cb7-8892-d4915666153c',7,'2025-11-19 04:14:52.751','2025-11-19 04:14:52.751'),
(69,'Student','62865831-8334-4bb5-a0fc-77ed413f4c30',7,'2025-11-19 04:14:52.752','2025-11-19 04:14:52.752'),
(70,'Student','5e042d84-b99e-4cbf-9e56-0e13bf478a19',7,'2025-11-19 04:14:52.753','2025-11-19 04:14:52.753'),
(71,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',7,'2025-11-19 04:14:52.754','2025-11-19 04:14:52.754'),
(72,'Student','acdb65e1-9206-41f9-bc29-0b9669a55779',7,'2025-11-19 04:14:52.755','2025-11-19 04:14:52.755'),
(73,'Student','893d8088-ce88-4b24-a48d-9ac3e3d82e95',7,'2025-11-19 04:14:52.756','2025-11-19 04:14:52.756'),
(74,'Student','06dec8fc-2338-439d-96db-58e5f48e1371',7,'2025-11-19 04:14:52.757','2025-11-19 04:14:52.757'),
(75,'Student','73baed1d-345f-4a13-b6c9-6fe384865c3c',7,'2025-11-19 04:14:52.758','2025-11-19 04:14:52.758'),
(76,'Student','b15f9a75-a92d-4c26-90ee-14ce741e6609',7,'2025-11-19 04:14:52.759','2025-11-19 04:14:52.759'),
(77,'Student','9fd931b4-0bd3-4225-95ed-4836fa138f28',7,'2025-11-19 04:14:52.760','2025-11-19 04:14:52.760'),
(78,'Teacher','d00a2bdb-ec48-4bd9-8c48-642ef0118450',8,'2025-11-19 04:14:52.761','2025-11-19 04:14:52.761'),
(79,'Student','02a52c74-f7ef-4c71-9203-4223468b7bf7',8,'2025-11-19 04:14:52.762','2025-11-19 04:14:52.762'),
(80,'Student','50c21929-22fa-4f24-97bb-ea166917a591',8,'2025-11-19 04:14:52.762','2025-11-19 04:14:52.762'),
(81,'Student','ce163b8d-34f2-49e8-8e26-2685d497b4cb',8,'2025-11-19 04:14:52.763','2025-11-19 04:14:52.763'),
(82,'Student','06dec8fc-2338-439d-96db-58e5f48e1371',8,'2025-11-19 04:14:52.764','2025-11-19 04:14:52.764'),
(83,'Student','9a0622e2-9288-40a3-9f17-20552bac0280',8,'2025-11-19 04:14:52.765','2025-11-19 04:14:52.765'),
(84,'Student','2a52a0f5-ea46-4492-a740-7510faf42549',8,'2025-11-19 04:14:52.766','2025-11-19 04:14:52.766'),
(85,'Student','7235332e-1683-4249-a5b3-87d8fe56ac24',8,'2025-11-19 04:14:52.767','2025-11-19 04:14:52.767'),
(86,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',8,'2025-11-19 04:14:52.768','2025-11-19 04:14:52.768'),
(87,'Student','69ffc999-3b15-4fff-ac9c-a8824c3c47ab',8,'2025-11-19 04:14:52.769','2025-11-19 04:14:52.769'),
(88,'Student','a5324c2d-c3c7-4f4f-8ed1-2630762140a5',8,'2025-11-19 04:14:52.770','2025-11-19 04:14:52.770'),
(89,'Teacher','107c1cff-458a-4045-a2a1-8a1296292d33',9,'2025-11-19 04:14:52.771','2025-11-19 04:14:52.771'),
(90,'Student','7b52133d-7af2-45a8-a084-20cce0e25fcc',9,'2025-11-19 04:14:52.772','2025-11-19 04:14:52.772'),
(91,'Student','06dec8fc-2338-439d-96db-58e5f48e1371',9,'2025-11-19 04:14:52.773','2025-11-19 04:14:52.773'),
(92,'Student','089478d4-2943-4f6e-aa24-06ca57602c21',9,'2025-11-19 04:14:52.774','2025-11-19 04:14:52.774'),
(93,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',9,'2025-11-19 04:14:52.775','2025-11-19 04:14:52.775'),
(94,'Student','a5169597-f3c3-4926-8ab2-f8706b7bec33',9,'2025-11-19 04:14:52.776','2025-11-19 04:14:52.776'),
(95,'Student','24c3aa03-08c5-4c1e-9278-ea5ec4c552db',9,'2025-11-19 04:14:52.777','2025-11-19 04:14:52.777'),
(96,'Student','1efc4f48-d4dc-4b7d-b817-9520e7b07c41',9,'2025-11-19 04:14:52.778','2025-11-19 04:14:52.778'),
(97,'Student','69ffc999-3b15-4fff-ac9c-a8824c3c47ab',9,'2025-11-19 04:14:52.779','2025-11-19 04:14:52.779'),
(98,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',9,'2025-11-19 04:14:52.780','2025-11-19 04:14:52.780'),
(99,'Student','a5324c2d-c3c7-4f4f-8ed1-2630762140a5',9,'2025-11-19 04:14:52.781','2025-11-19 04:14:52.781'),
(100,'Teacher','107c1cff-458a-4045-a2a1-8a1296292d33',10,'2025-11-19 04:14:52.782','2025-11-19 04:14:52.782'),
(101,'Student','5e7d2b4c-9c7b-4231-86b6-29506a783139',10,'2025-11-19 04:14:52.783','2025-11-19 04:14:52.783'),
(102,'Student','4a22e997-41f8-48dc-b9d0-4a30954b6eea',10,'2025-11-19 04:14:52.784','2025-11-19 04:14:52.784'),
(103,'Student','938336e9-bb0e-46df-a17f-520147c992bf',10,'2025-11-19 04:14:52.784','2025-11-19 04:14:52.784'),
(104,'Student','089478d4-2943-4f6e-aa24-06ca57602c21',10,'2025-11-19 04:14:52.785','2025-11-19 04:14:52.785'),
(105,'Student','02a52c74-f7ef-4c71-9203-4223468b7bf7',10,'2025-11-19 04:14:52.787','2025-11-19 04:14:52.787'),
(106,'Student','16420600-8509-40e4-b2ed-a6cee5b76586',10,'2025-11-19 04:14:52.788','2025-11-19 04:14:52.788'),
(107,'Student','13c3620d-bf19-45fb-8ece-28866a00e8c6',10,'2025-11-19 04:14:52.789','2025-11-19 04:14:52.789'),
(108,'Student','78a61336-34f7-41af-8b78-e9d39b44d41c',10,'2025-11-19 04:14:52.790','2025-11-19 04:14:52.790'),
(109,'Student','893d8088-ce88-4b24-a48d-9ac3e3d82e95',10,'2025-11-19 04:14:52.790','2025-11-19 04:14:52.790'),
(110,'Student','a5169597-f3c3-4926-8ab2-f8706b7bec33',10,'2025-11-19 04:14:52.791','2025-11-19 04:14:52.791'),
(111,'Teacher','97026abb-800d-475d-afd2-b219a641ef1c',11,'2025-11-19 04:14:52.799','2025-11-19 04:14:52.799'),
(112,'Student','467476bd-e9ea-4cab-aef3-fcbab30c4d2f',11,'2025-11-19 04:14:52.800','2025-11-19 04:14:52.800'),
(113,'Student','e7943a12-0757-4cc1-b61c-6410f99a4cc0',11,'2025-11-19 04:14:52.801','2025-11-19 04:14:52.801'),
(114,'Student','1efc4f48-d4dc-4b7d-b817-9520e7b07c41',11,'2025-11-19 04:14:52.802','2025-11-19 04:14:52.802'),
(115,'Student','73baed1d-345f-4a13-b6c9-6fe384865c3c',11,'2025-11-19 04:14:52.803','2025-11-19 04:14:52.803'),
(116,'Student','2146dbe6-5991-470e-9cd7-aa5f1524053d',11,'2025-11-19 04:14:52.804','2025-11-19 04:14:52.804'),
(117,'Student','7235332e-1683-4249-a5b3-87d8fe56ac24',11,'2025-11-19 04:14:52.805','2025-11-19 04:14:52.805'),
(118,'Student','bb6ca350-ab89-43e1-b3ad-9236cd07f228',11,'2025-11-19 04:14:52.806','2025-11-19 04:14:52.806'),
(119,'Student','2dcfdcc6-5727-4c59-931d-20fe51568d5e',11,'2025-11-19 04:14:52.807','2025-11-19 04:14:52.807'),
(120,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',11,'2025-11-19 04:14:52.808','2025-11-19 04:14:52.808'),
(121,'Student','893d8088-ce88-4b24-a48d-9ac3e3d82e95',11,'2025-11-19 04:14:52.809','2025-11-19 04:14:52.809'),
(122,'Teacher','97026abb-800d-475d-afd2-b219a641ef1c',12,'2025-11-19 04:14:52.810','2025-11-19 04:14:52.810'),
(123,'Student','5e7d2b4c-9c7b-4231-86b6-29506a783139',12,'2025-11-19 04:14:52.811','2025-11-19 04:14:52.811'),
(124,'Student','a5169597-f3c3-4926-8ab2-f8706b7bec33',12,'2025-11-19 04:14:52.812','2025-11-19 04:14:52.812'),
(125,'Student','13c3620d-bf19-45fb-8ece-28866a00e8c6',12,'2025-11-19 04:14:52.813','2025-11-19 04:14:52.813'),
(126,'Student','50c21929-22fa-4f24-97bb-ea166917a591',12,'2025-11-19 04:14:52.814','2025-11-19 04:14:52.814'),
(127,'Student','e7943a12-0757-4cc1-b61c-6410f99a4cc0',12,'2025-11-19 04:14:52.815','2025-11-19 04:14:52.815'),
(128,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',12,'2025-11-19 04:14:52.816','2025-11-19 04:14:52.816'),
(129,'Student','55ad0298-1275-473e-b4ac-f6717ecff3c4',12,'2025-11-19 04:14:52.817','2025-11-19 04:14:52.817'),
(130,'Student','9fd931b4-0bd3-4225-95ed-4836fa138f28',12,'2025-11-19 04:14:52.818','2025-11-19 04:14:52.818'),
(131,'Student','06dec8fc-2338-439d-96db-58e5f48e1371',12,'2025-11-19 04:14:52.819','2025-11-19 04:14:52.819'),
(132,'Student','ed6b89ff-ba24-41d2-9da3-82a9b418a0a2',12,'2025-11-19 04:14:52.820','2025-11-19 04:14:52.820'),
(133,'Teacher','97026abb-800d-475d-afd2-b219a641ef1c',13,'2025-11-19 04:14:52.821','2025-11-19 04:14:52.821'),
(134,'Student','27784591-6370-4a02-be60-99939ed1a8c6',13,'2025-11-19 04:14:52.822','2025-11-19 04:14:52.822'),
(135,'Student','01a01141-234f-4d70-9c40-27f632fd43ef',13,'2025-11-19 04:14:52.823','2025-11-19 04:14:52.823'),
(136,'Student','dca27f76-c5ee-45fa-a7bc-a5a36a386512',13,'2025-11-19 04:14:52.824','2025-11-19 04:14:52.824'),
(137,'Student','5e042d84-b99e-4cbf-9e56-0e13bf478a19',13,'2025-11-19 04:14:52.825','2025-11-19 04:14:52.825'),
(138,'Student','9fd931b4-0bd3-4225-95ed-4836fa138f28',13,'2025-11-19 04:14:52.825','2025-11-19 04:14:52.825'),
(139,'Student','78a61336-34f7-41af-8b78-e9d39b44d41c',13,'2025-11-19 04:14:52.826','2025-11-19 04:14:52.826'),
(140,'Student','69ffc999-3b15-4fff-ac9c-a8824c3c47ab',13,'2025-11-19 04:14:52.827','2025-11-19 04:14:52.827'),
(141,'Student','4a22e997-41f8-48dc-b9d0-4a30954b6eea',13,'2025-11-19 04:14:52.828','2025-11-19 04:14:52.828'),
(142,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',13,'2025-11-19 04:14:52.829','2025-11-19 04:14:52.829'),
(143,'Student','893d8088-ce88-4b24-a48d-9ac3e3d82e95',13,'2025-11-19 04:14:52.830','2025-11-19 04:14:52.830'),
(144,'Teacher','97026abb-800d-475d-afd2-b219a641ef1c',14,'2025-11-19 04:14:52.831','2025-11-19 04:14:52.831'),
(145,'Student','5e7d2b4c-9c7b-4231-86b6-29506a783139',14,'2025-11-19 04:14:52.832','2025-11-19 04:14:52.832'),
(146,'Student','62865831-8334-4bb5-a0fc-77ed413f4c30',14,'2025-11-19 04:14:52.833','2025-11-19 04:14:52.833'),
(147,'Student','bb6ca350-ab89-43e1-b3ad-9236cd07f228',14,'2025-11-19 04:14:52.834','2025-11-19 04:14:52.834'),
(148,'Student','7a83db2f-69ac-4f04-9309-2e5df45a74cf',14,'2025-11-19 04:14:52.835','2025-11-19 04:14:52.835'),
(149,'Student','7b2fbaac-5cc9-476a-84b8-54466684d98c',14,'2025-11-19 04:14:52.836','2025-11-19 04:14:52.836'),
(150,'Student','dca27f76-c5ee-45fa-a7bc-a5a36a386512',14,'2025-11-19 04:14:52.837','2025-11-19 04:14:52.837'),
(151,'Student','73baed1d-345f-4a13-b6c9-6fe384865c3c',14,'2025-11-19 04:14:52.838','2025-11-19 04:14:52.838'),
(152,'Student','b0f72cf5-9e1d-464b-8a5f-d9d3845e148f',14,'2025-11-19 04:14:52.839','2025-11-19 04:14:52.839'),
(153,'Student','27784591-6370-4a02-be60-99939ed1a8c6',14,'2025-11-19 04:14:52.839','2025-11-19 04:14:52.839'),
(154,'Student','06a90f08-f867-4284-b626-e1aea63e4630',14,'2025-11-19 04:14:52.840','2025-11-19 04:14:52.840');
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
('804a5e27-56c9-4a33-b82f-8166d4ee38b8','fa3516f81a29e403ca89eb0070f5b30e4a3152ff883a8bcff53ca3de09b31936','2025-11-19 04:14:49.892','20251119020719_add_explanation_to_quiz_question',NULL,NULL,'2025-11-19 04:14:49.887',1),
('8826b82c-e87d-4696-b3c3-54baded5a834','852a4e2c166c689df64fa4b1e82bf527de22bffa0e6ace5b8e479414c9ec21aa','2025-11-19 04:14:49.886','20251116055534_update_quiz_material_relation_remove_time',NULL,NULL,'2025-11-19 04:14:49.864',1),
('a08c1782-28a2-4d30-86ae-2d76d22d8c02','5d535f395498abb562d62c3d16a60924963a26c3c065d32a7a5e1f066075fcb1','2025-11-19 04:14:49.796','20251112144809_init',NULL,NULL,'2025-11-19 04:14:49.471',1),
('c4919e04-49ca-4af3-86ef-25d3a22d221e','330c558dd59e57f5be2e0b739af7e167005897877a1e9b870d17154fc31ad60e','2025-11-19 04:14:49.815','20251115092106_remove_subscription_plan',NULL,NULL,'2025-11-19 04:14:49.797',1),
('e5c6e449-fed8-4277-b4b5-117c0c3b9b7e','bde564d470fab41c136f8a2dc30030d38d8c0d5e42255b3cae1c4f9ee617b761','2025-11-19 04:14:49.863','20251116040034_init',NULL,NULL,'2025-11-19 04:14:49.816',1);
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
(1,'Essay',0,'2025-11-19 04:14:52.664','2025-11-19 04:14:52.664'),
(2,'Business Plan',0,'2025-11-19 04:14:52.664','2025-11-19 04:14:52.664'),
(3,'Penelitian',0,'2025-11-19 04:14:52.664','2025-11-19 04:14:52.664'),
(4,'Desain',0,'2025-11-19 04:14:52.664','2025-11-19 04:14:52.664');
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

-- Dump completed on 2025-11-19 11:16:07

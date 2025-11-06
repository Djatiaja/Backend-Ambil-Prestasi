/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ambil_prestasi
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
(1,1,'omnis','vitae reiciendis nostrum id repellat fugit sunt repellat voluptatibus commodi repellat consequatur voluptatibus quia necessitatibus reiciendis aliquid deserunt voluptate ducimus rerum fugiat ullam consequatur quos ullam rerum fugit enim aut','files/public/placeholder.png','2025-11-06 15:23:16.027','2025-11-06 15:23:16.027'),
(2,1,'quia','asperiores aut ullam nulla enim quos neque fugiat neque occaecati et quas exercitationem ipsum in sunt possimus cupiditate non deserunt sunt est voluptate labore unde sequi laborum possimus labore possimus','files/public/placeholder.png','2025-11-06 15:23:16.028','2025-11-06 15:23:16.028'),
(3,1,'ipsum','asperiores repellat in enim voluptatem labore eos ullam at exercitationem id dicta eos cupiditate unde id fugit esse necessitatibus ducimus error deserunt blanditiis magnam hic nihil neque cupiditate hic consectetur','files/public/placeholder.png','2025-11-06 15:23:16.030','2025-11-06 15:23:16.030'),
(4,1,'dolores','hic quas voluptatem consectetur id nemo laborum voluptatem rerum aliquid neque fugiat maiores sit vitae non nemo consequuntur omnis non repellat asperiores nemo occaecati esse est est dicta quas quia','files/public/placeholder.png','2025-11-06 15:23:16.031','2025-11-06 15:23:16.031'),
(5,1,'sed','exercitationem enim unde excepturi nemo hic rerum quos labore id sapiente nemo laborum sed ipsum eos unde omnis quae exercitationem est nostrum esse reiciendis vel et non aliquid voluptate maiores','files/public/placeholder.png','2025-11-06 15:23:16.032','2025-11-06 15:23:16.032'),
(6,1,'fugit','occaecati aut vel commodi consequatur dolores enim nihil sapiente hic necessitatibus laborum laborum occaecati numquam beatae nostrum possimus esse ipsum non in sapiente numquam error commodi esse deserunt vel possimus','files/public/placeholder.png','2025-11-06 15:23:16.033','2025-11-06 15:23:16.033'),
(7,1,'ullam','consequatur quia sequi dolores possimus esse commodi sit eos rerum omnis reiciendis esse exercitationem fugiat possimus nostrum enim necessitatibus consequuntur quasi aliquid nostrum aut reiciendis id consectetur aut beatae voluptatibus','files/public/placeholder.png','2025-11-06 15:23:16.034','2025-11-06 15:23:16.034'),
(8,1,'cupiditate','reiciendis et doloribus sunt dicta maiores qui sed sapiente consequatur dicta neque aut sit facilis ipsum voluptatem in reiciendis error quia asperiores fugit deserunt quia voluptatem reiciendis asperiores unde error','files/public/placeholder.png','2025-11-06 15:23:16.035','2025-11-06 15:23:16.035'),
(9,1,'repellat','aliquid consequatur voluptate magnam numquam quia possimus sequi dicta eos commodi neque nulla consequatur fugiat exercitationem magnam nemo dolores nulla doloribus vel maiores qui repellat rerum non consequuntur id sunt','files/public/placeholder.png','2025-11-06 15:23:16.036','2025-11-06 15:23:16.036'),
(10,1,'laborum','excepturi voluptatibus rerum nulla quas eos omnis dicta voluptatibus ducimus numquam et dicta asperiores voluptate asperiores qui ipsum vitae neque occaecati quas magnam magnam asperiores sit dicta doloribus dolores occaecati','files/public/placeholder.png','2025-11-06 15:23:16.037','2025-11-06 15:23:16.037'),
(11,2,'PPK','hic possimus nostrum quos sequi voluptatem omnis deserunt ipsum ullam maiores vel enim id tenetur quos necessitatibus quasi unde aut sunt id sunt voluptatem ipsum sed voluptate esse magnam est','files/public/placeholder.png','2025-11-06 15:23:16.149','2025-11-06 15:23:16.149'),
(12,1,'Pancasila','ipsum sequi labore repellat occaecati possimus blanditiis aliquid id non repellat dicta consequatur fugiat nostrum eos aut at voluptatem occaecati id aut reiciendis enim in non nulla nemo vel maiores','files/public/placeholder.png','2025-11-06 15:23:16.150','2025-11-06 15:23:16.150'),
(13,3,'Agama','non at dicta quas quae occaecati quasi occaecati reiciendis maiores facilis vitae ipsum quasi consectetur quos sapiente quasi hic id hic quia labore unde tenetur ducimus quae repellat unde error','files/public/placeholder.png','2025-11-06 15:23:16.151','2025-11-06 15:23:16.151'),
(14,1,'Bahasa Indonesia','quia quae enim voluptatem nostrum fugit quaerat possimus nihil tenetur enim eos eos at labore et voluptatibus excepturi quia vel quasi voluptate nulla possimus sunt sed labore blanditiis ullam consectetur','files/public/placeholder.png','2025-11-06 15:23:16.152','2025-11-06 15:23:16.152');
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
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `materialFilePath` varchar(191) NOT NULL,
  `ringkasanPath` varchar(191) NOT NULL,
  `templatePath` varchar(191) NOT NULL,
  `video_path` varchar(191) NOT NULL,
  `thumnail_path` varchar(191) NOT NULL,
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
(1,'Admin','2025-11-06 15:23:15.876','2025-11-06 15:23:15.876'),
(2,'Teacher','2025-11-06 15:23:15.876','2025-11-06 15:23:15.876'),
(3,'Student','2025-11-06 15:23:15.876','2025-11-06 15:23:15.876');
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
  `verified_at` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `roleId` int(11) NOT NULL,
  `bio` varchar(191) DEFAULT NULL,
  `specialization` varchar(191) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `telp` varchar(191) DEFAULT NULL,
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
('072f2189-bbd4-43e8-a68f-f2c574f6296f','student49@example.com','student49','Evgeniy.Flores10','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+49&background=random','2025-11-06 15:23:16.021','2024-01-15 06:17:47.840','2025-11-06 15:23:16.022',3,NULL,NULL,'ACTIVE',NULL),
('0d7b4179-3429-4e5b-98b6-4aaa90baf418','student15@example.com','student15','Kun.Óskarsson','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+15&background=random','2025-11-06 15:23:15.974','2024-06-30 05:52:09.330','2025-11-06 15:23:15.975',3,NULL,NULL,'ACTIVE',NULL),
('108ea388-fb6c-4001-827a-b21b18ba2105','student29@example.com','student29','Elena_Werner','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+29&background=random','2025-11-06 15:23:15.995','2025-07-26 20:37:43.248','2025-11-06 15:23:15.996',3,NULL,NULL,'ACTIVE',NULL),
('1418b530-69c5-485d-a731-c80b65e3fc88','student19@example.com','student19','Alberto_Marková','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+19&background=random','2025-11-06 15:23:15.979','2024-07-02 09:45:57.889','2025-11-06 15:23:15.980',3,NULL,NULL,'ACTIVE',NULL),
('17d557af-ebd1-4916-896a-927c809b904b','student18@example.com','student18','Kai_Sangthong2','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+18&background=random','2025-11-06 15:23:15.978','2023-10-25 15:16:04.440','2025-11-06 15:23:15.979',3,NULL,NULL,'ACTIVE',NULL),
('18deaa6d-44bc-46e1-996b-1211154c6ee2','student4@example.com','student4','Takeshi.Achieng51','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+4&background=random','2025-11-06 15:23:15.957','2021-11-11 23:54:10.090','2025-11-06 15:23:15.958',3,NULL,NULL,'ACTIVE',NULL),
('1b49ca1e-b41c-4b0c-9d4d-8a091e934715','student34@example.com','student34','Anah.Magnússon30','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+34&background=random','2025-11-06 15:23:16.002','2020-12-25 17:15:25.553','2025-11-06 15:23:16.002',3,NULL,NULL,'ACTIVE',NULL),
('28f206ea-8377-4d56-93d7-4171ea2174e9','teacher2@example.com','teacher2','Jianhua.Guðmundsdóttir74','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Teacher+2&background=random','2025-11-06 15:23:15.948','2021-01-21 22:16:57.021','2025-11-06 15:23:15.949',2,'Experienced math teacher with a passion for helping students succeed.','Mathematics','ACTIVE','08123456789'),
('339954e0-23d5-4316-8aca-c61d60214450','student22@example.com','student22','Koshi_Hájek','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+22&background=random','2025-11-06 15:23:15.984','2024-02-07 03:21:25.613','2025-11-06 15:23:15.985',3,NULL,NULL,'ACTIVE',NULL),
('349b2c55-d6ed-43ef-a75c-4065310e10e8','student31@example.com','student31','Abubakar_Friðriksson33','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+31&background=random','2025-11-06 15:23:15.998','2025-03-06 01:43:44.250','2025-11-06 15:23:15.998',3,NULL,NULL,'ACTIVE',NULL),
('352ee7ec-dd3c-418a-90ac-efc648f3ed19','student38@example.com','student38','Urai.Mendoza19','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+38&background=random','2025-11-06 15:23:16.007','2023-08-12 15:02:45.370','2025-11-06 15:23:16.007',3,NULL,NULL,'ACTIVE',NULL),
('3544cc6d-9f07-435f-829f-15236f0abaa9','student8@example.com','student8','Dorota.Santiago','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+8&background=random','2025-11-06 15:23:15.964','2024-08-27 17:16:35.156','2025-11-06 15:23:15.964',3,NULL,NULL,'ACTIVE',NULL),
('354f6e1f-31fd-41be-bb38-e9e11d7784c2','student9@example.com','student9','Usha.Hauksdóttir70','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+9&background=random','2025-11-06 15:23:15.965','2023-04-01 07:37:24.241','2025-11-06 15:23:15.966',3,NULL,NULL,'ACTIVE',NULL),
('35d80f38-23a7-4087-a7e9-7b3803c99ded','teachertestaccexample.com','teachertestacc','teachertestacc','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=teachertestacc&background=random','2025-11-06 15:23:16.024','2024-12-05 21:51:26.227','2025-11-06 15:23:16.024',2,NULL,NULL,'ACTIVE',NULL),
('3a3d4e27-6bb4-4d10-b7d3-26ce984b632f','student27@example.com','student27','Hiroshi.Abe16','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+27&background=random','2025-11-06 15:23:15.992','2024-03-31 22:41:31.639','2025-11-06 15:23:15.993',3,NULL,NULL,'ACTIVE',NULL),
('3fad4ac6-f4db-4b5b-9b70-fdfb1083a6ef','student32@example.com','student32','Pushpa_Shi40','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+32&background=random','2025-11-06 15:23:15.999','2025-04-20 16:01:04.921','2025-11-06 15:23:16.000',3,NULL,NULL,'ACTIVE',NULL),
('427d46ef-2302-45d6-907b-a07b875f5c8e','student2@example.com','student2','Katsumi_Nguyen','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+2&background=random','2025-11-06 15:23:15.954','2025-06-06 10:28:32.560','2025-11-06 15:23:15.955',3,NULL,NULL,'ACTIVE',NULL),
('42807b48-738f-4d77-a7a8-dbbf444c242f','student45@example.com','student45','Amit.Őri','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+45&background=random','2025-11-06 15:23:16.017','2023-09-25 14:19:25.816','2025-11-06 15:23:16.017',3,NULL,NULL,'ACTIVE',NULL),
('435ff6c6-ee27-4ce8-98e3-9fadb48785fa','student20@example.com','student20','Carol.Hernández91','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+20&background=random','2025-11-06 15:23:15.981','2021-10-29 08:04:46.543','2025-11-06 15:23:15.981',3,NULL,NULL,'ACTIVE',NULL),
('507dba8a-4900-49dd-b017-cb3487ec404e','student13@example.com','student13','Fran.Černý41','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+13&background=random','2025-11-06 15:23:15.971','2023-01-04 07:59:45.136','2025-11-06 15:23:15.972',3,NULL,NULL,'ACTIVE',NULL),
('5398dfdb-d1cc-49fa-a285-73bb9ed061f7','teacher1@example.com','teacher1','Lin.Brouwer99','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Teacher+1&background=random','2025-11-06 15:23:15.946','2024-07-31 21:56:45.316','2025-11-06 15:23:15.947',2,'Experienced math teacher with a passion for helping students succeed.','Mathematics','ACTIVE','08123456789'),
('632f13ef-f740-4690-956f-c3238b58eab8','teacher4@example.com','teacher4','Dariusz.Pillay','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Teacher+4&background=random','2025-11-06 15:23:15.951','2022-04-30 01:08:27.744','2025-11-06 15:23:15.952',2,'Experienced math teacher with a passion for helping students succeed.','Mathematics','ACTIVE','08123456789'),
('694ddf23-a785-4d63-a31a-23846e3bccf8','student43@example.com','student43','Xiaohong_Keller','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+43&background=random','2025-11-06 15:23:16.014','2024-10-11 18:12:06.202','2025-11-06 15:23:16.015',3,NULL,NULL,'ACTIVE',NULL),
('6cc027ca-cb68-47ef-bb4c-bb8a7bd635a7','student10@example.com','student10','Herbert.Hu63','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+10&background=random','2025-11-06 15:23:15.967','2021-01-05 04:25:00.741','2025-11-06 15:23:15.968',3,NULL,NULL,'ACTIVE',NULL),
('79875a7a-7ad6-465c-94de-77f34765331d','student11@example.com','student11','Somchai_Mizrahi91','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+11&background=random','2025-11-06 15:23:15.968','2022-01-30 16:25:04.715','2025-11-06 15:23:15.969',3,NULL,NULL,'ACTIVE',NULL),
('7b525afc-fe38-48c5-b998-e130b4ffbe7c','student23@example.com','student23','Takashi_Sharabi','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+23&background=random','2025-11-06 15:23:15.986','2025-05-10 08:27:01.838','2025-11-06 15:23:15.987',3,NULL,NULL,'ACTIVE',NULL),
('7cb78a48-b7e9-458b-ba46-24b3656580c9','student6@example.com','student6','Dennis.Zheng','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+6&background=random','2025-11-06 15:23:15.961','2022-04-09 02:28:20.053','2025-11-06 15:23:15.961',3,NULL,NULL,'ACTIVE',NULL),
('7d754900-6d1e-4c27-a749-005daf5310d6','student50@example.com','student50','Elisabeth.Odhiambo','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+50&background=random','2025-11-06 15:23:16.023','2022-07-07 00:27:52.498','2025-11-06 15:23:16.023',3,NULL,NULL,'ACTIVE',NULL),
('80c7fffe-f9f5-40c7-8bd2-59562a64dd56','student36@example.com','student36','Maryam.Kikuchi80','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+36&background=random','2025-11-06 15:23:16.004','2024-10-03 01:01:04.291','2025-11-06 15:23:16.005',3,NULL,NULL,'ACTIVE',NULL),
('81812e49-a080-4156-b887-233efefa9497','student5@example.com','student5','Magda_Serrano','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+5&background=random','2025-11-06 15:23:15.959','2024-07-13 04:51:09.160','2025-11-06 15:23:15.960',3,NULL,NULL,'ACTIVE',NULL),
('834b7992-dab3-45e8-9446-126bd8ba1cd7','student1@example.com','student1','Jose_Kowalczyk57','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+1&background=random','2025-11-06 15:23:15.953','2024-09-23 10:39:58.712','2025-11-06 15:23:15.954',3,NULL,NULL,'ACTIVE',NULL),
('88e8fe25-2eda-48ed-93d5-70981bfc64e9','student46@example.com','student46','Sunthon.Ødegård88','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+46&background=random','2025-11-06 15:23:16.018','2021-07-17 18:28:09.896','2025-11-06 15:23:16.019',3,NULL,NULL,'ACTIVE',NULL),
('89416d85-3527-4ecd-afe8-b3123e72f020','student24@example.com','student24','Blessing.Roberts48','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+24&background=random','2025-11-06 15:23:15.987','2024-08-14 08:04:16.664','2025-11-06 15:23:15.988',3,NULL,NULL,'ACTIVE',NULL),
('8e196413-e826-41ad-8ce1-69a435a117ac','student25@example.com','student25','Jason.Őzse','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+25&background=random','2025-11-06 15:23:15.989','2023-01-10 09:33:09.416','2025-11-06 15:23:15.990',3,NULL,NULL,'ACTIVE',NULL),
('97caeb80-b9c1-4d10-a6bf-f6327e8aa548','student21@example.com','student21','Mitsuo.Andreev51','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+21&background=random','2025-11-06 15:23:15.982','2024-07-23 14:57:10.357','2025-11-06 15:23:15.983',3,NULL,NULL,'ACTIVE',NULL),
('a03db7fa-ac7f-4981-b1e1-f41ad6b38b8e','student37@example.com','student37','Mitsuo_Núñez72','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+37&background=random','2025-11-06 15:23:16.006','2024-03-12 06:34:29.252','2025-11-06 15:23:16.006',3,NULL,NULL,'ACTIVE',NULL),
('a1fb966a-f98f-479b-bfec-e9ceab2a385a','student28@example.com','student28','Joan_Černá','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+28&background=random','2025-11-06 15:23:15.994','2024-12-13 03:25:39.615','2025-11-06 15:23:15.994',3,NULL,NULL,'ACTIVE',NULL),
('a2a454aa-e640-4a81-9409-b55880397c07','student44@example.com','student44','Yong_Atieno45','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+44&background=random','2025-11-06 15:23:16.015','2020-11-08 01:13:17.993','2025-11-06 15:23:16.016',3,NULL,NULL,'ACTIVE',NULL),
('ac31be76-a26c-45f5-8811-5b46d1832cc8','student35@example.com','student35','Aisha_Su99','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+35&background=random','2025-11-06 15:23:16.003','2024-12-31 02:34:27.149','2025-11-06 15:23:16.004',3,NULL,NULL,'ACTIVE',NULL),
('b4c9c922-dfbc-459a-962b-9324b044c407','student16@example.com','student16','Paulina_Thongsuk28','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+16&background=random','2025-11-06 15:23:15.975','2021-08-17 02:54:54.187','2025-11-06 15:23:15.976',3,NULL,NULL,'ACTIVE',NULL),
('ba40bbf9-6550-40d8-98dd-0d9985af7d4b','student42@example.com','student42','Yuval_Tang','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+42&background=random','2025-11-06 15:23:16.013','2023-11-03 13:02:06.524','2025-11-06 15:23:16.013',3,NULL,NULL,'ACTIVE',NULL),
('bd24467e-47de-4bfa-95b2-fdd663765fcf','student40@example.com','student40','Laxmi.Fischer8','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+40&background=random','2025-11-06 15:23:16.009','2023-02-28 05:42:48.265','2025-11-06 15:23:16.010',3,NULL,NULL,'ACTIVE',NULL),
('c18c9829-f9aa-41db-9c4a-476e9eeba797','student17@example.com','student17','Yakubu.Okeke70','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+17&background=random','2025-11-06 15:23:15.977','2022-11-08 10:13:24.599','2025-11-06 15:23:15.977',3,NULL,NULL,'ACTIVE',NULL),
('cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3','student33@example.com','student33','Dennis.Helgadóttir84','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+33&background=random','2025-11-06 15:23:16.000','2025-01-28 08:30:24.943','2025-11-06 15:23:16.001',3,NULL,NULL,'ACTIVE',NULL),
('cbdee0d8-64f7-415d-ba0a-f79da3cf81f5','student7@example.com','student7','Edda.Clark','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+7&background=random','2025-11-06 15:23:15.962','2023-02-14 23:21:05.907','2025-11-06 15:23:15.963',3,NULL,NULL,'ACTIVE',NULL),
('cbf05492-d576-4456-b68c-15aed414f839','student41@example.com','student41','Fatima.Botha74','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+41&background=random','2025-11-06 15:23:16.011','2023-12-10 11:17:49.095','2025-11-06 15:23:16.012',3,NULL,NULL,'ACTIVE',NULL),
('d0ef1d4a-af57-40b6-b1df-b6f1d9eedbcb','student14@example.com','student14','Radha_Kamiński','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+14&background=random','2025-11-06 15:23:15.973','2021-05-13 03:09:41.999','2025-11-06 15:23:15.973',3,NULL,NULL,'ACTIVE',NULL),
('d3afcefb-5a21-4425-bc87-5a2171f63478','student48@example.com','student48','Kiran_Brouwer15','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+48&background=random','2025-11-06 15:23:16.020','2022-02-18 13:41:36.716','2025-11-06 15:23:16.021',3,NULL,NULL,'ACTIVE',NULL),
('d79f3b3e-aa3d-4b86-b8b4-7f22c1fe2732','student26@example.com','student26','Fumiko_Förster7','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+26&background=random','2025-11-06 15:23:15.991','2021-04-13 23:05:00.665','2025-11-06 15:23:15.992',3,NULL,NULL,'ACTIVE',NULL),
('dd3e6db4-d91f-4e40-a16d-dc8a8dcffe13','student3@example.com','student3','Frank.Jasiński','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+3&background=random','2025-11-06 15:23:15.956','2022-04-09 18:02:35.661','2025-11-06 15:23:15.957',3,NULL,NULL,'ACTIVE',NULL),
('ddc70559-65ac-4773-9e85-9b72ffac328a','student47@example.com','student47','Ko.Okafor51','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+47&background=random','2025-11-06 15:23:16.019','2020-12-16 10:46:10.533','2025-11-06 15:23:16.020',3,NULL,NULL,'ACTIVE',NULL),
('e6c23f85-19f5-428b-b204-d6b3b3983256','student39@example.com','student39','Frank_Thongkham','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+39&background=random','2025-11-06 15:23:16.008','2023-12-11 08:37:51.845','2025-11-06 15:23:16.009',3,NULL,NULL,'ACTIVE',NULL),
('eaa12362-d2ec-4df2-a21f-7e9346abd852','teacher3@example.com','teacher3','Sibusiso_Fialová83','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Teacher+3&background=random','2025-11-06 15:23:15.950','2022-04-05 16:21:21.496','2025-11-06 15:23:15.950',2,'Experienced math teacher with a passion for helping students succeed.','Mathematics','ACTIVE','08123456789'),
('ee5301f8-b9e1-41c9-9d14-f01e138f1d39','student12@example.com','student12','Anita_Keller83','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+12&background=random','2025-11-06 15:23:15.970','2025-08-16 19:57:20.258','2025-11-06 15:23:15.971',3,NULL,NULL,'ACTIVE',NULL),
('f5044aab-d139-422b-90d2-d38c07137b92','student30@example.com','student30','Stefan_Tomaszewski92','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Student+30&background=random','2025-11-06 15:23:15.996','2023-08-09 07:49:04.211','2025-11-06 15:23:15.997',3,NULL,NULL,'ACTIVE',NULL),
('f5a490cd-3983-4c0e-b4ec-c72dec0ec7f6','djamgt23@gmail.com','admin','Admin User','$2b$10$OGnnEL14E5f.L/1UAJh.NebYwRY1BeCDp9OYx15CphjKflLcV48EO','https://ui-avatars.com/api/?name=Admin+User&background=random','2025-11-06 15:23:15.942','2024-12-14 21:11:03.485','2025-11-06 15:23:15.944',1,NULL,NULL,'ACTIVE',NULL);
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
(1,'Teacher','5398dfdb-d1cc-49fa-a285-73bb9ed061f7',1,'2025-11-06 15:23:16.042','2025-11-06 15:23:16.042'),
(2,'Student','3a3d4e27-6bb4-4d10-b7d3-26ce984b632f',1,'2025-11-06 15:23:16.044','2025-11-06 15:23:16.044'),
(3,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',1,'2025-11-06 15:23:16.046','2025-11-06 15:23:16.046'),
(4,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',1,'2025-11-06 15:23:16.047','2025-11-06 15:23:16.047'),
(5,'Student','352ee7ec-dd3c-418a-90ac-efc648f3ed19',1,'2025-11-06 15:23:16.048','2025-11-06 15:23:16.048'),
(6,'Student','ba40bbf9-6550-40d8-98dd-0d9985af7d4b',1,'2025-11-06 15:23:16.049','2025-11-06 15:23:16.049'),
(7,'Student','d0ef1d4a-af57-40b6-b1df-b6f1d9eedbcb',1,'2025-11-06 15:23:16.050','2025-11-06 15:23:16.050'),
(8,'Student','ddc70559-65ac-4773-9e85-9b72ffac328a',1,'2025-11-06 15:23:16.051','2025-11-06 15:23:16.051'),
(9,'Student','a2a454aa-e640-4a81-9409-b55880397c07',1,'2025-11-06 15:23:16.052','2025-11-06 15:23:16.052'),
(10,'Student','427d46ef-2302-45d6-907b-a07b875f5c8e',1,'2025-11-06 15:23:16.053','2025-11-06 15:23:16.053'),
(11,'Student','42807b48-738f-4d77-a7a8-dbbf444c242f',1,'2025-11-06 15:23:16.054','2025-11-06 15:23:16.054'),
(12,'Teacher','28f206ea-8377-4d56-93d7-4171ea2174e9',2,'2025-11-06 15:23:16.056','2025-11-06 15:23:16.056'),
(13,'Student','17d557af-ebd1-4916-896a-927c809b904b',2,'2025-11-06 15:23:16.057','2025-11-06 15:23:16.057'),
(14,'Student','cbf05492-d576-4456-b68c-15aed414f839',2,'2025-11-06 15:23:16.058','2025-11-06 15:23:16.058'),
(15,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',2,'2025-11-06 15:23:16.059','2025-11-06 15:23:16.059'),
(16,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',2,'2025-11-06 15:23:16.060','2025-11-06 15:23:16.060'),
(17,'Student','f5044aab-d139-422b-90d2-d38c07137b92',2,'2025-11-06 15:23:16.061','2025-11-06 15:23:16.061'),
(18,'Student','ba40bbf9-6550-40d8-98dd-0d9985af7d4b',2,'2025-11-06 15:23:16.062','2025-11-06 15:23:16.062'),
(19,'Student','354f6e1f-31fd-41be-bb38-e9e11d7784c2',2,'2025-11-06 15:23:16.063','2025-11-06 15:23:16.063'),
(20,'Student','349b2c55-d6ed-43ef-a75c-4065310e10e8',2,'2025-11-06 15:23:16.064','2025-11-06 15:23:16.064'),
(21,'Student','88e8fe25-2eda-48ed-93d5-70981bfc64e9',2,'2025-11-06 15:23:16.065','2025-11-06 15:23:16.065'),
(22,'Student','8e196413-e826-41ad-8ce1-69a435a117ac',2,'2025-11-06 15:23:16.066','2025-11-06 15:23:16.066'),
(23,'Teacher','35d80f38-23a7-4087-a7e9-7b3803c99ded',3,'2025-11-06 15:23:16.067','2025-11-06 15:23:16.067'),
(24,'Student','427d46ef-2302-45d6-907b-a07b875f5c8e',3,'2025-11-06 15:23:16.068','2025-11-06 15:23:16.068'),
(25,'Student','8e196413-e826-41ad-8ce1-69a435a117ac',3,'2025-11-06 15:23:16.069','2025-11-06 15:23:16.069'),
(26,'Student','e6c23f85-19f5-428b-b204-d6b3b3983256',3,'2025-11-06 15:23:16.070','2025-11-06 15:23:16.070'),
(27,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',3,'2025-11-06 15:23:16.071','2025-11-06 15:23:16.071'),
(28,'Student','694ddf23-a785-4d63-a31a-23846e3bccf8',3,'2025-11-06 15:23:16.072','2025-11-06 15:23:16.072'),
(29,'Student','88e8fe25-2eda-48ed-93d5-70981bfc64e9',3,'2025-11-06 15:23:16.073','2025-11-06 15:23:16.073'),
(30,'Student','834b7992-dab3-45e8-9446-126bd8ba1cd7',3,'2025-11-06 15:23:16.074','2025-11-06 15:23:16.074'),
(31,'Student','108ea388-fb6c-4001-827a-b21b18ba2105',3,'2025-11-06 15:23:16.074','2025-11-06 15:23:16.074'),
(32,'Student','b4c9c922-dfbc-459a-962b-9324b044c407',3,'2025-11-06 15:23:16.075','2025-11-06 15:23:16.075'),
(33,'Student','ba40bbf9-6550-40d8-98dd-0d9985af7d4b',3,'2025-11-06 15:23:16.076','2025-11-06 15:23:16.076'),
(34,'Teacher','eaa12362-d2ec-4df2-a21f-7e9346abd852',4,'2025-11-06 15:23:16.077','2025-11-06 15:23:16.077'),
(35,'Student','89416d85-3527-4ecd-afe8-b3123e72f020',4,'2025-11-06 15:23:16.078','2025-11-06 15:23:16.078'),
(36,'Student','349b2c55-d6ed-43ef-a75c-4065310e10e8',4,'2025-11-06 15:23:16.079','2025-11-06 15:23:16.079'),
(37,'Student','dd3e6db4-d91f-4e40-a16d-dc8a8dcffe13',4,'2025-11-06 15:23:16.080','2025-11-06 15:23:16.080'),
(38,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',4,'2025-11-06 15:23:16.081','2025-11-06 15:23:16.081'),
(39,'Student','3a3d4e27-6bb4-4d10-b7d3-26ce984b632f',4,'2025-11-06 15:23:16.082','2025-11-06 15:23:16.082'),
(40,'Student','6cc027ca-cb68-47ef-bb4c-bb8a7bd635a7',4,'2025-11-06 15:23:16.083','2025-11-06 15:23:16.083'),
(41,'Student','cbf05492-d576-4456-b68c-15aed414f839',4,'2025-11-06 15:23:16.084','2025-11-06 15:23:16.084'),
(42,'Student','d3afcefb-5a21-4425-bc87-5a2171f63478',4,'2025-11-06 15:23:16.085','2025-11-06 15:23:16.085'),
(43,'Student','f5044aab-d139-422b-90d2-d38c07137b92',4,'2025-11-06 15:23:16.086','2025-11-06 15:23:16.086'),
(44,'Student','88e8fe25-2eda-48ed-93d5-70981bfc64e9',4,'2025-11-06 15:23:16.087','2025-11-06 15:23:16.087'),
(45,'Teacher','28f206ea-8377-4d56-93d7-4171ea2174e9',5,'2025-11-06 15:23:16.089','2025-11-06 15:23:16.089'),
(46,'Student','3a3d4e27-6bb4-4d10-b7d3-26ce984b632f',5,'2025-11-06 15:23:16.090','2025-11-06 15:23:16.090'),
(47,'Student','339954e0-23d5-4316-8aca-c61d60214450',5,'2025-11-06 15:23:16.091','2025-11-06 15:23:16.091'),
(48,'Student','88e8fe25-2eda-48ed-93d5-70981bfc64e9',5,'2025-11-06 15:23:16.092','2025-11-06 15:23:16.092'),
(49,'Student','bd24467e-47de-4bfa-95b2-fdd663765fcf',5,'2025-11-06 15:23:16.093','2025-11-06 15:23:16.093'),
(50,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',5,'2025-11-06 15:23:16.094','2025-11-06 15:23:16.094'),
(51,'Student','834b7992-dab3-45e8-9446-126bd8ba1cd7',5,'2025-11-06 15:23:16.095','2025-11-06 15:23:16.095'),
(52,'Student','ba40bbf9-6550-40d8-98dd-0d9985af7d4b',5,'2025-11-06 15:23:16.096','2025-11-06 15:23:16.096'),
(53,'Student','b4c9c922-dfbc-459a-962b-9324b044c407',5,'2025-11-06 15:23:16.097','2025-11-06 15:23:16.097'),
(54,'Student','427d46ef-2302-45d6-907b-a07b875f5c8e',5,'2025-11-06 15:23:16.098','2025-11-06 15:23:16.098'),
(55,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',5,'2025-11-06 15:23:16.099','2025-11-06 15:23:16.099'),
(56,'Teacher','5398dfdb-d1cc-49fa-a285-73bb9ed061f7',6,'2025-11-06 15:23:16.099','2025-11-06 15:23:16.099'),
(57,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',6,'2025-11-06 15:23:16.100','2025-11-06 15:23:16.100'),
(58,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',6,'2025-11-06 15:23:16.101','2025-11-06 15:23:16.101'),
(59,'Student','42807b48-738f-4d77-a7a8-dbbf444c242f',6,'2025-11-06 15:23:16.102','2025-11-06 15:23:16.102'),
(60,'Student','18deaa6d-44bc-46e1-996b-1211154c6ee2',6,'2025-11-06 15:23:16.103','2025-11-06 15:23:16.103'),
(61,'Student','dd3e6db4-d91f-4e40-a16d-dc8a8dcffe13',6,'2025-11-06 15:23:16.104','2025-11-06 15:23:16.104'),
(62,'Student','1b49ca1e-b41c-4b0c-9d4d-8a091e934715',6,'2025-11-06 15:23:16.105','2025-11-06 15:23:16.105'),
(63,'Student','694ddf23-a785-4d63-a31a-23846e3bccf8',6,'2025-11-06 15:23:16.106','2025-11-06 15:23:16.106'),
(64,'Student','3fad4ac6-f4db-4b5b-9b70-fdfb1083a6ef',6,'2025-11-06 15:23:16.106','2025-11-06 15:23:16.106'),
(65,'Student','7b525afc-fe38-48c5-b998-e130b4ffbe7c',6,'2025-11-06 15:23:16.107','2025-11-06 15:23:16.107'),
(66,'Student','a2a454aa-e640-4a81-9409-b55880397c07',6,'2025-11-06 15:23:16.108','2025-11-06 15:23:16.108'),
(67,'Teacher','5398dfdb-d1cc-49fa-a285-73bb9ed061f7',7,'2025-11-06 15:23:16.109','2025-11-06 15:23:16.109'),
(68,'Student','354f6e1f-31fd-41be-bb38-e9e11d7784c2',7,'2025-11-06 15:23:16.110','2025-11-06 15:23:16.110'),
(69,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',7,'2025-11-06 15:23:16.111','2025-11-06 15:23:16.111'),
(70,'Student','349b2c55-d6ed-43ef-a75c-4065310e10e8',7,'2025-11-06 15:23:16.111','2025-11-06 15:23:16.111'),
(71,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',7,'2025-11-06 15:23:16.112','2025-11-06 15:23:16.112'),
(72,'Student','7cb78a48-b7e9-458b-ba46-24b3656580c9',7,'2025-11-06 15:23:16.113','2025-11-06 15:23:16.113'),
(73,'Student','bd24467e-47de-4bfa-95b2-fdd663765fcf',7,'2025-11-06 15:23:16.114','2025-11-06 15:23:16.114'),
(74,'Student','6cc027ca-cb68-47ef-bb4c-bb8a7bd635a7',7,'2025-11-06 15:23:16.115','2025-11-06 15:23:16.115'),
(75,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',7,'2025-11-06 15:23:16.116','2025-11-06 15:23:16.116'),
(76,'Student','507dba8a-4900-49dd-b017-cb3487ec404e',7,'2025-11-06 15:23:16.117','2025-11-06 15:23:16.117'),
(77,'Student','1b49ca1e-b41c-4b0c-9d4d-8a091e934715',7,'2025-11-06 15:23:16.118','2025-11-06 15:23:16.118'),
(78,'Teacher','eaa12362-d2ec-4df2-a21f-7e9346abd852',8,'2025-11-06 15:23:16.119','2025-11-06 15:23:16.119'),
(79,'Student','3a3d4e27-6bb4-4d10-b7d3-26ce984b632f',8,'2025-11-06 15:23:16.119','2025-11-06 15:23:16.119'),
(80,'Student','7cb78a48-b7e9-458b-ba46-24b3656580c9',8,'2025-11-06 15:23:16.120','2025-11-06 15:23:16.120'),
(81,'Student','427d46ef-2302-45d6-907b-a07b875f5c8e',8,'2025-11-06 15:23:16.121','2025-11-06 15:23:16.121'),
(82,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',8,'2025-11-06 15:23:16.122','2025-11-06 15:23:16.122'),
(83,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',8,'2025-11-06 15:23:16.123','2025-11-06 15:23:16.123'),
(84,'Student','0d7b4179-3429-4e5b-98b6-4aaa90baf418',8,'2025-11-06 15:23:16.124','2025-11-06 15:23:16.124'),
(85,'Student','3544cc6d-9f07-435f-829f-15236f0abaa9',8,'2025-11-06 15:23:16.125','2025-11-06 15:23:16.125'),
(86,'Student','89416d85-3527-4ecd-afe8-b3123e72f020',8,'2025-11-06 15:23:16.126','2025-11-06 15:23:16.126'),
(87,'Student','7b525afc-fe38-48c5-b998-e130b4ffbe7c',8,'2025-11-06 15:23:16.127','2025-11-06 15:23:16.127'),
(88,'Student','ee5301f8-b9e1-41c9-9d14-f01e138f1d39',8,'2025-11-06 15:23:16.128','2025-11-06 15:23:16.128'),
(89,'Teacher','28f206ea-8377-4d56-93d7-4171ea2174e9',9,'2025-11-06 15:23:16.129','2025-11-06 15:23:16.129'),
(90,'Student','80c7fffe-f9f5-40c7-8bd2-59562a64dd56',9,'2025-11-06 15:23:16.130','2025-11-06 15:23:16.130'),
(91,'Student','108ea388-fb6c-4001-827a-b21b18ba2105',9,'2025-11-06 15:23:16.131','2025-11-06 15:23:16.131'),
(92,'Student','89416d85-3527-4ecd-afe8-b3123e72f020',9,'2025-11-06 15:23:16.132','2025-11-06 15:23:16.132'),
(93,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',9,'2025-11-06 15:23:16.133','2025-11-06 15:23:16.133'),
(94,'Student','bd24467e-47de-4bfa-95b2-fdd663765fcf',9,'2025-11-06 15:23:16.134','2025-11-06 15:23:16.134'),
(95,'Student','ddc70559-65ac-4773-9e85-9b72ffac328a',9,'2025-11-06 15:23:16.134','2025-11-06 15:23:16.134'),
(96,'Student','dd3e6db4-d91f-4e40-a16d-dc8a8dcffe13',9,'2025-11-06 15:23:16.135','2025-11-06 15:23:16.135'),
(97,'Student','7d754900-6d1e-4c27-a749-005daf5310d6',9,'2025-11-06 15:23:16.136','2025-11-06 15:23:16.136'),
(98,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',9,'2025-11-06 15:23:16.137','2025-11-06 15:23:16.137'),
(99,'Student','d3afcefb-5a21-4425-bc87-5a2171f63478',9,'2025-11-06 15:23:16.138','2025-11-06 15:23:16.138'),
(100,'Teacher','5398dfdb-d1cc-49fa-a285-73bb9ed061f7',10,'2025-11-06 15:23:16.139','2025-11-06 15:23:16.139'),
(101,'Student','a2a454aa-e640-4a81-9409-b55880397c07',10,'2025-11-06 15:23:16.140','2025-11-06 15:23:16.140'),
(102,'Student','89416d85-3527-4ecd-afe8-b3123e72f020',10,'2025-11-06 15:23:16.141','2025-11-06 15:23:16.141'),
(103,'Student','88e8fe25-2eda-48ed-93d5-70981bfc64e9',10,'2025-11-06 15:23:16.142','2025-11-06 15:23:16.142'),
(104,'Student','427d46ef-2302-45d6-907b-a07b875f5c8e',10,'2025-11-06 15:23:16.143','2025-11-06 15:23:16.143'),
(105,'Student','435ff6c6-ee27-4ce8-98e3-9fadb48785fa',10,'2025-11-06 15:23:16.144','2025-11-06 15:23:16.144'),
(106,'Student','e6c23f85-19f5-428b-b204-d6b3b3983256',10,'2025-11-06 15:23:16.145','2025-11-06 15:23:16.145'),
(107,'Student','ddc70559-65ac-4773-9e85-9b72ffac328a',10,'2025-11-06 15:23:16.145','2025-11-06 15:23:16.145'),
(108,'Student','c18c9829-f9aa-41db-9c4a-476e9eeba797',10,'2025-11-06 15:23:16.146','2025-11-06 15:23:16.146'),
(109,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',10,'2025-11-06 15:23:16.147','2025-11-06 15:23:16.147'),
(110,'Student','97caeb80-b9c1-4d10-a6bf-f6327e8aa548',10,'2025-11-06 15:23:16.148','2025-11-06 15:23:16.148'),
(111,'Teacher','35d80f38-23a7-4087-a7e9-7b3803c99ded',11,'2025-11-06 15:23:16.154','2025-11-06 15:23:16.154'),
(112,'Student','cbf05492-d576-4456-b68c-15aed414f839',11,'2025-11-06 15:23:16.155','2025-11-06 15:23:16.155'),
(113,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',11,'2025-11-06 15:23:16.156','2025-11-06 15:23:16.156'),
(114,'Student','c18c9829-f9aa-41db-9c4a-476e9eeba797',11,'2025-11-06 15:23:16.157','2025-11-06 15:23:16.157'),
(115,'Student','8e196413-e826-41ad-8ce1-69a435a117ac',11,'2025-11-06 15:23:16.158','2025-11-06 15:23:16.158'),
(116,'Student','3a3d4e27-6bb4-4d10-b7d3-26ce984b632f',11,'2025-11-06 15:23:16.158','2025-11-06 15:23:16.158'),
(117,'Student','cbdee0d8-64f7-415d-ba0a-f79da3cf81f5',11,'2025-11-06 15:23:16.159','2025-11-06 15:23:16.159'),
(118,'Student','d79f3b3e-aa3d-4b86-b8b4-7f22c1fe2732',11,'2025-11-06 15:23:16.160','2025-11-06 15:23:16.160'),
(119,'Student','7cb78a48-b7e9-458b-ba46-24b3656580c9',11,'2025-11-06 15:23:16.161','2025-11-06 15:23:16.161'),
(120,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',11,'2025-11-06 15:23:16.162','2025-11-06 15:23:16.162'),
(121,'Student','ee5301f8-b9e1-41c9-9d14-f01e138f1d39',11,'2025-11-06 15:23:16.163','2025-11-06 15:23:16.163'),
(122,'Teacher','35d80f38-23a7-4087-a7e9-7b3803c99ded',12,'2025-11-06 15:23:16.164','2025-11-06 15:23:16.164'),
(123,'Student','d0ef1d4a-af57-40b6-b1df-b6f1d9eedbcb',12,'2025-11-06 15:23:16.165','2025-11-06 15:23:16.165'),
(124,'Student','d3afcefb-5a21-4425-bc87-5a2171f63478',12,'2025-11-06 15:23:16.165','2025-11-06 15:23:16.165'),
(125,'Student','bd24467e-47de-4bfa-95b2-fdd663765fcf',12,'2025-11-06 15:23:16.166','2025-11-06 15:23:16.166'),
(126,'Student','339954e0-23d5-4316-8aca-c61d60214450',12,'2025-11-06 15:23:16.167','2025-11-06 15:23:16.167'),
(127,'Student','89416d85-3527-4ecd-afe8-b3123e72f020',12,'2025-11-06 15:23:16.168','2025-11-06 15:23:16.168'),
(128,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',12,'2025-11-06 15:23:16.169','2025-11-06 15:23:16.169'),
(129,'Student','354f6e1f-31fd-41be-bb38-e9e11d7784c2',12,'2025-11-06 15:23:16.170','2025-11-06 15:23:16.170'),
(130,'Student','cbf05492-d576-4456-b68c-15aed414f839',12,'2025-11-06 15:23:16.171','2025-11-06 15:23:16.171'),
(131,'Student','1418b530-69c5-485d-a731-c80b65e3fc88',12,'2025-11-06 15:23:16.172','2025-11-06 15:23:16.172'),
(132,'Student','cbdee0d8-64f7-415d-ba0a-f79da3cf81f5',12,'2025-11-06 15:23:16.173','2025-11-06 15:23:16.173'),
(133,'Teacher','35d80f38-23a7-4087-a7e9-7b3803c99ded',13,'2025-11-06 15:23:16.174','2025-11-06 15:23:16.174'),
(134,'Student','81812e49-a080-4156-b887-233efefa9497',13,'2025-11-06 15:23:16.175','2025-11-06 15:23:16.175'),
(135,'Student','8e196413-e826-41ad-8ce1-69a435a117ac',13,'2025-11-06 15:23:16.176','2025-11-06 15:23:16.176'),
(136,'Student','cbf05492-d576-4456-b68c-15aed414f839',13,'2025-11-06 15:23:16.176','2025-11-06 15:23:16.176'),
(137,'Student','1b49ca1e-b41c-4b0c-9d4d-8a091e934715',13,'2025-11-06 15:23:16.177','2025-11-06 15:23:16.177'),
(138,'Student','f5044aab-d139-422b-90d2-d38c07137b92',13,'2025-11-06 15:23:16.178','2025-11-06 15:23:16.178'),
(139,'Student','3544cc6d-9f07-435f-829f-15236f0abaa9',13,'2025-11-06 15:23:16.179','2025-11-06 15:23:16.179'),
(140,'Student','352ee7ec-dd3c-418a-90ac-efc648f3ed19',13,'2025-11-06 15:23:16.180','2025-11-06 15:23:16.180'),
(141,'Student','694ddf23-a785-4d63-a31a-23846e3bccf8',13,'2025-11-06 15:23:16.181','2025-11-06 15:23:16.181'),
(142,'Student','834b7992-dab3-45e8-9446-126bd8ba1cd7',13,'2025-11-06 15:23:16.182','2025-11-06 15:23:16.182'),
(143,'Student','ddc70559-65ac-4773-9e85-9b72ffac328a',13,'2025-11-06 15:23:16.183','2025-11-06 15:23:16.183'),
(144,'Teacher','35d80f38-23a7-4087-a7e9-7b3803c99ded',14,'2025-11-06 15:23:16.184','2025-11-06 15:23:16.184'),
(145,'Student','80c7fffe-f9f5-40c7-8bd2-59562a64dd56',14,'2025-11-06 15:23:16.185','2025-11-06 15:23:16.185'),
(146,'Student','072f2189-bbd4-43e8-a68f-f2c574f6296f',14,'2025-11-06 15:23:16.186','2025-11-06 15:23:16.186'),
(147,'Student','cb5fc2cb-fc66-4e50-bf3a-560d62a49dc3',14,'2025-11-06 15:23:16.187','2025-11-06 15:23:16.187'),
(148,'Student','7b525afc-fe38-48c5-b998-e130b4ffbe7c',14,'2025-11-06 15:23:16.187','2025-11-06 15:23:16.187'),
(149,'Student','e6c23f85-19f5-428b-b204-d6b3b3983256',14,'2025-11-06 15:23:16.188','2025-11-06 15:23:16.188'),
(150,'Student','a03db7fa-ac7f-4981-b1e1-f41ad6b38b8e',14,'2025-11-06 15:23:16.189','2025-11-06 15:23:16.189'),
(151,'Student','ac31be76-a26c-45f5-8811-5b46d1832cc8',14,'2025-11-06 15:23:16.190','2025-11-06 15:23:16.190'),
(152,'Student','81812e49-a080-4156-b887-233efefa9497',14,'2025-11-06 15:23:16.191','2025-11-06 15:23:16.191'),
(153,'Student','f5044aab-d139-422b-90d2-d38c07137b92',14,'2025-11-06 15:23:16.192','2025-11-06 15:23:16.192'),
(154,'Student','352ee7ec-dd3c-418a-90ac-efc648f3ed19',14,'2025-11-06 15:23:16.193','2025-11-06 15:23:16.193');
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
('497fab6a-5fd9-4660-ab1c-8905071cfe84','ea1cf889658b5e94a4c03f6b4247bd88478e77dc205644d96f5031fdbf83f88c','2025-11-06 15:23:13.121','20251031125129_add_thumnail_to_material',NULL,NULL,'2025-11-06 15:23:13.115',1),
('9c45b5a9-7641-428c-876c-351027117010','178f8d459b6f6563fc29a56d4219281b697a65323bdfdd520dffb5097ab10e5e','2025-11-06 15:23:13.109','20251030154530_add_detail_user',NULL,NULL,'2025-11-06 15:23:13.102',1),
('a4c102e5-6553-4a41-ae01-ea89d929c489','a030d79b9e017651752703e841b00dc98c9c1c8143dcec341ff4f360b25c6df5','2025-11-06 15:23:13.102','20251030122342_add_delete_at',NULL,NULL,'2025-11-06 15:23:13.095',1),
('ef5f15ec-3c6a-4873-8fd7-99f190604154','fb6c6e1c134820bf382a994341b42514770004ebc5bc65b7dad0668ea2c421d3','2025-11-06 15:23:13.115','20251031115928_add_file_path_to_material',NULL,NULL,'2025-11-06 15:23:13.109',1),
('f329ad55-fe34-462d-8f53-d5c7931356ee','37a1da5ffeb6800b7f3e00b820425e143ac01d4bc77f96930fec8bf8ba8d5621','2025-11-06 15:23:13.095','20251030074157_init',NULL,NULL,'2025-11-06 15:23:12.837',1);
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
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
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
(1,'Essay','2025-11-06 15:23:16.026','2025-11-06 15:23:16.026',0),
(2,'Business Plan','2025-11-06 15:23:16.026','2025-11-06 15:23:16.026',0),
(3,'Penelitian','2025-11-06 15:23:16.026','2025-11-06 15:23:16.026',0),
(4,'Desain','2025-11-06 15:23:16.026','2025-11-06 15:23:16.026',0);
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

-- Dump completed on 2025-11-06 22:44:00

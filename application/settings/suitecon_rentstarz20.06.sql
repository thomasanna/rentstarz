-- MySQL dump 10.15  Distrib 10.0.20-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: suitecon_rentstarz
-- ------------------------------------------------------
-- Server version	10.0.20-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `engine4_activity_actions`
--

DROP TABLE IF EXISTS `engine4_activity_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actions` (
  `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `date` datetime NOT NULL,
  `attachment_count` smallint(3) unsigned NOT NULL DEFAULT '0',
  `comment_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `like_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`),
  KEY `OBJECT` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actions`
--

LOCK TABLES `engine4_activity_actions` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actions` DISABLE KEYS */;
INSERT INTO `engine4_activity_actions` VALUES (3,'profile_photo_update','user',1,'user',1,'{item:$subject} added a new profile photo.','[]','2016-03-29 17:16:37',1,0,0),(6,'status','user',1,'user',1,'How is everyoneÂ ','[]','2016-04-25 04:12:25',0,0,0),(9,'signup','user',7,'user',7,'','[]','2016-04-26 16:43:08',0,0,1),(10,'status','user',1,'user',1,'What\'s up everybodyÂ ','[]','2016-04-26 22:13:27',0,0,0),(53,'signup','user',39,'user',39,'','[]','2016-05-25 07:53:42',0,0,0),(57,'profile_photo_update','user',39,'user',39,'{item:$subject} added a new profile photo.','[]','2016-05-26 04:56:27',1,0,0),(104,'status','user',1,'user',1,'What\'s on everyone\'s mind','[]','2016-06-15 19:19:10',0,0,0),(111,'signup','user',73,'user',73,'','[]','2016-06-17 05:24:25',0,0,0),(112,'signup','user',72,'user',72,'','[]','2016-06-17 06:25:08',0,0,0),(114,'signup','user',71,'user',71,'','[]','2016-06-17 06:45:44',0,0,0),(115,'signup','user',74,'user',74,'','[]','2016-06-17 08:43:03',0,0,0),(116,'profile_photo_update','user',74,'user',74,'{item:$subject} added a new profile photo.','[]','2016-06-17 08:43:53',1,0,0),(117,'signup','user',75,'user',75,'','[]','2016-06-17 08:49:05',0,0,0),(118,'signup','user',76,'user',76,'','[]','2016-06-17 08:50:16',0,0,0),(119,'signup','user',77,'user',77,'','[]','2016-06-17 08:51:54',0,0,0),(120,'signup','user',78,'user',78,'','[]','2016-06-17 08:58:35',0,0,0),(121,'signup','user',79,'user',79,'','[]','2016-06-17 09:00:53',0,0,0),(123,'signup','user',82,'user',82,'','[]','2016-06-17 13:13:46',0,0,0),(124,'signup','user',85,'user',85,'','[]','2016-06-17 16:24:13',0,0,0),(125,'post_self','user',74,'user',74,'Few things have such a huge impact on happiness and the enjoyment, depth and plain fun of life as the friendships we have. \r\nIt could beÂ  the friendships Â with our partners, family members, co-workers and the people we have known for a few years now or since we were kids. Or even with people we have never even met at the other side of the world or the pets we love. \r\nSo Iâ€™d like to start 2016 by looking back and share some of the best advice on this topic from the people who have walked this earth over the past hundreds and thousands of years. \r\nThis is 74 thought-provoking, beautiful, sometimes poignant and sometimes funny quotes on friendship. \r\n     â€œA real friend is one who walks in when the rest of the world walks out.â€\r\n â€“ Walter Winchell   â€œIf you live to be 100, I hope I live to be 100 minus 1 day, so I never have to live without you.â€\r\n â€“ Winnie the Pooh   â€œI like to listen. I have learned a great deal from listening carefully. Most people never listen.â€\r\n â€“ Ernest Hemingway   â€œFriendship is born at that moment when one person says to another, â€˜What! You too? I thought I was the only one.â€\r\n â€“ C.S. Lewis   â€œTrue friendship comes when the silence between two people is comfortable.â€\r\n â€“ David Tyson   â€œSweet is the memory of distant friends! Like the mellow rays of the departing sun, it falls tenderly, yet sadly, on the heart.â€\r\n â€“ Washington Irving   â€œThereâ€™s not a word yet for old friends whoâ€™ve just met.â€\r\n â€“ Jim Henson   â€œA single rose can be my gardenâ€¦ a single friend, my world.â€\r\n â€“ Leo Buscaglia   â€œDonâ€™t make friends who are comfortable to be with. Make friends who will force you to lever yourself up.â€\r\n â€“ Thomas J. Watson   â€œYou can make more friends in two months by becoming interested in other people than you can in two years by trying to get other people interested in you.â€\r\n â€” Dale Carnegie','[]','2016-06-17 16:27:04',1,0,0),(127,'post_self','user',77,'user',77,'','[]','2016-06-17 17:19:26',1,0,0),(128,'signup','user',86,'user',86,'','[]','2016-06-18 15:41:23',0,0,0),(129,'profile_photo_update','user',86,'user',86,'{item:$subject} added a new profile photo.','[]','2016-06-18 17:25:42',1,0,0),(130,'friends','user',1,'user',75,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 04:23:00',0,0,0),(131,'friends','user',75,'user',1,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 04:23:00',0,0,0),(132,'post_self','user',78,'user',78,'Interior design Â is the art and science of enhancing the interiors, sometimes including the exterior, of a space or building, to achieve a healthier and more aesthetically pleasing environment for the end user. An interior designer is someone who plans, researches, coordinates and manage such projects. Interior design is a multifaceted profession that includes conceptual development, space planning, site inspections, programming, research, communicating with the stakeholders of a project, construction management, and execution of the design. \r\nInterior design is the process of shaping the experience of interior space, through the manipulation of spatial volume as well as surface treatment for the betterment of human functionality.','[]','2016-06-20 05:13:00',1,0,0),(133,'friends','user',1,'user',78,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:27:27',0,0,0),(134,'friends','user',78,'user',1,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:27:27',0,0,0),(135,'friends','user',74,'user',78,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:27:28',0,0,0),(136,'friends','user',78,'user',74,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:27:28',0,0,0),(137,'friends','user',74,'user',78,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:40:07',0,0,0),(138,'friends','user',78,'user',74,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 05:40:07',0,0,0),(139,'signup','user',87,'user',87,'','[]','2016-06-20 07:22:45',0,0,0),(140,'signup','user',88,'user',88,'','[]','2016-06-20 07:59:27',0,0,0),(142,'signup','user',89,'user',89,'','[]','2016-06-20 10:13:13',0,0,0),(143,'signup','user',90,'user',90,'','[]','2016-06-20 10:26:40',0,0,0),(144,'profile_photo_update','user',39,'user',39,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:09:08',1,0,0),(145,'signup','user',91,'user',91,'','[]','2016-06-20 11:11:03',0,0,0),(146,'signup','user',92,'user',92,'','[]','2016-06-20 11:13:35',0,0,0),(147,'profile_photo_update','user',77,'user',77,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:15:21',1,0,0),(148,'friends','user',1,'user',77,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 11:16:38',0,0,0),(149,'friends','user',77,'user',1,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 11:16:38',0,0,0),(150,'friends','user',77,'user',88,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 11:38:59',0,0,0),(151,'friends','user',88,'user',77,'{item:$object} is now friends with {item:$subject}.','[]','2016-06-20 11:38:59',0,0,0),(152,'profile_photo_update','user',88,'user',88,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:39:49',1,0,0),(153,'profile_photo_update','user',89,'user',89,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:42:08',1,0,0),(154,'profile_photo_update','user',78,'user',78,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:43:38',1,0,0),(155,'profile_photo_update','user',74,'user',74,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:44:49',1,0,0),(156,'profile_photo_update','user',90,'user',90,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:45:59',1,0,0),(157,'profile_photo_update','user',87,'user',87,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:48:42',1,0,0),(158,'profile_photo_update','user',87,'user',87,'{item:$subject} added a new profile photo.','[]','2016-06-20 11:49:33',1,0,0),(159,'signup','user',93,'user',93,'','[]','2016-06-20 12:07:50',0,0,0),(160,'profile_photo_update','user',73,'user',73,'{item:$subject} added a new profile photo.','[]','2016-06-20 12:50:37',1,0,0);
/*!40000 ALTER TABLE `engine4_activity_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_actionsettings`
--

DROP TABLE IF EXISTS `engine4_activity_actionsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actionsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actionsettings`
--

LOCK TABLES `engine4_activity_actionsettings` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actionsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_actionsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_actiontypes`
--

DROP TABLE IF EXISTS `engine4_activity_actiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actiontypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `displayable` tinyint(1) NOT NULL DEFAULT '3',
  `attachable` tinyint(1) NOT NULL DEFAULT '1',
  `commentable` tinyint(1) NOT NULL DEFAULT '1',
  `shareable` tinyint(1) NOT NULL DEFAULT '1',
  `is_generated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actiontypes`
--

LOCK TABLES `engine4_activity_actiontypes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actiontypes` DISABLE KEYS */;
INSERT INTO `engine4_activity_actiontypes` VALUES ('album_photo_new','album','{item:$subject} added {var:$count} photo(s) to the album {item:$object}:',1,5,1,3,1,1),('artarticle','advancedarticles','{item:$subject} has added a new article:',1,5,1,3,1,1),('comment_album','album','{item:$subject} commented on {item:$owner}\'s {item:$object:album}: {body:$body}',1,1,1,1,1,0),('comment_album_photo','album','{item:$subject} commented on {item:$owner}\'s {item:$object:photo}: {body:$body}',1,1,1,1,1,0),('comment_artarticle','advancedarticles','{item:$subject} commented on {item:$owner}\'s {item:$object:article}: {body:$body}',1,1,1,1,1,0),('friends','user','{item:$subject} is now friends with {item:$object}.',1,3,0,1,1,1),('friends_follow','user','{item:$subject} is now following {item:$object}.',1,3,0,1,1,1),('group_create','group','{item:$subject} created a new group:',1,5,1,1,1,1),('group_join','group','{item:$subject} joined the group {item:$object}',1,3,1,1,1,1),('group_photo_upload','group','{item:$subject} added {var:$count} photo(s).',1,3,2,1,1,1),('group_promote','group','{item:$subject} has been made an officer for the group {item:$object}',1,3,1,1,1,1),('group_topic_create','group','{item:$subject} posted a {itemChild:$object:topic:$child_id} in the group {item:$object}: {body:$body}',1,3,1,1,1,1),('group_topic_reply','group','{item:$subject} replied to a {itemChild:$object:topic:$child_id} in the group {item:$object}: {body:$body}',1,3,1,1,1,1),('login','user','{item:$subject} has signed in.',0,1,0,1,1,1),('logout','user','{item:$subject} has signed out.',0,1,0,1,1,1),('network_join','network','{item:$subject} joined the network {item:$object}',1,3,1,1,1,1),('post','user','{actors:$subject:$object}: {body:$body}',1,7,1,4,1,0),('post_self','user','{item:$subject} {body:$body}',1,5,1,4,1,0),('profile_photo_update','user','{item:$subject} has added a new profile photo.',1,5,1,4,1,1),('share','activity','{item:$subject} shared {item:$object}\'s {var:$type}. {body:$body}',1,5,1,1,0,1),('signup','user','{item:$subject} has just signed up. Say hello!',1,5,0,1,1,1),('status','user','{item:$subject} {body:$body}',1,5,0,1,4,0),('tagged','user','{item:$subject} tagged {item:$object} in a {var:$label}:',1,7,1,1,0,1);
/*!40000 ALTER TABLE `engine4_activity_actiontypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_attachments`
--

DROP TABLE IF EXISTS `engine4_activity_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_attachments` (
  `attachment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachment_id`),
  KEY `action_id` (`action_id`),
  KEY `type_id` (`type`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_attachments`
--

LOCK TABLES `engine4_activity_attachments` WRITE;
/*!40000 ALTER TABLE `engine4_activity_attachments` DISABLE KEYS */;
INSERT INTO `engine4_activity_attachments` VALUES (1,3,'album_photo',1,1),(3,34,'activity_action',8,1),(5,57,'album_photo',3,1),(16,116,'album_photo',12,1),(17,125,'album_photo',14,1),(19,127,'album_photo',16,1),(20,129,'album_photo',17,1),(21,132,'album_photo',19,1),(23,144,'album_photo',21,1),(24,147,'album_photo',22,1),(25,152,'album_photo',23,1),(26,153,'album_photo',24,1),(27,154,'album_photo',25,1),(28,155,'album_photo',26,1),(29,156,'album_photo',27,1),(30,157,'album_photo',28,1),(31,158,'album_photo',29,1),(32,160,'album_photo',30,1);
/*!40000 ALTER TABLE `engine4_activity_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_comments`
--

DROP TABLE IF EXISTS `engine4_activity_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_comments`
--

LOCK TABLES `engine4_activity_comments` WRITE;
/*!40000 ALTER TABLE `engine4_activity_comments` DISABLE KEYS */;
INSERT INTO `engine4_activity_comments` VALUES (1,16,'user',7,'................','2016-05-04 07:46:19',1),(2,23,'user',25,'Hi teeeeeeeeenu\nHow are you\n','2016-05-23 12:32:48',2),(4,36,'user',25,'Good start.............','2016-05-23 12:48:13',1),(5,65,'user',37,'Test comment','2016-06-06 10:56:49',0),(8,52,'user',37,'test','2016-06-09 06:42:57',0);
/*!40000 ALTER TABLE `engine4_activity_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_likes`
--

DROP TABLE IF EXISTS `engine4_activity_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_id` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_likes`
--

LOCK TABLES `engine4_activity_likes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_likes` DISABLE KEYS */;
INSERT INTO `engine4_activity_likes` VALUES (1,7,'user',1),(3,16,'user',7),(4,30,'user',25),(5,28,'user',25),(6,27,'user',25),(7,31,'user',25),(8,29,'user',25),(9,26,'user',25),(10,25,'user',25),(11,23,'user',25),(12,12,'user',25),(13,8,'user',25),(14,7,'user',25),(15,36,'user',25),(16,40,'user',25),(17,12,'user',34),(18,8,'user',34),(19,7,'user',34),(20,9,'user',39),(21,8,'user',39),(22,75,'user',37),(23,75,'user',49),(24,82,'user',57),(25,59,'user',37);
/*!40000 ALTER TABLE `engine4_activity_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notifications`
--

DROP TABLE IF EXISTS `engine4_activity_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notifications` (
  `notification_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `mitigated` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `LOOKUP` (`user_id`,`date`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notifications`
--

LOCK TABLES `engine4_activity_notifications` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notifications` DISABLE KEYS */;
INSERT INTO `engine4_activity_notifications` VALUES (64,7,'user',39,'activity_action',9,'liked','{\"label\":\"post\"}',1,1,'2016-05-25 07:54:51'),(115,74,'user',1,'activity_action',125,'commented','{\"label\":\"post\"}',1,1,'2016-06-18 01:59:27'),(116,75,'user',1,'user',75,'friend_request',NULL,1,1,'2016-06-19 22:34:03'),(117,1,'user',75,'user',1,'friend_accepted',NULL,0,1,'2016-06-20 04:23:00'),(118,78,'user',74,'activity_action',132,'liked','{\"label\":\"post\"}',1,1,'2016-06-20 05:14:06'),(119,78,'user',74,'activity_action',132,'commented','{\"label\":\"post\"}',1,1,'2016-06-20 05:14:23'),(120,78,'user',74,'user',78,'friend_request',NULL,1,1,'2016-06-20 05:15:40'),(121,78,'user',1,'user',78,'friend_request',NULL,1,1,'2016-06-20 05:17:28'),(122,77,'user',1,'user',77,'friend_request',NULL,1,1,'2016-06-20 05:17:39'),(123,82,'user',1,'user',82,'friend_request',NULL,0,0,'2016-06-20 05:18:00'),(124,1,'user',78,'user',1,'friend_accepted',NULL,0,0,'2016-06-20 05:27:27'),(125,74,'user',78,'user',74,'friend_accepted',NULL,1,1,'2016-06-20 05:27:28'),(126,78,'user',74,'user',78,'friend_request',NULL,1,1,'2016-06-20 05:37:39'),(127,78,'user',74,'user',78,'friend_request',NULL,1,1,'2016-06-20 05:38:46'),(128,74,'user',78,'user',74,'friend_accepted',NULL,1,1,'2016-06-20 05:40:07'),(129,88,'user',77,'user',88,'friend_request',NULL,1,1,'2016-06-20 08:51:46'),(130,1,'user',77,'user',1,'friend_accepted',NULL,0,0,'2016-06-20 11:16:38'),(131,77,'user',88,'user',77,'friend_accepted',NULL,0,1,'2016-06-20 11:38:59'),(132,91,'user',77,'user',91,'friend_request',NULL,0,0,'2016-06-20 12:26:41'),(133,78,'user',77,'user',78,'friend_request',NULL,0,0,'2016-06-20 12:26:53');
/*!40000 ALTER TABLE `engine4_activity_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notificationsettings`
--

DROP TABLE IF EXISTS `engine4_activity_notificationsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notificationsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notificationsettings`
--

LOCK TABLES `engine4_activity_notificationsettings` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notificationsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_notificationsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notificationtypes`
--

DROP TABLE IF EXISTS `engine4_activity_notificationtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notificationtypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `is_request` tinyint(1) NOT NULL DEFAULT '0',
  `handler` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notificationtypes`
--

LOCK TABLES `engine4_activity_notificationtypes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notificationtypes` DISABLE KEYS */;
INSERT INTO `engine4_activity_notificationtypes` VALUES ('commented','activity','{item:$subject} has commented on your {item:$object:$label}.',0,'',1),('commented_commented','activity','{item:$subject} has commented on a {item:$object:$label} you commented on.',0,'',1),('friend_accepted','user','You and {item:$subject} are now friends.',0,'',1),('friend_follow','user','{item:$subject} is now following you.',0,'',1),('friend_follow_accepted','user','You are now following {item:$subject}.',0,'',1),('friend_follow_request','user','{item:$subject} has requested to follow you.',1,'user.friends.request-follow',1),('friend_request','user','{item:$subject} has requested to be your friend.',1,'user.friends.request-friend',1),('group_accepted','group','Your request to join the group {item:$object} has been approved.',0,'',1),('group_approve','group','{item:$subject} has requested to join the group {item:$object}.',0,'',1),('group_discussion_reply','group','{item:$subject} has {item:$object:posted} on a {itemParent:$object::group topic} you posted on.',0,'',1),('group_discussion_response','group','{item:$subject} has {item:$object:posted} on a {itemParent:$object::group topic} you created.',0,'',1),('group_invite','group','{item:$subject} has invited you to the group {item:$object}.',1,'group.widget.request-group',1),('group_promote','group','You were promoted to officer in the group {item:$object}.',0,'',1),('liked','activity','{item:$subject} likes your {item:$object:$label}.',0,'',1),('liked_commented','activity','{item:$subject} has commented on a {item:$object:$label} you liked.',0,'',1),('message_new','messages','{item:$subject} has sent you a {item:$object:message}.',0,'',1),('post_user','user','{item:$subject} has posted on your {item:$object:profile}.',0,'',1),('shared','activity','{item:$subject} has shared your {item:$object:$label}.',0,'',1),('tagged','user','{item:$subject} tagged you in a {item:$object:$label}.',0,'',1);
/*!40000 ALTER TABLE `engine4_activity_notificationtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_stream`
--

DROP TABLE IF EXISTS `engine4_activity_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_stream` (
  `target_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `target_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `action_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`target_type`,`target_id`,`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`,`action_id`),
  KEY `OBJECT` (`object_type`,`object_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_stream`
--

LOCK TABLES `engine4_activity_stream` WRITE;
/*!40000 ALTER TABLE `engine4_activity_stream` DISABLE KEYS */;
INSERT INTO `engine4_activity_stream` VALUES ('everyone',0,'user',1,'user',1,'profile_photo_update',3),('everyone',0,'user',1,'user',1,'status',6),('everyone',0,'user',7,'user',7,'signup',9),('everyone',0,'user',1,'user',1,'status',10),('everyone',0,'user',39,'user',39,'signup',53),('everyone',0,'user',39,'user',39,'profile_photo_update',57),('everyone',0,'user',1,'user',1,'status',104),('everyone',0,'user',73,'user',73,'signup',111),('everyone',0,'user',72,'user',72,'signup',112),('everyone',0,'user',71,'user',71,'signup',114),('everyone',0,'user',74,'user',74,'signup',115),('everyone',0,'user',74,'user',74,'profile_photo_update',116),('everyone',0,'user',75,'user',75,'signup',117),('everyone',0,'user',76,'user',76,'signup',118),('everyone',0,'user',77,'user',77,'signup',119),('everyone',0,'user',78,'user',78,'signup',120),('everyone',0,'user',79,'user',79,'signup',121),('everyone',0,'user',82,'user',82,'signup',123),('everyone',0,'user',85,'user',85,'signup',124),('everyone',0,'user',74,'user',74,'post_self',125),('everyone',0,'user',77,'user',77,'post_self',127),('everyone',0,'user',86,'user',86,'signup',128),('everyone',0,'user',86,'user',86,'profile_photo_update',129),('everyone',0,'user',1,'user',75,'friends',130),('everyone',0,'user',75,'user',1,'friends',131),('everyone',0,'user',78,'user',78,'post_self',132),('everyone',0,'user',1,'user',78,'friends',133),('everyone',0,'user',78,'user',1,'friends',134),('everyone',0,'user',74,'user',78,'friends',135),('everyone',0,'user',78,'user',74,'friends',136),('everyone',0,'user',74,'user',78,'friends',137),('everyone',0,'user',78,'user',74,'friends',138),('everyone',0,'user',87,'user',87,'signup',139),('everyone',0,'user',88,'user',88,'signup',140),('everyone',0,'user',89,'user',89,'signup',142),('everyone',0,'user',90,'user',90,'signup',143),('everyone',0,'user',39,'user',39,'profile_photo_update',144),('everyone',0,'user',91,'user',91,'signup',145),('everyone',0,'user',92,'user',92,'signup',146),('everyone',0,'user',77,'user',77,'profile_photo_update',147),('everyone',0,'user',1,'user',77,'friends',148),('everyone',0,'user',77,'user',1,'friends',149),('everyone',0,'user',77,'user',88,'friends',150),('everyone',0,'user',88,'user',77,'friends',151),('everyone',0,'user',88,'user',88,'profile_photo_update',152),('everyone',0,'user',89,'user',89,'profile_photo_update',153),('everyone',0,'user',78,'user',78,'profile_photo_update',154),('everyone',0,'user',74,'user',74,'profile_photo_update',155),('everyone',0,'user',90,'user',90,'profile_photo_update',156),('everyone',0,'user',87,'user',87,'profile_photo_update',157),('everyone',0,'user',87,'user',87,'profile_photo_update',158),('everyone',0,'user',93,'user',93,'signup',159),('everyone',0,'user',73,'user',73,'profile_photo_update',160),('members',1,'user',1,'user',1,'profile_photo_update',3),('members',1,'user',1,'user',1,'status',6),('members',1,'user',1,'user',1,'status',10),('members',1,'user',1,'user',1,'status',104),('members',1,'user',75,'user',1,'friends',131),('members',1,'user',78,'user',1,'friends',134),('members',1,'user',77,'user',1,'friends',149),('members',7,'user',7,'user',7,'signup',9),('members',39,'user',39,'user',39,'signup',53),('members',39,'user',39,'user',39,'profile_photo_update',57),('members',39,'user',39,'user',39,'profile_photo_update',144),('members',71,'user',71,'user',71,'signup',114),('members',72,'user',72,'user',72,'signup',112),('members',73,'user',73,'user',73,'signup',111),('members',73,'user',73,'user',73,'profile_photo_update',160),('members',74,'user',74,'user',74,'signup',115),('members',74,'user',74,'user',74,'profile_photo_update',116),('members',74,'user',74,'user',74,'post_self',125),('members',74,'user',78,'user',74,'friends',136),('members',74,'user',78,'user',74,'friends',138),('members',74,'user',74,'user',74,'profile_photo_update',155),('members',75,'user',75,'user',75,'signup',117),('members',75,'user',1,'user',75,'friends',130),('members',76,'user',76,'user',76,'signup',118),('members',77,'user',77,'user',77,'signup',119),('members',77,'user',77,'user',77,'post_self',127),('members',77,'user',77,'user',77,'profile_photo_update',147),('members',77,'user',1,'user',77,'friends',148),('members',77,'user',88,'user',77,'friends',151),('members',78,'user',78,'user',78,'signup',120),('members',78,'user',78,'user',78,'post_self',132),('members',78,'user',1,'user',78,'friends',133),('members',78,'user',74,'user',78,'friends',135),('members',78,'user',74,'user',78,'friends',137),('members',78,'user',78,'user',78,'profile_photo_update',154),('members',79,'user',79,'user',79,'signup',121),('members',82,'user',82,'user',82,'signup',123),('members',85,'user',85,'user',85,'signup',124),('members',86,'user',86,'user',86,'signup',128),('members',86,'user',86,'user',86,'profile_photo_update',129),('members',87,'user',87,'user',87,'signup',139),('members',87,'user',87,'user',87,'profile_photo_update',157),('members',87,'user',87,'user',87,'profile_photo_update',158),('members',88,'user',88,'user',88,'signup',140),('members',88,'user',77,'user',88,'friends',150),('members',88,'user',88,'user',88,'profile_photo_update',152),('members',89,'user',89,'user',89,'signup',142),('members',89,'user',89,'user',89,'profile_photo_update',153),('members',90,'user',90,'user',90,'signup',143),('members',90,'user',90,'user',90,'profile_photo_update',156),('members',91,'user',91,'user',91,'signup',145),('members',92,'user',92,'user',92,'signup',146),('members',93,'user',93,'user',93,'signup',159),('owner',1,'user',1,'user',1,'profile_photo_update',3),('owner',1,'user',1,'user',1,'status',6),('owner',1,'user',1,'user',1,'status',10),('owner',1,'user',1,'user',1,'status',104),('owner',1,'user',1,'user',75,'friends',130),('owner',1,'user',1,'user',78,'friends',133),('owner',1,'user',1,'user',77,'friends',148),('owner',7,'user',7,'user',7,'signup',9),('owner',39,'user',39,'user',39,'signup',53),('owner',39,'user',39,'user',39,'profile_photo_update',57),('owner',39,'user',39,'user',39,'profile_photo_update',144),('owner',71,'user',71,'user',71,'signup',114),('owner',72,'user',72,'user',72,'signup',112),('owner',73,'user',73,'user',73,'signup',111),('owner',73,'user',73,'user',73,'profile_photo_update',160),('owner',74,'user',74,'user',74,'signup',115),('owner',74,'user',74,'user',74,'profile_photo_update',116),('owner',74,'user',74,'user',74,'post_self',125),('owner',74,'user',74,'user',78,'friends',135),('owner',74,'user',74,'user',78,'friends',137),('owner',74,'user',74,'user',74,'profile_photo_update',155),('owner',75,'user',75,'user',75,'signup',117),('owner',75,'user',75,'user',1,'friends',131),('owner',76,'user',76,'user',76,'signup',118),('owner',77,'user',77,'user',77,'signup',119),('owner',77,'user',77,'user',77,'post_self',127),('owner',77,'user',77,'user',77,'profile_photo_update',147),('owner',77,'user',77,'user',1,'friends',149),('owner',77,'user',77,'user',88,'friends',150),('owner',78,'user',78,'user',78,'signup',120),('owner',78,'user',78,'user',78,'post_self',132),('owner',78,'user',78,'user',1,'friends',134),('owner',78,'user',78,'user',74,'friends',136),('owner',78,'user',78,'user',74,'friends',138),('owner',78,'user',78,'user',78,'profile_photo_update',154),('owner',79,'user',79,'user',79,'signup',121),('owner',82,'user',82,'user',82,'signup',123),('owner',85,'user',85,'user',85,'signup',124),('owner',86,'user',86,'user',86,'signup',128),('owner',86,'user',86,'user',86,'profile_photo_update',129),('owner',87,'user',87,'user',87,'signup',139),('owner',87,'user',87,'user',87,'profile_photo_update',157),('owner',87,'user',87,'user',87,'profile_photo_update',158),('owner',88,'user',88,'user',88,'signup',140),('owner',88,'user',88,'user',77,'friends',151),('owner',88,'user',88,'user',88,'profile_photo_update',152),('owner',89,'user',89,'user',89,'signup',142),('owner',89,'user',89,'user',89,'profile_photo_update',153),('owner',90,'user',90,'user',90,'signup',143),('owner',90,'user',90,'user',90,'profile_photo_update',156),('owner',91,'user',91,'user',91,'signup',145),('owner',92,'user',92,'user',92,'signup',146),('owner',93,'user',93,'user',93,'signup',159),('parent',1,'user',1,'user',1,'profile_photo_update',3),('parent',1,'user',1,'user',1,'status',6),('parent',1,'user',1,'user',1,'status',10),('parent',1,'user',1,'user',1,'status',104),('parent',1,'user',75,'user',1,'friends',131),('parent',1,'user',78,'user',1,'friends',134),('parent',1,'user',77,'user',1,'friends',149),('parent',7,'user',7,'user',7,'signup',9),('parent',39,'user',39,'user',39,'signup',53),('parent',39,'user',39,'user',39,'profile_photo_update',57),('parent',39,'user',39,'user',39,'profile_photo_update',144),('parent',71,'user',71,'user',71,'signup',114),('parent',72,'user',72,'user',72,'signup',112),('parent',73,'user',73,'user',73,'signup',111),('parent',73,'user',73,'user',73,'profile_photo_update',160),('parent',74,'user',74,'user',74,'signup',115),('parent',74,'user',74,'user',74,'profile_photo_update',116),('parent',74,'user',74,'user',74,'post_self',125),('parent',74,'user',78,'user',74,'friends',136),('parent',74,'user',78,'user',74,'friends',138),('parent',74,'user',74,'user',74,'profile_photo_update',155),('parent',75,'user',75,'user',75,'signup',117),('parent',75,'user',1,'user',75,'friends',130),('parent',76,'user',76,'user',76,'signup',118),('parent',77,'user',77,'user',77,'signup',119),('parent',77,'user',77,'user',77,'post_self',127),('parent',77,'user',77,'user',77,'profile_photo_update',147),('parent',77,'user',1,'user',77,'friends',148),('parent',77,'user',88,'user',77,'friends',151),('parent',78,'user',78,'user',78,'signup',120),('parent',78,'user',78,'user',78,'post_self',132),('parent',78,'user',1,'user',78,'friends',133),('parent',78,'user',74,'user',78,'friends',135),('parent',78,'user',74,'user',78,'friends',137),('parent',78,'user',78,'user',78,'profile_photo_update',154),('parent',79,'user',79,'user',79,'signup',121),('parent',82,'user',82,'user',82,'signup',123),('parent',85,'user',85,'user',85,'signup',124),('parent',86,'user',86,'user',86,'signup',128),('parent',86,'user',86,'user',86,'profile_photo_update',129),('parent',87,'user',87,'user',87,'signup',139),('parent',87,'user',87,'user',87,'profile_photo_update',157),('parent',87,'user',87,'user',87,'profile_photo_update',158),('parent',88,'user',88,'user',88,'signup',140),('parent',88,'user',77,'user',88,'friends',150),('parent',88,'user',88,'user',88,'profile_photo_update',152),('parent',89,'user',89,'user',89,'signup',142),('parent',89,'user',89,'user',89,'profile_photo_update',153),('parent',90,'user',90,'user',90,'signup',143),('parent',90,'user',90,'user',90,'profile_photo_update',156),('parent',91,'user',91,'user',91,'signup',145),('parent',92,'user',92,'user',92,'signup',146),('parent',93,'user',93,'user',93,'signup',159),('registered',0,'user',1,'user',1,'profile_photo_update',3),('registered',0,'user',1,'user',1,'status',6),('registered',0,'user',7,'user',7,'signup',9),('registered',0,'user',1,'user',1,'status',10),('registered',0,'user',39,'user',39,'signup',53),('registered',0,'user',39,'user',39,'profile_photo_update',57),('registered',0,'user',1,'user',1,'status',104),('registered',0,'user',73,'user',73,'signup',111),('registered',0,'user',72,'user',72,'signup',112),('registered',0,'user',71,'user',71,'signup',114),('registered',0,'user',74,'user',74,'signup',115),('registered',0,'user',74,'user',74,'profile_photo_update',116),('registered',0,'user',75,'user',75,'signup',117),('registered',0,'user',76,'user',76,'signup',118),('registered',0,'user',77,'user',77,'signup',119),('registered',0,'user',78,'user',78,'signup',120),('registered',0,'user',79,'user',79,'signup',121),('registered',0,'user',82,'user',82,'signup',123),('registered',0,'user',85,'user',85,'signup',124),('registered',0,'user',74,'user',74,'post_self',125),('registered',0,'user',77,'user',77,'post_self',127),('registered',0,'user',86,'user',86,'signup',128),('registered',0,'user',86,'user',86,'profile_photo_update',129),('registered',0,'user',1,'user',75,'friends',130),('registered',0,'user',75,'user',1,'friends',131),('registered',0,'user',78,'user',78,'post_self',132),('registered',0,'user',1,'user',78,'friends',133),('registered',0,'user',78,'user',1,'friends',134),('registered',0,'user',74,'user',78,'friends',135),('registered',0,'user',78,'user',74,'friends',136),('registered',0,'user',74,'user',78,'friends',137),('registered',0,'user',78,'user',74,'friends',138),('registered',0,'user',87,'user',87,'signup',139),('registered',0,'user',88,'user',88,'signup',140),('registered',0,'user',89,'user',89,'signup',142),('registered',0,'user',90,'user',90,'signup',143),('registered',0,'user',39,'user',39,'profile_photo_update',144),('registered',0,'user',91,'user',91,'signup',145),('registered',0,'user',92,'user',92,'signup',146),('registered',0,'user',77,'user',77,'profile_photo_update',147),('registered',0,'user',1,'user',77,'friends',148),('registered',0,'user',77,'user',1,'friends',149),('registered',0,'user',77,'user',88,'friends',150),('registered',0,'user',88,'user',77,'friends',151),('registered',0,'user',88,'user',88,'profile_photo_update',152),('registered',0,'user',89,'user',89,'profile_photo_update',153),('registered',0,'user',78,'user',78,'profile_photo_update',154),('registered',0,'user',74,'user',74,'profile_photo_update',155),('registered',0,'user',90,'user',90,'profile_photo_update',156),('registered',0,'user',87,'user',87,'profile_photo_update',157),('registered',0,'user',87,'user',87,'profile_photo_update',158),('registered',0,'user',93,'user',93,'signup',159),('registered',0,'user',73,'user',73,'profile_photo_update',160);
/*!40000 ALTER TABLE `engine4_activity_stream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_advancedarticles_albums`
--

DROP TABLE IF EXISTS `engine4_advancedarticles_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_advancedarticles_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `num_views` int(11) unsigned NOT NULL DEFAULT '0',
  `num_comments` int(11) unsigned NOT NULL DEFAULT '0',
  `artarticle_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_advancedarticles_albums`
--

LOCK TABLES `engine4_advancedarticles_albums` WRITE;
/*!40000 ALTER TABLE `engine4_advancedarticles_albums` DISABLE KEYS */;
INSERT INTO `engine4_advancedarticles_albums` VALUES (1,'Home safety','',7,'user','2016-06-14 10:05:00','2016-06-14 10:05:00',1,0,0,0,1),(2,'Home Decor','',39,'user','2016-06-14 12:10:07','2016-06-14 12:10:07',1,0,0,0,2),(3,'Olive Apartments','',39,'user','2016-06-17 16:28:33','2016-06-17 16:28:33',1,0,0,0,3),(5,'10 Design Trends Coming to Homes Near You in 2016','',78,'user','2016-06-20 06:04:25','2016-06-20 06:04:25',1,0,0,0,5),(6,'The Idea and Invention of Villas','',7,'user','2016-06-20 12:39:17','2016-06-20 12:39:17',1,0,0,0,6);
/*!40000 ALTER TABLE `engine4_advancedarticles_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_advancedarticles_artarticles`
--

DROP TABLE IF EXISTS `engine4_advancedarticles_artarticles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_advancedarticles_artarticles` (
  `artarticle_id` int(11) NOT NULL AUTO_INCREMENT,
  `search` binary(1) NOT NULL,
  `category_id` smallint(6) DEFAULT NULL,
  `photo_id` int(11) DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `body` mediumtext CHARACTER SET utf8 NOT NULL,
  `status` enum('deleted','draft','inactive','active') COLLATE utf8_unicode_ci DEFAULT 'active',
  `num_views` int(11) DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  `activate_user_id` int(11) DEFAULT NULL,
  `activate_date` datetime DEFAULT NULL,
  `like_count` int(11) DEFAULT '0',
  `featured` tinyint(1) DEFAULT '0',
  `sponsored` tinyint(1) DEFAULT '0',
  `position` int(11) NOT NULL,
  `trending_article` int(11) NOT NULL,
  `comment_count` int(11) DEFAULT '0',
  PRIMARY KEY (`artarticle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_advancedarticles_artarticles`
--

LOCK TABLES `engine4_advancedarticles_artarticles` WRITE;
/*!40000 ALTER TABLE `engine4_advancedarticles_artarticles` DISABLE KEYS */;
INSERT INTO `engine4_advancedarticles_artarticles` VALUES (1,'1',NULL,242,'Home safety','home-safety','Mold[edit]\r\nMolds&nbsp;[1]&nbsp;are microscopic organisms that thrive in damp environments. They can be found on tiles and fabric, in bathrooms and kitchens, nearly any damp, warm place.&nbsp;Molds&nbsp;are usually not a problem indoors, unless mold spores land on a wet or damp spot and begin growing. Allergic reactions to mold are common. Allergic responses include hay fever-type symptoms, such as sneezing, runny nose, and red eyes.\r\nHome Safety Measures[edit]\r\nSlip and trip-&nbsp;falling accidents&nbsp;at home are very common and can cause serious and life-threatening injuries, so prevention of&nbsp;slip and trip&nbsp;accidents is essential in the good design of living quarters. The objective is especially important for the elderly and disabled, who may be of restricted movement and more susceptible to&nbsp;hazards. It includes of adequate supports such as&nbsp;handrails&nbsp;and&nbsp;balustrades&nbsp;as well as ensuring walking surfaces are of high&nbsp;friction&nbsp;and thus&nbsp;slip&nbsp;resistant.&nbsp;Lighting&nbsp;is also vital for being bright enough to enable the user to see obstacles when walking into a room, for example. Users may also be provided with a&nbsp;walking stick&nbsp;or&nbsp;crutches&nbsp;to aid walking and personal support.&nbsp;Fall prevention&nbsp;is an active form of protection for users.\r\nRadon testing and mitigation &ndash;&nbsp;The two types of&nbsp;radon gas&nbsp;testing devices are, passive and active. A person can set up a kit in their home or hire a professional to perform the test. If the test result comes back with high concentrations of radon, there are ways to reduce radon gas and bring it to acceptable levels. There are proven methods to reduce radon in a home or building.[2]&nbsp;One method uses a vent pipe system and fan, which pulls radon from beneath the house and vents it to the outside. This system, known as a soil suction radon reduction system, involves minor changes to your home.\r\nCarbon monoxide detectors &ndash;&nbsp;Carbon monoxide&nbsp;(CO) detectors located in key areas inside the home is a preventative measure against CO poisoning. The gas is created during&nbsp;incomplete combustion&nbsp;incentral heating&nbsp;boilers&nbsp;as well as in open fires for example.&nbsp;Chimneys&nbsp;to such devices can become blocked, and so the gas can enter living spaces. Only very low levels are toxic and since the gas is odorless, is a serious&nbsp;hazard. For multi-level homes, it is recommended having a minimum of one carbon monoxide detector per floor. For added protection, put a CO detector in each room and a utility/furnace room.\r\nToxic mold -&nbsp;Preventative steps include drying water damage and moisture control in the home. Inhaling or touching mold or mold spores may cause allergic reactions in sensitive individuals.\r\nBurns/Fire:\r\nFamily safety plans&nbsp;&ndash; Family safety plans are an essential tool in fire safety because the plan helps family members to identify a fire escape plan. A safety plan includes knowing two ways out of every room, a safe place for members to meet outside of a burning home, and essential emergency telephone numbers. It is important to practice fire escape plans.\r\nSprinklers&nbsp;&ndash;&nbsp;Fire sprinklers&nbsp;offer a layer of protection because the sprinkler can respond to fire while it is still small. Fire sprinklers&nbsp;[3]&nbsp;respond only the sprinkler closest to the heat source. Smoke alone will not set a fire sprinkler to discharge.\r\nFire extinguishers&nbsp;&ndash; There are five different classes of fires; A, B, C, D, and K. Class A consists of burning paper, wood, cloth or other combustible solids. Class B consists of liquids and gasses such as propane. Class C fires consist of electrical fires. While class D fires (which is less common) consists of burning metal and class K fires (the most common) consists of kitchen type materials, i.e., grease and oil.Fire extinguishers&nbsp;use a variety of substances to put out fires; dry powder, dry chemical, water, halogenated, carbon and foam. Since different substances burn differently, fire extinguishers are labeled (and often color-coded) according to the type or class of fire they can extinguish. It is, therefore, necessary to choose the correct fire extinguisher for home use.Fire alarms&ndash;&nbsp;Fire alarms&nbsp;monitors the environmental changes associated with combustion. Once the alarm has been triggered by fire or smoke, a loud sound emanates to warn of danger and sends a message to a central monitoring center, which then notifies the local fire department.Smoke alarms&nbsp;&ndash;&nbsp;Smoke alarms&nbsp;also known as smoke detectors, generally sound an audible and visual alarm. Smoke alarms are usually housed in a disk-shaped plastic enclosure about 6 inches in diameter and 1 inch thick and are often powered by a disposable battery.Heat detectors&nbsp;&ndash; Heat detectors are a device that responds to changes in ambient temperature. Heat detectors are not meant to replace smoke detectors. They are often placed in rooms where standard smoke detectors are not suitable, such as laundry rooms, garages, and attics.\r\nHome Fire Escape Plans- Create a fire escape plan with two exits from every room, and conduct practice drills with the entire family at least once every six months. When creating the fire escape plan, draw a layout that shows each room and potential escape route in the home. Explain the escape plan to children and ensure that they recognize the sound of the fire alarm and know to check the door for heat and how to stay low to the ground.[4]\r\nPoison&nbsp;- Always have the number of your local&nbsp;Poison Control Center&nbsp;available and familiarize yourself with what to do in case of poisoning.[5]&nbsp;Know which plants are poisonous and remove them from your home. Keep all medications, including over-the-counter medications secured and out of the reach of children. Do NOT make a person throw up unless told to do so by poison control or a health care professional.','&lt;h3 style=&quot;color: #000000; font-weight: bold; margin: 0.3em 0px 0px; overflow: hidden; padding-top: 0.5em; padding-bottom: 0px; border-bottom-style: none; font-size: 1.2em; line-height: 1.6; font-family: sans-serif; font-style: normal; font-variant: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: none #ffffff;&quot;&gt;Mold&lt;span style=&quot;-webkit-user-select: none; font-size: small; font-weight: normal; margin-left: 1em; vertical-align: baseline; line-height: 1em; display: inline-block; white-space: nowrap; unicode-bidi: isolate; font-family: sans-serif;&quot;&gt;&lt;span style=&quot;margin-right: 0.25em; color: #555555;&quot;&gt;[&lt;/span&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/w/index.php?title=Home_safety&amp;action=edit&amp;section=2&quot;&gt;edit&lt;/a&gt;&lt;span style=&quot;margin-left: 0.25em; color: #555555;&quot;&gt;]&lt;/span&gt;&lt;/span&gt;&lt;/h3&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;Molds&amp;nbsp;&lt;sup style=&quot;line-height: 1; unicode-bidi: isolate; white-space: nowrap; font-size: 11.2px; font-weight: normal; font-style: normal;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; white-space: nowrap; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Home_safety#cite_note-1&quot;&gt;[1]&lt;/a&gt;&lt;/sup&gt;&amp;nbsp;are microscopic organisms that thrive in damp environments. They can be found on tiles and fabric, in bathrooms and kitchens, nearly any damp, warm place.&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Mold&quot;&gt;Molds&lt;/a&gt;&amp;nbsp;are usually not a problem indoors, unless mold spores land on a wet or damp spot and begin growing. Allergic reactions to mold are common. Allergic responses include hay fever-type symptoms, such as sneezing, runny nose, and red eyes.&lt;/p&gt;\r\n&lt;h3 style=&quot;color: #000000; font-weight: bold; margin: 0.3em 0px 0px; overflow: hidden; padding-top: 0.5em; padding-bottom: 0px; border-bottom-style: none; font-size: 1.2em; line-height: 1.6; font-family: sans-serif; font-style: normal; font-variant: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: none #ffffff;&quot;&gt;Home Safety Measures&lt;span style=&quot;-webkit-user-select: none; font-size: small; font-weight: normal; margin-left: 1em; vertical-align: baseline; line-height: 1em; display: inline-block; white-space: nowrap; unicode-bidi: isolate; font-family: sans-serif;&quot;&gt;&lt;span style=&quot;margin-right: 0.25em; color: #555555;&quot;&gt;[&lt;/span&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/w/index.php?title=Home_safety&amp;action=edit&amp;section=3&quot;&gt;edit&lt;/a&gt;&lt;span style=&quot;margin-left: 0.25em; color: #555555;&quot;&gt;]&lt;/span&gt;&lt;/span&gt;&lt;/h3&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Slip and trip-&lt;/strong&gt;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Falling_accident&quot;&gt;falling accidents&lt;/a&gt;&amp;nbsp;at home are very common and can cause serious and life-threatening injuries, so prevention of&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Slip_and_trip&quot;&gt;slip and trip&lt;/a&gt;&amp;nbsp;accidents is essential in the good design of living quarters. The objective is especially important for the elderly and disabled, who may be of restricted movement and more susceptible to&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Hazard&quot;&gt;hazards&lt;/a&gt;. It includes of adequate supports such as&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Handrail&quot;&gt;handrails&lt;/a&gt;&amp;nbsp;and&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Balustrade&quot;&gt;balustrades&lt;/a&gt;&amp;nbsp;as well as ensuring walking surfaces are of high&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Friction&quot;&gt;friction&lt;/a&gt;&amp;nbsp;and thus&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #a55858; background: none;&quot; href=&quot;https://en.wikipedia.org/w/index.php?title=Wiki:_slip&amp;action=edit&amp;redlink=1&quot;&gt;slip&lt;/a&gt;&amp;nbsp;resistant.&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Lighting&quot;&gt;Lighting&lt;/a&gt;&amp;nbsp;is also vital for being bright enough to enable the user to see obstacles when walking into a room, for example. Users may also be provided with a&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Walking_stick&quot;&gt;walking stick&lt;/a&gt;&amp;nbsp;or&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Crutches&quot;&gt;crutches&lt;/a&gt;&amp;nbsp;to aid walking and personal support.&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Fall_prevention&quot;&gt;Fall prevention&lt;/a&gt;&amp;nbsp;is an active form of protection for users.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Radon testing and mitigation &amp;ndash;&lt;/strong&gt;&amp;nbsp;The two types of&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Radon_gas&quot;&gt;radon gas&lt;/a&gt;&amp;nbsp;testing devices are, passive and active. A person can set up a kit in their home or hire a professional to perform the test. If the test result comes back with high concentrations of radon, there are ways to reduce radon gas and bring it to acceptable levels. There are proven methods to reduce radon in a home or building.&lt;sup style=&quot;line-height: 1; unicode-bidi: isolate; white-space: nowrap; font-size: 11.2px; font-weight: normal; font-style: normal;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; white-space: nowrap; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Home_safety#cite_note-2&quot;&gt;[2]&lt;/a&gt;&lt;/sup&gt;&amp;nbsp;One method uses a vent pipe system and fan, which pulls radon from beneath the house and vents it to the outside. This system, known as a soil suction radon reduction system, involves minor changes to your home.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Carbon monoxide detectors &amp;ndash;&lt;/strong&gt;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Carbon_monoxide&quot;&gt;Carbon monoxide&lt;/a&gt;&amp;nbsp;(CO) detectors located in key areas inside the home is a preventative measure against CO poisoning. The gas is created during&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Incomplete_combustion&quot;&gt;incomplete combustion&lt;/a&gt;&amp;nbsp;in&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Central_heating&quot;&gt;central heating&lt;/a&gt;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Boiler&quot;&gt;boilers&lt;/a&gt;&amp;nbsp;as well as in open fires for example.&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Chimney&quot;&gt;Chimneys&lt;/a&gt;&amp;nbsp;to such devices can become blocked, and so the gas can enter living spaces. Only very low levels are toxic and since the gas is odorless, is a serious&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Hazard&quot;&gt;hazard&lt;/a&gt;. For multi-level homes, it is recommended having a minimum of one carbon monoxide detector per floor. For added protection, put a CO detector in each room and a utility/furnace room.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Toxic mold -&lt;/strong&gt;&amp;nbsp;Preventative steps include drying water damage and moisture control in the home. Inhaling or touching mold or mold spores may cause allergic reactions in sensitive individuals.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Burns/Fire:&lt;/strong&gt;&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Family safety plans&lt;/strong&gt;&amp;nbsp;&amp;ndash; Family safety plans are an essential tool in fire safety because the plan helps family members to identify a fire escape plan. A safety plan includes knowing two ways out of every room, a safe place for members to meet outside of a burning home, and essential emergency telephone numbers. It is important to practice fire escape plans.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Sprinklers&lt;/strong&gt;&amp;nbsp;&amp;ndash;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Fire_sprinkler&quot;&gt;Fire sprinklers&lt;/a&gt;&amp;nbsp;offer a layer of protection because the sprinkler can respond to fire while it is still small. Fire sprinklers&amp;nbsp;&lt;sup style=&quot;line-height: 1; unicode-bidi: isolate; white-space: nowrap; font-size: 11.2px; font-weight: normal; font-style: normal;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; white-space: nowrap; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Home_safety#cite_note-3&quot;&gt;[3]&lt;/a&gt;&lt;/sup&gt;&amp;nbsp;respond only the sprinkler closest to the heat source. Smoke alone will not set a fire sprinkler to discharge.&lt;/p&gt;\r\n&lt;dl style=&quot;margin-top: 0.2em; margin-bottom: 0.5em; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 22.4px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;dd style=&quot;margin-left: 1.6em; margin-bottom: 0.1em; margin-right: 0px;&quot;&gt;&lt;strong&gt;Fire extinguishers&lt;/strong&gt;&amp;nbsp;&amp;ndash; There are five different classes of fires; A, B, C, D, and K. Class A consists of burning paper, wood, cloth or other combustible solids. Class B consists of liquids and gasses such as propane. Class C fires consist of electrical fires. While class D fires (which is less common) consists of burning metal and class K fires (the most common) consists of kitchen type materials, i.e., grease and oil.&lt;/dd&gt;&lt;/dl&gt;&lt;dl style=&quot;margin-top: 0.2em; margin-bottom: 0.5em; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 22.4px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;dd style=&quot;margin-left: 1.6em; margin-bottom: 0.1em; margin-right: 0px;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Fire_extinguisher&quot;&gt;Fire extinguishers&lt;/a&gt;&amp;nbsp;use a variety of substances to put out fires; dry powder, dry chemical, water, halogenated, carbon and foam. Since different substances burn differently, fire extinguishers are labeled (and often color-coded) according to the type or class of fire they can extinguish. It is, therefore, necessary to choose the correct fire extinguisher for home use.&lt;/dd&gt;&lt;/dl&gt;&lt;dl style=&quot;margin-top: 0.2em; margin-bottom: 0.5em; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 22.4px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;dd style=&quot;margin-left: 1.6em; margin-bottom: 0.1em; margin-right: 0px;&quot;&gt;&lt;strong&gt;Fire alarms&lt;/strong&gt;&amp;ndash;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Fire_alarm&quot;&gt;Fire alarms&lt;/a&gt;&amp;nbsp;monitors the environmental changes associated with combustion. Once the alarm has been triggered by fire or smoke, a loud sound emanates to warn of danger and sends a message to a central monitoring center, which then notifies the local fire department.&lt;/dd&gt;&lt;/dl&gt;&lt;dl style=&quot;margin-top: 0.2em; margin-bottom: 0.5em; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 22.4px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;dd style=&quot;margin-left: 1.6em; margin-bottom: 0.1em; margin-right: 0px;&quot;&gt;&lt;strong&gt;Smoke alarms&lt;/strong&gt;&amp;nbsp;&amp;ndash;&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Smoke_detector&quot;&gt;Smoke alarms&lt;/a&gt;&amp;nbsp;also known as smoke detectors, generally sound an audible and visual alarm. Smoke alarms are usually housed in a disk-shaped plastic enclosure about 6 inches in diameter and 1 inch thick and are often powered by a disposable battery.&lt;/dd&gt;&lt;/dl&gt;&lt;dl style=&quot;margin-top: 0.2em; margin-bottom: 0.5em; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 22.4px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;dd style=&quot;margin-left: 1.6em; margin-bottom: 0.1em; margin-right: 0px;&quot;&gt;&lt;strong&gt;Heat detectors&lt;/strong&gt;&amp;nbsp;&amp;ndash; Heat detectors are a device that responds to changes in ambient temperature. Heat detectors are not meant to replace smoke detectors. They are often placed in rooms where standard smoke detectors are not suitable, such as laundry rooms, garages, and attics.&lt;/dd&gt;&lt;/dl&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Home Fire Escape Plans&lt;/strong&gt;- Create a fire escape plan with two exits from every room, and conduct practice drills with the entire family at least once every six months. When creating the fire escape plan, draw a layout that shows each room and potential escape route in the home. Explain the escape plan to children and ensure that they recognize the sound of the fire alarm and know to check the door for heat and how to stay low to the ground.&lt;sup style=&quot;line-height: 1; unicode-bidi: isolate; white-space: nowrap; font-size: 11.2px; font-weight: normal; font-style: normal;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; white-space: nowrap; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Home_safety#cite_note-4&quot;&gt;[4]&lt;/a&gt;&lt;/sup&gt;&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0.5em 0px; line-height: 22.4px; color: #252525; font-family: sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;Poison&lt;/strong&gt;&amp;nbsp;- Always have the number of your local&amp;nbsp;&lt;a style=&quot;text-decoration: none; color: #0b0080; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Poison_control_center&quot;&gt;Poison Control Center&lt;/a&gt;&amp;nbsp;available and familiarize yourself with what to do in case of poisoning.&lt;sup style=&quot;line-height: 1; unicode-bidi: isolate; white-space: nowrap; font-size: 11.2px; font-weight: normal; font-style: normal;&quot;&gt;&lt;a style=&quot;text-decoration: none; color: #0b0080; white-space: nowrap; background: none;&quot; href=&quot;https://en.wikipedia.org/wiki/Home_safety#cite_note-5&quot;&gt;[5]&lt;/a&gt;&lt;/sup&gt;&amp;nbsp;Know which plants are poisonous and remove them from your home. Keep all medications, including over-the-counter medications secured and out of the reach of children. Do NOT make a person throw up unless told to do so by poison control or a health care professional.&lt;/p&gt;','active',43,'2016-06-14 10:05:00',7,'user','2016-06-16 04:35:39',39,7,'2016-06-14 10:05:00',0,0,0,1,1,0),(2,'1',NULL,246,'Home Decor','home-decor','Living Room Paint Ideas\r\n\r\nMost of our time spend in our&nbsp;home.&nbsp;It&nbsp;should be simply beautiful decorated. By putting some small efforts we can result a lovely peaceful place. A common latest home maybe have featured dull colored theme but it seems like dull look. Bright colors can change the entire surrounding. It shows the elegant and stylish behavior towards the home decoration.\r\nThe most important part of the home is your room, where you get yourself relax at day or night. There are some colors that were used from a decade and most of the room&nbsp;decor&nbsp;starts with blue and white. Different colors of touch represent our moods in most of the ways. Every&nbsp;color&nbsp;has its on meaning like yellow symbolize the energy and it is also represented as attention grabber. On the&nbsp;other&nbsp;hand, grey&nbsp;color&nbsp;signifies the protection and strength.\r\nNow you want to change the tedious&nbsp;bedroom&nbsp;color to some energetic and peaceful color. Below are some of expert&rsquo;s recommendations about the selection of color for your room.\r\nThe strongest color is the Red, which raises the room energy level and mostly used in living room or dinning room.\r\n&nbsp;\r\nGO Floral! This summer\r\nHi there, spring is sparkling everywhere with its beautiful colors and making us happy. Tidy&nbsp;home&nbsp;issupposed to be a sign of good women. It&rsquo;s not much easy to maintain always perfect look, but by doing some small changes one can get great results.\r\nNo matters how big is the place; sometimes &ldquo;LESS IS MORE&rdquo;&nbsp;kitchen&nbsp;decorations are changing rapidly now a days. Giving some floral touch in spring, some royal, metallic or antique touch on special occasions.\r\nToday I&rsquo;m gone share with you my very own favorite and special theme that is Just about spring. &ldquo;Floral Theme&rdquo;&nbsp;Printed Crockery,&nbsp;Table Runners,&nbsp;Curtains,&nbsp;Hand Towels&nbsp;can be a great source of&nbsp;freshness.\r\nWhy you didn&rsquo;t change your setting yet! Try this now, everyone in the family will definitely appreciate &nbsp;your effort, so what are u waiting for? Just take small steps and&nbsp;GO Floral! This summer&nbsp;add some freshness in your kitchens as well, just like your wardrobes\r\nSame theme can be applied on&nbsp;other&nbsp;parts of the&nbsp;house&nbsp;as well, that&rsquo;s why it&rsquo;s my most favorite theme forsummer. See some incredible collection below and try to redecorate you&nbsp;house&nbsp;in best possible way.\r\n&nbsp;\r\nOrganizing items as you decorate\r\nImagine you are looking through the eyes of another person who comes to visit your&nbsp;home&nbsp;or residence. &nbsp;As they walk through the front door, what do they see first? &nbsp;Clutter and overwhelming amounts of items can be intimidating to your guests. &nbsp;Studies even have shown that people who keep neat and tidy homes actually have lower stress levels which directly lead to lowered blood pressure.\r\nYou don&rsquo;t always have to have an item in every single place. &nbsp;Open is not a bad thing, space wise. &nbsp;Imagine a bookcase. &nbsp;Your bookcase could look cluttered with every little nook and cranny filled with items&nbsp;other&nbsp;than books. &nbsp;Avoid bookshelves with clutter like the following picture:\r\n&nbsp;','&lt;h2 style=&quot;margin: 0px 0px 8px; padding: 0px; border: 0px; outline: 0px; font-size: 24px; vertical-align: baseline; color: #000000; font-weight: normal; text-decoration: none; font-family: Georgia, Geneva, \'Times New Roman\', times; font-style: normal; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 24px; vertical-align: baseline; color: #000000; font-weight: normal; text-decoration: none; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/living-room-paint-ideas/&quot;&gt;Living Room Paint Ideas&lt;/a&gt;&lt;/h2&gt;\r\n&lt;div style=&quot;margin: 0px 0px 30px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; line-height: 1.5; font-family: Helvetica, Arial, sans-serif; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Most of our time spend in our&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/business-card-doubles-as-a-cheese-grater/&quot;&gt;home&lt;/a&gt;.&amp;nbsp;It&amp;nbsp;should be simply beautiful decorated. By putting some small efforts we can result a lovely peaceful place. A common latest home maybe have featured dull colored theme but it seems like dull look. Bright colors can change the entire surrounding. It shows the elegant and stylish behavior towards the home decoration.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;The most important part of the home is your room, where you get yourself relax at day or night. There are some colors that were used from a decade and most of the room&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/relaxing-window-sill-cushioned-seats/&quot;&gt;decor&lt;/a&gt;&amp;nbsp;starts with blue and white. Different colors of touch represent our moods in most of the ways. Every&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/floating-bathtub-that-is-also-a-hammock-is-a-great-way-to-relax/&quot;&gt;color&lt;/a&gt;&amp;nbsp;has its on meaning like yellow symbolize the energy and it is also represented as attention grabber. On the&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/category/interior-design-other/&quot;&gt;other&lt;/a&gt;&amp;nbsp;hand, grey&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/tag/color/&quot;&gt;color&lt;/a&gt;&amp;nbsp;signifies the protection and strength.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Now you want to change the tedious&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/a-bunk-bed-built-for-kids-in-attic-of-home/&quot;&gt;bedroom&lt;/a&gt;&amp;nbsp;color to some energetic and peaceful color. Below are some of expert&amp;rsquo;s recommendations about the selection of color for your room.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;The strongest color is the Red, which raises the room energy level and mostly used in living room or dinning room.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;h1 style=&quot;margin: 0px 0px 5px; padding: 0px; border: 0px; outline: 0px; font-size: 30px; vertical-align: baseline; color: #333333; font-weight: normal; font-style: normal; font-family: Georgia, Geneva, \'Times New Roman\', times; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;GO Floral! This summer&lt;/h1&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Hi there, spring is sparkling everywhere with its beautiful colors and making us happy. Tidy&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/exotic-tropical-island-home-paradise-beneath-the-palm-trees/&quot;&gt;home&lt;/a&gt;&amp;nbsp;issupposed to be a sign of good women. It&amp;rsquo;s not much easy to maintain always perfect look, but by doing some small changes one can get great results.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;No matters how big is the place; sometimes &amp;ldquo;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;LESS IS MORE&lt;/strong&gt;&amp;rdquo;&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/business-card-doubles-as-a-cheese-grater/&quot;&gt;kitchen&lt;/a&gt;&amp;nbsp;decorations are changing rapidly now a days. Giving some floral touch in spring, some royal, metallic or antique touch on special occasions.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Today I&amp;rsquo;m gone share with you my very own favorite and special theme that is Just about spring. &amp;ldquo;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;Floral Theme&lt;/strong&gt;&amp;rdquo;&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;Printed Crockery&lt;/strong&gt;,&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;Table Runners&lt;/strong&gt;,&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;Curtains&lt;/strong&gt;,&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;Hand Towels&lt;/strong&gt;&amp;nbsp;can be a great source of&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;freshness&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Why you didn&amp;rsquo;t change your setting yet! Try this now, everyone in the family will definitely appreciate &amp;nbsp;your effort, so what are u waiting for? Just take small steps and&amp;nbsp;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;&quot;&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/go-floral-this-summer/&quot;&gt;GO Floral! This summer&lt;/a&gt;&lt;/strong&gt;&amp;nbsp;add some freshness in your kitchens as well, just like your wardrobes&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;&lt;span style=&quot;color: #262626; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #ffffff;&quot;&gt;Same theme can be applied on&amp;nbsp;&lt;/span&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot; href=&quot;http://www.interiordecoratingarticle.com/category/interior-design-other/&quot;&gt;other&lt;/a&gt;&lt;span style=&quot;color: #262626; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #ffffff;&quot;&gt;&amp;nbsp;parts of the&amp;nbsp;&lt;/span&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot; href=&quot;http://www.interiordecoratingarticle.com/pacific-heights-penthouse-studio/&quot;&gt;house&lt;/a&gt;&lt;span style=&quot;color: #262626; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #ffffff;&quot;&gt;&amp;nbsp;as well, that&amp;rsquo;s why it&amp;rsquo;s my most favorite theme for&lt;/span&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot; href=&quot;http://www.interiordecoratingarticle.com/wp-content/uploads/2016/03/go-floral-4.jpg&quot;&gt;&lt;img style=&quot;margin: 4px 0px 15px 15px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; height: auto; max-width: 610px; display: inline; float: right; background: transparent;&quot; src=&quot;http://www.interiordecoratingarticle.com/wp-content/uploads/2016/03/go-floral-4-290x290.jpg&quot; alt=&quot;go-floral-4&quot; width=&quot;290&quot; height=&quot;290&quot;&gt;&lt;/a&gt;&lt;span style=&quot;color: #262626; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #ffffff;&quot;&gt;summer. See some incredible collection below and try to redecorate you&amp;nbsp;&lt;/span&gt;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot; href=&quot;http://www.interiordecoratingarticle.com/tag/house/&quot;&gt;house&lt;/a&gt;&lt;span style=&quot;color: #262626; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline !important; float: none; background-color: #ffffff;&quot;&gt;&amp;nbsp;in best possible way.&lt;/span&gt;&lt;/p&gt;\r\n&lt;h1 style=&quot;margin: 0px 0px 5px; padding: 0px; border: 0px; outline: 0px; font-size: 30px; vertical-align: baseline; color: #333333; font-weight: normal; font-style: normal; font-family: Georgia, Geneva, \'Times New Roman\', times; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;&amp;nbsp;&lt;/h1&gt;\r\n&lt;h1 style=&quot;margin: 0px 0px 5px; padding: 0px; border: 0px; outline: 0px; font-size: 30px; vertical-align: baseline; color: #333333; font-weight: normal; font-style: normal; font-family: Georgia, Geneva, \'Times New Roman\', times; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Organizing items as you decorate&lt;/h1&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;Imagine you are looking through the eyes of another person who comes to visit your&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/business-card-doubles-as-a-cheese-grater/&quot;&gt;home&lt;/a&gt;&amp;nbsp;or residence. &amp;nbsp;As they walk through the front door, what do they see first? &amp;nbsp;Clutter and overwhelming amounts of items can be intimidating to your guests. &amp;nbsp;Studies even have shown that people who keep neat and tidy homes actually have lower stress levels which directly lead to lowered blood pressure.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;You don&amp;rsquo;t always have to have an item in every single place. &amp;nbsp;Open is not a bad thing, space wise. &amp;nbsp;Imagine a bookcase. &amp;nbsp;Your bookcase could look cluttered with every little nook and cranny filled with items&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #000000; background: transparent;&quot; href=&quot;http://www.interiordecoratingarticle.com/category/interior-design-other/&quot;&gt;other&lt;/a&gt;&amp;nbsp;than books. &amp;nbsp;Avoid bookshelves with clutter like the following picture:&lt;/p&gt;\r\n&lt;br style=&quot;margin: 10px 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; color: #262626; font-family: Helvetica, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18px; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: #ffffff;&quot;&gt;&amp;nbsp;&lt;/div&gt;','active',35,'2016-06-14 12:10:06',39,'user','2016-06-17 15:52:34',7,39,'2016-06-14 12:10:06',0,0,0,2,1,0),(3,'1',NULL,300,'Olive Apartments','olive-apartments','Olive Apartments is a luxurious 4-star hotel in London minutes from Old Spitalfields Market and Tower of London. This 4-star apartment is close to London Bridge and London Dungeon.FacilitiesDining facilities at Olive Apartments include a cafeteria.&nbsp;Other services:&nbsp;elevator/lift and tours/ticket assistance.GuestroomsMake yourself at home in one of the 12 guestrooms, featuring kitchens with stovetops and microwaves. Complimentary wireless Internet access is available to keep you connected.\r\n\r\nHow to book\r\nMaking your reservation in Olive N&iacute;k&eacute; Apartments is easy and secure. Simply select your dates of stay and click on the &ldquo;Check Rates&rdquo; button to submit the form.\r\nAfter room types and rates are returned to your screen, you will be able to choose the rate you desire by reading the room information in the center of the screen, then clicking on the \"Book Now\" button on the right side of the screen. After you have selected your desired room type, you will be taken to a \"Complete your booking\" form. Then you will need to review the \"Details of your stay\" and fill in the blanks on the \"Guest Details\" section. Be sure your name and email address are spelled correctly.\r\nAfter you fill out all of the needed information, press the \"Complete reservation\" button. To ensure your security, we use a secure commerce server, which encrypts the credit card number and encodes it into a non-usable form.\r\n','&lt;section style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: inherit; font-size: 14px; line-height: 22.4px; font-family: \'Open Sans\', sans-serif; vertical-align: baseline; display: block; color: #000000; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;Olive Apartments is a luxurious 4-star hotel in London minutes from Old Spitalfields Market and Tower of London. This 4-star apartment is close to London Bridge and London Dungeon.&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: bold; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;Facilities&lt;/strong&gt;&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;Dining facilities at Olive Apartments include a cafeteria.&lt;span&gt;&amp;nbsp;&lt;/span&gt;&lt;em style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: bold; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;Other services:&lt;span&gt;&amp;nbsp;&lt;/span&gt;&lt;/strong&gt;&lt;/em&gt;elevator/lift and tours/ticket assistance.&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;&lt;strong style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: bold; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;Guestrooms&lt;/strong&gt;&lt;br style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;Make yourself at home in one of the 12 guestrooms, featuring kitchens with stovetops and microwaves. Complimentary wireless Internet access is available to keep you connected.&lt;/section&gt;\r\n&lt;section style=&quot;margin: 3.333em 0px 0px; padding: 2.916em 0px 0px; border-width: 0.083em 0px 0px; border-top-style: solid; border-top-color: #cdc7c1; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: inherit; font-size: 14px; line-height: 22.4px; font-family: \'Open Sans\', sans-serif; vertical-align: baseline; display: block; color: #000000; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;&quot;&gt;\r\n&lt;h2 style=&quot;margin: 0px 0px 1.667em; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 2.083em; line-height: inherit; font-family: Lora, serif; vertical-align: baseline; color: #8e8c86;&quot;&gt;How to book&lt;/h2&gt;\r\nMaking your reservation in Olive N&amp;iacute;k&amp;eacute; Apartments is easy and secure. Simply select your dates of stay and click on the &amp;ldquo;Check Rates&amp;rdquo; button to submit the form.\r\n&lt;p style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;After room types and rates are returned to your screen, you will be able to choose the rate you desire by reading the room information in the center of the screen, then clicking on the &quot;Book Now&quot; button on the right side of the screen. After you have selected your desired room type, you will be taken to a &quot;Complete your booking&quot; form. Then you will need to review the &quot;Details of your stay&quot; and fill in the blanks on the &quot;Guest Details&quot; section. Be sure your name and email address are spelled correctly.&lt;/p&gt;\r\n&lt;p style=&quot;margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;&quot;&gt;After you fill out all of the needed information, press the &quot;Complete reservation&quot; button. To ensure your security, we use a secure commerce server, which encrypts the credit card number and encodes it into a non-usable form.&lt;/p&gt;\r\n&lt;/section&gt;','active',12,'2016-06-17 16:28:33',39,'user','2016-06-17 16:28:33',39,39,'2016-06-17 16:28:33',0,0,0,3,1,0),(5,'1',NULL,0,'10 Design Trends Coming to Homes Near You in 2016','10-design-trends-coming-to-homes-near-you-in-2016','The modern home is always evolving. And to get an idea of what it&rsquo;s evolving to, look no further than what&rsquo;s happening within its walls today. With that in mind, we delved into our New This Week series, sifting through Houzz discussions and data to find out what materials, strategies and concepts will be coming to more homes in 2016.\r\n1. Two-tone kitchen cabinets. Keep upper cabinets white or neutral for a clean, timeless feel, then go crazy with the lower cabinets by playing with various wood tones and deeper colors to take your kitchen in two different style directions.\r\n2. Outdoor fabric used indoors. Outdoor fabrics are becoming increasingly hard to distinguish from traditional indoor fabrics, and many Houzzers are bringing them inside, where their durability makes them perfect for high-traffic dining room and living room furniture, as shown here.\r\n\r\n3. Colored stainless steel appliances. Black stainless steel is making a buzz on Houzz. In a poll, nearly two-thirds of Houzzers say they would consider the dark alternative to shiny silver metal. (Shown here is LG&rsquo;s new Black Stainless collection.) Not into the darkness? Head to the light with Whirlpool&rsquo;s Sunset Bronze finish.\r\n&nbsp;\r\n4. Extra-large-format tile. Large-format tiles (such as 12 by 24 inches) have been making an appearance in kitchens and bathrooms for some time now, but be on the lookout for extra-large-format ones. Just how extra? Try 31 by 71 inches, like the ceramic Ann Sacks tiles shown here on a fireplace surround project by Pangaea. That&rsquo;s almost 3 by 6 feet\r\n&nbsp;\r\n5. Bidets. The separate bidet unit in bathrooms never really took off in America. But since manufacturers began creating combination bidet and toilet units, like the Toto version shown here, they&rsquo;ve been catching on. According to Houzz data, 5 percent of renovated master bathrooms now include bidets.\r\n&nbsp;\r\n6. Deep kitchen drawers. Houzz data shows that ease of storage is the top kitchen priority during a remodel. And while deep drawers have been creeping up to replace lower kitchen cabinets for a while now, they&rsquo;re only getting better &mdash; and more affordable. Dividers and inserts let you organize any shape or size of dish, pan or utensil under the sun, and there are even clever options for deep corner drawers, and drawers under range tops and kitchen sinks\r\n&nbsp;\r\n7. Formal dining rooms. Not everyone takes the leap to turn the dining room into an office or media room. For homeowners who entertain frequently, a designated space for gathering for special meals isn&rsquo;t negotiable, and they&rsquo;re pouring attention into these rooms\r\n&nbsp;\r\n\r\n\r\n8. Niche appliances. Looking for a little added luxury in the kitchen? Steam ovens (shown here) promise to cook food more thoroughly and healthily than microwaves; warming drawers give cooks a little wiggle room to deliver hot meals to family and guests; induction cooktops save space and are safer for homes with young kids; and kimchi refrigerators offer fans of the popular Korean condiment a chance to make their own at home.\r\n&nbsp;\r\n9. Heated entryway floors. Sure, heated floors are popular in bathrooms, but if you live in a cold region, consider putting them in your entryway to help melt snow and dry boots.\r\n&nbsp;\r\n10. Workhorse islands. Kitchen islands provide additional workspace, but they&rsquo;ve taken on so much more than that. With deep storage, prep sinks, room for seating and more, workhorse islands are becoming the central feature in modern kitchens.\r\n\r\n\r\n','&lt;p&gt;The modern home is always evolving. And to get an idea of what it&amp;rsquo;s evolving to, look no further than what&amp;rsquo;s happening within its walls today. With that in mind, we delved into our &lt;a href=&quot;http://www.houzz.com/ideabooks/query/%22new-this-week%22&quot; target=&quot;_blank&quot;&gt;New This Week series&lt;/a&gt;, sifting through Houzz &lt;a href=&quot;http://www.houzz.com/discussions&quot; target=&quot;_blank&quot;&gt;discussions&lt;/a&gt; and data to find out what materials, strategies and concepts will be coming to more homes in 2016.&lt;/p&gt;\r\n&lt;p&gt;&lt;strong&gt;1. Two-tone kitchen cabinets.&lt;/strong&gt; Keep upper cabinets white or neutral for a clean, timeless feel, then go crazy with the lower cabinets by playing with various wood tones and deeper colors to take your kitchen in two different style directions.&lt;/p&gt;\r\n&lt;p&gt;&lt;strong&gt;2. Outdoor fabric used indoors. &lt;/strong&gt;Outdoor fabrics are becoming increasingly hard to distinguish from traditional indoor fabrics, and many Houzzers are bringing them inside, where their durability makes them perfect for high-traffic dining room and living room furniture, as shown here.&lt;/p&gt;\r\n&lt;div&gt;\r\n&lt;div&gt;&lt;strong&gt;3. &lt;/strong&gt;&lt;strong&gt;Colored stainless steel appliances.&lt;/strong&gt; Black stainless steel is making a buzz on Houzz. In a poll, nearly two-thirds of Houzzers say they would consider the dark alternative to shiny silver metal. (Shown here is LG&amp;rsquo;s new Black Stainless collection.) Not into the darkness? Head to the light with Whirlpool&amp;rsquo;s Sunset Bronze finish.&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;4. Extra-large-format tile.&lt;/strong&gt; Large-format tiles (such as 12 by 24 inches) have been making an appearance in kitchens and bathrooms for some time now, but be on the lookout for &lt;em&gt;extra&lt;/em&gt;-large-format ones. Just how extra? Try 31 by 71 inches, like the ceramic Ann Sacks tiles shown here on a fireplace surround project by Pangaea. That&amp;rsquo;s almost 3 by 6 feet&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;5. &lt;/strong&gt;&lt;strong&gt;Bidets. &lt;/strong&gt;The separate bidet unit in bathrooms never really took off in America. But since manufacturers began creating combination bidet and toilet units, like the Toto version shown here, they&amp;rsquo;ve been catching on. According to Houzz data, 5 percent of renovated master bathrooms now include bidets.&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;6. Deep kitchen drawers.&lt;/strong&gt; Houzz data shows that ease of storage is the top kitchen priority during a remodel. And while deep drawers have been creeping up to replace lower kitchen cabinets for a while now, they&amp;rsquo;re only getting better &amp;mdash; and more affordable. Dividers and inserts let you organize any shape or size of dish, pan or utensil under the sun, and there are even clever options for deep corner drawers, and drawers under range tops and kitchen sinks&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;7. Formal dining rooms.&lt;/strong&gt; Not everyone takes the leap to turn the dining room into an office or media room. For homeowners who entertain frequently, a designated space for gathering for special meals isn&amp;rsquo;t negotiable, and they&amp;rsquo;re pouring attention into these rooms&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;\r\n&lt;div&gt;\r\n&lt;div&gt;&lt;strong&gt;8. Niche appliances.&lt;/strong&gt; Looking for a little added luxury in the kitchen? Steam ovens (shown here) promise to cook food more thoroughly and healthily than microwaves; warming drawers give cooks a little wiggle room to deliver hot meals to family and guests; induction cooktops save space and are safer for homes with young kids; and kimchi refrigerators offer fans of the popular Korean condiment a chance to make their own at home.&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;9. Heated entryway floors. &lt;/strong&gt;Sure, heated floors are popular in bathrooms, but if you live in a cold region, consider putting them in your entryway to help melt snow and dry boots.&lt;/div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;&lt;strong&gt;10. Workhorse islands. &lt;/strong&gt;Kitchen islands provide additional workspace, but they&amp;rsquo;ve taken on so much more than that. With deep storage, prep sinks, room for seating and more, workhorse islands are becoming the central feature in modern kitchens.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;','active',1,'2016-06-20 06:02:48',39,'user','2016-06-20 06:04:09',39,39,'2016-06-20 06:02:48',0,0,0,1,1,0),(6,'1',NULL,406,'The Idea and Invention of Villas','the-idea-and-invention-of-villas','The villa holds a central place in the history of Western architecture. the idea of a house built away from the city in a natural setting captured the imagination of wealthy patrons and architects. While the form of these structures changed over time and their location moved to suburban or even urban houses. The term villa designates several types of structure that share a natural setting or agrarian purpose. Included in the architecture of a villa may be working structures devoted to farming, referred to as villa rustica, as well as living quarters, or villa urbana. The villa is therefore most aptly understood as a label or identity capturing several distinct parts, sometimes interrelated or dependent on one another and in other cases divorced from a larger architectural complex. Rather than embodying a concrete form, the term villa exhibits mobility as the application of an idea to architecture. In place of a fixed image is an architectural environment that embodies an ideal of living, or villeggiatura\r\n&nbsp;\r\nThe Villa Recovered: Archaeological Studies in Renaissance Italy The architecture and landscape elements described by Pliny the Younger appear as part of the Roman tradition of the monumental Villa Adriana. Originally built by Emperor Hadrian in the first century A.D. (120s&ndash;130s), the villa extends across an area of more than 300 acres as a villa-estate combining the functions of imperial rule (negotium) and courtly leisure (otium). Fallen into ruin, the vast archaeological site was recovered in the fifteenth century and many architects&mdash;including Francesco di Giorgio Martini (1439&ndash;1501), Andrea Palladio (1508&ndash;1580), and Pirro Ligorio (ca. 1510&ndash;1583)&mdash;excavated and recorded firsthand the details of Hadrian&rsquo;s design while consulting descriptive passages of the emperor&rsquo;s life at the villa from the text Historia Augusta. Most notably, the architect-antiquarian Ligorio employed sculptural remains of the Villa Adriana in the Vatican gardens and as architectural spolia in his design of the nearby Villa d&rsquo;Este (begun 1560). Built as one of the most splendid garden ensembles in Renaissance Italy, Ligorio&rsquo;s design for Cardinal Ippolito II d&rsquo;Este (1509&ndash;1572) remains celebrated for its festive waterworks and terraced gardens \r\n\r\n\r\n&nbsp;\r\nVeduta del Palazzo dal Piano del Giardino con le sue Fontane\r\n\r\n\r\nLike the descriptions of ancient villas consulted by Renaissance architects, the Villa d&rsquo;Este commands spectacular vistas over the Roman campagna from its position high in the hills of Tivoli above the Villa Adriana.','&lt;p&gt;The villa holds a central place in the history of Western architecture. the idea of a house built away from the city in a natural setting captured the imagination of wealthy patrons and architects. While the form of these structures changed over time and their location moved to suburban or even urban houses. The term &lt;em&gt;villa&lt;/em&gt; designates several types of structure that share a natural setting or agrarian purpose. Included in the architecture of a villa may be working structures devoted to farming, referred to as &lt;em&gt;villa rustica&lt;/em&gt;, as well as living quarters, or &lt;em&gt;villa urbana&lt;/em&gt;. The villa is therefore most aptly understood as a label or identity capturing several distinct parts, sometimes interrelated or dependent on one another and in other cases divorced from a larger architectural complex. Rather than embodying a concrete form, the term &lt;em&gt;villa&lt;/em&gt; exhibits mobility as the application of an idea to architecture. In place of a fixed image is an architectural environment that embodies an ideal of living, or &lt;em&gt;villeggiatura&lt;/em&gt;&lt;/p&gt;\r\n&lt;p&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;p&gt;&lt;em&gt;&lt;strong&gt;The Villa Recovered: Archaeological Studies in Renaissance Italy&lt;/strong&gt;&lt;br&gt; The architecture and landscape elements described by Pliny the Younger appear as part of the Roman tradition of the monumental Villa Adriana. Originally built by Emperor Hadrian in the first century &lt;span&gt;&lt;span&gt;A.D.&lt;/span&gt;&lt;/span&gt; (120s&amp;ndash;130s), the villa extends across an area of more than 300 acres as a villa-estate combining the functions of imperial rule (&lt;em&gt;negotium&lt;/em&gt;) and courtly leisure (&lt;em&gt;otium&lt;/em&gt;). Fallen into ruin, the vast archaeological site was recovered in the fifteenth century and many architects&amp;mdash;including Francesco di Giorgio Martini (1439&amp;ndash;1501), Andrea Palladio (1508&amp;ndash;1580), and Pirro Ligorio (ca. 1510&amp;ndash;1583)&amp;mdash;excavated and recorded firsthand the details of Hadrian&amp;rsquo;s design while consulting descriptive passages of the emperor&amp;rsquo;s life at the villa from the text &lt;em&gt;Historia Augusta&lt;/em&gt;. Most notably, the architect-antiquarian Ligorio employed sculptural remains of the Villa Adriana in the Vatican gardens and as architectural spolia in his design of the nearby Villa d&amp;rsquo;Este (begun 1560). Built as one of the most splendid garden ensembles in Renaissance Italy, Ligorio&amp;rsquo;s design for Cardinal Ippolito II d&amp;rsquo;Este (1509&amp;ndash;1572) remains celebrated for its festive waterworks and terraced gardens &lt;br&gt;&lt;/em&gt;&lt;/p&gt;\r\n&lt;div&gt;&lt;br&gt;\r\n&lt;div&gt;\r\n&lt;div&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;div&gt;Veduta del Palazzo dal Piano del Giardino con le sue Fontane&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;p&gt;&lt;em&gt;Like the descriptions of ancient villas consulted by Renaissance architects, the Villa d&amp;rsquo;Este commands spectacular vistas over the Roman campagna from its position high in the hills of Tivoli above the Villa Adriana.&lt;/em&gt;&lt;/p&gt;','active',2,'2016-06-20 12:39:16',7,'user','2016-06-20 12:39:16',7,7,'2016-06-20 12:39:16',0,0,0,1,1,0);
/*!40000 ALTER TABLE `engine4_advancedarticles_artarticles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_advancedarticles_categories`
--

DROP TABLE IF EXISTS `engine4_advancedarticles_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_advancedarticles_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta` text COLLATE utf8_unicode_ci,
  `left_id` int(11) NOT NULL,
  `right_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `num_views` int(11) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `idx_left_right` (`left_id`,`right_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_advancedarticles_categories`
--

LOCK TABLES `engine4_advancedarticles_categories` WRITE;
/*!40000 ALTER TABLE `engine4_advancedarticles_categories` DISABLE KEYS */;
INSERT INTO `engine4_advancedarticles_categories` VALUES (1,'Arts & Culture','arts-culture',NULL,44,47,0,NULL,1,NULL,NULL,1,1),(2,'Business','business',NULL,4,19,0,NULL,1,NULL,NULL,1,2),(3,'Marketplace','marketplace',NULL,17,18,2,NULL,1,NULL,NULL,1,3),(4,'Press Releases','press-releases',NULL,15,16,2,NULL,1,NULL,NULL,1,4),(5,'Personal Finance','personal-finance',NULL,13,14,2,NULL,1,NULL,NULL,1,5),(6,'Earnings','earnings',NULL,11,12,2,NULL,1,NULL,NULL,1,6),(7,'Stocks','stocks',NULL,9,10,2,NULL,1,NULL,NULL,1,7),(8,'Entertainment','entertainment',NULL,53,60,0,NULL,1,NULL,NULL,1,8),(9,'Arts','arts',NULL,58,59,8,NULL,1,NULL,NULL,1,9),(10,'Fashion','fashion',NULL,56,57,8,NULL,1,NULL,NULL,1,10),(11,'Movies','movies',NULL,54,55,8,NULL,1,NULL,NULL,1,11),(12,'Health','health',NULL,51,52,0,NULL,1,NULL,NULL,1,12),(13,'Family & Home','family-home',NULL,22,27,0,NULL,1,NULL,NULL,1,13),(14,'Recreation','recreation',NULL,30,31,0,NULL,1,NULL,NULL,1,14),(15,'Personal','personal',NULL,32,33,0,NULL,1,NULL,NULL,1,15),(16,'Shopping','shopping',NULL,34,35,0,NULL,1,NULL,NULL,1,16),(17,'Society','society',NULL,36,37,0,NULL,1,NULL,NULL,1,17),(18,'Sports','sports',NULL,38,39,0,NULL,1,NULL,NULL,1,18),(19,'Technology','technology',NULL,40,41,0,NULL,1,NULL,NULL,1,19),(20,'Other','other',NULL,42,43,0,NULL,1,NULL,NULL,1,20);
/*!40000 ALTER TABLE `engine4_advancedarticles_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_advancedarticles_photos`
--

DROP TABLE IF EXISTS `engine4_advancedarticles_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_advancedarticles_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `artarticle_id` int(11) DEFAULT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `num_views` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned DEFAULT '0',
  `like_count` int(11) NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_advancedarticles_photos`
--

LOCK TABLES `engine4_advancedarticles_photos` WRITE;
/*!40000 ALTER TABLE `engine4_advancedarticles_photos` DISABLE KEYS */;
INSERT INTO `engine4_advancedarticles_photos` VALUES (1,1,7,'user','','',1,1,242,'2016-06-14 10:05:00','2016-06-14 10:05:00',0,0,0),(2,2,39,'user','','',2,2,246,'2016-06-14 12:10:07','2016-06-14 12:10:07',0,0,0),(3,3,39,'user','','',3,3,300,'2016-06-17 16:28:33','2016-06-17 16:28:33',0,0,0),(4,6,7,'user','','',6,6,406,'2016-06-20 12:39:17','2016-06-20 12:39:17',0,0,0);
/*!40000 ALTER TABLE `engine4_advancedarticles_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_album_albums`
--

DROP TABLE IF EXISTS `engine4_album_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_album_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `type` enum('wall','profile','message','blog') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `owner_type` (`owner_type`,`owner_id`),
  KEY `category_id` (`category_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_album_albums`
--

LOCK TABLES `engine4_album_albums` WRITE;
/*!40000 ALTER TABLE `engine4_album_albums` DISABLE KEYS */;
INSERT INTO `engine4_album_albums` VALUES (1,'Profile Photos','','user',1,0,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,15,0,1,'profile'),(2,'Profile Photos','','user',39,0,'2016-05-26 04:55:22','2016-05-26 04:55:22',2,4,0,1,'profile'),(7,'Profile Photos','','user',74,0,'2016-06-17 08:43:53','2016-06-17 08:43:53',12,1,0,1,'profile'),(8,'Wall Photos','','user',74,0,'2016-06-17 16:25:17','2016-06-17 16:25:18',13,1,0,1,'wall'),(9,'Wall Photos','','user',77,0,'2016-06-17 17:19:23','2016-06-17 17:19:24',16,0,0,1,'wall'),(10,'Profile Photos','','user',86,0,'2016-06-18 17:25:42','2016-06-18 17:25:42',17,0,0,1,'profile'),(12,'Wall Photos','','user',78,0,'2016-06-20 05:12:53','2016-06-20 05:12:53',19,1,0,1,'wall'),(13,'Profile Photos','','user',87,0,'2016-06-20 09:28:45','2016-06-20 09:28:45',20,0,0,1,'profile'),(14,'Profile Photos','','user',77,0,'2016-06-20 11:15:21','2016-06-20 11:15:21',22,0,0,1,'profile'),(15,'Profile Photos','','user',88,0,'2016-06-20 11:39:49','2016-06-20 11:39:50',23,0,0,1,'profile'),(16,'Profile Photos','','user',89,0,'2016-06-20 11:42:08','2016-06-20 11:42:08',24,0,0,1,'profile'),(17,'Profile Photos','','user',78,0,'2016-06-20 11:43:38','2016-06-20 11:43:38',25,0,0,1,'profile'),(18,'Profile Photos','','user',90,0,'2016-06-20 11:45:59','2016-06-20 11:46:00',27,0,0,1,'profile'),(19,'Profile Photos','','user',73,0,'2016-06-20 12:50:38','2016-06-20 12:50:38',30,0,0,1,'profile');
/*!40000 ALTER TABLE `engine4_album_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_album_categories`
--

DROP TABLE IF EXISTS `engine4_album_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_album_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_album_categories`
--

LOCK TABLES `engine4_album_categories` WRITE;
/*!40000 ALTER TABLE `engine4_album_categories` DISABLE KEYS */;
INSERT INTO `engine4_album_categories` VALUES (0,1,'All Categories'),(1,1,'Arts & Culture'),(2,1,'Business'),(3,1,'Entertainment'),(5,1,'Family & Home'),(6,1,'Health'),(7,1,'Recreation'),(8,1,'Personal'),(9,1,'Shopping'),(10,1,'Society'),(11,1,'Sports'),(12,1,'Technology'),(13,1,'Other');
/*!40000 ALTER TABLE `engine4_album_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_album_photos`
--

DROP TABLE IF EXISTS `engine4_album_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_album_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `order` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_album_photos`
--

LOCK TABLES `engine4_album_photos` WRITE;
/*!40000 ALTER TABLE `engine4_album_photos` DISABLE KEYS */;
INSERT INTO `engine4_album_photos` VALUES (1,1,'','','2016-03-29 17:16:37','2016-03-29 17:16:37',0,'user',1,5,24,0),(2,2,'','','2016-05-26 04:55:22','2016-05-26 04:55:22',0,'user',39,107,2,0),(3,2,'','','2016-05-26 04:56:27','2016-05-26 04:56:27',0,'user',39,113,1,0),(12,7,'','','2016-06-17 08:43:53','2016-06-17 08:43:53',0,'user',74,272,1,0),(13,8,'','','2016-06-17 16:25:17','2016-06-17 16:25:18',13,'user',74,294,2,0),(14,8,'','Few things have such a huge impact on happiness and the enjoyment, depth and plain fun of life as the friendships we have. \r\nIt could beÂ  the friendships Â with our partners, family members, co-workers and the people we have known for a few years now or since we were kids. Or even with people we have never even met at the other side of the world or the pets we love. \r\nSo Iâ€™d like to start 2016 by looking back and share some of the best advice on this topic from the people who have walked this earth over the past hundreds and thousands of years. \r\nThis is 74 thought-provoking, beautiful, sometimes poignant and sometimes funny quotes on friendship. \r\n     â€œA real friend is one who walks in when the rest of the world walks out.â€\r\n â€“ Walter Winchell   â€œIf you live to be 100, I hope I live to be 100 minus 1 day, so I never have to live without you.â€\r\n â€“ Winnie the Pooh   â€œI like to listen. I have learned a great deal from listening carefully. Most people never listen.â€\r\n â€“ Ernest Hemingway   â€œFriendship is born at that moment when one person says to another, â€˜What! You too? I thought I was the only one.â€\r\n â€“ C.S. Lewis   â€œTrue friendship comes when the silence between two people is comfortable.â€\r\n â€“ David Tyson   â€œSweet is the memory of distant friends! Like the mellow rays of the departing sun, it falls tenderly, yet sadly, on the heart.â€\r\n â€“ Washington Irving   â€œThereâ€™s not a word yet for old friends whoâ€™ve just met.â€\r\n â€“ Jim Henson   â€œA single rose can be my gardenâ€¦ a single friend, my world.â€\r\n â€“ Leo Buscaglia   â€œDonâ€™t make friends who are comfortable to be with. Make friends who will force you to lever yourself up.â€\r\n â€“ Thomas J. Watson   â€œYou can make more friends in two months by becoming interested in other people than you can in two years by trying to get other people interested in you.â€\r\n â€” Dale Carnegie','2016-06-17 16:27:03','2016-06-17 16:27:04',14,'user',74,296,2,1),(15,8,'','','2016-06-17 16:27:17','2016-06-17 16:27:18',15,'user',74,298,1,0),(16,9,'','','2016-06-17 17:19:23','2016-06-17 17:19:24',16,'user',77,304,2,0),(17,10,'','','2016-06-18 17:25:42','2016-06-18 17:25:42',0,'user',86,314,2,0),(19,12,'','Interior design Â is the art and science of enhancing the interiors, sometimes including the exterior, of a space or building, to achieve a healthier and more aesthetically pleasing environment for the end user. An interior designer is someone who plans, researches, coordinates and manage such projects. Interior design is a multifaceted profession that includes conceptual development, space planning, site inspections, programming, research, communicating with the stakeholders of a project, construction management, and execution of the design. \r\nInterior design is the process of shaping the experience of interior space, through the manipulation of spatial volume as well as surface treatment for the betterment of human functionality.','2016-06-20 05:12:53','2016-06-20 05:13:00',19,'user',78,316,2,1),(20,13,'','','2016-06-20 09:28:45','2016-06-20 09:28:45',0,'user',87,330,0,0),(21,2,'','','2016-06-20 11:09:08','2016-06-20 11:09:09',0,'user',39,348,0,0),(22,14,'','','2016-06-20 11:15:21','2016-06-20 11:15:21',0,'user',77,358,0,0),(23,15,'','','2016-06-20 11:39:49','2016-06-20 11:39:50',0,'user',88,364,0,0),(24,16,'','','2016-06-20 11:42:08','2016-06-20 11:42:08',0,'user',89,370,0,0),(25,17,'','','2016-06-20 11:43:38','2016-06-20 11:43:38',0,'user',78,376,0,0),(26,7,'','','2016-06-20 11:44:49','2016-06-20 11:44:49',0,'user',74,382,0,0),(27,18,'','','2016-06-20 11:45:59','2016-06-20 11:46:00',0,'user',90,388,1,0),(28,13,'','','2016-06-20 11:48:42','2016-06-20 11:48:43',0,'user',87,394,0,0),(29,13,'','','2016-06-20 11:49:33','2016-06-20 11:49:33',0,'user',87,400,1,0),(30,19,'','','2016-06-20 12:50:38','2016-06-20 12:50:38',0,'user',73,414,0,0);
/*!40000 ALTER TABLE `engine4_album_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_announcement_announcements`
--

DROP TABLE IF EXISTS `engine4_announcement_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_announcement_announcements` (
  `announcement_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `networks` text COLLATE utf8_unicode_ci,
  `member_levels` text COLLATE utf8_unicode_ci,
  `profile_types` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`announcement_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_announcement_announcements`
--

LOCK TABLES `engine4_announcement_announcements` WRITE;
/*!40000 ALTER TABLE `engine4_announcement_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_announcement_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_artarticle_fields_maps`
--

DROP TABLE IF EXISTS `engine4_artarticle_fields_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_artarticle_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_artarticle_fields_maps`
--

LOCK TABLES `engine4_artarticle_fields_maps` WRITE;
/*!40000 ALTER TABLE `engine4_artarticle_fields_maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_artarticle_fields_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_artarticle_fields_meta`
--

DROP TABLE IF EXISTS `engine4_artarticle_fields_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_artarticle_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_artarticle_fields_meta`
--

LOCK TABLES `engine4_artarticle_fields_meta` WRITE;
/*!40000 ALTER TABLE `engine4_artarticle_fields_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_artarticle_fields_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_artarticle_fields_options`
--

DROP TABLE IF EXISTS `engine4_artarticle_fields_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_artarticle_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_artarticle_fields_options`
--

LOCK TABLES `engine4_artarticle_fields_options` WRITE;
/*!40000 ALTER TABLE `engine4_artarticle_fields_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_artarticle_fields_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_artarticle_fields_search`
--

DROP TABLE IF EXISTS `engine4_artarticle_fields_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_artarticle_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_artarticle_fields_search`
--

LOCK TABLES `engine4_artarticle_fields_search` WRITE;
/*!40000 ALTER TABLE `engine4_artarticle_fields_search` DISABLE KEYS */;
INSERT INTO `engine4_artarticle_fields_search` VALUES (1),(2),(3),(4),(5),(6);
/*!40000 ALTER TABLE `engine4_artarticle_fields_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_artarticle_fields_values`
--

DROP TABLE IF EXISTS `engine4_artarticle_fields_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_artarticle_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_artarticle_fields_values`
--

LOCK TABLES `engine4_artarticle_fields_values` WRITE;
/*!40000 ALTER TABLE `engine4_artarticle_fields_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_artarticle_fields_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_allow`
--

DROP TABLE IF EXISTS `engine4_authorization_allow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_allow` (
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `action` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_type`,`resource_id`,`action`,`role`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_allow`
--

LOCK TABLES `engine4_authorization_allow` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_allow` DISABLE KEYS */;
INSERT INTO `engine4_authorization_allow` VALUES ('album',1,'comment','everyone',0,1,NULL),('album',1,'view','everyone',0,1,NULL),('album',2,'comment','everyone',0,1,NULL),('album',2,'view','everyone',0,1,NULL),('album',7,'comment','everyone',0,1,NULL),('album',7,'view','everyone',0,1,NULL),('album',8,'comment','everyone',0,1,NULL),('album',8,'view','everyone',0,1,NULL),('album',9,'comment','everyone',0,1,NULL),('album',9,'view','everyone',0,1,NULL),('album',10,'comment','everyone',0,1,NULL),('album',10,'view','everyone',0,1,NULL),('album',12,'comment','everyone',0,1,NULL),('album',12,'view','everyone',0,1,NULL),('album',13,'comment','everyone',0,1,NULL),('album',13,'view','everyone',0,1,NULL),('album',14,'comment','everyone',0,1,NULL),('album',14,'view','everyone',0,1,NULL),('album',15,'comment','everyone',0,1,NULL),('album',15,'view','everyone',0,1,NULL),('album',16,'comment','everyone',0,1,NULL),('album',16,'view','everyone',0,1,NULL),('album',17,'comment','everyone',0,1,NULL),('album',17,'view','everyone',0,1,NULL),('album',18,'comment','everyone',0,1,NULL),('album',18,'view','everyone',0,1,NULL),('album',19,'comment','everyone',0,1,NULL),('album',19,'view','everyone',0,1,NULL),('album_photo',1,'comment','everyone',0,1,NULL),('album_photo',1,'view','everyone',0,1,NULL),('album_photo',2,'comment','everyone',0,1,NULL),('album_photo',2,'view','everyone',0,1,NULL),('album_photo',3,'comment','everyone',0,1,NULL),('album_photo',3,'view','everyone',0,1,NULL),('album_photo',12,'comment','everyone',0,1,NULL),('album_photo',12,'view','everyone',0,1,NULL),('album_photo',13,'comment','everyone',0,1,NULL),('album_photo',13,'view','everyone',0,1,NULL),('album_photo',14,'comment','everyone',0,1,NULL),('album_photo',14,'view','everyone',0,1,NULL),('album_photo',15,'comment','everyone',0,1,NULL),('album_photo',15,'view','everyone',0,1,NULL),('album_photo',16,'comment','everyone',0,1,NULL),('album_photo',16,'view','everyone',0,1,NULL),('album_photo',17,'comment','everyone',0,1,NULL),('album_photo',17,'view','everyone',0,1,NULL),('album_photo',19,'comment','everyone',0,1,NULL),('album_photo',19,'view','everyone',0,1,NULL),('album_photo',20,'comment','everyone',0,1,NULL),('album_photo',20,'view','everyone',0,1,NULL),('album_photo',21,'comment','everyone',0,1,NULL),('album_photo',21,'view','everyone',0,1,NULL),('album_photo',22,'comment','everyone',0,1,NULL),('album_photo',22,'view','everyone',0,1,NULL),('album_photo',23,'comment','everyone',0,1,NULL),('album_photo',23,'view','everyone',0,1,NULL),('album_photo',24,'comment','everyone',0,1,NULL),('album_photo',24,'view','everyone',0,1,NULL),('album_photo',25,'comment','everyone',0,1,NULL),('album_photo',25,'view','everyone',0,1,NULL),('album_photo',26,'comment','everyone',0,1,NULL),('album_photo',26,'view','everyone',0,1,NULL),('album_photo',27,'comment','everyone',0,1,NULL),('album_photo',27,'view','everyone',0,1,NULL),('album_photo',28,'comment','everyone',0,1,NULL),('album_photo',28,'view','everyone',0,1,NULL),('album_photo',29,'comment','everyone',0,1,NULL),('album_photo',29,'view','everyone',0,1,NULL),('album_photo',30,'comment','everyone',0,1,NULL),('album_photo',30,'view','everyone',0,1,NULL),('artarticle',1,'comment','everyone',0,1,NULL),('artarticle',1,'comment','owner_member',0,1,NULL),('artarticle',1,'comment','owner_member_member',0,1,NULL),('artarticle',1,'comment','owner_network',0,1,NULL),('artarticle',1,'comment','registered',0,1,NULL),('artarticle',1,'view','everyone',0,1,NULL),('artarticle',1,'view','owner_member',0,1,NULL),('artarticle',1,'view','owner_member_member',0,1,NULL),('artarticle',1,'view','owner_network',0,1,NULL),('artarticle',1,'view','registered',0,1,NULL),('artarticle',2,'comment','everyone',0,1,NULL),('artarticle',2,'comment','owner_member',0,1,NULL),('artarticle',2,'comment','owner_member_member',0,1,NULL),('artarticle',2,'comment','owner_network',0,1,NULL),('artarticle',2,'comment','registered',0,1,NULL),('artarticle',2,'view','everyone',0,1,NULL),('artarticle',2,'view','owner_member',0,1,NULL),('artarticle',2,'view','owner_member_member',0,1,NULL),('artarticle',2,'view','owner_network',0,1,NULL),('artarticle',2,'view','registered',0,1,NULL),('artarticle',5,'comment','everyone',0,1,NULL),('artarticle',5,'comment','owner_member',0,1,NULL),('artarticle',5,'comment','owner_member_member',0,1,NULL),('artarticle',5,'comment','owner_network',0,1,NULL),('artarticle',5,'comment','registered',0,1,NULL),('artarticle',5,'view','everyone',0,1,NULL),('artarticle',5,'view','owner_member',0,1,NULL),('artarticle',5,'view','owner_member_member',0,1,NULL),('artarticle',5,'view','owner_network',0,1,NULL),('artarticle',5,'view','registered',0,1,NULL),('user',1,'comment','everyone',0,1,NULL),('user',1,'comment','member',0,1,NULL),('user',1,'comment','network',0,1,NULL),('user',1,'comment','registered',0,1,NULL),('user',1,'view','everyone',0,1,NULL),('user',1,'view','member',0,1,NULL),('user',1,'view','network',0,1,NULL),('user',1,'view','registered',0,1,NULL),('user',7,'comment','everyone',0,1,NULL),('user',7,'comment','member',0,1,NULL),('user',7,'comment','network',0,1,NULL),('user',7,'comment','registered',0,1,NULL),('user',7,'view','everyone',0,1,NULL),('user',7,'view','member',0,1,NULL),('user',7,'view','network',0,1,NULL),('user',7,'view','registered',0,1,NULL),('user',39,'comment','everyone',0,1,NULL),('user',39,'comment','member',0,1,NULL),('user',39,'comment','network',0,1,NULL),('user',39,'comment','registered',0,1,NULL),('user',39,'view','everyone',0,1,NULL),('user',39,'view','member',0,1,NULL),('user',39,'view','network',0,1,NULL),('user',39,'view','registered',0,1,NULL),('user',71,'comment','everyone',0,1,NULL),('user',71,'comment','member',0,1,NULL),('user',71,'comment','network',0,1,NULL),('user',71,'comment','registered',0,1,NULL),('user',71,'view','everyone',0,1,NULL),('user',71,'view','member',0,1,NULL),('user',71,'view','network',0,1,NULL),('user',71,'view','registered',0,1,NULL),('user',72,'comment','everyone',0,1,NULL),('user',72,'comment','member',0,1,NULL),('user',72,'comment','network',0,1,NULL),('user',72,'comment','registered',0,1,NULL),('user',72,'view','everyone',0,1,NULL),('user',72,'view','member',0,1,NULL),('user',72,'view','network',0,1,NULL),('user',72,'view','registered',0,1,NULL),('user',73,'comment','everyone',0,1,NULL),('user',73,'comment','member',0,1,NULL),('user',73,'comment','network',0,1,NULL),('user',73,'comment','registered',0,1,NULL),('user',73,'view','everyone',0,1,NULL),('user',73,'view','member',0,1,NULL),('user',73,'view','network',0,1,NULL),('user',73,'view','registered',0,1,NULL),('user',74,'comment','everyone',0,1,NULL),('user',74,'comment','member',0,1,NULL),('user',74,'comment','network',0,1,NULL),('user',74,'comment','registered',0,1,NULL),('user',74,'view','everyone',0,1,NULL),('user',74,'view','member',0,1,NULL),('user',74,'view','network',0,1,NULL),('user',74,'view','registered',0,1,NULL),('user',75,'comment','everyone',0,1,NULL),('user',75,'comment','member',0,1,NULL),('user',75,'comment','network',0,1,NULL),('user',75,'comment','registered',0,1,NULL),('user',75,'view','everyone',0,1,NULL),('user',75,'view','member',0,1,NULL),('user',75,'view','network',0,1,NULL),('user',75,'view','registered',0,1,NULL),('user',76,'comment','everyone',0,1,NULL),('user',76,'comment','member',0,1,NULL),('user',76,'comment','network',0,1,NULL),('user',76,'comment','registered',0,1,NULL),('user',76,'view','everyone',0,1,NULL),('user',76,'view','member',0,1,NULL),('user',76,'view','network',0,1,NULL),('user',76,'view','registered',0,1,NULL),('user',77,'comment','everyone',0,1,NULL),('user',77,'comment','member',0,1,NULL),('user',77,'comment','network',0,1,NULL),('user',77,'comment','registered',0,1,NULL),('user',77,'view','everyone',0,1,NULL),('user',77,'view','member',0,1,NULL),('user',77,'view','network',0,1,NULL),('user',77,'view','registered',0,1,NULL),('user',78,'comment','everyone',0,1,NULL),('user',78,'comment','member',0,1,NULL),('user',78,'comment','network',0,1,NULL),('user',78,'comment','registered',0,1,NULL),('user',78,'view','everyone',0,1,NULL),('user',78,'view','member',0,1,NULL),('user',78,'view','network',0,1,NULL),('user',78,'view','registered',0,1,NULL),('user',79,'comment','everyone',0,1,NULL),('user',79,'comment','member',0,1,NULL),('user',79,'comment','network',0,1,NULL),('user',79,'comment','registered',0,1,NULL),('user',79,'view','everyone',0,1,NULL),('user',79,'view','member',0,1,NULL),('user',79,'view','network',0,1,NULL),('user',79,'view','registered',0,1,NULL),('user',80,'comment','everyone',0,1,NULL),('user',80,'comment','member',0,1,NULL),('user',80,'comment','network',0,1,NULL),('user',80,'comment','registered',0,1,NULL),('user',80,'view','everyone',0,1,NULL),('user',80,'view','member',0,1,NULL),('user',80,'view','network',0,1,NULL),('user',80,'view','registered',0,1,NULL),('user',82,'comment','everyone',0,1,NULL),('user',82,'comment','member',0,1,NULL),('user',82,'comment','network',0,1,NULL),('user',82,'comment','registered',0,1,NULL),('user',82,'view','everyone',0,1,NULL),('user',82,'view','member',0,1,NULL),('user',82,'view','network',0,1,NULL),('user',82,'view','registered',0,1,NULL),('user',83,'comment','everyone',0,1,NULL),('user',83,'comment','member',0,1,NULL),('user',83,'comment','network',0,1,NULL),('user',83,'comment','registered',0,1,NULL),('user',83,'view','everyone',0,1,NULL),('user',83,'view','member',0,1,NULL),('user',83,'view','network',0,1,NULL),('user',83,'view','registered',0,1,NULL),('user',84,'comment','everyone',0,1,NULL),('user',84,'comment','member',0,1,NULL),('user',84,'comment','network',0,1,NULL),('user',84,'comment','registered',0,1,NULL),('user',84,'view','everyone',0,1,NULL),('user',84,'view','member',0,1,NULL),('user',84,'view','network',0,1,NULL),('user',84,'view','registered',0,1,NULL),('user',85,'comment','everyone',0,1,NULL),('user',85,'comment','member',0,1,NULL),('user',85,'comment','network',0,1,NULL),('user',85,'comment','registered',0,1,NULL),('user',85,'view','everyone',0,1,NULL),('user',85,'view','member',0,1,NULL),('user',85,'view','network',0,1,NULL),('user',85,'view','registered',0,1,NULL),('user',86,'comment','everyone',0,1,NULL),('user',86,'comment','member',0,1,NULL),('user',86,'comment','network',0,1,NULL),('user',86,'comment','registered',0,1,NULL),('user',86,'view','everyone',0,1,NULL),('user',86,'view','member',0,1,NULL),('user',86,'view','network',0,1,NULL),('user',86,'view','registered',0,1,NULL),('user',87,'comment','everyone',0,1,NULL),('user',87,'comment','member',0,1,NULL),('user',87,'comment','network',0,1,NULL),('user',87,'comment','registered',0,1,NULL),('user',87,'view','everyone',0,1,NULL),('user',87,'view','member',0,1,NULL),('user',87,'view','network',0,1,NULL),('user',87,'view','registered',0,1,NULL),('user',88,'comment','everyone',0,1,NULL),('user',88,'comment','member',0,1,NULL),('user',88,'comment','network',0,1,NULL),('user',88,'comment','registered',0,1,NULL),('user',88,'view','everyone',0,1,NULL),('user',88,'view','member',0,1,NULL),('user',88,'view','network',0,1,NULL),('user',88,'view','registered',0,1,NULL),('user',89,'comment','everyone',0,1,NULL),('user',89,'comment','member',0,1,NULL),('user',89,'comment','network',0,1,NULL),('user',89,'comment','registered',0,1,NULL),('user',89,'view','everyone',0,1,NULL),('user',89,'view','member',0,1,NULL),('user',89,'view','network',0,1,NULL),('user',89,'view','registered',0,1,NULL),('user',90,'comment','everyone',0,1,NULL),('user',90,'comment','member',0,1,NULL),('user',90,'comment','network',0,1,NULL),('user',90,'comment','registered',0,1,NULL),('user',90,'view','everyone',0,1,NULL),('user',90,'view','member',0,1,NULL),('user',90,'view','network',0,1,NULL),('user',90,'view','registered',0,1,NULL),('user',91,'comment','everyone',0,1,NULL),('user',91,'comment','member',0,1,NULL),('user',91,'comment','network',0,1,NULL),('user',91,'comment','registered',0,1,NULL),('user',91,'view','everyone',0,1,NULL),('user',91,'view','member',0,1,NULL),('user',91,'view','network',0,1,NULL),('user',91,'view','registered',0,1,NULL),('user',92,'comment','everyone',0,1,NULL),('user',92,'comment','member',0,1,NULL),('user',92,'comment','network',0,1,NULL),('user',92,'comment','registered',0,1,NULL),('user',92,'view','everyone',0,1,NULL),('user',92,'view','member',0,1,NULL),('user',92,'view','network',0,1,NULL),('user',92,'view','registered',0,1,NULL),('user',93,'comment','everyone',0,1,NULL),('user',93,'comment','member',0,1,NULL),('user',93,'comment','network',0,1,NULL),('user',93,'comment','registered',0,1,NULL),('user',93,'view','everyone',0,1,NULL),('user',93,'view','member',0,1,NULL),('user',93,'view','network',0,1,NULL),('user',93,'view','registered',0,1,NULL);
/*!40000 ALTER TABLE `engine4_authorization_allow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_levels`
--

DROP TABLE IF EXISTS `engine4_authorization_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_levels` (
  `level_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('public','user','moderator','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `flag` enum('default','superadmin','public') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_levels`
--

LOCK TABLES `engine4_authorization_levels` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_levels` DISABLE KEYS */;
INSERT INTO `engine4_authorization_levels` VALUES (1,'Superadmins','Users of this level can modify all of your settings and data.  This level cannot be modified or deleted.','admin','superadmin'),(3,'Moderators','Users of this level may edit user-side content.','moderator',''),(4,'Default Level','This is the default user level.  New users are assigned to it automatically.','user','default'),(5,'Public','Settings for this level apply to users who have not logged in.','public','public'),(6,'landlords','','user',NULL),(7,'tenants','','user',NULL),(8,'Services','','user',NULL);
/*!40000 ALTER TABLE `engine4_authorization_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_permissions`
--

DROP TABLE IF EXISTS `engine4_authorization_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_permissions` (
  `level_id` int(11) unsigned NOT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` tinyint(3) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_permissions`
--

LOCK TABLES `engine4_authorization_permissions` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_permissions` DISABLE KEYS */;
INSERT INTO `engine4_authorization_permissions` VALUES (1,'admin','view',1,NULL),(1,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(1,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(1,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(1,'album','comment',2,NULL),(1,'album','create',1,NULL),(1,'album','delete',2,NULL),(1,'album','edit',2,NULL),(1,'album','tag',2,NULL),(1,'album','view',2,NULL),(1,'announcement','create',1,NULL),(1,'announcement','delete',2,NULL),(1,'announcement','edit',2,NULL),(1,'announcement','view',2,NULL),(1,'artarticle','art_delete',1,NULL),(1,'artarticle','art_feature',0,NULL),(1,'artarticle','art_max',3,'15'),(1,'artarticle','art_photo',1,NULL),(1,'artarticle','art_photo_delete',1,NULL),(1,'artarticle','art_photo_edit',1,NULL),(1,'artarticle','art_sponsor',0,NULL),(1,'artarticle','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(1,'artarticle','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(1,'artarticle','comment',1,NULL),(1,'artarticle','create',0,NULL),(1,'artarticle','edit',1,NULL),(1,'artarticle','view',1,NULL),(1,'core_link','create',1,NULL),(1,'core_link','delete',2,NULL),(1,'core_link','view',2,NULL),(1,'general','activity',2,NULL),(1,'general','style',2,NULL),(1,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(1,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(1,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(1,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(1,'group','comment',2,NULL),(1,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(1,'group','create',1,NULL),(1,'group','delete',2,NULL),(1,'group','edit',2,NULL),(1,'group','event',1,NULL),(1,'group','invite',1,NULL),(1,'group','photo',1,NULL),(1,'group','photo.edit',2,NULL),(1,'group','style',1,NULL),(1,'group','topic.edit',2,NULL),(1,'group','view',2,NULL),(1,'messages','auth',3,'friends'),(1,'messages','create',1,NULL),(1,'messages','editor',3,'plaintext'),(1,'user','activity',1,NULL),(1,'user','auth_comment',5,'[\"registered\",\"network\",\"member\",\"owner\"]'),(1,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(1,'user','block',1,NULL),(1,'user','comment',2,NULL),(1,'user','commenthtml',3,''),(1,'user','create',1,NULL),(1,'user','delete',2,NULL),(1,'user','description',3,'Users of this level can modify all of your settings and data.  This level cannot be modified or deleted.'),(1,'user','edit',2,NULL),(1,'user','messages_editor',3,'plaintext'),(1,'user','quota',0,NULL),(1,'user','search',1,NULL),(1,'user','status',1,NULL),(1,'user','style',2,NULL),(1,'user','title',3,'Superadmins'),(1,'user','username',0,NULL),(1,'user','view',2,NULL),(2,'artarticle','art_delete',1,NULL),(2,'artarticle','art_feature',0,NULL),(2,'artarticle','art_max',3,'15'),(2,'artarticle','art_photo',1,NULL),(2,'artarticle','art_photo_delete',1,NULL),(2,'artarticle','art_photo_edit',1,NULL),(2,'artarticle','art_sponsor',0,NULL),(2,'artarticle','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(2,'artarticle','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(2,'artarticle','comment',1,NULL),(2,'artarticle','create',1,NULL),(2,'artarticle','edit',1,NULL),(2,'artarticle','view',1,NULL),(3,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(3,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(3,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(3,'album','comment',2,NULL),(3,'album','create',1,NULL),(3,'album','delete',2,NULL),(3,'album','edit',2,NULL),(3,'album','tag',2,NULL),(3,'album','view',2,NULL),(3,'announcement','view',1,NULL),(3,'artarticle','art_delete',1,NULL),(3,'artarticle','art_feature',0,NULL),(3,'artarticle','art_max',3,'15'),(3,'artarticle','art_photo',1,NULL),(3,'artarticle','art_photo_delete',1,NULL),(3,'artarticle','art_photo_edit',1,NULL),(3,'artarticle','art_sponsor',0,NULL),(3,'artarticle','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(3,'artarticle','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(3,'artarticle','comment',1,NULL),(3,'artarticle','create',1,NULL),(3,'artarticle','edit',1,NULL),(3,'artarticle','view',1,NULL),(3,'core_link','create',1,NULL),(3,'core_link','delete',2,NULL),(3,'core_link','view',2,NULL),(3,'general','activity',2,NULL),(3,'general','style',2,NULL),(3,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(3,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(3,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(3,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(3,'group','comment',2,NULL),(3,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(3,'group','create',1,NULL),(3,'group','delete',2,NULL),(3,'group','edit',2,NULL),(3,'group','event',1,NULL),(3,'group','invite',1,NULL),(3,'group','photo',1,NULL),(3,'group','photo.edit',2,NULL),(3,'group','style',1,NULL),(3,'group','topic.edit',2,NULL),(3,'group','view',2,NULL),(3,'messages','auth',3,'friends'),(3,'messages','create',1,NULL),(3,'messages','editor',3,'plaintext'),(3,'user','activity',1,NULL),(3,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(3,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(3,'user','block',1,NULL),(3,'user','comment',2,NULL),(3,'user','create',1,NULL),(3,'user','delete',2,NULL),(3,'user','edit',2,NULL),(3,'user','search',1,NULL),(3,'user','status',1,NULL),(3,'user','style',2,NULL),(3,'user','username',2,NULL),(3,'user','view',2,NULL),(4,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(4,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(4,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(4,'album','comment',1,NULL),(4,'album','create',1,NULL),(4,'album','delete',1,NULL),(4,'album','edit',1,NULL),(4,'album','tag',1,NULL),(4,'album','view',1,NULL),(4,'announcement','view',1,NULL),(4,'artarticle','art_delete',1,NULL),(4,'artarticle','art_feature',0,NULL),(4,'artarticle','art_max',3,'15'),(4,'artarticle','art_photo',1,NULL),(4,'artarticle','art_photo_delete',1,NULL),(4,'artarticle','art_photo_edit',1,NULL),(4,'artarticle','art_sponsor',0,NULL),(4,'artarticle','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(4,'artarticle','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(4,'artarticle','comment',1,NULL),(4,'artarticle','create',1,NULL),(4,'artarticle','edit',1,NULL),(4,'artarticle','view',1,NULL),(4,'core_link','create',1,NULL),(4,'core_link','delete',1,NULL),(4,'core_link','view',1,NULL),(4,'general','style',1,NULL),(4,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(4,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(4,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(4,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(4,'group','comment',1,NULL),(4,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(4,'group','create',1,NULL),(4,'group','delete',1,NULL),(4,'group','edit',1,NULL),(4,'group','event',1,NULL),(4,'group','invite',1,NULL),(4,'group','photo',1,NULL),(4,'group','photo.edit',1,NULL),(4,'group','style',1,NULL),(4,'group','topic.edit',1,NULL),(4,'group','view',1,NULL),(4,'messages','auth',3,'friends'),(4,'messages','create',1,NULL),(4,'messages','editor',3,'plaintext'),(4,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(4,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(4,'user','block',1,NULL),(4,'user','comment',1,NULL),(4,'user','create',1,NULL),(4,'user','delete',1,NULL),(4,'user','edit',1,NULL),(4,'user','search',1,NULL),(4,'user','status',1,NULL),(4,'user','style',1,NULL),(4,'user','username',1,NULL),(4,'user','view',1,NULL),(5,'album','tag',0,NULL),(5,'album','view',1,NULL),(5,'announcement','view',1,NULL),(5,'artarticle','view',1,NULL),(5,'core_link','view',1,NULL),(5,'group','view',1,NULL),(5,'messages','auth',0,NULL),(5,'messages','create',0,NULL),(5,'messages','editor',0,NULL),(5,'user','description',3,'Settings for this level apply to users who have not logged in.'),(5,'user','title',3,'Public'),(5,'user','view',0,NULL),(6,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(6,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(6,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(6,'album','comment',1,NULL),(6,'album','create',1,NULL),(6,'album','delete',1,NULL),(6,'album','edit',1,NULL),(6,'album','tag',1,NULL),(6,'album','view',1,NULL),(6,'announcement','view',1,NULL),(6,'core_link','create',1,NULL),(6,'core_link','delete',1,NULL),(6,'core_link','view',1,NULL),(6,'general','style',1,NULL),(6,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(6,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(6,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(6,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(6,'group','comment',1,NULL),(6,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(6,'group','create',1,NULL),(6,'group','delete',1,NULL),(6,'group','edit',1,NULL),(6,'group','event',1,NULL),(6,'group','invite',1,NULL),(6,'group','photo',1,NULL),(6,'group','photo.edit',1,NULL),(6,'group','style',1,NULL),(6,'group','topic.edit',1,NULL),(6,'group','view',1,NULL),(6,'messages','auth',3,'friends'),(6,'messages','create',1,NULL),(6,'messages','editor',3,'plaintext'),(6,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(6,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(6,'user','block',1,NULL),(6,'user','comment',1,NULL),(6,'user','create',1,NULL),(6,'user','delete',1,NULL),(6,'user','edit',1,NULL),(6,'user','search',1,NULL),(6,'user','status',1,NULL),(6,'user','style',1,NULL),(6,'user','username',1,NULL),(6,'user','view',1,NULL),(7,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(7,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(7,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(7,'album','comment',1,NULL),(7,'album','create',1,NULL),(7,'album','delete',1,NULL),(7,'album','edit',1,NULL),(7,'album','tag',1,NULL),(7,'album','view',1,NULL),(7,'announcement','view',1,NULL),(7,'core_link','create',1,NULL),(7,'core_link','delete',1,NULL),(7,'core_link','view',1,NULL),(7,'general','style',1,NULL),(7,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(7,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(7,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(7,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(7,'group','comment',1,NULL),(7,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(7,'group','create',1,NULL),(7,'group','delete',1,NULL),(7,'group','edit',1,NULL),(7,'group','event',1,NULL),(7,'group','invite',1,NULL),(7,'group','photo',1,NULL),(7,'group','photo.edit',1,NULL),(7,'group','style',1,NULL),(7,'group','topic.edit',1,NULL),(7,'group','view',1,NULL),(7,'messages','auth',3,'friends'),(7,'messages','create',1,NULL),(7,'messages','editor',3,'plaintext'),(7,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(7,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(7,'user','block',1,NULL),(7,'user','comment',1,NULL),(7,'user','create',1,NULL),(7,'user','delete',1,NULL),(7,'user','edit',1,NULL),(7,'user','search',1,NULL),(7,'user','status',1,NULL),(7,'user','style',1,NULL),(7,'user','username',1,NULL),(7,'user','view',1,NULL),(8,'album','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(8,'album','auth_tag',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(8,'album','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"owner\"]'),(8,'album','comment',1,NULL),(8,'album','create',1,NULL),(8,'album','delete',1,NULL),(8,'album','edit',1,NULL),(8,'album','tag',1,NULL),(8,'album','view',1,NULL),(8,'announcement','view',1,NULL),(8,'core_link','create',1,NULL),(8,'core_link','delete',1,NULL),(8,'core_link','view',1,NULL),(8,'general','style',1,NULL),(8,'group','auth_comment',5,'[\"registered\", \"member\", \"officer\"]'),(8,'group','auth_event',5,'[\"registered\", \"member\", \"officer\"]'),(8,'group','auth_photo',5,'[\"registered\", \"member\", \"officer\"]'),(8,'group','auth_view',5,'[\"everyone\", \"registered\", \"member\"]'),(8,'group','comment',1,NULL),(8,'group','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe'),(8,'group','create',1,NULL),(8,'group','delete',1,NULL),(8,'group','edit',1,NULL),(8,'group','event',1,NULL),(8,'group','invite',1,NULL),(8,'group','photo',1,NULL),(8,'group','photo.edit',1,NULL),(8,'group','style',1,NULL),(8,'group','topic.edit',1,NULL),(8,'group','view',1,NULL),(8,'messages','auth',3,'friends'),(8,'messages','create',1,NULL),(8,'messages','editor',3,'plaintext'),(8,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(8,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(8,'user','block',1,NULL),(8,'user','comment',1,NULL),(8,'user','create',1,NULL),(8,'user','delete',1,NULL),(8,'user','edit',1,NULL),(8,'user','search',1,NULL),(8,'user','status',1,NULL),(8,'user','style',1,NULL),(8,'user','username',1,NULL),(8,'user','view',1,NULL);
/*!40000 ALTER TABLE `engine4_authorization_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_city_list`
--

DROP TABLE IF EXISTS `engine4_city_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_city_list` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `city` varchar(100) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_city_list`
--

LOCK TABLES `engine4_city_list` WRITE;
/*!40000 ALTER TABLE `engine4_city_list` DISABLE KEYS */;
INSERT INTO `engine4_city_list` VALUES (1,1,1,'Los Angels');
/*!40000 ALTER TABLE `engine4_city_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_adcampaigns`
--

DROP TABLE IF EXISTS `engine4_core_adcampaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_adcampaigns` (
  `adcampaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `end_settings` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `limit_view` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_click` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_ctr` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `network` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adcampaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_adcampaigns`
--

LOCK TABLES `engine4_core_adcampaigns` WRITE;
/*!40000 ALTER TABLE `engine4_core_adcampaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_adcampaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_adphotos`
--

DROP TABLE IF EXISTS `engine4_core_adphotos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_adphotos` (
  `adphoto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`adphoto_id`),
  KEY `ad_id` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_adphotos`
--

LOCK TABLES `engine4_core_adphotos` WRITE;
/*!40000 ALTER TABLE `engine4_core_adphotos` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_adphotos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_ads`
--

DROP TABLE IF EXISTS `engine4_core_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_ads` (
  `ad_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ad_campaign` int(11) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `html_code` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ad_id`),
  KEY `ad_campaign` (`ad_campaign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_ads`
--

LOCK TABLES `engine4_core_ads` WRITE;
/*!40000 ALTER TABLE `engine4_core_ads` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_auth`
--

DROP TABLE IF EXISTS `engine4_core_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_auth` (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`user_id`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_auth`
--

LOCK TABLES `engine4_core_auth` WRITE;
/*!40000 ALTER TABLE `engine4_core_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedemails`
--

DROP TABLE IF EXISTS `engine4_core_bannedemails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedemails` (
  `bannedemail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedemail_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedemails`
--

LOCK TABLES `engine4_core_bannedemails` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedemails` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedemails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedips`
--

DROP TABLE IF EXISTS `engine4_core_bannedips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedips` (
  `bannedip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start` varbinary(16) NOT NULL,
  `stop` varbinary(16) NOT NULL,
  PRIMARY KEY (`bannedip_id`),
  UNIQUE KEY `start` (`start`,`stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedips`
--

LOCK TABLES `engine4_core_bannedips` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedips` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedusernames`
--

DROP TABLE IF EXISTS `engine4_core_bannedusernames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedusernames` (
  `bannedusername_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedusername_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedusernames`
--

LOCK TABLES `engine4_core_bannedusernames` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedusernames` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedusernames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedwords`
--

DROP TABLE IF EXISTS `engine4_core_bannedwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedwords` (
  `bannedword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedwords`
--

LOCK TABLES `engine4_core_bannedwords` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_comments`
--

DROP TABLE IF EXISTS `engine4_core_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_comments`
--

LOCK TABLES `engine4_core_comments` WRITE;
/*!40000 ALTER TABLE `engine4_core_comments` DISABLE KEYS */;
INSERT INTO `engine4_core_comments` VALUES (3,'album_photo',14,'user',1,'Hey','2016-06-18 01:59:27',0),(4,'album_photo',19,'user',74,'Nice\n','2016-06-20 05:14:23',0);
/*!40000 ALTER TABLE `engine4_core_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_content`
--

DROP TABLE IF EXISTS `engine4_core_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_content` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'widget',
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_content_id` int(11) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `params` text COLLATE utf8_unicode_ci,
  `attribs` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`content_id`),
  KEY `page_id` (`page_id`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=100001043 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_content`
--

LOCK TABLES `engine4_core_content` WRITE;
/*!40000 ALTER TABLE `engine4_core_content` DISABLE KEYS */;
INSERT INTO `engine4_core_content` VALUES (500,5,'container','main',NULL,2,'[\"\"]',NULL),(510,5,'container','left',500,4,'[\"\"]',NULL),(511,5,'container','middle',500,6,'[\"\"]',NULL),(520,5,'widget','user.profile-photo',510,3,'[\"\"]',NULL),(521,5,'widget','user.profile-options',510,4,'[\"\"]',NULL),(522,5,'widget','user.profile-friends-common',510,5,'{\"title\":\"Mutual Friends\"}',NULL),(523,5,'widget','user.profile-info',510,6,'{\"title\":\"Member Info\"}',NULL),(530,5,'widget','user.profile-status',511,8,'[\"\"]',NULL),(531,5,'widget','core.container-tabs',511,9,'{\"max\":\"6\"}',NULL),(540,5,'widget','activity.feed',531,11,'{\"title\":\"Updates\"}',NULL),(541,5,'widget','user.profile-fields',531,10,'{\"title\":\"Info\"}',NULL),(542,5,'widget','user.profile-friends',531,12,'{\"title\":\"Friends\",\"titleCount\":true}',NULL),(546,5,'widget','core.profile-links',531,15,'{\"title\":\"Links\",\"titleCount\":true}',NULL),(547,6,'container','main',NULL,1,NULL,NULL),(548,6,'container','middle',547,2,NULL,NULL),(549,6,'widget','core.content',548,1,NULL,NULL),(550,7,'container','main',NULL,1,NULL,NULL),(551,7,'container','middle',550,2,NULL,NULL),(552,7,'widget','core.content',551,1,NULL,NULL),(553,8,'container','main',NULL,1,NULL,NULL),(554,8,'container','middle',553,2,NULL,NULL),(555,8,'widget','core.content',554,1,NULL,NULL),(556,9,'container','main',NULL,1,NULL,NULL),(557,9,'container','middle',556,1,NULL,NULL),(558,9,'widget','core.content',557,1,NULL,NULL),(559,10,'container','main',NULL,1,NULL,NULL),(560,10,'container','middle',559,1,NULL,NULL),(561,10,'widget','core.content',560,1,NULL,NULL),(562,11,'container','main',NULL,1,NULL,NULL),(563,11,'container','middle',562,1,NULL,NULL),(564,11,'widget','core.content',563,1,NULL,NULL),(565,12,'container','main',NULL,1,NULL,NULL),(566,12,'container','middle',565,1,NULL,NULL),(567,12,'widget','core.content',566,1,NULL,NULL),(568,13,'container','main',NULL,1,NULL,NULL),(569,13,'container','middle',568,1,NULL,NULL),(570,13,'widget','core.content',569,1,NULL,NULL),(571,14,'container','top',NULL,1,NULL,NULL),(572,14,'container','main',NULL,2,NULL,NULL),(573,14,'container','middle',571,1,NULL,NULL),(574,14,'container','middle',572,2,NULL,NULL),(575,14,'widget','user.settings-menu',573,1,NULL,NULL),(576,14,'widget','core.content',574,1,NULL,NULL),(577,15,'container','top',NULL,1,NULL,NULL),(578,15,'container','main',NULL,2,NULL,NULL),(579,15,'container','middle',577,1,NULL,NULL),(580,15,'container','middle',578,2,NULL,NULL),(581,15,'widget','user.settings-menu',579,1,NULL,NULL),(582,15,'widget','core.content',580,1,NULL,NULL),(583,16,'container','top',NULL,1,NULL,NULL),(584,16,'container','main',NULL,2,NULL,NULL),(585,16,'container','middle',583,1,NULL,NULL),(586,16,'container','middle',584,2,NULL,NULL),(587,16,'widget','user.settings-menu',585,1,NULL,NULL),(588,16,'widget','core.content',586,1,NULL,NULL),(589,17,'container','top',NULL,1,NULL,NULL),(590,17,'container','main',NULL,2,NULL,NULL),(591,17,'container','middle',589,1,NULL,NULL),(592,17,'container','middle',590,2,NULL,NULL),(593,17,'widget','user.settings-menu',591,1,NULL,NULL),(594,17,'widget','core.content',592,1,NULL,NULL),(595,18,'container','top',NULL,1,NULL,NULL),(596,18,'container','main',NULL,2,NULL,NULL),(597,18,'container','middle',595,1,NULL,NULL),(598,18,'container','middle',596,2,NULL,NULL),(599,18,'widget','user.settings-menu',597,1,NULL,NULL),(600,18,'widget','core.content',598,1,NULL,NULL),(601,19,'container','top',NULL,1,NULL,NULL),(602,19,'container','main',NULL,2,NULL,NULL),(603,19,'container','middle',601,1,NULL,NULL),(604,19,'container','middle',602,2,NULL,NULL),(605,19,'widget','user.settings-menu',603,1,NULL,NULL),(606,19,'widget','core.content',604,1,NULL,NULL),(607,20,'container','top',NULL,1,NULL,NULL),(608,20,'container','main',NULL,2,NULL,NULL),(609,20,'container','middle',607,1,NULL,NULL),(610,20,'container','middle',608,2,NULL,NULL),(611,20,'container','left',608,1,NULL,NULL),(612,20,'widget','user.browse-menu',609,1,NULL,NULL),(613,20,'widget','core.content',610,1,NULL,NULL),(614,20,'widget','user.browse-search',611,1,NULL,NULL),(615,21,'container','main',NULL,1,NULL,NULL),(616,21,'container','middle',615,1,NULL,NULL),(617,21,'widget','core.content',616,1,NULL,NULL),(618,22,'container','main',NULL,1,NULL,NULL),(619,22,'container','middle',618,1,NULL,NULL),(620,22,'widget','core.content',619,2,NULL,NULL),(621,22,'widget','messages.menu',619,1,NULL,NULL),(622,23,'container','main',NULL,1,NULL,NULL),(623,23,'container','middle',622,1,NULL,NULL),(624,23,'widget','core.content',623,2,NULL,NULL),(625,23,'widget','messages.menu',623,1,NULL,NULL),(626,24,'container','main',NULL,1,NULL,NULL),(627,24,'container','middle',626,1,NULL,NULL),(628,24,'widget','core.content',627,2,NULL,NULL),(629,24,'widget','messages.menu',627,1,NULL,NULL),(630,25,'container','main',NULL,1,NULL,NULL),(631,25,'container','middle',630,1,NULL,NULL),(632,25,'widget','core.content',631,2,NULL,NULL),(633,25,'widget','messages.menu',631,1,NULL,NULL),(634,26,'container','main',NULL,1,NULL,NULL),(635,26,'container','middle',634,1,NULL,NULL),(636,26,'widget','core.content',635,2,NULL,NULL),(637,26,'widget','messages.menu',635,1,NULL,NULL),(638,27,'container','main',NULL,1,NULL,NULL),(639,27,'container','middle',638,2,NULL,NULL),(640,27,'widget','core.content',639,1,NULL,NULL),(641,27,'widget','core.comments',639,2,NULL,NULL),(642,28,'container','main',NULL,1,NULL,NULL),(643,28,'container','middle',642,2,NULL,NULL),(644,28,'widget','core.content',643,1,NULL,NULL),(645,28,'widget','core.comments',643,2,NULL,NULL),(646,29,'container','top',NULL,1,NULL,NULL),(647,29,'container','main',NULL,2,NULL,NULL),(648,29,'container','middle',646,1,NULL,NULL),(649,29,'container','middle',647,2,NULL,NULL),(650,29,'container','right',647,1,NULL,NULL),(651,29,'widget','album.browse-menu',648,1,NULL,NULL),(652,29,'widget','core.content',649,1,NULL,NULL),(653,29,'widget','album.browse-search',650,1,NULL,NULL),(654,29,'widget','album.browse-menu-quick',650,2,NULL,NULL),(655,5,'widget','album.profile-albums',531,13,'{\"title\":\"Albums\",\"titleCount\":true}',NULL),(656,30,'container','top',NULL,1,NULL,NULL),(657,30,'container','main',NULL,2,NULL,NULL),(658,30,'container','middle',656,1,NULL,NULL),(659,30,'container','middle',657,2,NULL,NULL),(660,30,'widget','album.browse-menu',658,1,NULL,NULL),(661,30,'widget','core.content',659,1,NULL,NULL),(662,31,'container','top',NULL,1,NULL,NULL),(663,31,'container','main',NULL,2,NULL,NULL),(664,31,'container','middle',662,1,NULL,NULL),(665,31,'container','middle',663,2,NULL,NULL),(666,31,'container','right',663,1,NULL,NULL),(667,31,'widget','album.browse-menu',664,1,NULL,NULL),(668,31,'widget','core.content',665,1,NULL,NULL),(669,31,'widget','album.browse-search',666,1,NULL,NULL),(670,31,'widget','album.browse-menu-quick',666,2,NULL,NULL),(671,5,'widget','group.profile-groups',531,16,'{\"title\":\"Groups\",\"titleCount\":true}',NULL),(672,32,'container','main',NULL,1,'',NULL),(673,32,'container','middle',672,3,'',NULL),(674,32,'container','left',672,1,'',NULL),(675,32,'widget','core.container-tabs',673,2,'{\"max\":\"6\"}',NULL),(676,32,'widget','group.profile-status',673,1,'',NULL),(677,32,'widget','group.profile-photo',674,1,'',NULL),(678,32,'widget','group.profile-options',674,2,'',NULL),(679,32,'widget','group.profile-info',674,3,'',NULL),(680,32,'widget','activity.feed',675,1,'{\"title\":\"Updates\"}',NULL),(681,32,'widget','group.profile-members',675,2,'{\"title\":\"Members\",\"titleCount\":true}',NULL),(682,32,'widget','group.profile-photos',675,3,'{\"title\":\"Photos\",\"titleCount\":true}',NULL),(683,32,'widget','group.profile-discussions',675,4,'{\"title\":\"Discussions\",\"titleCount\":true}',NULL),(684,32,'widget','core.profile-links',675,5,'{\"title\":\"Links\",\"titleCount\":true}',NULL),(685,32,'widget','group.profile-events',675,6,'{\"title\":\"Events\",\"titleCount\":true}',NULL),(686,33,'container','main',NULL,1,'',NULL),(687,33,'container','middle',686,2,'',NULL),(688,33,'widget','group.profile-status',687,3,'',NULL),(689,33,'widget','group.profile-photo',687,4,'',NULL),(690,33,'widget','group.profile-info',687,5,'',NULL),(691,33,'widget','core.container-tabs',687,6,'{\"max\":6}',NULL),(692,33,'widget','activity.feed',691,7,'{\"title\":\"What\'s New\"}',NULL),(693,33,'widget','group.profile-members',691,8,'{\"title\":\"Members\",\"titleCount\":true}',NULL),(694,34,'container','top',NULL,1,NULL,NULL),(695,34,'container','main',NULL,2,NULL,NULL),(696,34,'container','middle',694,1,NULL,NULL),(697,34,'container','middle',695,2,NULL,NULL),(698,34,'container','right',695,1,NULL,NULL),(699,34,'widget','group.browse-menu',696,1,NULL,NULL),(700,34,'widget','core.content',697,1,NULL,NULL),(701,34,'widget','group.browse-search',698,1,NULL,NULL),(702,34,'widget','group.browse-menu-quick',698,2,NULL,NULL),(703,35,'container','top',NULL,1,NULL,NULL),(704,35,'container','main',NULL,2,NULL,NULL),(705,35,'container','middle',703,1,NULL,NULL),(706,35,'container','middle',704,2,NULL,NULL),(707,35,'widget','group.browse-menu',705,1,NULL,NULL),(708,35,'widget','core.content',706,1,NULL,NULL),(709,36,'container','top',NULL,1,NULL,NULL),(710,36,'container','main',NULL,2,NULL,NULL),(711,36,'container','middle',709,1,NULL,NULL),(712,36,'container','middle',710,2,NULL,NULL),(713,36,'container','right',710,1,NULL,NULL),(714,36,'widget','group.browse-menu',711,1,NULL,NULL),(715,36,'widget','core.content',712,1,NULL,NULL),(716,36,'widget','group.browse-search',713,1,NULL,NULL),(717,36,'widget','group.browse-menu-quick',713,2,NULL,NULL),(746,39,'container','main',NULL,2,'[]',NULL),(747,39,'container','middle',746,6,'[]',NULL),(756,41,'container','top',NULL,1,'[\"[]\"]',NULL),(757,41,'container','main',NULL,2,'[\"[]\"]',NULL),(758,41,'container','middle',756,6,'[\"[]\"]',NULL),(759,41,'container','middle',757,6,'[\"[]\"]',NULL),(760,41,'container','left',757,4,'[\"[]\"]',NULL),(761,41,'widget','user.browse-menu',758,3,'[\"[]\"]',NULL),(762,41,'widget','core.content',759,8,'[\"[]\"]',NULL),(763,41,'widget','user.browse-search',760,6,'[\"[]\"]',NULL),(934,1,'container','main',NULL,2,'[\"\"]',''),(935,1,'widget','ynresponsivepurity.mini-menu',934,2,'{\"title\":\"Rentstarz \",\"name\":\"ynresponsivepurity.mini-menu\",\"logo\":\"public\\/admin\\/rent2-starz-landing-page.png\",\"logo_link\":\"\",\"site_name\":\"\",\"site_link\":\"\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\"}',''),(936,1,'widget','ynresponsivepurity.main-menu',934,3,'{\"title\":\"\",\"limit\":\"12\",\"name\":\"ynresponsivepurity.main-menu\",\"nomobile\":\"0\"}',''),(937,2,'container','main',NULL,2,'[\"\"]',''),(938,2,'widget','ynresponsivepurity.footer-menu',937,2,'[\"[]\"]',''),(939,3,'container','main',NULL,2,'[\"\"]',''),(940,3,'container','middle',939,6,'[\"\"]',''),(943,42,'container','main',NULL,2,'[\"\"]',''),(944,42,'container','left',943,4,'[\"\"]',''),(945,42,'widget','user.home-photo',944,3,'[\"\"]',''),(946,42,'widget','user.home-links',944,4,'[\"\"]',''),(947,42,'widget','user.list-online',944,5,'{\"title\":\"%s Members Online\"}',''),(948,42,'widget','core.statistics',944,6,'{\"title\":\"Statistics\"}',''),(949,42,'container','right',943,5,'[\"\"]',''),(950,42,'widget','activity.list-requests',949,1,'{\"title\":\"Requests\"}',''),(951,42,'widget','user.list-signups',949,2,'{\"title\":\"Newest Members\"}',''),(952,42,'widget','user.list-popular',949,3,'{\"title\":\"Popular Members\"}',''),(953,42,'container','middle',943,6,'[\"\"]',''),(954,42,'widget','announcement.list-announcements',953,1,'',''),(955,42,'widget','activity.feed',953,9,'{\"title\":\"What\'s New\"}',''),(956,3,'widget','ynresponsivepurity.slider',940,6,'{\"background_image\":\"\",\"show_title\":\"1\",\"show_description\":\"1\",\"title\":\"\",\"name\":\"ynresponsivepurity.slider\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\"}',NULL),(100000939,4,'container','main',NULL,2,'[\"\"]',''),(100000940,4,'container','middle',100000939,6,'[\"\"]',''),(100000956,4,'widget','ynresponsivepurity.slider',100000940,3,'{\"background_image\":\"\",\"show_title\":\"0\",\"show_description\":\"0\",\"title\":\"\",\"name\":\"ynresponsivepurity.slider\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\"}',NULL),(100000958,3,'widget','announcement.list-announcements',940,7,'{\"title\":\"Renting in NewYork city\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\",\"name\":\"announcement.list-announcements\",\"itemCountPerPage\":\"4\"}',NULL),(100000959,43,'container','main',NULL,2,'[]',NULL),(100000960,43,'container','middle',100000959,6,'[]',NULL),(100000961,43,'container','top',NULL,1,'[]',NULL),(100000962,43,'container','middle',100000961,6,'[]',NULL),(100000963,43,'widget','user.browse-menu',100000962,3,'[]',NULL),(100000964,43,'container','left',100000959,4,'[]',NULL),(100000965,43,'widget','user.browse-search',100000964,6,'[]',NULL),(100000966,43,'widget','core.content',100000960,8,'[]',NULL),(100000967,44,'container','main',NULL,2,'[]',NULL),(100000968,44,'container','middle',100000967,6,'[]',NULL),(100000975,44,'container','top',NULL,1,'[]',NULL),(100000976,44,'container','middle',100000975,6,'[]',NULL),(100000977,44,'widget','user.browse-menu',100000976,3,'[]',NULL),(100000978,44,'container','left',100000967,4,'[]',NULL),(100000979,44,'widget','user.browse-search',100000978,6,'[]',NULL),(100000980,44,'widget','core.content',100000968,8,'[]',NULL),(100000981,45,'container','main',NULL,2,'[\"[]\"]',NULL),(100000982,45,'container','middle',100000981,6,'[\"[]\"]',NULL),(100000983,45,'container','top',NULL,1,'[\"[]\"]',NULL),(100000984,45,'container','middle',100000983,6,'[\"[]\"]',NULL),(100000985,45,'container','left',100000981,4,'[\"[]\"]',NULL),(100000986,45,'widget','user.browse-search',100000985,6,'[\"[]\"]',NULL),(100000987,45,'widget','core.content',100000982,8,'[\"[]\"]',NULL),(100000988,3,'container','top',NULL,1,'[]',NULL),(100000989,3,'container','middle',100000988,6,'[]',NULL),(100000990,3,'container','left',939,4,'[]',NULL),(100000991,5,'widget','user.profile-documents',531,14,'{\"title\":\"Documents\"}',NULL),(100000992,45,'widget','user.browse-menu',100000984,3,'[]',NULL),(100000993,46,'container','top',NULL,1,'[\"[]\"]',NULL),(100000994,46,'container','middle',100000993,6,'[\"[]\"]',NULL),(100000995,46,'widget','advancedarticles.actions-block',100000994,3,'[\"[]\"]',NULL),(100000996,46,'container','main',NULL,2,'[\"[]\"]',NULL),(100000997,46,'container','left',100000996,4,'[\"[]\"]',NULL),(100001002,46,'container','middle',100000996,6,'[\"[]\"]',NULL),(100001003,46,'widget','advancedarticles.featured-block',100001002,7,'{\"title\":\"Featured Articles\",\"name\":\"advancedarticles.featured-block\",\"perpage\":\"4\",\"category_id\":\"0\",\"interval\":\"5\",\"sort\":\"title\",\"nomobile\":\"0\"}',NULL),(100001004,46,'widget','core.container-tabs',100001002,8,'{\"max\":6}',NULL),(100001008,46,'container','right',100000996,5,'[\"[]\"]',NULL),(100001012,47,'container','top',NULL,1,NULL,NULL),(100001013,47,'container','middle',100001012,6,NULL,NULL),(100001014,47,'widget','advancedarticles.actions-block',100001013,3,NULL,NULL),(100001015,47,'widget','advancedarticles.bredcrumbs-block',100001013,4,NULL,NULL),(100001016,47,'container','main',NULL,2,NULL,NULL),(100001017,47,'container','middle',100001016,6,NULL,NULL),(100001018,47,'widget','advancedarticles.listarticle-block',100001017,7,NULL,NULL),(100001019,47,'container','right',100001016,5,NULL,NULL),(100001020,47,'widget','advancedarticles.categories-block',100001019,9,NULL,NULL),(100001021,47,'widget','advancedarticles.filter-block',100001019,10,NULL,NULL),(100001022,48,'container','top',NULL,1,'[]',NULL),(100001023,48,'container','middle',100001022,6,'[]',NULL),(100001024,48,'widget','advancedarticles.actions-block',100001023,3,'[]',NULL),(100001025,48,'widget','advancedarticles.bredcrumbs-block',100001023,4,'[]',NULL),(100001026,48,'container','main',NULL,2,'[]',NULL),(100001027,48,'container','middle',100001026,6,'[]',NULL),(100001028,48,'widget','advancedarticles.article-block',100001027,7,'[]',NULL),(100001029,48,'container','right',100001026,5,'[]',NULL),(100001032,49,'container','top',NULL,1,NULL,NULL),(100001033,49,'container','middle',100001032,6,NULL,NULL),(100001034,49,'widget','advancedarticles.actions-block',100001033,3,NULL,NULL),(100001035,49,'container','main',NULL,2,NULL,NULL),(100001036,49,'container','middle',100001035,6,NULL,NULL),(100001037,49,'widget','advancedarticles.tags-block',100001036,7,'{\"title\":\"Popular Tags\",\"name\":\"advancedarticles.tags-block\",\"perpage\":\"20\",\"link\":\"0\",\"sort\":\"text\",\"nomobile\":\"0\"}',NULL),(100001038,49,'container','right',100001035,5,NULL,NULL),(100001039,49,'widget','advancedarticles.filter-block',100001038,8,NULL,NULL),(100001040,46,'widget','advancedarticles.trending-articles',100001008,11,'{\"title\":\"Trending Articles\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\",\"name\":\"advancedarticles.trending-articles\"}',NULL),(100001041,46,'widget','advancedarticles.listarticle-block',100001004,9,'{\"title\":\"Articles\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\",\"name\":\"advancedarticles.listarticle-block\"}',NULL),(100001042,48,'widget','advancedarticles.trending-articles',100001029,9,'{\"title\":\"Trending Articles\",\"nomobile\":\"0\",\"notablet\":\"0\",\"nofullsite\":\"0\",\"name\":\"advancedarticles.trending-articles\"}',NULL);
/*!40000 ALTER TABLE `engine4_core_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_geotags`
--

DROP TABLE IF EXISTS `engine4_core_geotags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_geotags` (
  `geotag_id` int(11) unsigned NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`geotag_id`),
  KEY `latitude` (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_geotags`
--

LOCK TABLES `engine4_core_geotags` WRITE;
/*!40000 ALTER TABLE `engine4_core_geotags` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_geotags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_jobs`
--

DROP TABLE IF EXISTS `engine4_core_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_jobs` (
  `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `jobtype_id` int(10) unsigned NOT NULL,
  `state` enum('pending','active','sleeping','failed','cancelled','completed','timeout') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `is_complete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `progress` decimal(5,4) unsigned NOT NULL DEFAULT '0.0000',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `data` text COLLATE utf8_unicode_ci,
  `messages` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`job_id`),
  KEY `jobtype_id` (`jobtype_id`),
  KEY `state` (`state`),
  KEY `is_complete` (`is_complete`,`priority`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_jobs`
--

LOCK TABLES `engine4_core_jobs` WRITE;
/*!40000 ALTER TABLE `engine4_core_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_jobtypes`
--

DROP TABLE IF EXISTS `engine4_core_jobtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_jobtypes` (
  `jobtype_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `multi` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`jobtype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_jobtypes`
--

LOCK TABLES `engine4_core_jobtypes` WRITE;
/*!40000 ALTER TABLE `engine4_core_jobtypes` DISABLE KEYS */;
INSERT INTO `engine4_core_jobtypes` VALUES (1,'Download File','file_download','core','Core_Plugin_Job_FileDownload','Core_Form_Admin_Job_FileDownload',1,100,1),(2,'Upload File','file_upload','core','Core_Plugin_Job_FileUpload','Core_Form_Admin_Job_FileUpload',1,100,1),(3,'Rebuild Activity Privacy','activity_maintenance_rebuild_privacy','activity','Activity_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1),(4,'Rebuild Member Privacy','user_maintenance_rebuild_privacy','user','User_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1),(5,'Rebuild Network Membership','network_maintenance_rebuild_membership','network','Network_Plugin_Job_Maintenance_RebuildMembership',NULL,1,50,1),(6,'Storage Transfer','storage_transfer','core','Storage_Plugin_Job_Transfer','Core_Form_Admin_Job_Generic',1,100,1),(7,'Storage Cleanup','storage_cleanup','core','Storage_Plugin_Job_Cleanup','Core_Form_Admin_Job_Generic',1,100,1),(8,'Rebuild Album Privacy','album_maintenance_rebuild_privacy','album','Album_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1),(9,'Rebuild Group Privacy','group_maintenance_rebuild_privacy','group','Group_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1);
/*!40000 ALTER TABLE `engine4_core_jobtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_languages`
--

DROP TABLE IF EXISTS `engine4_core_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_languages` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fallback` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_languages`
--

LOCK TABLES `engine4_core_languages` WRITE;
/*!40000 ALTER TABLE `engine4_core_languages` DISABLE KEYS */;
INSERT INTO `engine4_core_languages` VALUES (1,'en','English','en',1);
/*!40000 ALTER TABLE `engine4_core_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_likes`
--

DROP TABLE IF EXISTS `engine4_core_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_likes`
--

LOCK TABLES `engine4_core_likes` WRITE;
/*!40000 ALTER TABLE `engine4_core_likes` DISABLE KEYS */;
INSERT INTO `engine4_core_likes` VALUES (1,'album_photo',1,'user',1),(17,'album_photo',19,'user',74);
/*!40000 ALTER TABLE `engine4_core_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_links`
--

DROP TABLE IF EXISTS `engine4_core_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_links` (
  `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `view_count` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`link_id`),
  KEY `owner` (`owner_type`,`owner_id`),
  KEY `parent` (`parent_type`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_links`
--

LOCK TABLES `engine4_core_links` WRITE;
/*!40000 ALTER TABLE `engine4_core_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_listitems`
--

DROP TABLE IF EXISTS `engine4_core_listitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_listitems`
--

LOCK TABLES `engine4_core_listitems` WRITE;
/*!40000 ALTER TABLE `engine4_core_listitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_listitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_lists`
--

DROP TABLE IF EXISTS `engine4_core_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `child_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_lists`
--

LOCK TABLES `engine4_core_lists` WRITE;
/*!40000 ALTER TABLE `engine4_core_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_log`
--

DROP TABLE IF EXISTS `engine4_core_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_log` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `plugin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(2) NOT NULL DEFAULT '6',
  `priorityName` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INFO',
  PRIMARY KEY (`message_id`),
  KEY `domain` (`domain`,`timestamp`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_log`
--

LOCK TABLES `engine4_core_log` WRITE;
/*!40000 ALTER TABLE `engine4_core_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mail`
--

DROP TABLE IF EXISTS `engine4_core_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mail` (
  `mail_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('system','zend') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(3) DEFAULT '100',
  `recipient_count` int(11) unsigned DEFAULT '0',
  `recipient_total` int(10) NOT NULL DEFAULT '0',
  `creation_time` datetime NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mail`
--

LOCK TABLES `engine4_core_mail` WRITE;
/*!40000 ALTER TABLE `engine4_core_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mailrecipients`
--

DROP TABLE IF EXISTS `engine4_core_mailrecipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mailrecipients` (
  `recipient_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`recipient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mailrecipients`
--

LOCK TABLES `engine4_core_mailrecipients` WRITE;
/*!40000 ALTER TABLE `engine4_core_mailrecipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_mailrecipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mailtemplates`
--

DROP TABLE IF EXISTS `engine4_core_mailtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mailtemplates` (
  `mailtemplate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `vars` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mailtemplate_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mailtemplates`
--

LOCK TABLES `engine4_core_mailtemplates` WRITE;
/*!40000 ALTER TABLE `engine4_core_mailtemplates` DISABLE KEYS */;
INSERT INTO `engine4_core_mailtemplates` VALUES (1,'header','core',''),(2,'footer','core',''),(3,'header_member','core',''),(4,'footer_member','core',''),(5,'core_contact','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_name],[sender_email],[sender_link],[sender_photo],[message]'),(6,'core_verification','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(7,'core_verification_password','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),(8,'core_welcome','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(9,'core_welcome_password','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),(10,'notify_admin_user_signup','core','[host],[email],[date],[recipient_title],[object_title],[object_link]'),(11,'core_lostpassword','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(12,'notify_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(13,'notify_commented_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(14,'notify_liked','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(15,'notify_liked_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(16,'user_account_approved','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo]'),(17,'notify_friend_accepted','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(18,'notify_friend_request','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(19,'notify_friend_follow_request','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(20,'notify_friend_follow_accepted','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(21,'notify_friend_follow','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(22,'notify_post_user','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(23,'notify_tagged','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(24,'notify_message_new','messages','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(25,'invite','invite','[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),(26,'invite_code','invite','[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),(27,'payment_subscription_active','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(28,'payment_subscription_cancelled','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(29,'payment_subscription_expired','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(30,'payment_subscription_overdue','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(31,'payment_subscription_pending','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(32,'payment_subscription_recurrence','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(33,'payment_subscription_refunded','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(34,'notify_group_accepted','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(35,'notify_group_approve','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(36,'notify_group_discussion_reply','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(37,'notify_group_discussion_response','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(38,'notify_group_invite','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(39,'notify_group_promote','group','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]');
/*!40000 ALTER TABLE `engine4_core_mailtemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_menuitems`
--

DROP TABLE IF EXISTS `engine4_core_menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_menuitems` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `menu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `submenu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `LOOKUP` (`name`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_menuitems`
--

LOCK TABLES `engine4_core_menuitems` WRITE;
/*!40000 ALTER TABLE `engine4_core_menuitems` DISABLE KEYS */;
INSERT INTO `engine4_core_menuitems` VALUES (1,'core_main_home','core','Home','User_Plugin_Menus','','core_main','',0,0,1),(2,'core_sitemap_home','core','Home','','{\"route\":\"default\"}','core_sitemap','',1,0,1),(3,'core_footer_privacy','core','Privacy','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"privacy\"}','core_footer','',1,0,1),(4,'core_footer_terms','core','Terms of Service','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"terms\"}','core_footer','',1,0,2),(5,'core_footer_contact','core','Contact','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"contact\"}','core_footer','',1,0,3),(6,'core_mini_admin','core','Admin','User_Plugin_Menus','','core_mini','',1,0,6),(7,'core_mini_profile','user','My Profile','User_Plugin_Menus','','core_mini','',1,0,4),(8,'core_mini_settings','user','Settings','User_Plugin_Menus','','core_mini','',1,0,2),(9,'core_mini_auth','user','Auth','User_Plugin_Menus','','core_mini','',1,0,1),(10,'core_mini_signup','user','Signup','User_Plugin_Menus','','core_mini','',1,0,5),(11,'core_admin_main_home','core','Home','','{\"route\":\"admin_default\"}','core_admin_main','',1,0,1),(12,'core_admin_main_manage','core','Manage','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_manage',1,0,2),(13,'core_admin_main_settings','core','Settings','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_settings',1,0,3),(14,'core_admin_main_plugins','core','Plugins','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_plugins',1,0,4),(15,'core_admin_main_layout','core','Layout','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_layout',1,0,5),(16,'core_admin_main_ads','core','Ads','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_ads',1,0,6),(17,'core_admin_main_stats','core','Stats','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_stats',1,0,8),(18,'core_admin_main_manage_levels','core','Member Levels','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\"}','core_admin_main_manage','',1,0,2),(19,'core_admin_main_manage_networks','network','Networks','','{\"route\":\"admin_default\",\"module\":\"network\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,3),(20,'core_admin_main_manage_announcements','announcement','Announcements','','{\"route\":\"admin_default\",\"module\":\"announcement\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,4),(21,'core_admin_message_mail','core','Email All Members','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"message\",\"action\":\"mail\"}','core_admin_main_manage','',1,0,5),(22,'core_admin_main_manage_reports','core','Abuse Reports','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"report\"}','core_admin_main_manage','',1,0,6),(23,'core_admin_main_manage_packages','core','Packages & Plugins','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"packages\"}','core_admin_main_manage','',1,0,7),(24,'core_admin_main_settings_general','core','General Settings','','{\"route\":\"core_admin_settings\",\"action\":\"general\"}','core_admin_main_settings','',1,0,1),(25,'core_admin_main_settings_locale','core','Locale Settings','','{\"route\":\"core_admin_settings\",\"action\":\"locale\"}','core_admin_main_settings','',1,0,1),(26,'core_admin_main_settings_fields','fields','Profile Questions','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"fields\"}','core_admin_main_settings','',1,0,2),(27,'core_admin_main_wibiya','core','Wibiya Integration','','{\"route\":\"admin_default\", \"action\":\"wibiya\", \"controller\":\"settings\", \"module\":\"core\"}','core_admin_main_settings','',1,0,4),(28,'core_admin_main_settings_spam','core','Spam & Banning Tools','','{\"route\":\"core_admin_settings\",\"action\":\"spam\"}','core_admin_main_settings','',1,0,5),(29,'core_admin_main_settings_mailtemplates','core','Mail Templates','','{\"route\":\"admin_default\",\"controller\":\"mail\",\"action\":\"templates\"}','core_admin_main_settings','',1,0,6),(30,'core_admin_main_settings_mailsettings','core','Mail Settings','','{\"route\":\"admin_default\",\"controller\":\"mail\",\"action\":\"settings\"}','core_admin_main_settings','',1,0,7),(31,'core_admin_main_settings_performance','core','Performance & Caching','','{\"route\":\"core_admin_settings\",\"action\":\"performance\"}','core_admin_main_settings','',1,0,8),(32,'core_admin_main_settings_password','core','Admin Password','','{\"route\":\"core_admin_settings\",\"action\":\"password\"}','core_admin_main_settings','',1,0,9),(33,'core_admin_main_settings_tasks','core','Task Scheduler','','{\"route\":\"admin_default\",\"controller\":\"tasks\"}','core_admin_main_settings','',1,0,10),(34,'core_admin_main_layout_content','core','Layout Editor','','{\"route\":\"admin_default\",\"controller\":\"content\"}','core_admin_main_layout','',1,0,1),(35,'core_admin_main_layout_themes','core','Theme Editor','','{\"route\":\"admin_default\",\"controller\":\"themes\"}','core_admin_main_layout','',1,0,2),(36,'core_admin_main_layout_files','core','File & Media Manager','','{\"route\":\"admin_default\",\"controller\":\"files\"}','core_admin_main_layout','',1,0,3),(37,'core_admin_main_layout_language','core','Language Manager','','{\"route\":\"admin_default\",\"controller\":\"language\"}','core_admin_main_layout','',1,0,4),(38,'core_admin_main_layout_menus','core','Menu Editor','','{\"route\":\"admin_default\",\"controller\":\"menus\"}','core_admin_main_layout','',1,0,5),(39,'core_admin_main_ads_manage','core','Manage Ad Campaigns','','{\"route\":\"admin_default\",\"controller\":\"ads\"}','core_admin_main_ads','',1,0,1),(40,'core_admin_main_ads_create','core','Create New Campaign','','{\"route\":\"admin_default\",\"controller\":\"ads\",\"action\":\"create\"}','core_admin_main_ads','',1,0,2),(41,'core_admin_main_ads_affiliate','core','SE Affiliate Program','','{\"route\":\"admin_default\",\"controller\":\"settings\",\"action\":\"affiliate\"}','core_admin_main_ads','',1,0,3),(42,'core_admin_main_ads_viglink','core','VigLink','','{\"route\":\"admin_default\",\"controller\":\"settings\",\"action\":\"viglink\"}','core_admin_main_ads','',1,0,4),(43,'core_admin_main_stats_statistics','core','Site-wide Statistics','','{\"route\":\"admin_default\",\"controller\":\"stats\"}','core_admin_main_stats','',1,0,1),(44,'core_admin_main_stats_url','core','Referring URLs','','{\"route\":\"admin_default\",\"controller\":\"stats\",\"action\":\"referrers\"}','core_admin_main_stats','',1,0,2),(45,'core_admin_main_stats_resources','core','Server Information','','{\"route\":\"admin_default\",\"controller\":\"system\"}','core_admin_main_stats','',1,0,3),(46,'core_admin_main_stats_logs','core','Log Browser','','{\"route\":\"admin_default\",\"controller\":\"log\",\"action\":\"index\"}','core_admin_main_stats','',1,0,3),(47,'core_admin_banning_general','core','Spam & Banning Tools','','{\"route\":\"core_admin_settings\",\"action\":\"spam\"}','core_admin_banning','',1,0,1),(48,'adcampaign_admin_main_edit','core','Edit Settings','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"ads\",\"action\":\"edit\"}','adcampaign_admin_main','',1,0,1),(49,'adcampaign_admin_main_manageads','core','Manage Advertisements','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"ads\",\"action\":\"manageads\"}','adcampaign_admin_main','',1,0,2),(50,'core_admin_main_settings_activity','activity','Activity Feed Settings','','{\"route\":\"admin_default\",\"module\":\"activity\",\"controller\":\"settings\",\"action\":\"index\"}','core_admin_main_settings','',1,0,4),(51,'core_admin_main_settings_notifications','activity','Default Email Notifications','','{\"route\":\"admin_default\",\"module\":\"activity\",\"controller\":\"settings\",\"action\":\"notifications\"}','core_admin_main_settings','',1,0,11),(52,'authorization_admin_main_manage','authorization','View Member Levels','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\"}','authorization_admin_main','',1,0,1),(53,'authorization_admin_main_level','authorization','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\",\"action\":\"edit\"}','authorization_admin_main','',1,0,3),(54,'authorization_admin_level_main','authorization','Level Info','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\",\"action\":\"edit\"}','authorization_admin_level','',1,0,1),(55,'core_main_user','user','Landlord','','{\"route\":\"user_general\",\"action\":\"browse\"}','core_main','',0,0,4),(56,'core_sitemap_user','user','Members','','{\"route\":\"user_general\",\"action\":\"browse\"}','core_sitemap','',1,0,2),(57,'user_home_updates','user','View Recent Updates','User_Plugin_Menus','{\"route\":\"recent_activity\",\"icon\":\"application/modules/User/externals/images/links/updates.png\"}','user_home','',1,0,5),(58,'user_home_view','user','View My Profile','User_Plugin_Menus','{\"route\":\"user_profile_self\",\"icon\":\"application/modules/User/externals/images/links/profile.png\"}','user_home','',1,0,2),(59,'user_home_edit','user','Edit My Profile','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"profile\",\"icon\":\"application/modules/User/externals/images/links/edit.png\"}','user_home','',1,0,1),(60,'user_home_friends','user','Browse Members','User_Plugin_Menus','{\"route\":\"user_general\",\"controller\":\"index\",\"action\":\"browse\",\"icon\":\"application/modules/User/externals/images/links/search.png\"}','user_home','',1,0,3),(61,'user_profile_edit','user','Edit Profile','User_Plugin_Menus','','user_profile','',1,0,1),(62,'user_profile_friend','user','Friends','User_Plugin_Menus','','user_profile','',1,0,4),(63,'user_profile_block','user','Block','User_Plugin_Menus','','user_profile','',1,0,5),(64,'user_profile_report','user','Report User','User_Plugin_Menus','','user_profile','',1,0,6),(65,'user_profile_admin','user','Admin Settings','User_Plugin_Menus','','user_profile','',1,0,7),(66,'user_edit_profile','user','Personal Info','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"profile\"}','user_edit','',1,0,1),(67,'user_edit_photo','user','Edit My Photo','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"photo\"}','user_edit','',1,0,2),(68,'user_edit_style','user','Profile Style','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"style\"}','user_edit','',1,0,3),(69,'user_settings_general','user','General','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"general\"}','user_settings','',1,0,1),(70,'user_settings_privacy','user','Privacy','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"privacy\"}','user_settings','',1,0,2),(71,'user_settings_notifications','user','Notifications','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"notifications\"}','user_settings','',1,0,3),(72,'user_settings_password','user','Change Password','','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"password\"}','user_settings','',1,0,5),(73,'user_settings_delete','user','Delete Account','User_Plugin_Menus::canDelete','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"delete\"}','user_settings','',1,0,6),(74,'core_admin_main_manage_members','user','Members','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,1),(75,'core_admin_main_signup','user','Signup Process','','{\"route\":\"admin_default\", \"controller\":\"signup\", \"module\":\"user\"}','core_admin_main_settings','',1,0,3),(76,'core_admin_main_facebook','user','Facebook Integration','','{\"route\":\"admin_default\", \"action\":\"facebook\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(77,'core_admin_main_twitter','user','Twitter Integration','','{\"route\":\"admin_default\", \"action\":\"twitter\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(78,'core_admin_main_janrain','user','Janrain Integration','','{\"route\":\"admin_default\", \"action\":\"janrain\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(79,'core_admin_main_settings_friends','user','Friendship Settings','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"friends\"}','core_admin_main_settings','',1,0,6),(80,'user_admin_banning_logins','user','Login History','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"logins\",\"action\":\"index\"}','core_admin_banning','',1,0,2),(81,'authorization_admin_level_user','user','Members','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"level\"}','authorization_admin_level','',1,0,2),(82,'core_mini_messages','messages','Messages','Messages_Plugin_Menus','','core_mini','',1,0,3),(83,'user_profile_message','messages','Send Message','Messages_Plugin_Menus','','user_profile','',1,0,2),(84,'authorization_admin_level_messages','messages','Messages','','{\"route\":\"admin_default\",\"module\":\"messages\",\"controller\":\"settings\",\"action\":\"level\"}','authorization_admin_level','',1,0,3),(85,'messages_main_inbox','messages','Inbox','','{\"route\":\"messages_general\",\"action\":\"inbox\"}','messages_main','',1,0,1),(86,'messages_main_outbox','messages','Sent Messages','','{\"route\":\"messages_general\",\"action\":\"outbox\"}','messages_main','',1,0,2),(87,'messages_main_compose','messages','Compose Message','','{\"route\":\"messages_general\",\"action\":\"compose\"}','messages_main','',1,0,3),(88,'user_settings_network','network','Networks','','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"network\"}','user_settings','',1,0,3),(89,'core_main_invite','invite','Invite','Invite_Plugin_Menus::canInvite','{\"route\":\"default\",\"module\":\"invite\"}','core_main','',1,0,11),(90,'user_home_invite','invite','Invite Your Friends','Invite_Plugin_Menus::canInvite','{\"route\":\"default\",\"module\":\"invite\",\"icon\":\"application/modules/Invite/externals/images/invite.png\"}','user_home','',1,0,4),(91,'core_admin_main_settings_storage','core','Storage System','','{\"route\":\"admin_default\",\"module\":\"storage\",\"controller\":\"services\",\"action\":\"index\"}','core_admin_main_settings','',1,0,11),(92,'user_settings_payment','user','Subscription','Payment_Plugin_Menus','{\"route\":\"default\", \"module\":\"payment\", \"controller\":\"settings\", \"action\":\"index\"}','user_settings','',1,0,4),(93,'core_admin_main_payment','payment','Billing','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_payment',1,0,7),(94,'core_admin_main_payment_transactions','payment','Transactions','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"index\",\"action\":\"index\"}','core_admin_main_payment','',1,0,1),(95,'core_admin_main_payment_settings','payment','Settings','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"settings\",\"action\":\"index\"}','core_admin_main_payment','',1,0,2),(96,'core_admin_main_payment_gateways','payment','Gateways','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"gateway\",\"action\":\"index\"}','core_admin_main_payment','',1,0,3),(97,'core_admin_main_payment_packages','payment','Plans','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"package\",\"action\":\"index\"}','core_admin_main_payment','',1,0,4),(98,'core_admin_main_payment_subscriptions','payment','Subscriptions','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"subscription\",\"action\":\"index\"}','core_admin_main_payment','',1,0,5),(99,'core_main_album','album','Gallery','','{\"route\":\"album_general\",\"action\":\"browse\"}','core_main','',1,0,10),(100,'core_sitemap_album','album','Gallery','','{\"route\":\"album_general\",\"action\":\"browse\"}','core_sitemap','',1,0,4),(101,'album_main_browse','album','Browse Albums','Album_Plugin_Menus::canViewAlbums','{\"route\":\"album_general\",\"action\":\"browse\"}','album_main','',1,0,1),(102,'album_main_manage','album','My Albums','Album_Plugin_Menus::canCreateAlbums','{\"route\":\"album_general\",\"action\":\"manage\"}','album_main','',1,0,2),(103,'album_main_upload','album','Add New Photos','Album_Plugin_Menus::canCreateAlbums','{\"route\":\"album_general\",\"action\":\"upload\"}','album_main','',1,0,3),(104,'album_quick_upload','album','Add New Photos','Album_Plugin_Menus::canCreateAlbums','{\"route\":\"album_general\",\"action\":\"upload\",\"class\":\"buttonlink icon_photos_new\"}','album_quick','',1,0,1),(105,'core_admin_main_plugins_album','album','Photo Albums','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"manage\",\"action\":\"index\"}','core_admin_main_plugins','',1,0,999),(106,'album_admin_main_manage','album','View Albums','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"manage\"}','album_admin_main','',1,0,1),(107,'album_admin_main_settings','album','Global Settings','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"settings\"}','album_admin_main','',1,0,2),(108,'album_admin_main_level','album','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"level\"}','album_admin_main','',1,0,3),(109,'album_admin_main_categories','album','Categories','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"settings\", \"action\":\"categories\"}','album_admin_main','',1,0,4),(110,'authorization_admin_level_album','album','Photo Albums','','{\"route\":\"admin_default\",\"module\":\"album\",\"controller\":\"level\",\"action\":\"index\"}','authorization_admin_level','',1,0,999),(111,'mobi_browse_album','album','Albums','','{\"route\":\"album_general\",\"action\":\"browse\"}','mobi_browse','',1,0,2),(112,'core_main_group','group','Associations','','{\"route\":\"group_general\"}','core_main','',0,0,9),(113,'core_sitemap_group','group','Associations','','{\"route\":\"group_general\"}','core_sitemap','',1,0,3),(114,'group_main_browse','group','Browse Groups','','{\"route\":\"group_general\",\"action\":\"browse\"}','group_main','',1,0,1),(115,'group_main_manage','group','My Groups','Group_Plugin_Menus','{\"route\":\"group_general\",\"action\":\"manage\"}','group_main','',1,0,2),(116,'group_main_create','group','Create New Group','Group_Plugin_Menus','{\"route\":\"group_general\",\"action\":\"create\"}','group_main','',1,0,3),(117,'group_quick_create','group','Create New Group','Group_Plugin_Menus::canCreateGroups','{\"route\":\"group_general\",\"action\":\"create\",\"class\":\"buttonlink icon_group_new\"}','group_quick','',1,0,1),(118,'group_profile_edit','group','Edit Profile','Group_Plugin_Menus','','group_profile','',1,0,1),(119,'group_profile_style','group','Edit Styles','Group_Plugin_Menus','','group_profile','',1,0,2),(120,'group_profile_member','group','Member','Group_Plugin_Menus','','group_profile','',1,0,3),(121,'group_profile_report','group','Report Group','Group_Plugin_Menus','','group_profile','',1,0,4),(122,'group_profile_share','group','Share','Group_Plugin_Menus','','group_profile','',1,0,5),(123,'group_profile_invite','group','Invite','Group_Plugin_Menus','','group_profile','',1,0,6),(124,'group_profile_message','group','Message Members','Group_Plugin_Menus','','group_profile','',1,0,7),(125,'core_admin_main_plugins_group','group','Groups','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"manage\"}','core_admin_main_plugins','',1,0,999),(126,'group_admin_main_manage','group','Manage Groups','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"manage\"}','group_admin_main','',1,0,1),(127,'group_admin_main_settings','group','Global Settings','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"settings\"}','group_admin_main','',1,0,2),(128,'group_admin_main_level','group','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"settings\",\"action\":\"level\"}','group_admin_main','',1,0,3),(129,'group_admin_main_categories','group','Categories','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"settings\",\"action\":\"categories\"}','group_admin_main','',1,0,4),(130,'authorization_admin_level_group','group','Groups','','{\"route\":\"admin_default\",\"module\":\"group\",\"controller\":\"settings\",\"action\":\"level\"}','authorization_admin_level','',1,0,999),(131,'mobi_browse_group','group','Groups','','{\"route\":\"group_general\"}','mobi_browse','',1,0,8),(133,'custom_133','core','Tenants','','{\"uri\":\"\\/tenants\",\"icon\":\"\"}','core_main','',1,1,5),(134,'core_admin_plugins_younet_core','younet-core','YouNet Core','','{\"route\":\"admin_default\",\"module\":\"younet-core\",\"controller\":\"settings\",\"action\":\"yours\"}','core_admin_main_plugins','',1,0,1),(135,'younet_core_admin_main_yours','younet-core','Your Plugins','','{\"route\":\"admin_default\",\"module\":\"younet-core\",\"controller\":\"settings\",\"action\":\"yours\"}','younet_core_admin_main','',1,0,2),(136,'younet_core_admin_main_younet','younet-core','YouNet Plugins','','{\"route\":\"admin_default\",\"module\":\"younet-core\",\"controller\":\"settings\",\"action\":\"younet\"}','younet_core_admin_main','',1,0,1),(137,'younet_core_admin_main_info','younet-core','License Term','','{\"route\":\"admin_default\",\"module\":\"younet-core\",\"controller\":\"settings\",\"action\":\"information\"}','younet_core_admin_main','',1,0,3),(138,'core_admin_main_plugins_ynresponsive1','ynresponsive1','YN - Responsive','','{\"route\":\"admin_default\",\"module\":\"ynresponsive1\",\"controller\":\"settings\"}','core_admin_main_plugins','',1,0,999),(139,'ynresponsive1_admin_main_settings','ynresponsive1','Global Settings','','{\"route\":\"admin_default\",\"module\":\"ynresponsive1\",\"controller\":\"settings\"}','ynresponsive1_admin_main','',1,0,1),(140,'yntheme_admin_main_settings','yntheme','Global Settings',NULL,'{\"route\":\"admin_default\",\"module\":\"yntheme\",\"controller\":\"settings\"}','yntheme_admin_main',NULL,1,0,999),(141,'yntheme_admin_main_themes','yntheme','Themes',NULL,'{\"route\":\"admin_default\",\"module\":\"yntheme\",\"controller\":\"themes\"}','yntheme_admin_main',NULL,1,0,999),(142,'core_admin_main_plugins_yntheme','yntheme','YouNet Themes',NULL,'{\"route\":\"admin_default\",\"module\":\"yntheme\",\"controller\":\"themes\"}','core_admin_main_plugins',NULL,0,0,999),(143,'core_admin_main_plugins_ynresponsivepurity','ynresponsivepurity','YN - Responsive Purity','','{\"route\":\"admin_default\",\"module\":\"ynresponsivepurity\",\"controller\":\"manage-slider\"}','core_admin_main_plugins','',1,0,999),(144,'ynresponsivepurity_admin_main_manage_slider','ynresponsivepurity','Manage Slider','','{\"route\":\"admin_default\",\"module\":\"ynresponsivepurity\",\"controller\":\"manage-slider\"}','ynresponsivepurity_admin_main','',1,0,1),(145,'ynresponsivepurity_admin_main_manage_welcome','ynresponsivepurity','Manage Welcome Blocks','','{\"route\":\"admin_default\",\"module\":\"ynresponsivepurity\",\"controller\":\"manage-welcome\"}','ynresponsivepurity_admin_main','',1,0,2),(146,'ynresponsivepurity_admin_main_manage_module','ynresponsivepurity','Manage Modules','','{\"route\":\"admin_default\",\"module\":\"ynresponsivepurity\",\"controller\":\"manage-module\"}','ynresponsivepurity_admin_main','',1,0,3),(147,'core_main_dashboard','core','Home','Ynresponsive1_Plugin_Menus','{\"route\":\"dashboard_general\"}','core_main','',1,0,2),(148,'custom_148','core','Landlords','','{\"uri\":\"\\/landlords\",\"icon\":\"\"}','core_main','',1,1,3),(152,'core_admin_main_manage_country','user','Manage Country','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"countrylist\"}','core_admin_main_manage',NULL,1,0,999),(153,'core_admin_main_manage_state','user','Manage State','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"statelist\"}','core_admin_main_manage',NULL,1,0,999),(154,'core_admin_main_manage_city','user','Manage City','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"citylist\"}','core_admin_main_manage',NULL,1,0,999),(155,'custom_155','core','Services','','{\"uri\":\"\\/services\",\"icon\":\"\",\"target\":\"\",\"enabled\":\"1\"}','core_main','',1,1,6),(156,'core_admin_main_manage_property','user','Manage Property','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"propertylist\"}','core_admin_main_manage',NULL,1,0,999),(157,'user_index_propertylist','user','Properties','User_Plugin_Menus','','user_profile',NULL,1,0,11),(158,'user_index_addproperty','user','Add Property','User_Plugin_Menus','','user_home',NULL,1,0,999),(159,'core_admin_main_manage_propertyrequest','user','Manage Property Request','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"propertyrequestlist\"}','core_admin_main_manage',NULL,1,0,999),(160,'core_admin_main_manage_coverletter','user','Manage Cover Letter','','{\"route\":\"admin_default\",\"module\":\"user\",\n                   \"controller\":\"manage\",\"action\":\"coverletterlist\"}','core_admin_main_manage',NULL,1,0,999),(162,'user_index_myproperties','user','My Properties','User_Plugin_Menus','','user_home',NULL,1,0,6),(163,'user_edit_document','user','Upload Document','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\r\n                   \"controller\":\"edit\",\"action\":\"document\"}','user_edit',NULL,1,4,999),(164,'user_profile_friends','user','Browse Members','User_Plugin_Menus','','user_profile',NULL,1,0,8),(165,'user_profile_invite','invite','Invite Your Friends','User_Plugin_Menus','','user_profile',NULL,1,0,9),(166,'user_profile_updates','user','View Recent Updates','User_Plugin_Menus','','user_profile',NULL,1,0,10),(167,'user_profile_addproperty','user','Add Property','User_Plugin_Menus','','user_profile',NULL,1,0,12),(168,'user_profile_view','user','View My Profile','User_Plugin_Menus','','user_profile',NULL,1,0,3),(169,'core_main_properties','user','Properties','User_Plugin_Menus','','core_main',NULL,1,0,7),(170,'user_edit_documentslist','user','Documents','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\n                   \"controller\":\"edit\",\"action\":\"documentslist\"}','user_edit',NULL,1,4,4),(171,'core_admin_main_plugins_advancedarticles','advancedarticles','Advanced Articles','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\", \"action\":\"articles\"}','core_admin_main_plugins','',1,0,1000),(172,'advancedarticles_admin_main_settings','advancedarticles','List of Categories','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\"}','advancedarticles_admin_main','',0,0,1),(173,'advancedarticles_admin_main_category','advancedarticles','View Articles','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\",\"action\":\"articles\"}','advancedarticles_admin_main','',1,0,2),(174,'advancedarticles_admin_main_global','advancedarticles','Global Settings','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\",\"action\":\"settings\"}','advancedarticles_admin_main','',1,0,3),(175,'advancedarticles_admin_main_level','advancedarticles','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\",\"action\":\"level\"}','advancedarticles_admin_main','',1,0,4),(176,'advancedarticles_admin_main_questions','advancedarticles','Article Questions','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"fields\"}','advancedarticles_admin_main','',1,0,5),(177,'advancedarticles_admin_main_more','advancedarticles','More Plugins','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\"controller\":\"settings\",\"action\":\"more\"}','advancedarticles_admin_main','',1,0,10),(178,'advancedarticles_page_home','advancedarticles','Articles Home','','{\"route\":\"advancedarticles_general\",\"action\":\"browse\"}','advancedarticles_home','',1,0,1),(179,'advancedarticles_page_category','advancedarticles','Browse Articles','','{\"route\":\"advancedarticles_general\",\"action\":\"category\"}','advancedarticles_home','',0,0,2),(180,'advancedarticles_page_my','advancedarticles','My Articles','Advancedarticles_Plugin_Menus','','advancedarticles_home','',0,0,3),(181,'advancedarticles_page_add','advancedarticles','Add New Article','Advancedarticles_Plugin_Menus','','advancedarticles_home','',1,0,4),(182,'advancedarticles_article','advancedarticles','Articles','','{\"route\":\"advancedarticles_general\",\"controller\":\"articles\"}','core_main','',1,0,8),(183,'advancedarticles_admin_main_add','advancedarticles','Add New Article','','{\"route\":\"admin_default\",\"module\":\"advancedarticles\",\n                   \"controller\":\"settings\",\"action\":\"addarticle\"}','advancedarticles_admin_main',NULL,1,0,999);
/*!40000 ALTER TABLE `engine4_core_menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_menus`
--

DROP TABLE IF EXISTS `engine4_core_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type` enum('standard','hidden','custom') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'standard',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(3) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_menus`
--

LOCK TABLES `engine4_core_menus` WRITE;
/*!40000 ALTER TABLE `engine4_core_menus` DISABLE KEYS */;
INSERT INTO `engine4_core_menus` VALUES (1,'core_main','standard','Main Navigation Menu',1),(2,'core_mini','standard','Mini Navigation Menu',2),(3,'core_footer','standard','Footer Menu',3),(4,'core_sitemap','standard','Sitemap',4),(5,'user_home','standard','Member Home Quick Links Menu',999),(6,'user_profile','standard','Member Profile Options Menu',999),(7,'user_edit','standard','Member Edit Profile Navigation Menu',999),(8,'user_browse','standard','Member Browse Navigation Menu',999),(9,'user_settings','standard','Member Settings Navigation Menu',999),(10,'messages_main','standard','Messages Main Navigation Menu',999),(11,'album_main','standard','Album Main Navigation Menu',999),(12,'album_quick','standard','Album Quick Navigation Menu',999),(13,'group_main','standard','Group Main Navigation Menu',999),(14,'group_profile','standard','Group Profile Options Menu',999);
/*!40000 ALTER TABLE `engine4_core_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_migrations`
--

DROP TABLE IF EXISTS `engine4_core_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_migrations` (
  `package` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `current` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_migrations`
--

LOCK TABLES `engine4_core_migrations` WRITE;
/*!40000 ALTER TABLE `engine4_core_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_modules`
--

DROP TABLE IF EXISTS `engine4_core_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_modules` (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `version` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('core','standard','extra') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'extra',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_modules`
--

LOCK TABLES `engine4_core_modules` WRITE;
/*!40000 ALTER TABLE `engine4_core_modules` DISABLE KEYS */;
INSERT INTO `engine4_core_modules` VALUES ('activity','Activity','Activity','4.8.10',1,'core'),('advancedarticles','Advanced Articles','Advanced Articles','4.1.3',1,'extra'),('album','Albums','Albums','4.8.9',1,'extra'),('announcement','Announcements','Announcements','4.8.0',1,'standard'),('authorization','Authorization','Authorization','4.7.0',1,'core'),('core','Core','Core','4.8.10',1,'core'),('fields','Fields','Fields','4.8.10',1,'core'),('group','Groups','Groups','4.8.10',1,'extra'),('invite','Invite','Invite','4.8.7',1,'standard'),('messages','Messages','Messages','4.8.7',1,'standard'),('network','Networks','Networks','4.8.6',1,'standard'),('payment','Payment','Payment','4.8.10',1,'standard'),('sqlupdates','Sqlupdates','for updating db','4.0.0',1,'extra'),('storage','Storage','Storage','4.8.9',1,'core'),('user','Members','Members','4.8.10',1,'core'),('ynresponsive1','YN - Responsive Core','YouNet Responsive Module','4.05',1,'extra'),('ynresponsivepurity','YN - Responsive Purity Template','Responsive Purity Template','4.01',1,'extra'),('yntheme','YN - Themes Core','Manage YouNet Themes','4.04p1',1,'extra'),('younet-core','YN - Core Module','YouNet Core Module','4.02p9',1,'extra');
/*!40000 ALTER TABLE `engine4_core_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_nodes`
--

DROP TABLE IF EXISTS `engine4_core_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_nodes` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `signature` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `first_seen` datetime NOT NULL,
  `last_seen` datetime NOT NULL,
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_nodes`
--

LOCK TABLES `engine4_core_nodes` WRITE;
/*!40000 ALTER TABLE `engine4_core_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_pages`
--

DROP TABLE IF EXISTS `engine4_core_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_pages` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '1',
  `fragment` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `levels` text COLLATE utf8_unicode_ci,
  `provides` text COLLATE utf8_unicode_ci,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_pages`
--

LOCK TABLES `engine4_core_pages` WRITE;
/*!40000 ALTER TABLE `engine4_core_pages` DISABLE KEYS */;
INSERT INTO `engine4_core_pages` VALUES (1,'header','Site Header',NULL,'','','',0,1,'',NULL,'header-footer',0,0),(2,'footer','Site Footer',NULL,'','','',0,1,'',NULL,'header-footer',0,0),(3,'core_index_index','Landing Page',NULL,'Landing Page','This is your site\'s landing page.','rentstarz',0,0,'default',NULL,'no-viewer;no-subject',0,1),(4,'user_index_home','Member Home Page',NULL,'Member Home Page','This is the home page for members.','',0,0,'',NULL,'viewer;no-subject',0,0),(5,'user_profile_index','Member Profile',NULL,'Member Profile','This is a member\'s profile.','',0,0,'',NULL,'subject=user',0,0),(6,'core_help_contact','Contact Page',NULL,'Contact Us','This is the contact page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(7,'core_help_privacy','Privacy Page',NULL,'Privacy Policy','This is the privacy policy page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(8,'core_help_terms','Terms of Service Page',NULL,'Terms of Service','This is the terms of service page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(9,'core_error_requireuser','Sign-in Required Page',NULL,'Sign-in Required','','',0,0,'',NULL,NULL,0,0),(10,'core_search_index','Search Page',NULL,'Search Results','','',0,0,'',NULL,NULL,0,0),(11,'user_auth_login','Sign-in Page',NULL,'Sign-in','This is the site sign-in page.','',0,0,'',NULL,NULL,0,0),(12,'user_signup_index','Sign-up Page',NULL,'Sign-up','This is the site sign-up page.','',0,0,'',NULL,NULL,0,0),(13,'user_auth_forgot','Forgot Password Page',NULL,'Forgot Password','This is the site forgot password page.','',0,0,'',NULL,NULL,0,0),(14,'user_settings_general','User General Settings Page',NULL,'General','This page is the user general settings page.','',0,0,'',NULL,NULL,0,0),(15,'user_settings_privacy','User Privacy Settings Page',NULL,'Privacy','This page is the user privacy settings page.','',0,0,'',NULL,NULL,0,0),(16,'user_settings_network','User Networks Settings Page',NULL,'Networks','This page is the user networks settings page.','',0,0,'',NULL,NULL,0,0),(17,'user_settings_notifications','User Notifications Settings Page',NULL,'Notifications','This page is the user notification settings page.','',0,0,'',NULL,NULL,0,0),(18,'user_settings_password','User Change Password Settings Page',NULL,'Change Password','This page is the change password page.','',0,0,'',NULL,NULL,0,0),(19,'user_settings_delete','User Delete Account Settings Page',NULL,'Delete Account','This page is the delete accout page.','',0,0,'',NULL,NULL,0,0),(20,'user_index_browse','Member Browse Page',NULL,'Member Browse','This page show member lists.','',0,0,'',NULL,NULL,0,0),(21,'invite_index_index','Invite Page',NULL,'Invite','','',0,0,'',NULL,NULL,0,0),(22,'messages_messages_compose','Messages Compose Page',NULL,'Compose','','',0,0,'',NULL,NULL,0,0),(23,'messages_messages_inbox','Messages Inbox Page',NULL,'Inbox','','',0,0,'',NULL,NULL,0,0),(24,'messages_messages_outbox','Messages Outbox Page',NULL,'Inbox','','',0,0,'',NULL,NULL,0,0),(25,'messages_messages_search','Messages Search Page',NULL,'Search','','',0,0,'',NULL,NULL,0,0),(26,'messages_messages_view','Messages View Page',NULL,'My Message','','',0,0,'',NULL,NULL,0,0),(27,'album_photo_view','Album Photo View Page',NULL,'Album Photo View','This page displays an album\'s photo.','',0,0,'',NULL,'subject=album_photo',0,0),(28,'album_album_view','Album View Page',NULL,'Album View','This page displays an album\'s photos.','',0,0,'',NULL,'subject=album',0,0),(29,'album_index_browse','Album Browse Page',NULL,'Album Browse','This page lists album entries.','',0,0,'',NULL,NULL,0,0),(30,'album_index_upload','Album Create Page',NULL,'Add New Photos','This page is the album create page.','',0,0,'',NULL,NULL,0,0),(31,'album_index_manage','Album Manage Page',NULL,'My Albums','This page lists album a user\'s albums.','',0,0,'',NULL,NULL,0,0),(32,'group_profile_index','Group Profile',NULL,'Group Profile','This is the profile for an group.','',0,0,'',NULL,'subject=group',0,0),(33,'mobi_group_profile','Mobile Group Profile',NULL,'Mobile Group Profile','This is the mobile verison of a group profile.','',0,0,'',NULL,NULL,0,0),(34,'group_index_browse','Group Browse Page',NULL,'Group Browse','This page lists groups.','',0,0,'',NULL,NULL,0,0),(35,'group_index_create','Group Create Page',NULL,'Group Create','This page allows users to create groups.','',0,0,'',NULL,NULL,0,0),(36,'group_index_manage','Group Manage Page',NULL,'My Groups','This page lists a user\'s groups.','',0,0,'',NULL,NULL,0,0),(39,NULL,'Documents','documents','Documents','','',1,0,'','[\"5\"]','no-subject',0,1),(41,NULL,'Tenants','www-rentstarz-com-pages-tenant','Tenant','this is the tenant browse page','tenants, landlord, for rent apartment',1,0,'','[\"4\"]','no-subject',0,1),(42,'ynresponsive1_index_dashboard','Dashboard Page',NULL,'Dashboard Page','This is your site\'s dashboard page.','',1,0,'',NULL,NULL,0,0),(43,'user_index_tenants','Tenants page',NULL,'Tenants','','',1,0,'','[\"1\",\"3\",\"4\",\"5\",\"6\",\"7\"]','no-subject',0,0),(44,'user_index_landlords','Landlords page',NULL,'Landlords','','',1,0,'','[\"1\",\"3\",\"4\",\"5\",\"6\",\"7\"]','no-subject',0,0),(45,'user_index_services','Services List',NULL,'','','',1,0,'',NULL,'no-subject',0,0),(46,'advancedarticles_articles_browse','Advanced Article Home Page',NULL,'Article Home Page','','',0,0,'default','','viewer;no-subject',0,0),(47,'advancedarticles_articles_category','Advanced Article Category Page',NULL,'Article Browse Page','','',0,0,'default','','viewer;no-subject',0,0),(48,'advancedarticles_articles_article','Advanced Article Page',NULL,'Article Profile','','',0,0,'default','','viewer;no-subject',0,0),(49,'advancedarticles_articles_tagscloud','Advanced Article Tags Page',NULL,'Article Popular Tags Page','','',0,0,'default','','viewer;no-subject',0,0);
/*!40000 ALTER TABLE `engine4_core_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_processes`
--

DROP TABLE IF EXISTS `engine4_core_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_processes` (
  `pid` int(10) unsigned NOT NULL,
  `parent_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `system_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `started` int(10) unsigned NOT NULL,
  `timeout` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_processes`
--

LOCK TABLES `engine4_core_processes` WRITE;
/*!40000 ALTER TABLE `engine4_core_processes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_referrers`
--

DROP TABLE IF EXISTS `engine4_core_referrers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_referrers` (
  `host` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `query` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) unsigned NOT NULL,
  PRIMARY KEY (`host`,`path`,`query`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_referrers`
--

LOCK TABLES `engine4_core_referrers` WRITE;
/*!40000 ALTER TABLE `engine4_core_referrers` DISABLE KEYS */;
INSERT INTO `engine4_core_referrers` VALUES ('','rentstarz.com','',1),('59900546.responsive-test.net','/','',1),('avid.force.com','/pkb/articles/en_us/faq/lost-stolen-or-broken-ilok-policy','',1),('baidu.com','/s','wd=rentstarz-landingpage',1),('bing.com','','',1),('domainsigma.com','/whois/rentstarz.com','',1),('domainsigma.com','/whois/suitecontact.com','',1),('google.com','/search','',1),('google.com.my','/search','q=anything&ie=utf-8',1),('my.tmdhosting.com','/admin/tickets/view/647430/ccname/virgin','',1),('my.tmdhosting.com','/admin/tickets/view/926015/ccname/virgin','',1),('my.tmdhosting.com','/admin/tickets/view/926569/ccname/active','',1),('my.tmdhosting.com','/admin/tickets/view/926569/ccname/virgin','',1),('rentstarz.com','/propertydetail/37','',1),('rentstarz.com','/propertylist/37','',1),('rentstarz.com','/services','profile_type=&displayname=shaiju&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_',1),('rentstarz.com','/tenants','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/admin','',1),('rentstarz.titechnologies.org','/admin/user/manage','displayname=judith&username=&email=&level_id=0&enabled=-1&search=&order=&order_direction=&user_id=',1),('rentstarz.titechnologies.org','/admin/user/manage','displayname=manish+jha&username=&email=&level_id=0&enabled=-1&search=&order=&order_direction=&user_id=',1),('rentstarz.titechnologies.org','/admin/user/manage','displayname=mic+b&username=&email=&level_id=0&enabled=-1&search=&order=&order_direction=&user_id=',1),('rentstarz.titechnologies.org','/admin/user/manage','displayname=xavier&username=&email=&level_id=0&enabled=-1&search=&order=&order_direction=&user_id=',1),('rentstarz.titechnologies.org','/albums/photo/view/album_id/2/photo_id/3','',1),('rentstarz.titechnologies.org','/albums/photo/view/album_id/5/photo_id/9','',1),('rentstarz.titechnologies.org','/albums/photo/view/album_id/8/photo_id/14','',1),('rentstarz.titechnologies.org','/albums/view/1','',1),('rentstarz.titechnologies.org','/albums/view/12','',1),('rentstarz.titechnologies.org','/albums/view/2','',1),('rentstarz.titechnologies.org','/albums/view/5','',1),('rentstarz.titechnologies.org','/albums/view/6','',1),('rentstarz.titechnologies.org','/albums/view/7','',1),('rentstarz.titechnologies.org','/albums/view/8','',1),('rentstarz.titechnologies.org','/groups','search_text=&category_id=3&view=&order=creation_date+desc',1),('rentstarz.titechnologies.org','/groups','search_text=&category_id=7&view=1&order=member_count+desc',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alias_',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias_gend',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_field_',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=judth%20hinds&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=rinku&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_a',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=teenuthomas12&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&',1),('rentstarz.titechnologies.org','/landlords','profile_type=&displayname=ton&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_ali',1),('rentstarz.titechnologies.org','/landlords','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_4_19_alias_gender=&1_1_5_a',1),('rentstarz.titechnologies.org','/landlords','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/landlords','profile_type=&services_type_id=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/landlords','profile_type=1&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/landlords','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alias',1),('rentstarz.titechnologies.org','/landlords','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias_gen',1),('rentstarz.titechnologies.org','/landlords','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=lynn&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_f',1),('rentstarz.titechnologies.org','/landlords','profile_type=4&displayname=tess&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/login/return_url/64-l21lbwjlcnmvag9tzq%3d%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2dyb3vwcw%3d%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2fsynvtcw%3d%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2fydgljbgvz','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2xvz2lu','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2xvz2lul3jldhvybl91cmwvnjqttdj4dloybhvmm0p','',1),('rentstarz.titechnologies.org','/login/return_url/64-l2xvz2lul3jldhvybl91cmwvnjqttdnocfoyntfjqsu','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3byb3blcnr5c2vhcmnocmvzdwxsdhm%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3byb3blcnr5zgv0ywlslzk%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3nlcnzpy2vzp3byb2zpbgvfdhlwzt02jmrpc3bsyxl','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3nlyxjjad9xdwvyet1ob21lk0rly29y','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3rlbmfudhm%3d','',1),('rentstarz.titechnologies.org','/login/return_url/64-l3vzzxivyxv0ac9yzxnldc9jb2rll2fhegpxndm0a2d','',1),('rentstarz.titechnologies.org','/members','extra%5bhas_photo%5d=&extra%5bis_online%5d=&page=1',1),('rentstarz.titechnologies.org','/members','extra%5bhas_photo%5d=&extra%5bis_online%5d=&page=3',1),('rentstarz.titechnologies.org','/members','profile_type=1&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_field',1),('rentstarz.titechnologies.org','/members','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias_gen',1),('rentstarz.titechnologies.org','/members','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_field',1),('rentstarz.titechnologies.org','/members','profile_type=6&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias_gen',1),('rentstarz.titechnologies.org','/members','profile_type=6&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/members/edit/profile/id/1','',1),('rentstarz.titechnologies.org','/members/edit/profile/id/38','',1),('rentstarz.titechnologies.org','/members/edit/profile/id/6','',1),('rentstarz.titechnologies.org','/messages/search','query=jemy',1),('rentstarz.titechnologies.org','/messages/view/id/1','',1),('rentstarz.titechnologies.org','/profile/10','',1),('rentstarz.titechnologies.org','/profile/12','',1),('rentstarz.titechnologies.org','/profile/15','',1),('rentstarz.titechnologies.org','/profile/16','',1),('rentstarz.titechnologies.org','/profile/17','',1),('rentstarz.titechnologies.org','/profile/2','',1),('rentstarz.titechnologies.org','/profile/23','',1),('rentstarz.titechnologies.org','/profile/30','',1),('rentstarz.titechnologies.org','/profile/35','',1),('rentstarz.titechnologies.org','/profile/38/action_id/69','',1),('rentstarz.titechnologies.org','/profile/7/action_id/9','',1),('rentstarz.titechnologies.org','/profile/71','',1),('rentstarz.titechnologies.org','/profile/74/action_id/125','',1),('rentstarz.titechnologies.org','/profile/8','',1),('rentstarz.titechnologies.org','/profile/90','',1),('rentstarz.titechnologies.org','/profile/bindiya+prakash','',1),('rentstarz.titechnologies.org','/property/edit/11','',1),('rentstarz.titechnologies.org','/property/edit/2','',1),('rentstarz.titechnologies.org','/property/edit/4','',1),('rentstarz.titechnologies.org','/propertydetail/16','',1),('rentstarz.titechnologies.org','/propertydetail/17','',1),('rentstarz.titechnologies.org','/propertydetail/18','',1),('rentstarz.titechnologies.org','/propertydetail/32111','',1),('rentstarz.titechnologies.org','/propertydetail/32768','',1),('rentstarz.titechnologies.org','/propertydetail/34','',1),('rentstarz.titechnologies.org','/propertydetail/36','',1),('rentstarz.titechnologies.org','/propertydetail/39','',1),('rentstarz.titechnologies.org','/propertylist/51','',1),('rentstarz.titechnologies.org','/propertylist/57','',1),('rentstarz.titechnologies.org','/propertylist/87','',1),('rentstarz.titechnologies.org','/propertylist/88','',1),('rentstarz.titechnologies.org','/propertyrequestslist','',1),('rentstarz.titechnologies.org','/propertyrequestslist/18','',1),('rentstarz.titechnologies.org','/propertyrequestslist/34','',1),('rentstarz.titechnologies.org','/propertyrequestslist/38','',1),('rentstarz.titechnologies.org','/search','query=bidhuna',1),('rentstarz.titechnologies.org','/search','query=bindila',1),('rentstarz.titechnologies.org','/search','query=bindila&type=user&submit=',1),('rentstarz.titechnologies.org','/search','query=cather',1),('rentstarz.titechnologies.org','/search','query=catherine&type=&submit=',1),('rentstarz.titechnologies.org','/search','query=hi',1),('rentstarz.titechnologies.org','/search','query=jem&type=group&submit=',1),('rentstarz.titechnologies.org','/search','query=jem&type=user&submit=',1),('rentstarz.titechnologies.org','/search','query=jemy&type=album&submit=',1),('rentstarz.titechnologies.org','/search','query=jemy&type=group&submit=',1),('rentstarz.titechnologies.org','/search','query=jemyann&type=user&submit=',1),('rentstarz.titechnologies.org','/search','query=jemythomas',1),('rentstarz.titechnologies.org','/search','query=judith',1),('rentstarz.titechnologies.org','/search','query=qa',1),('rentstarz.titechnologies.org','/search','query=qateam&type=&submit=',1),('rentstarz.titechnologies.org','/search','query=qateam&type=user&submit=',1),('rentstarz.titechnologies.org','/search','query=rem',1),('rentstarz.titechnologies.org','/search','query=rem&type=&submit=',1),('rentstarz.titechnologies.org','/search','query=veegaland',1),('rentstarz.titechnologies.org','/search','query=visal',1),('rentstarz.titechnologies.org','/search','query=visal+varghese&type=&submit=',1),('rentstarz.titechnologies.org','/services','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alias_',1),('rentstarz.titechnologies.org','/services','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias_gend',1),('rentstarz.titechnologies.org','/services','profile_type=&displayname=john&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_al',1),('rentstarz.titechnologies.org','/services','profile_type=&displayname=shoba%20rani&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_4_19_alias_gender=&1_1_5_a',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=&1_5_35_field_35=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias_gender=&1_4_19_alias_gender=&1_5_',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=2&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/services','profile_type=&services_type_id=3&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/services','profile_type=1&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/services','profile_type=6&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias_gen',1),('rentstarz.titechnologies.org','/services','profile_type=6&displayname=h&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alia',1),('rentstarz.titechnologies.org','/services','profile_type=6&displayname=john&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_a',1),('rentstarz.titechnologies.org','/signup/verify/email/anwin.cherian%40titechnologies.org/verify/f','',1),('rentstarz.titechnologies.org','/signup/verify/email/bindiya.prakash%40titechnologies.in/verify/','',1),('rentstarz.titechnologies.org','/signup/verify/email/deepthy.s%40titechnologies.in/verify/2005a3','',1),('rentstarz.titechnologies.org','/signup/verify/email/della.varghese%40titechnologies.org/verify/','',1),('rentstarz.titechnologies.org','/signup/verify/email/ganesh.nath%40titechnologies.org/verify/3e9','',1),('rentstarz.titechnologies.org','/signup/verify/email/geethika.antony%40titechnologies.org/verify','',1),('rentstarz.titechnologies.org','/signup/verify/email/jemy.thomas%40titechnologies.org/verify/370','',1),('rentstarz.titechnologies.org','/signup/verify/email/jemy.thomas%40titechnologies.org/verify/e73','',1),('rentstarz.titechnologies.org','/signup/verify/email/ju11236%40yahoo.com/verify/aa305147b54e102f','',1),('rentstarz.titechnologies.org','/signup/verify/email/nibi.mathew%40titechnologies.in/verify/71ca','',1),('rentstarz.titechnologies.org','/signup/verify/email/nithinkumar.cn%40titechnologies.in/verify/0','',1),('rentstarz.titechnologies.org','/signup/verify/email/nithinkumar.cn%40titechnologies.in/verify/b','',1),('rentstarz.titechnologies.org','/signup/verify/email/qateam%40titechnologies.in/verify/3878cdcc2','',1),('rentstarz.titechnologies.org','/signup/verify/email/qateam%40titechnologies.in/verify/a26424afc','',1),('rentstarz.titechnologies.org','/signup/verify/email/qateam%40titechnologies.in/verify/d41acb75c','',1),('rentstarz.titechnologies.org','/signup/verify/email/rita.jose%40titechnologies.org/verify/24928','',1),('rentstarz.titechnologies.org','/signup/verify/email/rita.jose%40titechnologies.org/verify/bd728','',1),('rentstarz.titechnologies.org','/signup/verify/email/roshan.joseph%40technipolis.com/verify/7eaf','',1),('rentstarz.titechnologies.org','/signup/verify/email/shaiju%40technipolis.com/verify/2e933c401a6','',1),('rentstarz.titechnologies.org','/signup/verify/email/sulthan.kareem%40titechnologies.org/verify/','',1),('rentstarz.titechnologies.org','/signup/verify/email/teenuthomas12%40gmail.com/verify/17d72d93e9','',1),('rentstarz.titechnologies.org','/signup/verify/email/visal.varghese%40titechnologies.in/verify/d','',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alias_',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=2&1_4_19_alias',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=3&1_4_19_alias',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias_gend',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=dd&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alia',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=hinds&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_a',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=judth%20hinds&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1',1),('rentstarz.titechnologies.org','/tenants','profile_type=&displayname=vv&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alia',1),('rentstarz.titechnologies.org','/tenants','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_4_19_alias_gender=&1_1_5_a',1),('rentstarz.titechnologies.org','/tenants','profile_type=&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/tenants','profile_type=&services_type_id=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_5_37_field_37=&1_1_5_alias',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_alias',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=3&1_4_19_alia',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_field',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&displayname=hinds&1_5_35_field_35=&1_4_17_field_17=&1_4_18_field_18=&1_5_36_field_36=&1_1_5_alias_gender=&1_4_19_',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&displayname=teenu%20thomas&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender',1),('rentstarz.titechnologies.org','/tenants','profile_type=1&services_type_id=&1_4_17_field_17=&1_5_35_field_35=&1_5_36_field_36=&1_4_18_field_18=&1_5_37_field_37=&1_1_5_alia',1),('rentstarz.titechnologies.org','/tenants','profile_type=4&displayname=&1_5_35_field_35=&1_4_17_field_17=&1_5_36_field_36=&1_4_18_field_18=&1_1_5_alias_gender=&1_5_37_field',1),('whois.domaintools.com','/rentstarz.com','',1),('whois.domaintools.com','/suitecontact.com','',1),('','blank','',2),('','suitecontact.com','',2),('buttons-for-website.com','','',2),('google.com','','',2),('google.com','/search','q=rent%20starz.com&aq=f&aqi=g147&aql=&oq=&gs_rfai=',2),('m.baidu.com','/s','wd=rentstarz-landingpage',2),('rentstarz.com','/articles','page=2',2),('rentstarz.com','/landlords','',2),('rentstarz.com','/members','',2),('rentstarz.com','/myproperties/36','',2),('rentstarz.com','/propertydetail/38','',2),('rentstarz.com','/propertysearchresullts','',2),('rentstarz.titechnologies.org','/admin/','',2),('rentstarz.titechnologies.org','/admin/content','',2),('rentstarz.titechnologies.org','/admin/user/manage','displayname=&username=&email=rita.jose%40titechnologies.org&level_id=0&enabled=-1&search=&order=&order_direction=&user_id=',2),('rentstarz.titechnologies.org','/admin/user/manage','order=user_id&order_direction=desc&page=3',2),('rentstarz.titechnologies.org','/albums/photo/view/album_id/10/photo_id/17','',2),('rentstarz.titechnologies.org','/albums/photo/view/album_id/2/photo_id/2','',2),('rentstarz.titechnologies.org','/albums/photo/view/album_id/8/photo_id/13','',2),('rentstarz.titechnologies.org','/albums/photo/view/album_id/8/photo_id/15','',2),('rentstarz.titechnologies.org','/albums/view/13','',2),('rentstarz.titechnologies.org','/articles/allphoto/2','',2),('rentstarz.titechnologies.org','/articles/edit/4','',2),('rentstarz.titechnologies.org','/articles/edit/5','',2),('rentstarz.titechnologies.org','/groups','search_text=&category_id=&view=&order=member_count+desc',2),('rentstarz.titechnologies.org','/groups','search_text=&category_id=&view=1&order=creation_date+desc',2),('rentstarz.titechnologies.org','/groups','search_text=&category_id=&view=1&order=member_count+desc',2),('rentstarz.titechnologies.org','/login/return_url/64-l3nlcnzpy2vz','',2),('rentstarz.titechnologies.org','/members/edit/profile/id/36','',2),('rentstarz.titechnologies.org','/members/edit/profile/id/37','',2),('rentstarz.titechnologies.org','/members/edit/profile/id/4','',2),('rentstarz.titechnologies.org','/profile/21','',2),('rentstarz.titechnologies.org','/profile/36/action_id/67','',2),('rentstarz.titechnologies.org','/profile/43','',2),('rentstarz.titechnologies.org','/profile/45','',2),('rentstarz.titechnologies.org','/profile/63','',2),('rentstarz.titechnologies.org','/profile/66','',2),('rentstarz.titechnologies.org','/profile/72','',2),('rentstarz.titechnologies.org','/profile/76','',2),('rentstarz.titechnologies.org','/profile/82','',2),('rentstarz.titechnologies.org','/profile/85','',2),('rentstarz.titechnologies.org','/profile/86','',2),('rentstarz.titechnologies.org','/profile/9','',2),('rentstarz.titechnologies.org','/property/edit/8','',2),('rentstarz.titechnologies.org','/property/edit/9','',2),('rentstarz.titechnologies.org','/propertydetail/27','',2),('rentstarz.titechnologies.org','/propertydetail/35','',2),('rentstarz.titechnologies.org','/propertydetail/4','',2),('rentstarz.titechnologies.org','/propertydetail/8','',2),('rentstarz.titechnologies.org','/propertylist/62','',2),('rentstarz.titechnologies.org','/propertylist/77','',2),('rentstarz.titechnologies.org','/propertylist/82','',2),('rentstarz.titechnologies.org','/search','query=asset',2),('rentstarz.titechnologies.org','/search','query=home',2),('rentstarz.titechnologies.org','/search','query=jem',2),('rentstarz.titechnologies.org','/search','query=jemy&type=user&submit=',2),('rentstarz.titechnologies.org','/search','query=qateam&type=album&submit=',2),('rentstarz.titechnologies.org','/tenant','',2),('rentstarz.titechnologies.org','/user/auth/reset/code/aaxjq434kgwkoc8wggwcwo8gc/uid/62','',2),('search.yahoo.com','/','',2),('track.titechnologies.in','/issues/18114','',2),('track.titechnologies.in','/projects/rent-starz','',2),('burger-imperia.com','/','',3),('rentstarz.com','/articles','',3),('rentstarz.com','/tenants','',3),('rentstarz.titechnologies.org','/articles/5/10-design-trends-coming-to-homes-near-you-in-2016','',3),('rentstarz.titechnologies.org','/login/return_url/64-l2fkzhbyb3blcnr5','',3),('rentstarz.titechnologies.org','/login/return_url/64-l2xvz2lul3jldhvybl91cmwvnjqtthclm0qlm0q%3d','',3),('rentstarz.titechnologies.org','/login/return_url/64-l3byb3blcnr5bglzdc8zng%3d%3d','',3),('rentstarz.titechnologies.org','/login/return_url/64-l3vzzxivyxv0ac9mb3jnb3q%3d','',3),('rentstarz.titechnologies.org','/members/settings/delete','',3),('rentstarz.titechnologies.org','/profile/11/action_id/16','',3),('rentstarz.titechnologies.org','/profile/22','',3),('rentstarz.titechnologies.org','/profile/4','',3),('rentstarz.titechnologies.org','/profile/41','',3),('rentstarz.titechnologies.org','/profile/68','',3),('rentstarz.titechnologies.org','/profile/75','',3),('rentstarz.titechnologies.org','/profile/87','',3),('rentstarz.titechnologies.org','/property/edit/1','',3),('rentstarz.titechnologies.org','/property/edit/10','',3),('rentstarz.titechnologies.org','/propertydetail/2','',3),('rentstarz.titechnologies.org','/propertydetail/23','',3),('rentstarz.titechnologies.org','/propertydetail/40','',3),('rentstarz.titechnologies.org','/propertydetail/7','',3),('rentstarz.titechnologies.org','/propertylist/34','',3),('rentstarz.titechnologies.org','/propertylist/78','',3),('rentstarz.titechnologies.org','/propertyrequestslist/36','',3),('rentstarz.titechnologies.org','/search','query=jemy&type=&submit=',3),('rentstarz.titechnologies.org','/search','query=test',3),('','suitecontact.com/store','',4),('rentstarz.com','/addproperty','',4),('rentstarz.com','/services','',4),('rentstarz.titechnologies.org','/albums/photo/view/album_id/13/photo_id/20','',4),('rentstarz.titechnologies.org','/albums/photo/view/album_id/7/photo_id/12','',4),('rentstarz.titechnologies.org','/albums/view/4','',4),('rentstarz.titechnologies.org','/articles/allphoto/1','',4),('rentstarz.titechnologies.org','/articles/view/2/2','',4),('rentstarz.titechnologies.org','/groups/manage','',4),('rentstarz.titechnologies.org','/login/return_url/64-l3npz251cc9jb25maxjt','',4),('rentstarz.titechnologies.org','/members/edit/profile/id/18','',4),('rentstarz.titechnologies.org','/members/settings/notifications','',4),('rentstarz.titechnologies.org','/profile/14','',4),('rentstarz.titechnologies.org','/profile/69','',4),('rentstarz.titechnologies.org','/profile/78/action_id/132','',4),('rentstarz.titechnologies.org','/propertydetail/12','',4),('rentstarz.titechnologies.org','/propertyrequestslist/37','',4),('rentstarz.titechnologies.org','/responsive/friend-requests','',4),('rentstarz.titechnologies.org','/search','query=bindiya',4),('rentstarz.titechnologies.org','/search','query=jemy+',4),('rentstarz.titechnologies.org','/search','query=jemyann',4),('rentstarz.titechnologies.org','/search','query=qateam',4),('rentstarz.titechnologies.org','/groups/create','',5),('rentstarz.titechnologies.org','/help/privacy','',5),('rentstarz.titechnologies.org','/login/return_url/64-l3byb3blcnr5cmvxdwvzdhnsaxn0lzew','',5),('rentstarz.titechnologies.org','/profile/19','',5),('rentstarz.titechnologies.org','/profile/62','',5),('rentstarz.titechnologies.org','/profile/7','',5),('rentstarz.titechnologies.org','/propertydetail/22','',5),('rentstarz.titechnologies.org','/propertydetail/26','',5),('rentstarz.titechnologies.org','/propertydetail/31','',5),('rentstarz.titechnologies.org','/search','query=jemy',5),('track.titechnologies.in','/issues/18012','',5),('rentstarz.titechnologies.org','/admin/user/manage','order=user_id&order_direction=desc&page=1',6),('rentstarz.titechnologies.org','/profile/25','',6),('rentstarz.titechnologies.org','/propertydetail/37','',6),('rentstarz.titechnologies.org','/propertydetail/38','',6),('top1-seo-service.com','/try.php','u=http://suitecontact.com',6),('track.titechnologies.in','/issues/18136','',6),('rentstarz.titechnologies.org','/admin/user/manage/propertyrequestlist','',7),('rentstarz.titechnologies.org','/articles/view/1/1','',7),('rentstarz.titechnologies.org','/help/contact','',7),('rentstarz.titechnologies.org','/members/settings/privacy','',7),('rentstarz.titechnologies.org','/messages/compose','',7),('rentstarz.titechnologies.org','/profile/1','',7),('rentstarz.titechnologies.org','/profile/79','',7),('rentstarz.titechnologies.org','/profile/88','',7),('rentstarz.titechnologies.org','/propertydetail/14','',7),('rentstarz.titechnologies.org','/propertylist/18','',7),('rentstarz.titechnologies.org','/search','query=home+decor',7),('rentstarz.titechnologies.org','/admin/user/manage/propertylist','',8),('rentstarz.titechnologies.org','/albums/photo/view/album_id/4/photo_id/5','',8),('rentstarz.titechnologies.org','/members/settings/network','',8),('rentstarz.titechnologies.org','/messages/outbox','',8),('rentstarz.titechnologies.org','/profile/20/action_id/25','',8),('rentstarz.titechnologies.org','/profile/73','',8),('rentstarz.titechnologies.org','/propertydetail/13','',8),('rentstarz.titechnologies.org','/propertyrequestslist/10','',8),('rentstarz.titechnologies.org','/members','extra%5bhas_photo%5d=&extra%5bis_online%5d=&page=2',9),('rentstarz.titechnologies.org','/members/settings/password','',9),('rentstarz.titechnologies.org','/profile/49/action_id/75','',9),('rentstarz.titechnologies.org','/propertydetail/1','',9),('rentstarz.titechnologies.org','/responsive/notifications','',9),('rentstarz.titechnologies.org','/search','query=sulthan',9),('rentstarz.com','/','',10),('rentstarz.titechnologies.org','/admin/user/manage','order=user_id&order_direction=desc&page=2',10),('rentstarz.titechnologies.org','/albums/manage','',10),('rentstarz.titechnologies.org','/articles/edit/1','',10),('rentstarz.titechnologies.org','/group/1','',10),('rentstarz.titechnologies.org','/help/terms','',10),('rentstarz.titechnologies.org','/profile/11','',10),('rentstarz.titechnologies.org','/profile/34','',10),('rentstarz.com','/members/home','',11),('rentstarz.titechnologies.org','/albums/photo/view/album_id/3/photo_id/4','',11),('rentstarz.titechnologies.org','/albums/photo/view/album_id/5/photo_id/10','',11),('rentstarz.titechnologies.org','/login/return_url/64-l2xhbmrsb3jkcw%3d%3d','',11),('rentstarz.titechnologies.org','/albums/upload','',12),('rentstarz.titechnologies.org','/articles/3/olive-apartments','',12),('rentstarz.titechnologies.org','/profile/57','',12),('google.com','/search','q=bulletproof&rlz=1cdgoyi_enus649us649&oq=bullet&aqs=chrome.1.69i57j0l3.5540j0j9&hl=en-us&sourceid=chrome-mobile&ie=utf-8',13),('rentstarz.titechnologies.org','/profile/51','',13),('rentstarz.titechnologies.org','/profile/65','',13),('rentstarz.titechnologies.org','/propertydetail/33','',13),('rentstarz.titechnologies.org','/user/auth/forgot','',13),('rentstarz.titechnologies.org','/profile/78','',14),('rentstarz.titechnologies.org','/propertydetail/28','',14),('rentstarz.titechnologies.org','/www.rentstarz.com/pages/tenant','',14),('google.com','/','',15),('rentstarz.titechnologies.org','/albums/view/3','',15),('rentstarz.titechnologies.org','/members/edit/documentslist','',15),('rentstarz.titechnologies.org','/propertydetail/10','',15),('rentstarz.titechnologies.org','/profile/77','',16),('rentstarz.titechnologies.org','/members/settings/general','',17),('rentstarz.titechnologies.org','/myproperties/78','',17),('rentstarz.titechnologies.org','/profile/61','',17),('rentstarz.titechnologies.org','/profile/50','',18),('rentstarz.titechnologies.org','/albums/photo/view/album_id/3/photo_id/8','',19),('rentstarz.titechnologies.org','/myproperties/36','',19),('rentstarz.titechnologies.org','/profile/6','',19),('rentstarz.titechnologies.org','/admin/advancedarticles/settings/articles','',20),('rentstarz.titechnologies.org','/messages/inbox','',22),('rentstarz.titechnologies.org','/profile/44','',22),('rentstarz.titechnologies.org','/profile/46','',22),('rentstarz.titechnologies.org','/propertydetail/30','',22),('rentstarz.titechnologies.org','/admin/user/manage','',23),('rentstarz.titechnologies.org','/articles/edit/2','',24),('rentstarz.titechnologies.org','/profile/admin','',24),('rentstarz.titechnologies.org','/propertydetail/11','',24),('rentstarz.titechnologies.org','/members/edit/style','',26),('rentstarz.titechnologies.org','/profile/39','',26),('rentstarz.titechnologies.org','/profile/74','',26),('rentstarz.titechnologies.org','/propertylist/38','',26),('rentstarz.titechnologies.org','/articles/2/home-decor','',27),('rentstarz.titechnologies.org','/propertydetail/9','',28),('rentstarz.titechnologies.org','/profile/18','',29),('rentstarz.titechnologies.org','/propertydetail/32','',29),('rentstarz.titechnologies.org','/activity/notifications','',32),('rentstarz.titechnologies.org','/profile/49','',36),('rentstarz.titechnologies.org','/articles/1/home-safety','',39),('rentstarz.titechnologies.org','/myproperties/38','',44),('rentstarz.titechnologies.org','/login/return_url/64-l3npz251ca%3d%3d','',45),('rentstarz.titechnologies.org','/members/edit/document','',50),('rentstarz.titechnologies.org','/myproperties/77','',53),('rentstarz.titechnologies.org','/propertylist/36','',56),('rentstarz.titechnologies.org','/profile/38','',63),('rentstarz.titechnologies.org','/members','',67),('rentstarz.titechnologies.org','/profile/36','',67),('rentstarz.titechnologies.org','/members/edit/photo','',70),('rentstarz.titechnologies.org','/signup/confirm','',78),('rentstarz.titechnologies.org','/invite','',80),('rentstarz.titechnologies.org','/propertyrequestslist/','',81),('rentstarz.titechnologies.org','/propertylist/37','',87),('rentstarz.titechnologies.org','/groups','',97),('rentstarz.titechnologies.org','/addproperty','',144),('rentstarz.titechnologies.org','/login','',144),('rentstarz.titechnologies.org','/articles','',146),('rentstarz.titechnologies.org','/myproperties/37','',150),('rentstarz.titechnologies.org','/dashboard','',161),('rentstarz.titechnologies.org','/profile/37','',184),('rentstarz.titechnologies.org','/albums','',187),('rentstarz.titechnologies.org','/members/edit/profile','',256),('rentstarz.titechnologies.org','/services','',326),('rentstarz.titechnologies.org','/login/return_url/64-lw%3d%3d','',398),('rentstarz.titechnologies.org','/tenants','',406),('rentstarz.titechnologies.org','/landlords','',568),('rentstarz.titechnologies.org','/propertysearchresullts','',703),('rentstarz.titechnologies.org','/signup','',1170),('rentstarz.titechnologies.org','/members/home','',1487),('rentstarz.titechnologies.org','/','',2455);
/*!40000 ALTER TABLE `engine4_core_referrers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_reports`
--

DROP TABLE IF EXISTS `engine4_core_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `category` (`category`),
  KEY `user_id` (`user_id`),
  KEY `read` (`read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_reports`
--

LOCK TABLES `engine4_core_reports` WRITE;
/*!40000 ALTER TABLE `engine4_core_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_routes`
--

DROP TABLE IF EXISTS `engine4_core_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_routes` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_routes`
--

LOCK TABLES `engine4_core_routes` WRITE;
/*!40000 ALTER TABLE `engine4_core_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_search`
--

DROP TABLE IF EXISTS `engine4_core_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_search` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`),
  FULLTEXT KEY `LOOKUP` (`title`,`description`,`keywords`,`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_search`
--

LOCK TABLES `engine4_core_search` WRITE;
/*!40000 ALTER TABLE `engine4_core_search` DISABLE KEYS */;
INSERT INTO `engine4_core_search` VALUES ('user',74,'Sulthan Kareem','','',''),('user',7,'jithesh pk','','',''),('album',1,'Profile Photos','','',''),('user',1,'mic b','','',''),('user',75,'Jemy Thomas','','',''),('artarticle',1,'Home safety','Mold[edit]\r\nMolds&nbsp;[1]&nbsp;are microscopic organisms that thrive in damp environments. They can be found on tiles and fabric, in bathrooms and kitchens, nearly any damp, warm place.&nbsp;Molds&nbsp;are usually not a problem indoors, unless mold','',''),('user',80,'Helen Cruce','','',''),('user',82,'NULL','','',''),('album_photo',14,'','Few things have such a huge impact on happiness and the enjoyment, depth and plain fun of life as the friendships we have. \r\nIt could beÂ  the friendships Â with our partners, family members, co-workers and the people we have known for a few years now or ','',''),('user',39,'Visal Varghese','','',''),('album',2,'Profile Photos','','',''),('album',7,'Profile Photos','','',''),('user',76,'Rita Jose','','',''),('user',77,'Bindiya Prakash','','',''),('user',78,'NULL','','',''),('user',79,'Ganesh Nath','','',''),('advancedarticles_album',1,'Home safety','','',''),('artarticle',2,'Home Decor','Living Room Paint Ideas\r\n\r\nMost of our time spend in our&nbsp;home.&nbsp;It&nbsp;should be simply beautiful decorated. By putting some small efforts we can result a lovely peaceful place. A common latest home maybe have featured dull colored theme bu','',''),('advancedarticles_album',2,'Home Decor','','',''),('artarticle',3,'Olive Apartments','Olive Apartments is a luxurious 4-star hotel in London minutes from Old Spitalfields Market and Tower of London. This 4-star apartment is close to London Bridge and London Dungeon.FacilitiesDining facilities at Olive Apartments include a cafeteria.&n','',''),('album',8,'Wall Photos','','',''),('user',83,'Fdgdfg','','',''),('user',84,'Fabia Hinds','','',''),('user',85,'Teenu Thomas','','',''),('user',71,'Ashikh C K','','',''),('user',72,'Catherine Glenita','','',''),('user',73,'Frank Mark','','',''),('advancedarticles_album',3,'Olive Apartments','','',''),('album',9,'Wall Photos','','',''),('user',86,'Fabia Hinds','','',''),('album',10,'Profile Photos','','',''),('album',11,'Wall Photos','','',''),('album',12,'Wall Photos','','',''),('album_photo',19,'','Interior design Â is the art and science of enhancing the interiors, sometimes including the exterior, of a space or building, to achieve a healthier and more aesthetically pleasing environment for the end user. An interior designer is someone who plans, ','',''),('artarticle',5,'10 Design Trends Coming to Homes Near You in 2016','The modern home is always evolving. And to get an idea of what it&rsquo;s evolving to, look no further than what&rsquo;s happening within its walls today. With that in mind, we delved into our New This Week series, sifting through Houzz discussions a','',''),('advancedarticles_album',4,'Design Forecast: 10 Trends to Watch for in 2016','','',''),('advancedarticles_album',5,'10 Design Trends Coming to Homes Near You in 2016','','',''),('user',87,'Lima Philip','','',''),('user',88,'Bianca Kristine','','',''),('album',13,'Profile Photos','','',''),('user',89,'natasha  Gomes','','',''),('user',90,'Sophia Claire','','',''),('user',91,'Angela Cathy','','',''),('user',92,'Tom Sawyer','','',''),('album',14,'Profile Photos','','',''),('album',15,'Profile Photos','','',''),('album',16,'Profile Photos','','',''),('album',17,'Profile Photos','','',''),('album',18,'Profile Photos','','',''),('user',93,'Jamie Sullivan','','',''),('artarticle',6,'The Idea and Invention of Villas','The villa holds a central place in the history of Western architecture. the idea of a house built away from the city in a natural setting captured the imagination of wealthy patrons and architects. While the form of these structures changed over time','',''),('advancedarticles_album',6,'The Idea and Invention of Villas','','',''),('album',19,'Profile Photos','','','');
/*!40000 ALTER TABLE `engine4_core_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_serviceproviders`
--

DROP TABLE IF EXISTS `engine4_core_serviceproviders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_serviceproviders` (
  `serviceprovider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceprovider_id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_serviceproviders`
--

LOCK TABLES `engine4_core_serviceproviders` WRITE;
/*!40000 ALTER TABLE `engine4_core_serviceproviders` DISABLE KEYS */;
INSERT INTO `engine4_core_serviceproviders` VALUES (1,'MySQL','database','mysql','Engine_ServiceLocator_Plugin_Database_Mysql',1),(2,'PDO MySQL','database','mysql_pdo','Engine_ServiceLocator_Plugin_Database_MysqlPdo',1),(3,'MySQLi','database','mysqli','Engine_ServiceLocator_Plugin_Database_Mysqli',1),(4,'File','cache','file','Engine_ServiceLocator_Plugin_Cache_File',1),(5,'APC','cache','apc','Engine_ServiceLocator_Plugin_Cache_Apc',1),(6,'Memcache','cache','memcached','Engine_ServiceLocator_Plugin_Cache_Memcached',1),(7,'Simple','captcha','image','Engine_ServiceLocator_Plugin_Captcha_Image',1),(8,'ReCaptcha','captcha','recaptcha','Engine_ServiceLocator_Plugin_Captcha_Recaptcha',1),(9,'SMTP','mail','smtp','Engine_ServiceLocator_Plugin_Mail_Smtp',1),(10,'Sendmail','mail','sendmail','Engine_ServiceLocator_Plugin_Mail_Sendmail',1),(11,'GD','image','gd','Engine_ServiceLocator_Plugin_Image_Gd',1),(12,'Imagick','image','imagick','Engine_ServiceLocator_Plugin_Image_Imagick',1),(13,'Akismet','akismet','standard','Engine_ServiceLocator_Plugin_Akismet',1);
/*!40000 ALTER TABLE `engine4_core_serviceproviders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_services`
--

DROP TABLE IF EXISTS `engine4_core_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `profile` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'default',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `type` (`type`,`profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_services`
--

LOCK TABLES `engine4_core_services` WRITE;
/*!40000 ALTER TABLE `engine4_core_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_servicetypes`
--

DROP TABLE IF EXISTS `engine4_core_servicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `interface` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_servicetypes`
--

LOCK TABLES `engine4_core_servicetypes` WRITE;
/*!40000 ALTER TABLE `engine4_core_servicetypes` DISABLE KEYS */;
INSERT INTO `engine4_core_servicetypes` VALUES (1,'Database','database','Zend_Db_Adapter_Abstract',1),(2,'Cache','cache','Zend_Cache_Backend',1),(3,'Captcha','captcha','Zend_Captcha_Adapter',1),(4,'Mail Transport','mail','Zend_Mail_Transport_Abstract',1),(5,'Image','image','Engine_Image_Adapter_Abstract',1),(6,'Akismet','akismet','Zend_Service_Akismet',1);
/*!40000 ALTER TABLE `engine4_core_servicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_session`
--

DROP TABLE IF EXISTS `engine4_core_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_session` (
  `id` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_session`
--

LOCK TABLES `engine4_core_session` WRITE;
/*!40000 ALTER TABLE `engine4_core_session` DISABLE KEYS */;
INSERT INTO `engine4_core_session` VALUES ('00eosobhc27m1jacae6102h292',1466400445,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('00l8ksj87ivc6rudft5gdlh1q3',1466400202,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0141nh119hdcf8v2c74bqe01s1',1466396455,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('014ei48p11miok9otdhpgfh7k3',1466411341,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0193c5263baebf247773d13e16138e72',1466425376,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('01b3f5f072dd40ea65e64e4506564be5',1466426431,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('01lrpji8oko5e24vqcju4s35d2',1466399236,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('04sc9q0i1pmpneqj922unrgmn7',1466369849,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('061iqjv4c8uaqo2rqf4vao8rv7',1466412725,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('06acb4b91337022e10192ac3598bf3a2',1466424118,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0826htds17bduuragaj995uru2',1466413599,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('091b10e35f190205af18588dd2670cb5',1466425916,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('09ba0sis4btvoeh7kcotfu29o1',1466342446,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0b5kop6kcbfhcvhil7ema36207',1466418403,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"40f71607dee704de37f04eb20b533517\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:39;}login_id|s:3:\"649\";twitter_lock|i:39;',39),('0bigni5vb0ukphg0mmu5jlslu1',1466402459,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0c390c9d4e1ddf9a38a88b646bfa3444',1466425695,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0d3bd0975b11cd9bf8c76bcd91b69c0f',1466423827,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0d8b7600c119f4abd4bab02729adee58',1466420849,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0e34hp67gncfveufre8ojk35a0',1466417078,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0gegbvjdb73d6hg5lifr0dvv06',1466413726,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0h9vhbg2q64v4h7luprrr6kup7',1466404239,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0o4pe1qofgc5begg47hug867m2',1466402337,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0p8u6ie5qktli95a3g50vr1rb7',1466407807,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('0su3vpfs2j8e8rcsqmm9cb7sh4',1466398732,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('10936cb01065f1cdd00d2bd9608d87ad',1466420758,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('10aosi5fb999bv6km3t8p15f01',1466418160,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('119baef1d5a9df8fb988757c23f07fc4',1466425636,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('11a8bletnr8o8b2df6l701akm1',1466400520,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('14e056410d24a79aa82412988e32d7bf',1466424885,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1571b0f235843dc40a6ac449342008c6',1466427142,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Invite|a:1:{s:6:\"active\";b:1;}redirectURL|s:6:\"/login\";',NULL),('16a65e131a05d2e380b1c705c4c804e6',1466427222,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"687\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5da8bcec0f838aa035f9ddd2a41d5fd6\";}twitter_lock|i:7;twitter_uid|b:0;',7),('16unt9g1nv94ho4rbopl6pr1d1',1466418368,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1985708e5004d8405a590a5e5fd0d852',1466424430,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1bjthsu24p4qcjjoli0lskjdu1',1466408796,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1d00c5f7a0ad671f730b037d61a57036',1466427205,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1b5c815d878087b7fc5d8f82bc8ece82\";}twitter_uid|b:0;User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Invite|a:1:{s:6:\"active\";b:1;}Zend_Auth|a:1:{s:7:\"storage\";i:77;}login_id|s:3:\"688\";twitter_lock|i:77;',77),('1d4p53mgl5gh33vvkd6dn6bkg4',1466397448,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1fr8ejlqbdlunblf3981jd5mo4',1466376610,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1m7onev4maagrht18dso0ln9e7',1466399084,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1mundc9o6saahs69894g7e1r74',1466416510,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('1pfs0714fuq8nne2195ibbcur3',1466415055,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('22tvufq3ocbhhntn9051icnrm5',1466390755,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('24fbb81b756a971e7b17d1a6decc6e46',1466419582,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('251a26830d82ce14d7e4ae7fe914578a',1466423563,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('25f7ab609ae0e8355690e752d263282f',1466420970,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('269ba40f6c3ed6d46793bbe5ad1c21be',1466420695,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('27j0c64fbntdf32btd5ro70dq6',1466400811,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('2c2fb50270fe1c6fbc8f44a0ef3355f0',1466427153,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('2e2016e3c2e9946170aa50eb3dd8e022',1466423042,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('2gdehmon9inp54bge44pceh0q6',1466407488,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('2htn9bcbrh3m1us7vbun79m4t5',1466417588,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('2idng5b8b2gg9qrighpdv14r87',1466404105,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('3295e46ac49e8af16d5b5e61d1ec8be3',1466421394,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('32df92d66a5b76ab887f97fdaf8e86e0',1466425916,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('352b7f18adc1f943eaeaf8b20c726aa8',1466419157,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('375515ccf30ae1fe941bbf2c114bbe6c',1466427092,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('38446b495fbd7bb6a807632345da7ad2',1466426885,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d1af7ac97cf26bb4faa15c35c40ca044\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"671\";twitter_lock|i:7;',7),('38mmq9ar3grh6e82s9hvvdafs5',1466418461,1209600,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"374\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"70436b3f6344a9b1e52ad89edaa8998a\";}twitter_lock|i:1;twitter_uid|b:0;',1),('39880ae212b3073b693cdbb5f69df372',1466426875,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:39;}login_id|s:3:\"673\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"daeeb448f8a0a8f3fc55d58aa2dc1914\";}twitter_lock|i:39;twitter_uid|b:0;',39),('3b356b5d63aa34126795550bb9555313',1466423198,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('3d111c60d57d48594dbd12dfbca6f794',1466418897,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('3f58d29f184e8d12fe8605afaaa912cb',1466423428,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('3vrbgu3p5ae3l1e133n9nlfou7',1466398507,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('41932daf2da538ef2dd485a4937ffba5',1466422372,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('41b77f01fcovngtojv0lqlfku6',1466404636,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('427e01f0524f343b09540cd463836cf3',1466425821,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('43tdn2021i6be64a50c1rrend3',1466397671,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('454aa6l1gchs0kt20828hm3n14',1466395961,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('469484453894291f8efa7b4af078d558',1466421044,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('48f572bb4e6d1fa2b94d9297471a38f8',1466421252,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4b9f21b5227c8ea846b98c2583db3c36',1466422807,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4d370d8e8521198752c4bf737e2b8ab7',1466420163,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4da83563389b250e87d41e16120ea3fa',1466421795,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4e6b4d2c02a68958a0de31d9f53a91aa',1466422980,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4e6pds646qmefnoqcvcrhkflk7',1466350446,1209600,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/login\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}ActivityFormToken|a:1:{s:5:\"token\";s:32:\"75502624d990132143ac7a57541d8963\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:86;}login_id|s:3:\"639\";twitter_lock|i:86;',86),('4fbf3cf9ee65d863a0d695d331bd1395',1466425291,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4g2tlb6kap3197494l9nf9kap6',1466403796,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4j1vgdfa6do8b59o2f08frhck6',1466409417,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4qg69vee77n1k9rqk5p5ffhlq7',1466415733,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4rn1j0r1hij7sgbtsfp0fpdg16',1466399363,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('4tuk5u5psc59qq1s7brmrp5nr6',1466404520,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('50ea2a881b6d6763cf306980e16457d7',1466422617,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('50fe468479bc579fac59c9d1ebdccb41',1466420112,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('52v98lhaiubsp8mhqbv2qada35',1466412086,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('53900fb6196cf143a029d1b91a4ef6d0',1466427246,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"04e7f9366c3d0d7a38320e82d17d5029\";}twitter_uid|b:0;Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}Zend_Auth|a:1:{s:7:\"storage\";i:93;}login_id|s:3:\"689\";twitter_lock|i:93;',93),('55mnv8f94gja33kn4m37flmhq0',1466408237,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:77;}login_id|s:3:\"657\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"906e1b475bbe2a0d5a8f4f93feef7cd0\";}twitter_lock|i:77;twitter_uid|b:0;',77),('56c9acf5928d7b6e12bc2360c26f6ba6',1466423909,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5772e6bcb0f8a71ce3f6db516d054332',1466420632,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('57tv3lk97r242jhh3rimgcks37',1466397200,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('580d174d1d195c7a94cf0b71c9b80f18',1466419792,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('582538567b9d56b4a23a4a6be48c66a7',1466425999,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5ec3eccb4f0e91b292fcfb51f07eaeb0',1466421646,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5f2deff5d92520a262b8ac8ae2a77205',1466423299,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5fbvj6e2bi5oij7qltnf9bh2l7',1466342574,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5fc55d942123d8e7f4f5cc978b81e077',1466424999,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5fvt1do2k73lpud9fg915kkfb2',1466411891,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5hl9bne9eh1of5gu8thr8vi984',1466406837,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5ia8rpon9719rctibnoq2nt477',1466416010,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('5u82mf7mf5mljvrkufqf9m3qc1',1466412025,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('64548d0a606860ee355176823d3cb569',1466424553,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('64qv02l4ri1pmdsvvoen4g3e96',1466407892,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('669rmugtoh9adhmpmape0nn4t0',1466411952,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('672o62gajggc4m6qa85952qtr3',1466414871,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('67rkepe9tef38quhekppnlfsm2',1466397575,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6c8bc7bb8d9db4c41782f9c63a603df4',1466422845,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:92;}login_id|s:3:\"676\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"23ed95abb93d85044b9158089bd768e1\";}twitter_lock|i:92;twitter_uid|b:0;',92),('6d7efa094881a216a6e673fd200ba37e',1466426491,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6fupt7qnah3qj3ae1aq0tm10g2',1466407428,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6kpnbspf6k8s00gkd26ld8gub3',1466407184,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6or8a38jbcbp3jvb5e91v3us63',1466396651,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6sajce9epp5tbpvpopnidh03n6',1466407124,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6sl0g7oglcg0kr5is17c9qokh6',1466413797,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6spb7p9l0ijvppha1aaeuiomr2',1466401214,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('6vqjtoehng6jjpbmbcqreaskp1',1466409704,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('70608ffb9de6ef5ff2175288f6fcf9ad',1466421191,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('71e44d3cf7453f0923f7074d4417642e',1466423700,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('71fhd1noj83qvkdu2h3qe5gnv6',1466375759,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('734311a5e3908c12a0c7a8257e8cad2e',1466425919,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('74440a35fd6b163912d0f8045a926acf',1466426370,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('760lg81hfh3cg3vlijriehisc1',1466416857,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('78f0irbq1967qudueots2ta1k5',1466417360,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7b11fcf3deeccbbef2c04924c38985a1',1466426595,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7c07df8b7eb0e7b6986517db948edb07',1466427198,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:73;}login_id|s:3:\"697\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"2d36892f84ea023f8cfa61a0bbd8722b\";}twitter_lock|i:73;twitter_uid|b:0;',73),('7cgjvcottnn2m3m1d96nrhip71',1466409240,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7f2b61f455a362e09cfb2fab89abaf35',1466424494,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7l42o88tn1v35n0huk5l49nee1',1466396278,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7n3iin2m3jun1n8rc46cfjpbd6',1466405231,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7nopcnmgortlvgihas62mnn6j7',1466410324,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7pet4f2s6fdpjuquk5ps2sn2o5',1466395477,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7q4029dea2p8n3foe7h7sgc131',1466412953,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('7re1vu0fvkr6nkcddnc3fv9la2',1466414334,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8244049cab1010c62ec348525d509ef2',1466425444,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('831s002j877a4avjnlhg2kdf50',1466370013,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('84b2dsqgcujdg0tdf1klmcuj02',1466401778,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('84ri0dqfqti6p45eme9otvj876',1466402277,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('853ce94b01cdb6b0996e174190198ef9',1466427125,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";',NULL),('86p3q14n03tgs9570cu8ulfp01',1466399759,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('87i1gp58vv6ii9fljdub3fcve7',1466418553,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Invite|a:1:{s:6:\"active\";b:1;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7877fff87c74f63d9211f85519b0fd40\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:85;}login_id|s:3:\"656\";twitter_lock|i:85;',85),('88e80909556b818b1a98edaf3293fa90',1466421126,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8aacc20ddf3154652d3f4c3077e3236c',1466419839,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('8d3imvbdpjlnulch17mhj3olc5',1466414546,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8e0b77b91ee91768f5544ac06a9bb950',1466424651,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8ef4e0705510f82940dde092b77e7c20',1466419785,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8f650c6a07be4e01dfe79bef6d318d65',1466424298,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8f9ba44ede200e4f6082280d34b544a0',1466427228,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('8plbrr5j0okthvjah3mi456ue1',1466417595,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/login\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"655\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"aff0182bdb5a835c294eeb91e9d58b6f\";}twitter_lock|i:7;twitter_uid|b:0;',7),('8uqv7lokglnjcavo44l12ovk53',1466398873,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('90unj5d9uqpv43ak83kokvn7n3',1466404390,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('91eq5gunssv5gdp09udht2go62',1466404173,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('93f12f612818a6600d4a483bb49eb9ab',1466420225,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('93kcs9o6ugofa8lqlnp0luoc95',1466396455,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('98majfhkm1boon2r3te189p7g0',1466402034,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('9b15f5426c037f19aae41747f7a40ec5',1466426782,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9d3dbf3daaea5de38133e302f18619a2',1466420102,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9e1f73a86ed6417913058d3045487f73',1466420911,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('9fr8nvvv2o0q7ek9bhsj1q8pg4',1466409820,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9hns4t4ssjsneujsva34p5oon6',1466412840,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9r2etmh96jcorivcjd90v0h211',1466400374,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9r3f65vkj615k3ap7bck0uu2i5',1466402779,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9r4orrrm8os255r5s4aqdmegn6',1466397750,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('9vlllp8tcc2fj6qo22ji2kpcn1',1466416984,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a16es6lpa8teok8nv0et2q0oc6',1466416634,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a1ab31f08e52d52fc0c58e6cc1052484',1466422685,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a1m91vnml97usfn1t5ik0vfuh1',1466415142,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a3252349dae7b1f5379162eb94c52895',1466420470,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a58o0nu77t64u3222p3f07u186',1466398585,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a66085bcb2bceb1267813bcec72846cf',1466422496,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a6c92db4114bd63da933c457bc3f5e69',1466422745,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a8f4omo60i78vqojvmvf7v8p53',1466403276,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a9394d033cb9d3f240fdf654dfbea4b2',1466425157,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('a9jpio504lkl4jn2hn06u8tit2',1466409949,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('aab53b630a0ff37b426c9971d8920155',1466423102,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('al4c84dk06frsb4qv9uoe77r42',1466396344,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('am0p6pj8m370c7c9njcclou8t6',1466396020,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('aob468aki1egnm8n8eejqe1413',1466413434,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('aplj1ktmhmku2dp4v93epceeg3',1466376505,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('arpsndai4n42q1q4ek5a59jf07',1466407373,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b1efkmhh6crm79ttb485mpb0b5',1466376823,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b20707ea56f05a0eaa27f4a328e47e88',1466426846,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b33f3994ae0470671b845ba2cb5c3e46',1466423639,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b3670ee9991a568cb35cfe1f96350d24',1466424813,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b57d7293d67d419ae2be63ce31d8ed94',1466423369,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b614520de6d5e6e54951abd956287270',1466421729,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b781b4d47f69c6fc8680702ef6045e57',1466425568,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('b805ff972d6949d8b27c45f70df1138a',1466421888,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bd1afd2737f0d566d7deda958f8bf0eb',1466425757,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bd2f2f0649e512444f651852289fa8ef',1466422570,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"677\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"41a66c7eb1c61228df417bcec3ea1afb\";}twitter_lock|i:7;twitter_uid|b:0;',7),('bfadc2a32192fea767c3d99158e14139',1466422556,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bfdb61f89b7ceb35332e30fa51ce13fb',1466419460,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bh6hl0k456inksqebck61jumh3',1466401993,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bjko3sulm39a5h500egs8q0e53',1466401517,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bn0e2ssqbq8offgvakssngltb3',1466403852,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bpndbm7l194h24e55djk4tu7h3',1466399628,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bvi0sv0sru7p17m8kr1n5e8u05',1466418579,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('bvi6grbfaajm6crihujiup9if3',1466397375,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c0064ea5eb6d2dcf2130d4074e8030ac',1466426908,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c30e89244085ee5a1a94eba4007eff31',1466419704,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c33a05d7c4acb6fb07a29527cff3d34f',1466420367,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c3e9385f0e113d976cd2e9d81a0aaa60',1466424051,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c413bfb94cd0a513e2abc636c6d6ffd7',1466424177,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('c7f4t2jqsrllucec4gbt32f145',1466409303,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cb33c8dabb51462869170ae3e650b5c7',1466421321,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cblno0p28e2986q0qs4cep74f6',1466398936,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cek0iat9jr8j6kfhsm7b1986j0',1466417232,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cf71408a91d941e88316d4ad52e3338d',1466426307,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cfa592d493afsq6u01k1jjbe82',1466405291,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('cjoqnqdhdeb66a6umsl6shd866',1466401435,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d0102e47edb4dacde594c26b2cd69c6b',1466422920,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d3456f23a44ad0c51072b67c36596060',1466427257,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:77;}login_id|s:3:\"674\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7504b2fc1848b6d3246bf3628ffa23cf\";}twitter_lock|i:77;twitter_uid|b:0;',77),('d4e8521f7beff984b4b58c7f4873863a',1466422130,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d4rsoc3mehm1sevph9n8190rg7',1466403737,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d5285ma4j6cov9u8nat9a8pp86',1466416699,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d5a0ed58e25d778cb3fe1cf2d8e7525e',1466426712,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d7oh585tis5ierhbqfe60nng06',1466401124,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('d8522938b3a310acc6730408ff367097',1466421960,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('da36cf3bad7d14329292ae1d21561cca',1466426071,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dae0ae1276e15c0779b8358196e14e2f',1466423490,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('daqv6eeb4ndurskai99707elp6',1466381913,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dbaeae92b7732a97f35c8ad01a41a5c1',1466425219,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dc1de6718bbc215a5dd997dec0a9e2e1',1466423242,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dc81bb743ac139ad449f3eafe962e157',1466419004,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dcfuu959seq9bg7adldnf8fie2',1466417488,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dd646e71eb85fda52e58fbdfd1a4414f',1466420911,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ddcfbe8905b96bb7931d3f28fab0e814',1466424239,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('def6t1c02q2q25ckc43t97i135',1466410073,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('df2db1e8a8ab2197e6dab855f0534646',1466425097,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dgftgt5p0uu0k6543etj5uf407',1466415801,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('digolmo0195t6hkrbpbabhfj05',1466411684,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('do9jatt3bqmj9vqh03ibgb1196',1466373874,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('dqd9jtf6tl3occve1nao7mnv61',1466418514,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('du9ag80vlqfmmhmih55vqqtti5',1466402907,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e07tpvv1o4al7s0i7kfjlopsd3',1466404874,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e212fa5472d98dcf3298571efd02cb11',1466426968,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e2pj2dqahmu4ui0h2465crlrj0',1466407992,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e3de1fbb0b0a2516912c7daa53001fa0',1466424469,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e4593ed1632f1ed2e20e73d214c93d14',1466427268,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Invite|a:1:{s:6:\"active\";b:1;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"f0cfb1d6208eb07e98b8d67e4750d5ac\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:77;}login_id|s:3:\"685\";twitter_lock|i:77;',77),('e69e970d9c56833a3e680f942a79d043',1466426095,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";',NULL),('e6iuq0emo4onnqivb14af54d17',1466411623,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('e93ae3e963f83ea2951ed9d0eb14c4b4',1466427030,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ebc0e3ba1059da40949d57c40e811d6c',1466424748,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ec6lvs00ntpk0o8rpuadjdlck1',1466402523,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ej72ni76c2afu407f86qu4fu65',1466381695,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('em74q43iurtb1l1lj82vcd9ql4',1466414040,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('es6f07v90744j72a69bhb08no6',1466409172,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('eu18hmgkak7vmt29trnt17ono3',1466403624,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f0g8iop4k5larcsfe7eig0e9d6',1466398208,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f322d95cfac0fd129e6952f9120f3255',1466421309,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:92;}login_id|s:3:\"675\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1beeb6e532f94ab9a638d3c6561f23d1\";}twitter_lock|i:92;twitter_uid|b:0;',92),('f4dce7dd34fcf5c694f0757831a62d93',1466420569,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f4qcig2pqgr5l2vrmpchs345l6',1466401931,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f50e704tm8e1p9uulmh7i74vo0',1466401302,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('f5819f58fe2827c5e3dd336a3bc7073f',1466422251,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f7d1hpir7s7h9krejc85a3vap0',1466375661,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f7d512f5dfacc152da138f36d1d5cf6d',1466421525,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f88b8c2a9d100ae5c44a233dfd42b74d',1466425508,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('f8pqhv8k15ukpnpn0ajqs60l71',1466408140,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fa8d4a76473eca7993d9608f24218bf8',1466419338,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fd9ccgae8dsjcdjkfn87romv46',1466405001,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fjn93hq9ccd9r7htqibck9scq2',1466407024,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fk44ovih0gdkmvek4ena6kbna5',1466414805,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fle1m59h3ucngtlbvc76574lt0',1466396807,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('fo4pka12bfb7v5fg9jplb8ggs6',1466408292,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ftt43d0g0edpii9pfdl6m37q02',1466404580,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('g7bd4b402fq34hjsb92rok8qs3',1466418580,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";twitter_uid|b:0;ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7dc79fc9e03632ef2db47e58b8500b4b\";}Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}Zend_Auth|a:1:{s:7:\"storage\";i:90;}login_id|s:3:\"665\";twitter_lock|i:90;',90),('gca8b019fvmqp3tfqcub3p5j57',1466397840,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('gm3h2tr22g916eanr97o8d0av7',1466401057,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('gquag1d6mkdic2k3pm3g4qfhe1',1466413345,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('gu7i5sec9e1n8a8pujsrehn6i5',1466414149,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('h66akoqa0aldkb7fc0bm4a3hn7',1466418414,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/login\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Zend_Auth|a:1:{s:7:\"storage\";i:39;}login_id|s:3:\"663\";',39),('hegfm664trobjkmmmv9vso5ei7',1466376437,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('hlvevf3ok2bi00o4d0anveb184',1466408905,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('hmc6qbq22pndq3cfr8vt1e7bk2',1466399562,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('htrfcp9tage5e4r15m6sar4sg6',1466411757,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('hu4c1ss6jgd311ise3b24ndku3',1466412664,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('hvf2r9hms0up2f4fc5l5u1tai0',1466402182,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('i0ruanibpq6itnq1je2qc8lv53',1466414454,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('i32m67t0mvh5u466l74p1cnlj0',1466400980,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('i49kucuhr7c9pakjne7m8s2q53',1466418535,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"71d1b56abfc62fdba987d9f0e664aa69\";}twitter_uid|b:0;Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}Zend_Auth|a:1:{s:7:\"storage\";i:77;}login_id|s:3:\"660\";twitter_lock|i:77;',77),('i692drddoj740the38et2ol583',1466414649,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ig9j5r0m8te3fd395erlgkraf2',1466407743,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('inn0eesi5cbaidi80ldvihor74',1466396489,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('io0qe2hef47a0qckbtuhtdil47',1466411434,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('j1h3ku0v5tkedngqd5preript4',1466398446,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('j7ghermtnfurqpekv1nileuj13',1466413219,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('j9k9r6atsieq7tdp5v2j3f5643',1466418306,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('jh26b9ti8sclukgr1ov2c8a7v4',1466397960,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('jput026ocoqog28nosjdh3bvo0',1466415525,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('jq9ohfo89u18dd8rpmv0tegeo6',1466418566,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"aa74aad43df8f350279c564dbe3589f0\";}twitter_uid|b:0;User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Invite|a:1:{s:6:\"active\";b:1;}Zend_Auth|a:1:{s:7:\"storage\";i:85;}login_id|s:3:\"661\";twitter_lock|i:85;',85),('jv5otp8pijermvk25ai7a8d5n7',1466403537,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('k25bi481i0qp3u2jabakc0fko4',1466408556,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('k43v35bm5m96gc5915cse7q6p1',1466412348,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('k6m1admksqonpb05o763rd5mq0',1466398087,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('k7mo48tgdu20q97ag7t94a11k5',1466414932,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kdj2ktk59c7rnp1njr09s30kk1',1466396942,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kga5eoj6ir3jp2ea822s08ru05',1466401299,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kjpej7bq4757ebrvp40e79fso1',1466396869,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kpnkuq2pgvk7a212ccmdjgn0b4',1466394470,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kt4lk055v38s7cdq9ig2cpj9t2',1466342275,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('kufit4fjteu0mv5husr1jalvs0',1466399718,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:25:\"/profile/78/action_id/132\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('l65toe4colt0enatn9b7ji4le6',1466397318,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('l6v2n9oa0i9acnvq46fg0t1a70',1466405082,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('l75jrfafukeoeqceattmp68oj4',1466399145,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('l89to6ka8en3bqs7302gkufsd6',1466411491,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ldqrmj7b9mqgoos6csundqgei0',1466411204,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ldvk02djojkckcjcs5js2cgnp7',1466398814,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('lg388106k4a1ne0rsi1vgn73b2',1466396213,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('lgue2pe9iunk43i12g7md9vgr3',1466342371,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('li3hab9la0m324l6a4pdqob182',1466396114,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('llcanl8rui01db8lf19prmvt74',1466409564,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ln4bqls3atqo1fqgc1a97rkhe7',1466412211,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('lp9jji6t47k8j2vgc661duhb43',1466408211,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('lpkbar6lldham88ch4vnu0fsu5',1466396491,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('lu5fh1s19hbti960o7rhi1ess1',1466404940,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('lvjp9k90umgv7tcjk36nboq910',1466381842,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('m4daevaa52ecgol1264ee3h3q5',1466418576,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Signup_Confirm|a:3:{s:8:\"approved\";i:1;s:8:\"verified\";i:0;s:7:\"enabled\";i:0;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:89;}login_id|s:3:\"664\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"80fc677fbee03544693f2421c9a99732\";}twitter_lock|i:89;twitter_uid|b:0;',89),('m6nfqdi2d4ki6ge4sbs9dm0p57',1466415367,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('mh1kbqdg3kfhi5glp466dvsjr5',1466381774,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('mj2of48jlos0rnclifn9lmlbt2',1466414741,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('mm1vcug62t715p22l140m0rod6',1466418464,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5df042f408f00e4bda38a0e92c29129a\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:87;}login_id|s:3:\"662\";twitter_lock|i:87;',87),('ms94gu21n29kq2t13bg9rvp5q0',1466403397,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('n6kp07ubk216lsnmppekrmfs40',1466416074,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('naeqncsbdl1u2vokq6gugmb8b6',1466416141,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('nam52ssoapp6i0p0re2it6u4e7',1466410197,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('nbgjnh39svusfk5ibl55rkain7',1466402391,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ncdq5e06h74o14hg1jel3d0al5',1466396563,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('nd33jitkb82qfpo6jvqmg9ff01',1466399692,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('nekjpl00jhc4d1pr6b2b78aub4',1466411282,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ngoufttj5hh81q4pmkin1pomu5',1466416389,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ni3kuk0s3rk3kq5plg11sp4br0',1466403935,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('nm953cajfookbs5777aciaj5n2',1466398311,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ntcvm2c816vv3ljsgn73bb1s27',1466411559,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('o585cu8iijard3cg4v4gtuloe0',1466399967,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('o9q95sa40hhsrnvbc6galg1d32',1466414271,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('o9to1ndlfeucos62f9tnkui8r2',1466417971,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('oacf9uomm1f3lhjglhp26vo5r3',1466413092,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('od1sv78pm13do5r47gvpv874h3',1466398021,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ofa5m97mh20jkaj79qo736sib6',1466418100,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('p4iaqb6b6f1vrrsg8qh7b51u51',1466415466,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('p4lccbvcc7iu88ndf5bj7brnp5',1466402103,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('p69s0k1g5ihtfdgjeejm1687i3',1466399303,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('p8diti09bpd89njidca5hf3ik3',1466418222,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('pjfhv6e805hc4fqpfor4g6pek7',1466401372,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('pmuhau0cf4jv5dm2ki5j01hju5',1466396742,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ppf89bg84qa03do2ms4tv38he1',1466411824,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ppk26na7l6b7b8mdv1u3042lo3',1466410956,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ptjhnpdm7q44kgfjrti4hboom7',1466399011,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('q2b4ekrssb4j8vstp2c9hou8i1',1466414394,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('q8be8aigf8baojubsmf4q7j1m5',1466407245,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('qi9uqaglqsasva1ala1oduf8u3',1466342642,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('qjqeb5qam19rr1k51e9lrc40i5',1466400884,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('qkrghlfururtkf2gh2lds78ov6',1466416457,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('qo8ave4rrd9bqfldaq84dqkod5',1466412267,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('quobirl410mfgktlieihjrmpg1',1466395047,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('r1cllqrnceh3rark2ok47g4o84',1466412147,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('r2g8u1d2n6k9sc2p69asoj6v21',1466412602,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('r65q2vmq7el90b2jumrer4edc5',1466404308,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('r9s27uvgps845p360b1lic4mb3',1466413495,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rb45ps2v0j9kko5jfg96c0hnd1',1466408968,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rf18ljohl5mqarr38n35ish636',1466382072,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rf3r12dlltd2e0liql3tlf27n3',1466400066,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rm9frimahfvmh1ubjbc3lgshr6',1466418431,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rmpu72gmpuv1ai2ah43jp6n7r0',1466399839,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('rnl43du65ff0m0ueim0vnse4l6',1466400126,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('s1e0d1rcfni959k5s4g5kvqh81',1466399490,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('s1gbtbp3bf9u233gmka8vo4us5',1466415595,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('s2ao9di1d8keguig3jhb9tl0b5',1466406773,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('s5a5a9omftufa30j28uf38h7m5',1466397073,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('saicnbc7h71hjv8lu7lkr3il31',1466406897,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('sf6ptu9lq76n6ccjektq2cllo7',1466407557,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('si1rnk5oaqt7q30e1aqdcl0nl4',1466416232,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('skmusutk79v8tij2uug4e5p5n5',1466412475,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('sr8rugpn5jsisimjnnfpf4i8t0',1466402034,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/admin\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('su79lml01p3npil96a4bo5oe21',1466342695,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"640\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5bd542df39ff76b63f00a3951f632cb3\";}twitter_lock|i:7;twitter_uid|b:0;',7),('t1mqt1sdvcd04ll8jsjosi03r3',1466409032,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('t1pkojtqt5m8qavul1tfh2to23',1466394470,86400,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:10:\"/landlords\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('t4ki33m6l7kv3j3ms2jvh9goa4',1466406802,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"641\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"82f17ed03cf140f3ed2a68f801aeca32\";}twitter_lock|i:7;twitter_uid|b:0;',7),('t70mg6gkgisseh2ff8ltunvqn7',1466416758,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('t74dpi62ditllu5ir8miarlre3',1466400101,1209600,'mobile|a:1:{s:6:\"mobile\";N;}redirectURL|s:6:\"/login\";ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"373\";twitter_lock|i:1;twitter_uid|b:0;ActivityFormToken|a:1:{s:5:\"token\";s:32:\"f456b26f5d96c3d172b5ad880115af14\";}',1),('tq4hifugohmhhrqpusaceeb8c6',1466404747,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ttee05pd3n4q0opb7m3idktvs5',1466416919,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ttnpigg09hh5v3slonpg35klj5',1466399033,86400,'mobile|a:1:{s:6:\"mobile\";N;}ynbusinesspages_business|a:1:{s:10:\"businessId\";N;}',NULL),('u8g65rljc0dkdileth0uumj625',1466416295,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('uq7vbmho5b573v009ig9kmjcl0',1466414991,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('uslnu3p97hdqdsgp32bg63qvo1',1466407683,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('uuqfn0otrm7ntk18sq6g9n7cd2',1466402652,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('v1d92i8tfg2usd28ki28c5keb0',1466382540,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('v3j46dvfb72fqoc0d5bds99872',1466382903,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('v5cntkle8cgt2mqh21fva060b0',1466375598,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('v8rjbgq0116aglms5smmmsjk44',1466396414,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('ve29pvoq60ljus99u65b463n62',1466395120,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('vkdn26ubi8gr1vp4pehiosjs05',1466350443,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('vklej87uaehed7ku2s56bdfjg0',1466407313,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('vlke50cj7s28p9jqueibvf6664',1466415890,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('vnckqtbqta0rrfkovc5bd9ceb4',1466415279,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL),('vpoftb1e3a40l4oi5fnsm5g0o7',1466369943,86400,'mobile|a:1:{s:6:\"mobile\";N;}',NULL);
/*!40000 ALTER TABLE `engine4_core_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_settings`
--

DROP TABLE IF EXISTS `engine4_core_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_settings` (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_settings`
--

LOCK TABLES `engine4_core_settings` WRITE;
/*!40000 ALTER TABLE `engine4_core_settings` DISABLE KEYS */;
INSERT INTO `engine4_core_settings` VALUES ('activity.content','everyone'),('activity.disallowed','N'),('activity.filter','1'),('activity.length','15'),('activity.liveupdate','120000'),('activity.publish','1'),('activity.userdelete','1'),('activity.userlength','5'),('art.per.page','10'),('art.photo','12'),('art.public','1'),('art.sort','5'),('core.admin.mode','none'),('core.admin.password','f7af4a471ebecf0daf7dd73f42ae9272'),('core.admin.reauthenticate','0'),('core.admin.timeout','600'),('core.analytics.code',''),('core.doctype','XHTML1_STRICT'),('core.facebook.enable','none'),('core.facebook.key',''),('core.facebook.secret',''),('core.general.analytics',''),('core.general.browse','0'),('core.general.commenthtml',''),('core.general.includes',''),('core.general.notificationupdate','120000'),('core.general.portal','1'),('core.general.profile','0'),('core.general.quota','0'),('core.general.search','1'),('core.general.site.description','Rentstarz is a social network company that focuses on connecting landlords, tenants and Legal Aids for the purposes of  renting, leasing and educating. Our objective is to provide a medium for both landlords and tenants to connect. Rentstarz is a social hub for the renting and leasing market. '),('core.general.site.keywords','rentstarz, rent, starz, landlord, tenant, legal aide, process server, lease, sublet,real estate, apartment, room,'),('core.general.site.title','rentstarz'),('core.general.staticBaseUrl',''),('core.license.email','email@domain.com'),('core.license.key','9860-6577-1950-0000'),('core.license.statistics','0'),('core.locale.locale','auto'),('core.locale.timezone','US/Pacific'),('core.log.adapter','file'),('core.mail.contact','monob245@gmail.com'),('core.mail.count','25'),('core.mail.enabled','1'),('core.mail.from','rentstarz.com'),('core.mail.name','Site Admin'),('core.mail.queueing','1'),('core.secret','30b8039f6799b7229900ba61f9d843b9380694f9'),('core.site.counter','60'),('core.site.creation','2016-03-06 01:10:13'),('core.site.title','Social Network'),('core.spam.censor',''),('core.spam.comment','0'),('core.spam.contact','0'),('core.spam.email.antispam.login','1'),('core.spam.email.antispam.signup','1'),('core.spam.invite','0'),('core.spam.ipbans',''),('core.spam.login','0'),('core.spam.signup','0'),('core.static.baseurl',''),('core.tasks.count','1'),('core.tasks.interval','60'),('core.tasks.jobs','3'),('core.tasks.key','41cc05fc'),('core.tasks.last','1466427228'),('core.tasks.mode','curl'),('core.tasks.pid',''),('core.tasks.processes','2'),('core.tasks.time','120'),('core.tasks.timeout','900'),('core.thumbnails.icon.height','48'),('core.thumbnails.icon.mode','crop'),('core.thumbnails.icon.width','48'),('core.thumbnails.main.height','720'),('core.thumbnails.main.mode','resize'),('core.thumbnails.main.width','720'),('core.thumbnails.normal.height','160'),('core.thumbnails.normal.mode','resize'),('core.thumbnails.normal.width','140'),('core.thumbnails.profile.height','400'),('core.thumbnails.profile.mode','resize'),('core.thumbnails.profile.width','200'),('core.translate.adapter','csv'),('core.twitter.enable','none'),('core.twitter.key',''),('core.twitter.secret',''),('form.mode','1'),('group.bbcode','1'),('group.html','1'),('invite.allowCustomMessage','1'),('invite.fromEmail',''),('invite.fromName',''),('invite.max','10'),('invite.message','You are being invited to join our social network.'),('invite.subject','Join Us'),('payment.benefit','all'),('payment.currency','USD'),('payment.secret','f4e0f541493c5013b5fbb7e6c264861b'),('storage.service.mirrored.counter','0'),('storage.service.mirrored.index','0'),('storage.service.roundrobin.counter','0'),('user.friends.direction','1'),('user.friends.eligible','2'),('user.friends.lists','1'),('user.friends.verification','1'),('user.signup.adminemail','1'),('user.signup.approve','1'),('user.signup.checkemail','0'),('user.signup.inviteonly','0'),('user.signup.random','0'),('user.signup.terms','1'),('user.signup.username','0'),('user.signup.verifyemail','2'),('user.support.links','1'),('ynresponsive1.setuphomepage','1'),('yntheme.enabled','0');
/*!40000 ALTER TABLE `engine4_core_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_statistics`
--

DROP TABLE IF EXISTS `engine4_core_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_statistics` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_statistics`
--

LOCK TABLES `engine4_core_statistics` WRITE;
/*!40000 ALTER TABLE `engine4_core_statistics` DISABLE KEYS */;
INSERT INTO `engine4_core_statistics` VALUES ('core.comments','2016-05-04 07:00:00',1),('core.comments','2016-05-23 12:00:00',3),('core.comments','2016-06-06 10:00:00',2),('core.comments','2016-06-06 12:00:00',1),('core.comments','2016-06-07 11:00:00',1),('core.comments','2016-06-08 10:00:00',1),('core.comments','2016-06-09 06:00:00',1),('core.comments','2016-06-18 01:00:00',1),('core.comments','2016-06-20 05:00:00',1),('core.emails','2016-03-07 15:00:00',1),('core.emails','2016-03-30 14:00:00',1),('core.emails','2016-04-05 17:00:00',1),('core.emails','2016-04-18 21:00:00',1),('core.emails','2016-04-25 17:00:00',4),('core.emails','2016-04-25 18:00:00',5),('core.emails','2016-04-26 16:00:00',3),('core.emails','2016-04-26 19:00:00',1),('core.emails','2016-04-26 22:00:00',4),('core.emails','2016-04-26 23:00:00',2),('core.emails','2016-05-03 05:00:00',3),('core.emails','2016-05-03 07:00:00',3),('core.emails','2016-05-03 09:00:00',1),('core.emails','2016-05-03 12:00:00',3),('core.emails','2016-05-04 05:00:00',3),('core.emails','2016-05-04 07:00:00',3),('core.emails','2016-05-11 06:00:00',3),('core.emails','2016-05-11 07:00:00',3),('core.emails','2016-05-12 05:00:00',3),('core.emails','2016-05-13 11:00:00',3),('core.emails','2016-05-17 07:00:00',6),('core.emails','2016-05-18 05:00:00',3),('core.emails','2016-05-19 06:00:00',3),('core.emails','2016-05-19 08:00:00',6),('core.emails','2016-05-19 09:00:00',3),('core.emails','2016-05-20 12:00:00',8),('core.emails','2016-05-23 01:00:00',1),('core.emails','2016-05-23 06:00:00',6),('core.emails','2016-05-23 09:00:00',7),('core.emails','2016-05-23 10:00:00',14),('core.emails','2016-05-23 11:00:00',1),('core.emails','2016-05-23 12:00:00',23),('core.emails','2016-05-23 13:00:00',3),('core.emails','2016-05-24 06:00:00',5),('core.emails','2016-05-24 07:00:00',3),('core.emails','2016-05-24 08:00:00',6),('core.emails','2016-05-24 09:00:00',3),('core.emails','2016-05-24 11:00:00',4),('core.emails','2016-05-24 12:00:00',4),('core.emails','2016-05-25 05:00:00',2),('core.emails','2016-05-25 06:00:00',7),('core.emails','2016-05-25 07:00:00',8),('core.emails','2016-05-25 08:00:00',5),('core.emails','2016-05-25 10:00:00',2),('core.emails','2016-05-26 09:00:00',7),('core.emails','2016-05-26 10:00:00',1),('core.emails','2016-05-26 11:00:00',1),('core.emails','2016-05-27 06:00:00',4),('core.emails','2016-05-27 07:00:00',4),('core.emails','2016-05-27 08:00:00',3),('core.emails','2016-05-30 05:00:00',4),('core.emails','2016-05-30 12:00:00',6),('core.emails','2016-05-31 06:00:00',1),('core.emails','2016-05-31 07:00:00',3),('core.emails','2016-05-31 09:00:00',1),('core.emails','2016-05-31 12:00:00',5),('core.emails','2016-06-01 04:00:00',1),('core.emails','2016-06-02 07:00:00',4),('core.emails','2016-06-03 04:00:00',10),('core.emails','2016-06-06 10:00:00',2),('core.emails','2016-06-06 12:00:00',2),('core.emails','2016-06-07 09:00:00',6),('core.emails','2016-06-07 11:00:00',3),('core.emails','2016-06-08 10:00:00',3),('core.emails','2016-06-08 11:00:00',5),('core.emails','2016-06-08 12:00:00',7),('core.emails','2016-06-09 10:00:00',1),('core.emails','2016-06-09 11:00:00',1),('core.emails','2016-06-09 12:00:00',1),('core.emails','2016-06-10 06:00:00',2),('core.emails','2016-06-10 11:00:00',2),('core.emails','2016-06-10 13:00:00',2),('core.emails','2016-06-14 06:00:00',3),('core.emails','2016-06-14 07:00:00',5),('core.emails','2016-06-15 05:00:00',3),('core.emails','2016-06-15 11:00:00',3),('core.emails','2016-06-16 08:00:00',3),('core.emails','2016-06-16 09:00:00',1),('core.emails','2016-06-16 10:00:00',1),('core.emails','2016-06-16 11:00:00',5),('core.emails','2016-06-16 13:00:00',4),('core.emails','2016-06-17 04:00:00',4),('core.emails','2016-06-17 05:00:00',4),('core.emails','2016-06-17 06:00:00',7),('core.emails','2016-06-17 08:00:00',17),('core.emails','2016-06-17 09:00:00',6),('core.emails','2016-06-17 13:00:00',10),('core.emails','2016-06-17 15:00:00',2),('core.emails','2016-06-17 16:00:00',4),('core.emails','2016-06-18 01:00:00',1),('core.emails','2016-06-18 15:00:00',3),('core.emails','2016-06-19 22:00:00',1),('core.emails','2016-06-20 04:00:00',1),('core.emails','2016-06-20 05:00:00',11),('core.emails','2016-06-20 07:00:00',6),('core.emails','2016-06-20 08:00:00',3),('core.emails','2016-06-20 10:00:00',8),('core.emails','2016-06-20 11:00:00',10),('core.emails','2016-06-20 12:00:00',6),('core.likes','2016-03-29 17:00:00',1),('core.likes','2016-04-25 18:00:00',1),('core.likes','2016-04-26 22:00:00',1),('core.likes','2016-05-04 07:00:00',2),('core.likes','2016-05-19 08:00:00',1),('core.likes','2016-05-23 09:00:00',1),('core.likes','2016-05-23 10:00:00',6),('core.likes','2016-05-23 12:00:00',7),('core.likes','2016-05-24 08:00:00',1),('core.likes','2016-05-24 11:00:00',4),('core.likes','2016-05-25 05:00:00',1),('core.likes','2016-05-25 06:00:00',1),('core.likes','2016-05-25 07:00:00',2),('core.likes','2016-05-26 11:00:00',1),('core.likes','2016-05-27 08:00:00',2),('core.likes','2016-05-30 05:00:00',1),('core.likes','2016-05-30 12:00:00',1),('core.likes','2016-05-31 12:00:00',1),('core.likes','2016-06-06 10:00:00',1),('core.likes','2016-06-06 12:00:00',2),('core.likes','2016-06-07 09:00:00',1),('core.likes','2016-06-07 11:00:00',1),('core.likes','2016-06-08 10:00:00',1),('core.likes','2016-06-20 05:00:00',1),('core.reports','2016-05-25 05:00:00',1),('core.views','2016-03-06 01:00:00',37),('core.views','2016-03-06 02:00:00',9),('core.views','2016-03-06 03:00:00',4),('core.views','2016-03-06 04:00:00',10),('core.views','2016-03-06 05:00:00',12),('core.views','2016-03-06 10:00:00',3),('core.views','2016-03-06 11:00:00',5),('core.views','2016-03-06 16:00:00',1),('core.views','2016-03-06 17:00:00',10),('core.views','2016-03-06 18:00:00',12),('core.views','2016-03-06 19:00:00',1),('core.views','2016-03-06 23:00:00',15),('core.views','2016-03-07 01:00:00',6),('core.views','2016-03-07 04:00:00',1),('core.views','2016-03-07 05:00:00',5),('core.views','2016-03-07 06:00:00',1),('core.views','2016-03-07 09:00:00',2),('core.views','2016-03-07 10:00:00',1),('core.views','2016-03-07 14:00:00',1),('core.views','2016-03-07 15:00:00',11),('core.views','2016-03-07 16:00:00',17),('core.views','2016-03-07 19:00:00',2),('core.views','2016-03-07 20:00:00',24),('core.views','2016-03-07 21:00:00',10),('core.views','2016-03-07 22:00:00',11),('core.views','2016-03-07 23:00:00',1),('core.views','2016-03-08 02:00:00',11),('core.views','2016-03-08 03:00:00',9),('core.views','2016-03-08 04:00:00',10),('core.views','2016-03-08 05:00:00',3),('core.views','2016-03-08 06:00:00',5),('core.views','2016-03-08 07:00:00',3),('core.views','2016-03-08 10:00:00',1),('core.views','2016-03-08 13:00:00',1),('core.views','2016-03-08 14:00:00',3),('core.views','2016-03-08 17:00:00',34),('core.views','2016-03-08 18:00:00',26),('core.views','2016-03-08 19:00:00',5),('core.views','2016-03-08 20:00:00',4),('core.views','2016-03-09 01:00:00',2),('core.views','2016-03-09 09:00:00',9),('core.views','2016-03-09 12:00:00',1),('core.views','2016-03-09 16:00:00',11),('core.views','2016-03-09 21:00:00',1),('core.views','2016-03-10 01:00:00',3),('core.views','2016-03-10 04:00:00',2),('core.views','2016-03-10 05:00:00',2),('core.views','2016-03-10 08:00:00',1),('core.views','2016-03-10 09:00:00',4),('core.views','2016-03-10 11:00:00',37),('core.views','2016-03-10 12:00:00',1),('core.views','2016-03-10 14:00:00',1),('core.views','2016-03-10 20:00:00',2),('core.views','2016-03-10 21:00:00',12),('core.views','2016-03-10 22:00:00',3),('core.views','2016-03-10 23:00:00',1),('core.views','2016-03-11 02:00:00',1),('core.views','2016-03-11 07:00:00',24),('core.views','2016-03-11 10:00:00',4),('core.views','2016-03-11 11:00:00',4),('core.views','2016-03-11 12:00:00',1),('core.views','2016-03-11 13:00:00',2),('core.views','2016-03-11 17:00:00',2),('core.views','2016-03-11 19:00:00',2),('core.views','2016-03-11 22:00:00',2),('core.views','2016-03-11 23:00:00',2),('core.views','2016-03-12 00:00:00',3),('core.views','2016-03-12 01:00:00',4),('core.views','2016-03-12 02:00:00',1),('core.views','2016-03-12 03:00:00',6),('core.views','2016-03-12 06:00:00',2),('core.views','2016-03-12 10:00:00',4),('core.views','2016-03-12 11:00:00',2),('core.views','2016-03-12 12:00:00',16),('core.views','2016-03-12 14:00:00',2),('core.views','2016-03-12 16:00:00',18),('core.views','2016-03-12 22:00:00',2),('core.views','2016-03-12 23:00:00',1),('core.views','2016-03-13 01:00:00',1),('core.views','2016-03-13 02:00:00',1),('core.views','2016-03-13 05:00:00',1),('core.views','2016-03-13 07:00:00',2),('core.views','2016-03-13 08:00:00',1),('core.views','2016-03-13 13:00:00',2),('core.views','2016-03-13 19:00:00',1),('core.views','2016-03-13 20:00:00',1),('core.views','2016-03-13 23:00:00',1),('core.views','2016-03-14 04:00:00',2),('core.views','2016-03-14 06:00:00',1),('core.views','2016-03-14 07:00:00',7),('core.views','2016-03-14 09:00:00',1),('core.views','2016-03-14 11:00:00',2),('core.views','2016-03-14 12:00:00',1),('core.views','2016-03-14 17:00:00',3),('core.views','2016-03-14 18:00:00',1),('core.views','2016-03-14 19:00:00',47),('core.views','2016-03-14 20:00:00',130),('core.views','2016-03-14 21:00:00',37),('core.views','2016-03-14 23:00:00',1),('core.views','2016-03-15 00:00:00',2),('core.views','2016-03-15 03:00:00',4),('core.views','2016-03-15 04:00:00',9),('core.views','2016-03-15 05:00:00',19),('core.views','2016-03-15 07:00:00',2),('core.views','2016-03-15 10:00:00',5),('core.views','2016-03-15 11:00:00',1),('core.views','2016-03-15 12:00:00',2),('core.views','2016-03-15 13:00:00',1),('core.views','2016-03-15 14:00:00',25),('core.views','2016-03-15 15:00:00',27),('core.views','2016-03-15 16:00:00',83),('core.views','2016-03-15 17:00:00',31),('core.views','2016-03-15 18:00:00',1),('core.views','2016-03-15 19:00:00',13),('core.views','2016-03-15 21:00:00',13),('core.views','2016-03-15 22:00:00',7),('core.views','2016-03-15 23:00:00',3),('core.views','2016-03-16 01:00:00',5),('core.views','2016-03-16 03:00:00',1),('core.views','2016-03-16 05:00:00',2),('core.views','2016-03-16 06:00:00',3),('core.views','2016-03-16 08:00:00',2),('core.views','2016-03-16 09:00:00',2),('core.views','2016-03-16 10:00:00',2),('core.views','2016-03-16 12:00:00',1),('core.views','2016-03-16 13:00:00',19),('core.views','2016-03-16 14:00:00',25),('core.views','2016-03-16 17:00:00',1),('core.views','2016-03-16 20:00:00',5),('core.views','2016-03-16 22:00:00',1),('core.views','2016-03-16 23:00:00',30),('core.views','2016-03-17 01:00:00',2),('core.views','2016-03-17 02:00:00',2),('core.views','2016-03-17 04:00:00',1),('core.views','2016-03-17 05:00:00',3),('core.views','2016-03-17 08:00:00',5),('core.views','2016-03-17 09:00:00',1),('core.views','2016-03-17 10:00:00',1),('core.views','2016-03-17 11:00:00',3),('core.views','2016-03-17 13:00:00',15),('core.views','2016-03-17 15:00:00',1),('core.views','2016-03-17 20:00:00',2),('core.views','2016-03-17 21:00:00',2),('core.views','2016-03-17 23:00:00',4),('core.views','2016-03-18 02:00:00',1),('core.views','2016-03-18 03:00:00',2),('core.views','2016-03-18 04:00:00',1),('core.views','2016-03-18 06:00:00',3),('core.views','2016-03-18 07:00:00',2),('core.views','2016-03-18 08:00:00',1),('core.views','2016-03-18 11:00:00',2),('core.views','2016-03-18 12:00:00',2),('core.views','2016-03-18 13:00:00',4),('core.views','2016-03-18 14:00:00',1),('core.views','2016-03-18 15:00:00',6),('core.views','2016-03-18 16:00:00',3),('core.views','2016-03-18 17:00:00',3),('core.views','2016-03-18 20:00:00',1),('core.views','2016-03-18 23:00:00',2),('core.views','2016-03-19 00:00:00',5),('core.views','2016-03-19 01:00:00',2),('core.views','2016-03-19 03:00:00',1),('core.views','2016-03-19 04:00:00',3),('core.views','2016-03-19 06:00:00',2),('core.views','2016-03-19 09:00:00',1),('core.views','2016-03-19 19:00:00',1),('core.views','2016-03-19 20:00:00',1),('core.views','2016-03-19 22:00:00',1),('core.views','2016-03-19 23:00:00',2),('core.views','2016-03-20 00:00:00',4),('core.views','2016-03-20 01:00:00',1),('core.views','2016-03-20 03:00:00',1),('core.views','2016-03-20 05:00:00',1),('core.views','2016-03-20 06:00:00',1),('core.views','2016-03-20 07:00:00',1),('core.views','2016-03-20 09:00:00',3),('core.views','2016-03-20 12:00:00',1),('core.views','2016-03-20 15:00:00',1),('core.views','2016-03-20 16:00:00',1),('core.views','2016-03-20 17:00:00',1),('core.views','2016-03-20 22:00:00',2),('core.views','2016-03-21 01:00:00',1),('core.views','2016-03-21 03:00:00',1),('core.views','2016-03-21 08:00:00',1),('core.views','2016-03-21 21:00:00',1),('core.views','2016-03-22 05:00:00',1),('core.views','2016-03-24 14:00:00',1),('core.views','2016-03-24 19:00:00',1),('core.views','2016-03-24 23:00:00',2),('core.views','2016-03-26 01:00:00',1),('core.views','2016-03-26 20:00:00',1),('core.views','2016-03-26 21:00:00',1),('core.views','2016-03-27 21:00:00',1),('core.views','2016-03-28 01:00:00',1),('core.views','2016-03-28 02:00:00',1),('core.views','2016-03-28 03:00:00',2),('core.views','2016-03-28 04:00:00',5),('core.views','2016-03-28 05:00:00',3),('core.views','2016-03-28 08:00:00',1),('core.views','2016-03-28 09:00:00',2),('core.views','2016-03-28 13:00:00',19),('core.views','2016-03-28 14:00:00',13),('core.views','2016-03-28 17:00:00',13),('core.views','2016-03-28 18:00:00',5),('core.views','2016-03-28 19:00:00',30),('core.views','2016-03-28 20:00:00',5),('core.views','2016-03-28 21:00:00',11),('core.views','2016-03-28 22:00:00',11),('core.views','2016-03-29 02:00:00',9),('core.views','2016-03-29 05:00:00',14),('core.views','2016-03-29 10:00:00',1),('core.views','2016-03-29 13:00:00',1),('core.views','2016-03-29 14:00:00',10),('core.views','2016-03-29 15:00:00',55),('core.views','2016-03-29 16:00:00',15),('core.views','2016-03-29 17:00:00',34),('core.views','2016-03-29 19:00:00',16),('core.views','2016-03-29 20:00:00',5),('core.views','2016-03-29 21:00:00',4),('core.views','2016-03-29 23:00:00',1),('core.views','2016-03-30 02:00:00',1),('core.views','2016-03-30 04:00:00',5),('core.views','2016-03-30 05:00:00',2),('core.views','2016-03-30 06:00:00',2),('core.views','2016-03-30 08:00:00',1),('core.views','2016-03-30 09:00:00',5),('core.views','2016-03-30 13:00:00',26),('core.views','2016-03-30 14:00:00',25),('core.views','2016-03-30 15:00:00',1),('core.views','2016-03-30 16:00:00',5),('core.views','2016-03-30 17:00:00',10),('core.views','2016-03-30 21:00:00',8),('core.views','2016-03-30 22:00:00',3),('core.views','2016-03-30 23:00:00',4),('core.views','2016-03-31 04:00:00',1),('core.views','2016-03-31 11:00:00',1),('core.views','2016-03-31 13:00:00',10),('core.views','2016-03-31 14:00:00',1),('core.views','2016-03-31 16:00:00',10),('core.views','2016-03-31 17:00:00',9),('core.views','2016-03-31 19:00:00',10),('core.views','2016-03-31 20:00:00',1),('core.views','2016-03-31 21:00:00',6),('core.views','2016-03-31 22:00:00',1),('core.views','2016-03-31 23:00:00',25),('core.views','2016-04-01 00:00:00',9),('core.views','2016-04-01 01:00:00',13),('core.views','2016-04-01 11:00:00',1),('core.views','2016-04-01 16:00:00',1),('core.views','2016-04-01 19:00:00',2),('core.views','2016-04-01 20:00:00',2),('core.views','2016-04-01 22:00:00',8),('core.views','2016-04-01 23:00:00',7),('core.views','2016-04-02 00:00:00',1),('core.views','2016-04-02 01:00:00',2),('core.views','2016-04-02 02:00:00',3),('core.views','2016-04-02 03:00:00',7),('core.views','2016-04-02 06:00:00',2),('core.views','2016-04-02 09:00:00',2),('core.views','2016-04-02 10:00:00',6),('core.views','2016-04-02 12:00:00',1),('core.views','2016-04-02 14:00:00',20),('core.views','2016-04-02 16:00:00',1),('core.views','2016-04-02 19:00:00',15),('core.views','2016-04-02 20:00:00',2),('core.views','2016-04-02 21:00:00',4),('core.views','2016-04-02 22:00:00',1),('core.views','2016-04-03 00:00:00',22),('core.views','2016-04-03 02:00:00',3),('core.views','2016-04-03 03:00:00',1),('core.views','2016-04-03 05:00:00',1),('core.views','2016-04-03 07:00:00',2),('core.views','2016-04-03 08:00:00',5),('core.views','2016-04-03 09:00:00',3),('core.views','2016-04-03 10:00:00',4),('core.views','2016-04-03 11:00:00',4),('core.views','2016-04-03 12:00:00',5),('core.views','2016-04-03 13:00:00',1),('core.views','2016-04-03 14:00:00',1),('core.views','2016-04-03 16:00:00',2),('core.views','2016-04-03 18:00:00',1),('core.views','2016-04-03 19:00:00',5),('core.views','2016-04-03 20:00:00',6),('core.views','2016-04-03 22:00:00',10),('core.views','2016-04-03 23:00:00',2),('core.views','2016-04-04 01:00:00',4),('core.views','2016-04-04 02:00:00',3),('core.views','2016-04-04 03:00:00',5),('core.views','2016-04-04 05:00:00',1),('core.views','2016-04-04 06:00:00',2),('core.views','2016-04-04 07:00:00',1),('core.views','2016-04-04 08:00:00',1),('core.views','2016-04-04 09:00:00',2),('core.views','2016-04-04 11:00:00',3),('core.views','2016-04-04 12:00:00',2),('core.views','2016-04-04 13:00:00',5),('core.views','2016-04-04 14:00:00',1),('core.views','2016-04-04 15:00:00',1),('core.views','2016-04-04 16:00:00',6),('core.views','2016-04-04 17:00:00',9),('core.views','2016-04-04 18:00:00',21),('core.views','2016-04-04 19:00:00',6),('core.views','2016-04-04 20:00:00',6),('core.views','2016-04-04 21:00:00',11),('core.views','2016-04-04 22:00:00',2),('core.views','2016-04-04 23:00:00',3),('core.views','2016-04-05 02:00:00',6),('core.views','2016-04-05 03:00:00',1),('core.views','2016-04-05 06:00:00',1),('core.views','2016-04-05 07:00:00',4),('core.views','2016-04-05 10:00:00',2),('core.views','2016-04-05 11:00:00',1),('core.views','2016-04-05 13:00:00',7),('core.views','2016-04-05 14:00:00',2),('core.views','2016-04-05 15:00:00',6),('core.views','2016-04-05 16:00:00',11),('core.views','2016-04-05 17:00:00',22),('core.views','2016-04-05 18:00:00',6),('core.views','2016-04-05 21:00:00',4),('core.views','2016-04-05 23:00:00',1),('core.views','2016-04-06 00:00:00',3),('core.views','2016-04-06 01:00:00',3),('core.views','2016-04-06 03:00:00',1),('core.views','2016-04-06 05:00:00',2),('core.views','2016-04-06 07:00:00',20),('core.views','2016-04-06 08:00:00',11),('core.views','2016-04-06 09:00:00',11),('core.views','2016-04-06 10:00:00',10),('core.views','2016-04-06 11:00:00',18),('core.views','2016-04-06 12:00:00',21),('core.views','2016-04-06 14:00:00',2),('core.views','2016-04-06 15:00:00',3),('core.views','2016-04-06 16:00:00',14),('core.views','2016-04-06 17:00:00',9),('core.views','2016-04-06 18:00:00',2),('core.views','2016-04-06 19:00:00',18),('core.views','2016-04-06 20:00:00',3),('core.views','2016-04-06 21:00:00',1),('core.views','2016-04-06 22:00:00',19),('core.views','2016-04-06 23:00:00',3),('core.views','2016-04-07 00:00:00',18),('core.views','2016-04-07 01:00:00',6),('core.views','2016-04-07 02:00:00',3),('core.views','2016-04-07 03:00:00',13),('core.views','2016-04-07 05:00:00',7),('core.views','2016-04-07 08:00:00',4),('core.views','2016-04-07 10:00:00',2),('core.views','2016-04-07 12:00:00',2),('core.views','2016-04-07 13:00:00',47),('core.views','2016-04-07 14:00:00',5),('core.views','2016-04-07 15:00:00',1),('core.views','2016-04-07 16:00:00',4),('core.views','2016-04-07 20:00:00',1),('core.views','2016-04-07 21:00:00',1),('core.views','2016-04-07 23:00:00',1),('core.views','2016-04-08 00:00:00',1),('core.views','2016-04-08 01:00:00',1),('core.views','2016-04-08 02:00:00',35),('core.views','2016-04-08 04:00:00',1),('core.views','2016-04-08 05:00:00',1),('core.views','2016-04-08 07:00:00',1),('core.views','2016-04-08 09:00:00',1),('core.views','2016-04-08 10:00:00',1),('core.views','2016-04-08 11:00:00',1),('core.views','2016-04-08 13:00:00',1),('core.views','2016-04-08 14:00:00',2),('core.views','2016-04-08 16:00:00',1),('core.views','2016-04-08 18:00:00',1),('core.views','2016-04-08 19:00:00',2),('core.views','2016-04-08 20:00:00',1),('core.views','2016-04-08 22:00:00',3),('core.views','2016-04-09 00:00:00',2),('core.views','2016-04-09 01:00:00',1),('core.views','2016-04-09 04:00:00',1),('core.views','2016-04-09 05:00:00',2),('core.views','2016-04-09 07:00:00',3),('core.views','2016-04-09 10:00:00',1),('core.views','2016-04-09 11:00:00',1),('core.views','2016-04-09 12:00:00',1),('core.views','2016-04-09 13:00:00',1),('core.views','2016-04-09 16:00:00',2),('core.views','2016-04-09 17:00:00',2),('core.views','2016-04-09 19:00:00',1),('core.views','2016-04-09 20:00:00',1),('core.views','2016-04-09 22:00:00',2),('core.views','2016-04-09 23:00:00',5),('core.views','2016-04-10 00:00:00',1),('core.views','2016-04-10 03:00:00',7),('core.views','2016-04-10 05:00:00',1),('core.views','2016-04-10 09:00:00',2),('core.views','2016-04-10 10:00:00',2),('core.views','2016-04-10 12:00:00',1),('core.views','2016-04-10 13:00:00',2),('core.views','2016-04-10 18:00:00',1),('core.views','2016-04-10 20:00:00',1),('core.views','2016-04-10 22:00:00',1),('core.views','2016-04-10 23:00:00',5),('core.views','2016-04-11 00:00:00',3),('core.views','2016-04-11 03:00:00',2),('core.views','2016-04-11 04:00:00',1),('core.views','2016-04-11 06:00:00',3),('core.views','2016-04-11 07:00:00',1),('core.views','2016-04-11 10:00:00',1),('core.views','2016-04-11 12:00:00',1),('core.views','2016-04-11 14:00:00',4),('core.views','2016-04-11 15:00:00',1),('core.views','2016-04-11 18:00:00',1),('core.views','2016-04-11 19:00:00',2),('core.views','2016-04-11 21:00:00',3),('core.views','2016-04-11 22:00:00',1),('core.views','2016-04-12 01:00:00',4),('core.views','2016-04-12 02:00:00',5),('core.views','2016-04-12 04:00:00',2),('core.views','2016-04-12 05:00:00',1),('core.views','2016-04-12 06:00:00',1),('core.views','2016-04-12 07:00:00',1),('core.views','2016-04-12 08:00:00',3),('core.views','2016-04-12 11:00:00',3),('core.views','2016-04-12 12:00:00',1),('core.views','2016-04-12 13:00:00',1),('core.views','2016-04-12 16:00:00',1),('core.views','2016-04-12 17:00:00',1),('core.views','2016-04-12 18:00:00',1),('core.views','2016-04-12 19:00:00',1),('core.views','2016-04-12 23:00:00',1),('core.views','2016-04-13 00:00:00',6),('core.views','2016-04-13 01:00:00',3),('core.views','2016-04-13 03:00:00',1),('core.views','2016-04-13 05:00:00',1),('core.views','2016-04-13 08:00:00',1),('core.views','2016-04-13 09:00:00',1),('core.views','2016-04-13 12:00:00',3),('core.views','2016-04-13 13:00:00',2),('core.views','2016-04-13 16:00:00',1),('core.views','2016-04-13 17:00:00',4),('core.views','2016-04-13 18:00:00',3),('core.views','2016-04-13 19:00:00',4),('core.views','2016-04-13 20:00:00',3),('core.views','2016-04-13 21:00:00',3),('core.views','2016-04-14 00:00:00',1),('core.views','2016-04-14 01:00:00',10),('core.views','2016-04-14 03:00:00',1),('core.views','2016-04-14 04:00:00',6),('core.views','2016-04-14 07:00:00',1),('core.views','2016-04-14 09:00:00',1),('core.views','2016-04-14 10:00:00',2),('core.views','2016-04-14 12:00:00',3),('core.views','2016-04-14 16:00:00',14),('core.views','2016-04-14 18:00:00',4),('core.views','2016-04-14 20:00:00',1),('core.views','2016-04-14 21:00:00',1),('core.views','2016-04-14 22:00:00',2),('core.views','2016-04-14 23:00:00',3),('core.views','2016-04-15 00:00:00',1),('core.views','2016-04-15 01:00:00',1),('core.views','2016-04-15 02:00:00',1),('core.views','2016-04-15 03:00:00',1),('core.views','2016-04-15 04:00:00',3),('core.views','2016-04-15 05:00:00',1),('core.views','2016-04-15 08:00:00',1),('core.views','2016-04-15 09:00:00',3),('core.views','2016-04-15 12:00:00',1),('core.views','2016-04-15 13:00:00',16),('core.views','2016-04-15 15:00:00',1),('core.views','2016-04-15 16:00:00',9),('core.views','2016-04-15 18:00:00',1),('core.views','2016-04-15 19:00:00',5),('core.views','2016-04-15 20:00:00',4),('core.views','2016-04-15 21:00:00',1),('core.views','2016-04-15 23:00:00',1),('core.views','2016-04-16 01:00:00',1),('core.views','2016-04-16 02:00:00',5),('core.views','2016-04-16 09:00:00',1),('core.views','2016-04-16 11:00:00',1),('core.views','2016-04-16 13:00:00',15),('core.views','2016-04-16 15:00:00',1),('core.views','2016-04-16 16:00:00',3),('core.views','2016-04-16 19:00:00',4),('core.views','2016-04-16 21:00:00',1),('core.views','2016-04-16 23:00:00',3),('core.views','2016-04-17 00:00:00',2),('core.views','2016-04-17 01:00:00',2),('core.views','2016-04-17 03:00:00',7),('core.views','2016-04-17 06:00:00',1),('core.views','2016-04-17 11:00:00',1),('core.views','2016-04-17 13:00:00',1),('core.views','2016-04-17 14:00:00',3),('core.views','2016-04-17 15:00:00',3),('core.views','2016-04-17 16:00:00',13),('core.views','2016-04-17 17:00:00',13),('core.views','2016-04-17 18:00:00',3),('core.views','2016-04-17 19:00:00',1),('core.views','2016-04-17 20:00:00',3),('core.views','2016-04-17 21:00:00',12),('core.views','2016-04-17 22:00:00',3),('core.views','2016-04-17 23:00:00',1),('core.views','2016-04-18 01:00:00',1),('core.views','2016-04-18 02:00:00',1),('core.views','2016-04-18 03:00:00',1),('core.views','2016-04-18 07:00:00',1),('core.views','2016-04-18 08:00:00',1),('core.views','2016-04-18 11:00:00',3),('core.views','2016-04-18 12:00:00',4),('core.views','2016-04-18 15:00:00',11),('core.views','2016-04-18 16:00:00',1),('core.views','2016-04-18 17:00:00',1),('core.views','2016-04-18 19:00:00',7),('core.views','2016-04-18 21:00:00',19),('core.views','2016-04-18 22:00:00',3),('core.views','2016-04-18 23:00:00',1),('core.views','2016-04-19 01:00:00',1),('core.views','2016-04-19 06:00:00',3),('core.views','2016-04-19 07:00:00',1),('core.views','2016-04-19 09:00:00',1),('core.views','2016-04-19 13:00:00',2),('core.views','2016-04-19 15:00:00',1),('core.views','2016-04-19 16:00:00',2),('core.views','2016-04-19 17:00:00',3),('core.views','2016-04-19 18:00:00',22),('core.views','2016-04-19 19:00:00',1),('core.views','2016-04-19 21:00:00',1),('core.views','2016-04-19 22:00:00',9),('core.views','2016-04-19 23:00:00',1),('core.views','2016-04-20 03:00:00',1),('core.views','2016-04-20 05:00:00',8),('core.views','2016-04-20 09:00:00',3),('core.views','2016-04-20 11:00:00',1),('core.views','2016-04-20 13:00:00',1),('core.views','2016-04-20 14:00:00',1),('core.views','2016-04-20 16:00:00',1),('core.views','2016-04-20 17:00:00',6),('core.views','2016-04-20 18:00:00',2),('core.views','2016-04-20 19:00:00',2),('core.views','2016-04-20 20:00:00',2),('core.views','2016-04-20 22:00:00',3),('core.views','2016-04-21 00:00:00',1),('core.views','2016-04-21 02:00:00',2),('core.views','2016-04-21 03:00:00',2),('core.views','2016-04-21 05:00:00',1),('core.views','2016-04-21 06:00:00',1),('core.views','2016-04-21 07:00:00',1),('core.views','2016-04-21 09:00:00',2),('core.views','2016-04-21 12:00:00',3),('core.views','2016-04-21 16:00:00',2),('core.views','2016-04-21 19:00:00',1),('core.views','2016-04-21 20:00:00',1),('core.views','2016-04-21 22:00:00',5),('core.views','2016-04-22 00:00:00',2),('core.views','2016-04-22 04:00:00',2),('core.views','2016-04-22 06:00:00',2),('core.views','2016-04-22 07:00:00',13),('core.views','2016-04-22 12:00:00',6),('core.views','2016-04-22 14:00:00',13),('core.views','2016-04-22 16:00:00',3),('core.views','2016-04-22 17:00:00',7),('core.views','2016-04-22 18:00:00',8),('core.views','2016-04-22 19:00:00',21),('core.views','2016-04-22 21:00:00',1),('core.views','2016-04-22 23:00:00',3),('core.views','2016-04-23 05:00:00',1),('core.views','2016-04-23 06:00:00',11),('core.views','2016-04-23 08:00:00',6),('core.views','2016-04-23 09:00:00',1),('core.views','2016-04-23 11:00:00',2),('core.views','2016-04-23 13:00:00',2),('core.views','2016-04-23 22:00:00',2),('core.views','2016-04-23 23:00:00',6),('core.views','2016-04-24 00:00:00',1),('core.views','2016-04-24 06:00:00',1),('core.views','2016-04-24 11:00:00',7),('core.views','2016-04-24 13:00:00',3),('core.views','2016-04-24 14:00:00',1),('core.views','2016-04-24 18:00:00',6),('core.views','2016-04-24 19:00:00',5),('core.views','2016-04-24 20:00:00',12),('core.views','2016-04-24 21:00:00',22),('core.views','2016-04-24 22:00:00',23),('core.views','2016-04-25 00:00:00',1),('core.views','2016-04-25 01:00:00',2),('core.views','2016-04-25 02:00:00',1),('core.views','2016-04-25 04:00:00',10),('core.views','2016-04-25 05:00:00',7),('core.views','2016-04-25 07:00:00',12),('core.views','2016-04-25 08:00:00',1),('core.views','2016-04-25 11:00:00',3),('core.views','2016-04-25 13:00:00',16),('core.views','2016-04-25 14:00:00',4),('core.views','2016-04-25 15:00:00',7),('core.views','2016-04-25 16:00:00',1),('core.views','2016-04-25 17:00:00',58),('core.views','2016-04-25 18:00:00',50),('core.views','2016-04-25 19:00:00',51),('core.views','2016-04-25 20:00:00',76),('core.views','2016-04-25 21:00:00',33),('core.views','2016-04-25 23:00:00',40),('core.views','2016-04-26 00:00:00',32),('core.views','2016-04-26 01:00:00',68),('core.views','2016-04-26 02:00:00',8),('core.views','2016-04-26 03:00:00',2),('core.views','2016-04-26 06:00:00',3),('core.views','2016-04-26 12:00:00',19),('core.views','2016-04-26 13:00:00',42),('core.views','2016-04-26 14:00:00',43),('core.views','2016-04-26 15:00:00',11),('core.views','2016-04-26 16:00:00',58),('core.views','2016-04-26 17:00:00',40),('core.views','2016-04-26 18:00:00',19),('core.views','2016-04-26 19:00:00',58),('core.views','2016-04-26 21:00:00',13),('core.views','2016-04-26 22:00:00',102),('core.views','2016-04-26 23:00:00',75),('core.views','2016-04-27 00:00:00',6),('core.views','2016-04-27 01:00:00',16),('core.views','2016-04-27 02:00:00',29),('core.views','2016-04-27 05:00:00',11),('core.views','2016-04-27 07:00:00',9),('core.views','2016-04-27 11:00:00',16),('core.views','2016-04-27 12:00:00',1),('core.views','2016-04-27 13:00:00',12),('core.views','2016-04-27 14:00:00',18),('core.views','2016-04-27 16:00:00',1),('core.views','2016-04-27 18:00:00',7),('core.views','2016-04-27 19:00:00',40),('core.views','2016-04-27 20:00:00',14),('core.views','2016-04-27 21:00:00',29),('core.views','2016-04-27 23:00:00',12),('core.views','2016-04-28 00:00:00',3),('core.views','2016-04-28 01:00:00',2),('core.views','2016-04-28 02:00:00',6),('core.views','2016-04-28 03:00:00',27),('core.views','2016-04-28 05:00:00',2),('core.views','2016-04-28 07:00:00',22),('core.views','2016-04-28 10:00:00',2),('core.views','2016-04-28 11:00:00',25),('core.views','2016-04-28 13:00:00',2),('core.views','2016-04-28 14:00:00',11),('core.views','2016-04-28 16:00:00',9),('core.views','2016-05-01 18:00:00',8),('core.views','2016-05-02 04:00:00',13),('core.views','2016-05-02 06:00:00',37),('core.views','2016-05-02 07:00:00',13),('core.views','2016-05-02 08:00:00',16),('core.views','2016-05-02 09:00:00',17),('core.views','2016-05-02 10:00:00',13),('core.views','2016-05-02 11:00:00',2),('core.views','2016-05-02 12:00:00',13),('core.views','2016-05-02 18:00:00',5),('core.views','2016-05-02 21:00:00',5),('core.views','2016-05-03 04:00:00',16),('core.views','2016-05-03 05:00:00',11),('core.views','2016-05-03 06:00:00',14),('core.views','2016-05-03 07:00:00',36),('core.views','2016-05-03 08:00:00',1),('core.views','2016-05-03 09:00:00',14),('core.views','2016-05-03 11:00:00',2),('core.views','2016-05-03 12:00:00',27),('core.views','2016-05-03 14:00:00',5),('core.views','2016-05-04 01:00:00',6),('core.views','2016-05-04 04:00:00',46),('core.views','2016-05-04 05:00:00',15),('core.views','2016-05-04 06:00:00',1),('core.views','2016-05-04 07:00:00',12),('core.views','2016-05-04 08:00:00',5),('core.views','2016-05-04 10:00:00',3),('core.views','2016-05-04 11:00:00',12),('core.views','2016-05-04 12:00:00',7),('core.views','2016-05-04 13:00:00',3),('core.views','2016-05-04 14:00:00',1),('core.views','2016-05-05 10:00:00',4),('core.views','2016-05-05 11:00:00',22),('core.views','2016-05-06 04:00:00',1),('core.views','2016-05-06 10:00:00',2),('core.views','2016-05-06 18:00:00',10),('core.views','2016-05-06 20:00:00',6),('core.views','2016-05-06 21:00:00',3),('core.views','2016-05-07 05:00:00',11),('core.views','2016-05-09 04:00:00',2),('core.views','2016-05-09 19:00:00',5),('core.views','2016-05-10 04:00:00',5),('core.views','2016-05-10 13:00:00',5),('core.views','2016-05-10 17:00:00',5),('core.views','2016-05-11 04:00:00',15),('core.views','2016-05-11 05:00:00',5),('core.views','2016-05-11 06:00:00',25),('core.views','2016-05-11 07:00:00',14),('core.views','2016-05-11 10:00:00',4),('core.views','2016-05-11 11:00:00',2),('core.views','2016-05-11 12:00:00',10),('core.views','2016-05-11 14:00:00',9),('core.views','2016-05-12 04:00:00',17),('core.views','2016-05-12 05:00:00',17),('core.views','2016-05-12 07:00:00',17),('core.views','2016-05-12 13:00:00',4),('core.views','2016-05-12 14:00:00',16),('core.views','2016-05-12 15:00:00',7),('core.views','2016-05-13 08:00:00',15),('core.views','2016-05-13 09:00:00',8),('core.views','2016-05-13 10:00:00',12),('core.views','2016-05-13 11:00:00',24),('core.views','2016-05-13 13:00:00',4),('core.views','2016-05-13 14:00:00',2),('core.views','2016-05-13 15:00:00',1),('core.views','2016-05-13 20:00:00',2),('core.views','2016-05-16 15:00:00',1),('core.views','2016-05-17 04:00:00',1),('core.views','2016-05-17 05:00:00',12),('core.views','2016-05-17 07:00:00',36),('core.views','2016-05-17 08:00:00',1),('core.views','2016-05-18 04:00:00',9),('core.views','2016-05-18 05:00:00',65),('core.views','2016-05-18 06:00:00',7),('core.views','2016-05-18 07:00:00',1),('core.views','2016-05-18 08:00:00',1),('core.views','2016-05-18 10:00:00',1),('core.views','2016-05-18 11:00:00',1),('core.views','2016-05-18 12:00:00',10),('core.views','2016-05-19 03:00:00',1),('core.views','2016-05-19 04:00:00',5),('core.views','2016-05-19 05:00:00',6),('core.views','2016-05-19 06:00:00',16),('core.views','2016-05-19 07:00:00',48),('core.views','2016-05-19 08:00:00',36),('core.views','2016-05-19 09:00:00',29),('core.views','2016-05-19 10:00:00',4),('core.views','2016-05-19 11:00:00',29),('core.views','2016-05-19 12:00:00',14),('core.views','2016-05-19 13:00:00',17),('core.views','2016-05-19 14:00:00',12),('core.views','2016-05-20 04:00:00',3),('core.views','2016-05-20 07:00:00',28),('core.views','2016-05-20 09:00:00',24),('core.views','2016-05-20 11:00:00',31),('core.views','2016-05-20 12:00:00',26),('core.views','2016-05-20 13:00:00',5),('core.views','2016-05-22 02:00:00',21),('core.views','2016-05-22 10:00:00',15),('core.views','2016-05-22 22:00:00',5),('core.views','2016-05-23 00:00:00',4),('core.views','2016-05-23 01:00:00',17),('core.views','2016-05-23 04:00:00',41),('core.views','2016-05-23 05:00:00',50),('core.views','2016-05-23 06:00:00',75),('core.views','2016-05-23 07:00:00',43),('core.views','2016-05-23 08:00:00',9),('core.views','2016-05-23 09:00:00',45),('core.views','2016-05-23 10:00:00',72),('core.views','2016-05-23 11:00:00',82),('core.views','2016-05-23 12:00:00',73),('core.views','2016-05-23 13:00:00',28),('core.views','2016-05-23 23:00:00',1),('core.views','2016-05-24 00:00:00',11),('core.views','2016-05-24 02:00:00',3),('core.views','2016-05-24 04:00:00',58),('core.views','2016-05-24 05:00:00',1),('core.views','2016-05-24 06:00:00',60),('core.views','2016-05-24 07:00:00',82),('core.views','2016-05-24 08:00:00',72),('core.views','2016-05-24 09:00:00',58),('core.views','2016-05-24 10:00:00',79),('core.views','2016-05-24 11:00:00',105),('core.views','2016-05-24 12:00:00',95),('core.views','2016-05-24 13:00:00',7),('core.views','2016-05-24 22:00:00',1),('core.views','2016-05-25 03:00:00',7),('core.views','2016-05-25 04:00:00',14),('core.views','2016-05-25 05:00:00',59),('core.views','2016-05-25 06:00:00',64),('core.views','2016-05-25 07:00:00',109),('core.views','2016-05-25 08:00:00',46),('core.views','2016-05-25 09:00:00',38),('core.views','2016-05-25 10:00:00',68),('core.views','2016-05-25 11:00:00',141),('core.views','2016-05-25 12:00:00',12),('core.views','2016-05-25 13:00:00',2),('core.views','2016-05-26 03:00:00',2),('core.views','2016-05-26 04:00:00',56),('core.views','2016-05-26 05:00:00',9),('core.views','2016-05-26 06:00:00',2),('core.views','2016-05-26 07:00:00',13),('core.views','2016-05-26 09:00:00',49),('core.views','2016-05-26 10:00:00',13),('core.views','2016-05-26 11:00:00',20),('core.views','2016-05-26 12:00:00',12),('core.views','2016-05-26 19:00:00',2),('core.views','2016-05-26 20:00:00',1),('core.views','2016-05-27 04:00:00',3),('core.views','2016-05-27 05:00:00',35),('core.views','2016-05-27 06:00:00',67),('core.views','2016-05-27 07:00:00',17),('core.views','2016-05-27 08:00:00',28),('core.views','2016-05-27 09:00:00',30),('core.views','2016-05-27 10:00:00',41),('core.views','2016-05-27 11:00:00',2),('core.views','2016-05-27 12:00:00',9),('core.views','2016-05-27 13:00:00',1),('core.views','2016-05-29 21:00:00',1),('core.views','2016-05-30 04:00:00',2),('core.views','2016-05-30 05:00:00',30),('core.views','2016-05-30 06:00:00',22),('core.views','2016-05-30 07:00:00',12),('core.views','2016-05-30 09:00:00',28),('core.views','2016-05-30 10:00:00',25),('core.views','2016-05-30 11:00:00',11),('core.views','2016-05-30 12:00:00',74),('core.views','2016-05-30 13:00:00',2),('core.views','2016-05-31 04:00:00',11),('core.views','2016-05-31 05:00:00',67),('core.views','2016-05-31 06:00:00',30),('core.views','2016-05-31 07:00:00',75),('core.views','2016-05-31 09:00:00',15),('core.views','2016-05-31 10:00:00',58),('core.views','2016-05-31 11:00:00',54),('core.views','2016-05-31 12:00:00',37),('core.views','2016-06-01 03:00:00',1),('core.views','2016-06-01 04:00:00',39),('core.views','2016-06-01 05:00:00',2),('core.views','2016-06-01 06:00:00',59),('core.views','2016-06-01 07:00:00',39),('core.views','2016-06-01 09:00:00',2),('core.views','2016-06-01 11:00:00',3),('core.views','2016-06-01 12:00:00',6),('core.views','2016-06-02 04:00:00',49),('core.views','2016-06-02 05:00:00',19),('core.views','2016-06-02 06:00:00',38),('core.views','2016-06-02 07:00:00',44),('core.views','2016-06-02 09:00:00',31),('core.views','2016-06-02 10:00:00',31),('core.views','2016-06-02 11:00:00',23),('core.views','2016-06-02 12:00:00',6),('core.views','2016-06-02 16:00:00',30),('core.views','2016-06-02 22:00:00',1),('core.views','2016-06-03 03:00:00',1),('core.views','2016-06-03 04:00:00',49),('core.views','2016-06-03 05:00:00',11),('core.views','2016-06-03 07:00:00',6),('core.views','2016-06-03 09:00:00',6),('core.views','2016-06-03 10:00:00',30),('core.views','2016-06-03 11:00:00',2),('core.views','2016-06-03 12:00:00',1),('core.views','2016-06-03 13:00:00',4),('core.views','2016-06-03 15:00:00',12),('core.views','2016-06-03 16:00:00',1),('core.views','2016-06-04 02:00:00',4),('core.views','2016-06-04 11:00:00',2),('core.views','2016-06-04 17:00:00',7),('core.views','2016-06-05 01:00:00',3),('core.views','2016-06-06 03:00:00',1),('core.views','2016-06-06 04:00:00',8),('core.views','2016-06-06 05:00:00',20),('core.views','2016-06-06 07:00:00',2),('core.views','2016-06-06 09:00:00',27),('core.views','2016-06-06 10:00:00',141),('core.views','2016-06-06 11:00:00',15),('core.views','2016-06-06 12:00:00',145),('core.views','2016-06-06 13:00:00',3),('core.views','2016-06-06 18:00:00',4),('core.views','2016-06-06 23:00:00',3),('core.views','2016-06-07 02:00:00',18),('core.views','2016-06-07 03:00:00',8),('core.views','2016-06-07 06:00:00',22),('core.views','2016-06-07 07:00:00',2),('core.views','2016-06-07 08:00:00',4),('core.views','2016-06-07 09:00:00',103),('core.views','2016-06-07 10:00:00',64),('core.views','2016-06-07 11:00:00',73),('core.views','2016-06-07 12:00:00',76),('core.views','2016-06-07 21:00:00',1),('core.views','2016-06-08 04:00:00',73),('core.views','2016-06-08 05:00:00',114),('core.views','2016-06-08 06:00:00',119),('core.views','2016-06-08 07:00:00',68),('core.views','2016-06-08 08:00:00',83),('core.views','2016-06-08 09:00:00',57),('core.views','2016-06-08 10:00:00',99),('core.views','2016-06-08 11:00:00',133),('core.views','2016-06-08 12:00:00',235),('core.views','2016-06-08 13:00:00',202),('core.views','2016-06-08 14:00:00',12),('core.views','2016-06-08 17:00:00',2),('core.views','2016-06-09 04:00:00',88),('core.views','2016-06-09 05:00:00',203),('core.views','2016-06-09 06:00:00',88),('core.views','2016-06-09 07:00:00',18),('core.views','2016-06-09 08:00:00',4),('core.views','2016-06-09 09:00:00',104),('core.views','2016-06-09 10:00:00',121),('core.views','2016-06-09 11:00:00',107),('core.views','2016-06-09 12:00:00',211),('core.views','2016-06-09 13:00:00',58),('core.views','2016-06-09 14:00:00',67),('core.views','2016-06-09 15:00:00',4),('core.views','2016-06-09 17:00:00',1),('core.views','2016-06-10 04:00:00',8),('core.views','2016-06-10 05:00:00',27),('core.views','2016-06-10 06:00:00',43),('core.views','2016-06-10 07:00:00',9),('core.views','2016-06-10 08:00:00',2),('core.views','2016-06-10 09:00:00',27),('core.views','2016-06-10 10:00:00',139),('core.views','2016-06-10 11:00:00',51),('core.views','2016-06-10 12:00:00',70),('core.views','2016-06-10 13:00:00',22),('core.views','2016-06-10 18:00:00',3),('core.views','2016-06-10 19:00:00',9),('core.views','2016-06-10 20:00:00',1),('core.views','2016-06-13 04:00:00',35),('core.views','2016-06-13 05:00:00',97),('core.views','2016-06-13 06:00:00',33),('core.views','2016-06-13 07:00:00',28),('core.views','2016-06-13 08:00:00',6),('core.views','2016-06-13 09:00:00',21),('core.views','2016-06-13 10:00:00',42),('core.views','2016-06-13 11:00:00',17),('core.views','2016-06-13 12:00:00',66),('core.views','2016-06-13 13:00:00',6),('core.views','2016-06-14 04:00:00',49),('core.views','2016-06-14 05:00:00',10),('core.views','2016-06-14 06:00:00',96),('core.views','2016-06-14 07:00:00',57),('core.views','2016-06-14 08:00:00',11),('core.views','2016-06-14 09:00:00',99),('core.views','2016-06-14 10:00:00',110),('core.views','2016-06-14 11:00:00',79),('core.views','2016-06-14 12:00:00',78),('core.views','2016-06-14 13:00:00',77),('core.views','2016-06-14 15:00:00',2),('core.views','2016-06-15 04:00:00',16),('core.views','2016-06-15 05:00:00',53),('core.views','2016-06-15 06:00:00',95),('core.views','2016-06-15 07:00:00',31),('core.views','2016-06-15 08:00:00',46),('core.views','2016-06-15 09:00:00',27),('core.views','2016-06-15 10:00:00',7),('core.views','2016-06-15 11:00:00',21),('core.views','2016-06-15 12:00:00',19),('core.views','2016-06-15 13:00:00',37),('core.views','2016-06-15 18:00:00',5),('core.views','2016-06-15 19:00:00',24),('core.views','2016-06-16 03:00:00',2),('core.views','2016-06-16 04:00:00',147),('core.views','2016-06-16 05:00:00',260),('core.views','2016-06-16 06:00:00',116),('core.views','2016-06-16 07:00:00',109),('core.views','2016-06-16 08:00:00',77),('core.views','2016-06-16 09:00:00',104),('core.views','2016-06-16 10:00:00',126),('core.views','2016-06-16 11:00:00',86),('core.views','2016-06-16 12:00:00',114),('core.views','2016-06-16 13:00:00',48),('core.views','2016-06-16 16:00:00',7),('core.views','2016-06-16 17:00:00',10),('core.views','2016-06-17 01:00:00',4),('core.views','2016-06-17 03:00:00',12),('core.views','2016-06-17 04:00:00',134),('core.views','2016-06-17 05:00:00',108),('core.views','2016-06-17 06:00:00',107),('core.views','2016-06-17 07:00:00',137),('core.views','2016-06-17 08:00:00',135),('core.views','2016-06-17 09:00:00',95),('core.views','2016-06-17 10:00:00',71),('core.views','2016-06-17 11:00:00',90),('core.views','2016-06-17 12:00:00',156),('core.views','2016-06-17 13:00:00',132),('core.views','2016-06-17 14:00:00',172),('core.views','2016-06-17 15:00:00',81),('core.views','2016-06-17 16:00:00',125),('core.views','2016-06-17 17:00:00',38),('core.views','2016-06-17 23:00:00',1),('core.views','2016-06-18 00:00:00',8),('core.views','2016-06-18 01:00:00',21),('core.views','2016-06-18 02:00:00',5),('core.views','2016-06-18 05:00:00',4),('core.views','2016-06-18 12:00:00',1),('core.views','2016-06-18 15:00:00',33),('core.views','2016-06-18 16:00:00',1),('core.views','2016-06-18 17:00:00',28),('core.views','2016-06-18 19:00:00',4),('core.views','2016-06-19 01:00:00',1),('core.views','2016-06-19 13:00:00',4),('core.views','2016-06-19 15:00:00',1),('core.views','2016-06-19 20:00:00',5),('core.views','2016-06-19 21:00:00',2),('core.views','2016-06-19 22:00:00',21),('core.views','2016-06-20 00:00:00',18),('core.views','2016-06-20 02:00:00',1),('core.views','2016-06-20 03:00:00',5),('core.views','2016-06-20 04:00:00',129),('core.views','2016-06-20 05:00:00',139),('core.views','2016-06-20 06:00:00',90),('core.views','2016-06-20 07:00:00',92),('core.views','2016-06-20 08:00:00',78),('core.views','2016-06-20 09:00:00',158),('core.views','2016-06-20 10:00:00',198),('core.views','2016-06-20 11:00:00',1084),('core.views','2016-06-20 12:00:00',492),('messages.creations','2016-04-26 23:00:00',2),('messages.creations','2016-06-07 09:00:00',1),('messages.creations','2016-06-16 11:00:00',1),('user.creations','2016-03-07 15:00:00',1),('user.creations','2016-03-30 14:00:00',1),('user.creations','2016-04-05 17:00:00',1),('user.creations','2016-04-25 17:00:00',1),('user.creations','2016-04-25 18:00:00',1),('user.creations','2016-04-26 16:00:00',1),('user.creations','2016-05-03 04:00:00',1),('user.creations','2016-05-03 07:00:00',1),('user.creations','2016-05-03 12:00:00',1),('user.creations','2016-05-04 04:00:00',1),('user.creations','2016-05-11 06:00:00',1),('user.creations','2016-05-11 07:00:00',1),('user.creations','2016-05-12 05:00:00',1),('user.creations','2016-05-13 11:00:00',1),('user.creations','2016-05-17 05:00:00',1),('user.creations','2016-05-17 07:00:00',1),('user.creations','2016-05-18 05:00:00',1),('user.creations','2016-05-19 06:00:00',1),('user.creations','2016-05-19 08:00:00',1),('user.creations','2016-05-19 09:00:00',1),('user.creations','2016-05-20 12:00:00',1),('user.creations','2016-05-23 05:00:00',1),('user.creations','2016-05-23 06:00:00',1),('user.creations','2016-05-23 09:00:00',3),('user.creations','2016-05-23 10:00:00',2),('user.creations','2016-05-23 13:00:00',1),('user.creations','2016-05-24 06:00:00',2),('user.creations','2016-05-24 07:00:00',1),('user.creations','2016-05-24 08:00:00',1),('user.creations','2016-05-24 12:00:00',1),('user.creations','2016-05-25 06:00:00',2),('user.creations','2016-05-25 07:00:00',2),('user.creations','2016-05-25 08:00:00',2),('user.creations','2016-05-25 10:00:00',1),('user.creations','2016-05-26 09:00:00',2),('user.creations','2016-05-27 07:00:00',1),('user.creations','2016-05-30 05:00:00',1),('user.creations','2016-05-30 12:00:00',1),('user.creations','2016-05-31 07:00:00',1),('user.creations','2016-06-02 07:00:00',1),('user.creations','2016-06-03 04:00:00',5),('user.creations','2016-06-07 09:00:00',1),('user.creations','2016-06-08 11:00:00',1),('user.creations','2016-06-08 12:00:00',3),('user.creations','2016-06-10 05:00:00',1),('user.creations','2016-06-10 11:00:00',1),('user.creations','2016-06-14 06:00:00',1),('user.creations','2016-06-14 07:00:00',1),('user.creations','2016-06-15 05:00:00',1),('user.creations','2016-06-15 11:00:00',1),('user.creations','2016-06-16 08:00:00',1),('user.creations','2016-06-16 11:00:00',1),('user.creations','2016-06-16 13:00:00',1),('user.creations','2016-06-17 04:00:00',2),('user.creations','2016-06-17 05:00:00',1),('user.creations','2016-06-17 08:00:00',5),('user.creations','2016-06-17 09:00:00',2),('user.creations','2016-06-17 13:00:00',3),('user.creations','2016-06-17 15:00:00',1),('user.creations','2016-06-17 16:00:00',1),('user.creations','2016-06-18 15:00:00',1),('user.creations','2016-06-20 07:00:00',2),('user.creations','2016-06-20 10:00:00',2),('user.creations','2016-06-20 11:00:00',2),('user.creations','2016-06-20 12:00:00',1),('user.friendships','2016-06-08 10:00:00',1),('user.friendships','2016-06-16 10:00:00',1),('user.friendships','2016-06-20 05:00:00',1),('user.friendships','2016-06-20 11:00:00',1),('user.logins','2016-03-06 03:00:00',1),('user.logins','2016-03-14 19:00:00',2),('user.logins','2016-03-15 17:00:00',1),('user.logins','2016-03-28 22:00:00',1),('user.logins','2016-03-29 14:00:00',2),('user.logins','2016-03-29 15:00:00',1),('user.logins','2016-03-30 06:00:00',1),('user.logins','2016-03-30 09:00:00',1),('user.logins','2016-03-30 13:00:00',2),('user.logins','2016-03-30 14:00:00',1),('user.logins','2016-04-06 11:00:00',1),('user.logins','2016-04-06 19:00:00',3),('user.logins','2016-04-07 01:00:00',1),('user.logins','2016-04-07 05:00:00',1),('user.logins','2016-04-13 21:00:00',1),('user.logins','2016-04-17 15:00:00',1),('user.logins','2016-04-18 21:00:00',1),('user.logins','2016-04-21 22:00:00',1),('user.logins','2016-04-24 11:00:00',1),('user.logins','2016-04-24 20:00:00',1),('user.logins','2016-04-24 22:00:00',1),('user.logins','2016-04-25 17:00:00',3),('user.logins','2016-04-25 18:00:00',2),('user.logins','2016-04-25 19:00:00',8),('user.logins','2016-04-25 20:00:00',9),('user.logins','2016-04-25 21:00:00',3),('user.logins','2016-04-26 01:00:00',3),('user.logins','2016-04-26 02:00:00',1),('user.logins','2016-04-26 12:00:00',2),('user.logins','2016-04-26 19:00:00',2),('user.logins','2016-04-26 22:00:00',3),('user.logins','2016-04-26 23:00:00',3),('user.logins','2016-04-27 01:00:00',2),('user.logins','2016-04-27 02:00:00',1),('user.logins','2016-04-27 05:00:00',1),('user.logins','2016-04-27 19:00:00',2),('user.logins','2016-04-27 23:00:00',1),('user.logins','2016-04-28 03:00:00',2),('user.logins','2016-04-28 11:00:00',1),('user.logins','2016-05-02 04:00:00',1),('user.logins','2016-05-02 09:00:00',1),('user.logins','2016-05-02 10:00:00',1),('user.logins','2016-05-02 12:00:00',1),('user.logins','2016-05-02 21:00:00',1),('user.logins','2016-05-03 04:00:00',1),('user.logins','2016-05-03 06:00:00',1),('user.logins','2016-05-03 09:00:00',1),('user.logins','2016-05-04 04:00:00',1),('user.logins','2016-05-04 05:00:00',1),('user.logins','2016-05-04 07:00:00',1),('user.logins','2016-05-05 11:00:00',1),('user.logins','2016-05-07 05:00:00',1),('user.logins','2016-05-10 04:00:00',1),('user.logins','2016-05-10 13:00:00',1),('user.logins','2016-05-11 04:00:00',2),('user.logins','2016-05-11 05:00:00',1),('user.logins','2016-05-12 04:00:00',1),('user.logins','2016-05-12 07:00:00',2),('user.logins','2016-05-13 08:00:00',1),('user.logins','2016-05-13 09:00:00',1),('user.logins','2016-05-17 07:00:00',1),('user.logins','2016-05-18 05:00:00',2),('user.logins','2016-05-19 04:00:00',1),('user.logins','2016-05-19 08:00:00',1),('user.logins','2016-05-19 12:00:00',2),('user.logins','2016-05-20 07:00:00',4),('user.logins','2016-05-20 09:00:00',1),('user.logins','2016-05-22 02:00:00',1),('user.logins','2016-05-23 01:00:00',1),('user.logins','2016-05-23 04:00:00',1),('user.logins','2016-05-23 05:00:00',1),('user.logins','2016-05-23 06:00:00',1),('user.logins','2016-05-23 09:00:00',1),('user.logins','2016-05-23 10:00:00',2),('user.logins','2016-05-23 11:00:00',1),('user.logins','2016-05-23 12:00:00',2),('user.logins','2016-05-23 13:00:00',1),('user.logins','2016-05-24 06:00:00',2),('user.logins','2016-05-24 07:00:00',4),('user.logins','2016-05-24 08:00:00',2),('user.logins','2016-05-24 09:00:00',1),('user.logins','2016-05-24 10:00:00',1),('user.logins','2016-05-24 11:00:00',5),('user.logins','2016-05-24 12:00:00',3),('user.logins','2016-05-25 03:00:00',1),('user.logins','2016-05-25 04:00:00',1),('user.logins','2016-05-25 05:00:00',3),('user.logins','2016-05-25 06:00:00',2),('user.logins','2016-05-25 07:00:00',2),('user.logins','2016-05-25 08:00:00',1),('user.logins','2016-05-25 10:00:00',3),('user.logins','2016-05-25 11:00:00',7),('user.logins','2016-05-26 04:00:00',3),('user.logins','2016-05-26 05:00:00',1),('user.logins','2016-05-26 07:00:00',1),('user.logins','2016-05-26 09:00:00',2),('user.logins','2016-05-26 10:00:00',2),('user.logins','2016-05-26 11:00:00',1),('user.logins','2016-05-27 05:00:00',3),('user.logins','2016-05-27 06:00:00',1),('user.logins','2016-05-27 08:00:00',1),('user.logins','2016-05-30 05:00:00',2),('user.logins','2016-05-30 06:00:00',2),('user.logins','2016-05-30 07:00:00',1),('user.logins','2016-05-30 09:00:00',1),('user.logins','2016-05-30 10:00:00',2),('user.logins','2016-05-30 12:00:00',2),('user.logins','2016-05-31 04:00:00',1),('user.logins','2016-05-31 05:00:00',7),('user.logins','2016-05-31 06:00:00',2),('user.logins','2016-05-31 07:00:00',7),('user.logins','2016-05-31 09:00:00',1),('user.logins','2016-05-31 10:00:00',5),('user.logins','2016-05-31 11:00:00',4),('user.logins','2016-06-01 04:00:00',3),('user.logins','2016-06-01 06:00:00',3),('user.logins','2016-06-02 05:00:00',1),('user.logins','2016-06-02 06:00:00',3),('user.logins','2016-06-02 07:00:00',1),('user.logins','2016-06-02 09:00:00',1),('user.logins','2016-06-02 11:00:00',1),('user.logins','2016-06-03 04:00:00',2),('user.logins','2016-06-06 04:00:00',1),('user.logins','2016-06-06 05:00:00',2),('user.logins','2016-06-06 10:00:00',4),('user.logins','2016-06-06 12:00:00',2),('user.logins','2016-06-07 02:00:00',1),('user.logins','2016-06-07 06:00:00',1),('user.logins','2016-06-07 09:00:00',3),('user.logins','2016-06-07 10:00:00',1),('user.logins','2016-06-08 04:00:00',5),('user.logins','2016-06-08 05:00:00',2),('user.logins','2016-06-08 06:00:00',1),('user.logins','2016-06-08 08:00:00',4),('user.logins','2016-06-08 10:00:00',2),('user.logins','2016-06-08 11:00:00',3),('user.logins','2016-06-08 12:00:00',4),('user.logins','2016-06-08 13:00:00',9),('user.logins','2016-06-09 04:00:00',5),('user.logins','2016-06-09 05:00:00',11),('user.logins','2016-06-09 09:00:00',1),('user.logins','2016-06-09 10:00:00',3),('user.logins','2016-06-09 12:00:00',3),('user.logins','2016-06-09 13:00:00',1),('user.logins','2016-06-09 14:00:00',1),('user.logins','2016-06-10 05:00:00',2),('user.logins','2016-06-10 06:00:00',2),('user.logins','2016-06-10 10:00:00',1),('user.logins','2016-06-10 11:00:00',1),('user.logins','2016-06-10 13:00:00',1),('user.logins','2016-06-13 04:00:00',2),('user.logins','2016-06-13 05:00:00',2),('user.logins','2016-06-13 06:00:00',1),('user.logins','2016-06-13 07:00:00',2),('user.logins','2016-06-13 10:00:00',1),('user.logins','2016-06-13 11:00:00',1),('user.logins','2016-06-13 12:00:00',2),('user.logins','2016-06-14 04:00:00',2),('user.logins','2016-06-14 06:00:00',1),('user.logins','2016-06-14 07:00:00',3),('user.logins','2016-06-14 09:00:00',7),('user.logins','2016-06-14 10:00:00',3),('user.logins','2016-06-14 11:00:00',3),('user.logins','2016-06-14 12:00:00',2),('user.logins','2016-06-14 13:00:00',2),('user.logins','2016-06-15 05:00:00',7),('user.logins','2016-06-15 06:00:00',4),('user.logins','2016-06-15 11:00:00',1),('user.logins','2016-06-15 12:00:00',2),('user.logins','2016-06-15 13:00:00',1),('user.logins','2016-06-16 04:00:00',7),('user.logins','2016-06-16 05:00:00',11),('user.logins','2016-06-16 06:00:00',3),('user.logins','2016-06-16 07:00:00',1),('user.logins','2016-06-16 08:00:00',3),('user.logins','2016-06-16 09:00:00',1),('user.logins','2016-06-16 10:00:00',5),('user.logins','2016-06-16 11:00:00',2),('user.logins','2016-06-16 12:00:00',1),('user.logins','2016-06-16 13:00:00',2),('user.logins','2016-06-17 03:00:00',1),('user.logins','2016-06-17 04:00:00',7),('user.logins','2016-06-17 05:00:00',2),('user.logins','2016-06-17 06:00:00',4),('user.logins','2016-06-17 07:00:00',1),('user.logins','2016-06-17 08:00:00',4),('user.logins','2016-06-17 09:00:00',4),('user.logins','2016-06-17 10:00:00',4),('user.logins','2016-06-17 11:00:00',8),('user.logins','2016-06-17 12:00:00',5),('user.logins','2016-06-17 13:00:00',5),('user.logins','2016-06-17 14:00:00',3),('user.logins','2016-06-17 15:00:00',1),('user.logins','2016-06-17 16:00:00',4),('user.logins','2016-06-17 17:00:00',2),('user.logins','2016-06-18 15:00:00',2),('user.logins','2016-06-19 13:00:00',1),('user.logins','2016-06-20 03:00:00',1),('user.logins','2016-06-20 04:00:00',6),('user.logins','2016-06-20 05:00:00',5),('user.logins','2016-06-20 06:00:00',3),('user.logins','2016-06-20 07:00:00',3),('user.logins','2016-06-20 09:00:00',3),('user.logins','2016-06-20 10:00:00',4),('user.logins','2016-06-20 11:00:00',16),('user.logins','2016-06-20 12:00:00',4);
/*!40000 ALTER TABLE `engine4_core_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_status`
--

DROP TABLE IF EXISTS `engine4_core_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_status` (
  `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_status`
--

LOCK TABLES `engine4_core_status` WRITE;
/*!40000 ALTER TABLE `engine4_core_status` DISABLE KEYS */;
INSERT INTO `engine4_core_status` VALUES (1,'user',2,'Hello All','2016-03-07 15:08:25'),(2,'user',1,'How is everyoneÂ ','2016-04-25 04:12:25'),(3,'user',6,'Brooklyn is getting crazy everybody. Apartments are so expensive','2016-04-25 18:14:58'),(4,'user',1,'What\'s up everybodyÂ ','2016-04-26 22:13:27'),(5,'user',57,'www.iclothing.com','2016-06-07 12:22:34'),(6,'user',1,'What\'s on everyone\'s mind','2016-06-15 19:19:10');
/*!40000 ALTER TABLE `engine4_core_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_styles`
--

DROP TABLE IF EXISTS `engine4_core_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_styles` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `style` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_styles`
--

LOCK TABLES `engine4_core_styles` WRITE;
/*!40000 ALTER TABLE `engine4_core_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tagmaps`
--

DROP TABLE IF EXISTS `engine4_core_tagmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tagmaps` (
  `tagmap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `tagger_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tagger_id` int(11) unsigned NOT NULL,
  `tag_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `extra` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`tagmap_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `tagger_type` (`tagger_type`,`tagger_id`),
  KEY `tag_type` (`tag_type`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tagmaps`
--

LOCK TABLES `engine4_core_tagmaps` WRITE;
/*!40000 ALTER TABLE `engine4_core_tagmaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_tagmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tags`
--

DROP TABLE IF EXISTS `engine4_core_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tags` (
  `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tags`
--

LOCK TABLES `engine4_core_tags` WRITE;
/*!40000 ALTER TABLE `engine4_core_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tasks`
--

DROP TABLE IF EXISTS `engine4_core_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tasks` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `timeout` int(11) unsigned NOT NULL DEFAULT '60',
  `processes` smallint(3) unsigned NOT NULL DEFAULT '1',
  `semaphore` smallint(3) NOT NULL DEFAULT '0',
  `started_last` int(11) NOT NULL DEFAULT '0',
  `started_count` int(11) unsigned NOT NULL DEFAULT '0',
  `completed_last` int(11) NOT NULL DEFAULT '0',
  `completed_count` int(11) unsigned NOT NULL DEFAULT '0',
  `failure_last` int(11) NOT NULL DEFAULT '0',
  `failure_count` int(11) unsigned NOT NULL DEFAULT '0',
  `success_last` int(11) NOT NULL DEFAULT '0',
  `success_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `plugin` (`plugin`),
  KEY `module` (`module`),
  KEY `started_last` (`started_last`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tasks`
--

LOCK TABLES `engine4_core_tasks` WRITE;
/*!40000 ALTER TABLE `engine4_core_tasks` DISABLE KEYS */;
INSERT INTO `engine4_core_tasks` VALUES (1,'Job Queue','core','Core_Plugin_Task_Jobs',5,1,0,1466427228,7841,1466427228,7841,0,0,1466427228,7841),(2,'Background Mailer','core','Core_Plugin_Task_Mail',15,1,0,1466427228,7838,1466427228,7838,0,0,1466427228,7838),(3,'Cache Prefetch','core','Core_Plugin_Task_Prefetch',300,1,0,1466427092,3171,1466427092,3171,0,0,1466427092,3171),(4,'Statistics','core','Core_Plugin_Task_Statistics',43200,1,0,1466395120,112,1466395120,112,0,0,1466395120,112),(5,'Log Rotation','core','Core_Plugin_Task_LogRotation',7200,1,0,1466424553,321,1466424553,321,0,0,1466424553,321),(6,'Member Data Maintenance','user','User_Plugin_Task_Cleanup',60,1,0,1466427228,4051,1466427228,4051,0,0,1466427228,4051),(7,'Payment Maintenance','user','Payment_Plugin_Task_Cleanup',43200,1,0,1466396020,97,1466396020,97,0,0,1466396020,97);
/*!40000 ALTER TABLE `engine4_core_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_themes`
--

DROP TABLE IF EXISTS `engine4_core_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_themes` (
  `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_themes`
--

LOCK TABLES `engine4_core_themes` WRITE;
/*!40000 ALTER TABLE `engine4_core_themes` DISABLE KEYS */;
INSERT INTO `engine4_core_themes` VALUES (1,'default','Default','',0),(2,'midnight','Midnight','',0),(3,'clean','Clean','',0),(4,'modern','Modern','',0),(5,'bamboo','Bamboo','',0),(6,'digita','Digita','',0),(7,'grid-blue','Grid Blue','',0),(8,'grid-brown','Grid Brown','',0),(9,'grid-dark','Grid Dark','',0),(10,'grid-gray','Grid Gray','',0),(11,'grid-green','Grid Green','',0),(12,'grid-pink','Grid Pink','',0),(13,'grid-purple','Grid Purple','',0),(14,'grid-red','Grid Red','',0),(15,'kandy-cappuccino','Kandy Cappuccino','',0),(16,'kandy-limeorange','Kandy Limeorange','',0),(17,'kandy-mangoberry','Kandy Mangoberry','',0),(18,'kandy-watermelon','Kandy Watermelon','',0),(19,'musicbox-blue','Musicbox Blue','',0),(20,'musicbox-brown','Musicbox Brown','',0),(21,'musicbox-gray','Musicbox Gray','',0),(22,'musicbox-green','Musicbox Green','',0),(23,'musicbox-pink','Musicbox Pink','',0),(24,'musicbox-purple','Musicbox Purple','',0),(25,'musicbox-red','Musicbox Red','',0),(26,'musicbox-yellow','Musicbox Yellow','',0),(27,'quantum-beige','Quantum Beige','',0),(28,'quantum-blue','Quantum Blue','',0),(29,'quantum-gray','Quantum Gray','',0),(30,'quantum-green','Quantum Green','',0),(31,'quantum-orange','Quantum Orange','',0),(32,'quantum-pink','Quantum Pink','',0),(33,'quantum-purple','Quantum Purple','',0),(34,'quantum-red','Quantum Red','',0),(35,'slipstream','Slipstream','',0),(36,'snowbot','Snowbot','',0),(37,'ynresponsivepurity-green','YN - Responsive Purity Template - Green','Responsive Purity Template - Green',0),(38,'ynresponsivepurity-blue','YN - Responsive Purity Template - Blue','Responsive Purity Template - Blue',0),(39,'ynresponsivepurity-navy','YN - Responsive Purity Template - Navy','Responsive Purity Template - Blue',0),(40,'ynresponsivepurity-orange','YN - Responsive Purity Template - Orange','Responsive Purity Template - Blue',1),(41,'ynresponsivepurity-red','YN - Responsive Purity Template - Red','Responsive Purity Template - Red',0),(42,'ynresponsivepurity-purple','YN - Responsive Purity Template - Purple','Responsive Purity Template - Blue',0),(43,'ynresponsivepurity-yellow','YN - Responsive Purity Template - Yellow','Responsive Purity Template - Blue',0);
/*!40000 ALTER TABLE `engine4_core_themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_country_list`
--

DROP TABLE IF EXISTS `engine4_country_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_country_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `country` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_country_list`
--

LOCK TABLES `engine4_country_list` WRITE;
/*!40000 ALTER TABLE `engine4_country_list` DISABLE KEYS */;
INSERT INTO `engine4_country_list` VALUES (1,'United States of America');
/*!40000 ALTER TABLE `engine4_country_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_cover_letter`
--

DROP TABLE IF EXISTS `engine4_cover_letter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_cover_letter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` varchar(5000) NOT NULL,
  `status` varchar(100) NOT NULL,
  `create_at` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_cover_letter`
--

LOCK TABLES `engine4_cover_letter` WRITE;
/*!40000 ALTER TABLE `engine4_cover_letter` DISABLE KEYS */;
INSERT INTO `engine4_cover_letter` VALUES (1,0,'Template 1','Template 1','default','2016-06-08'),(2,0,'Template 2','Visal varghese is a well known person in Titechnologies','default','2016-06-08'),(4,0,'test 1','test','default','2016-06-16');
/*!40000 ALTER TABLE `engine4_cover_letter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_albums`
--

DROP TABLE IF EXISTS `engine4_group_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_albums`
--

LOCK TABLES `engine4_group_albums` WRITE;
/*!40000 ALTER TABLE `engine4_group_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_categories`
--

DROP TABLE IF EXISTS `engine4_group_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_categories`
--

LOCK TABLES `engine4_group_categories` WRITE;
/*!40000 ALTER TABLE `engine4_group_categories` DISABLE KEYS */;
INSERT INTO `engine4_group_categories` VALUES (3,'Computers & Internet'),(7,'Family & Home'),(10,'Health & Wellness'),(18,'Neighborhood Watch'),(19,'Process Server'),(20,'Legal');
/*!40000 ALTER TABLE `engine4_group_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_groups`
--

DROP TABLE IF EXISTS `engine4_group_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_groups` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `invite` tinyint(1) NOT NULL DEFAULT '1',
  `approval` tinyint(1) NOT NULL DEFAULT '0',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `member_count` smallint(6) unsigned NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_groups`
--

LOCK TABLES `engine4_group_groups` WRITE;
/*!40000 ALTER TABLE `engine4_group_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_listitems`
--

DROP TABLE IF EXISTS `engine4_group_listitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_listitems`
--

LOCK TABLES `engine4_group_listitems` WRITE;
/*!40000 ALTER TABLE `engine4_group_listitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_listitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_lists`
--

DROP TABLE IF EXISTS `engine4_group_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_lists`
--

LOCK TABLES `engine4_group_lists` WRITE;
/*!40000 ALTER TABLE `engine4_group_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_membership`
--

DROP TABLE IF EXISTS `engine4_group_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `title` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_membership`
--

LOCK TABLES `engine4_group_membership` WRITE;
/*!40000 ALTER TABLE `engine4_group_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_photos`
--

DROP TABLE IF EXISTS `engine4_group_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_photos`
--

LOCK TABLES `engine4_group_photos` WRITE;
/*!40000 ALTER TABLE `engine4_group_photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_posts`
--

DROP TABLE IF EXISTS `engine4_group_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_posts`
--

LOCK TABLES `engine4_group_posts` WRITE;
/*!40000 ALTER TABLE `engine4_group_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_topics`
--

DROP TABLE IF EXISTS `engine4_group_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lastposter_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`topic_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_topics`
--

LOCK TABLES `engine4_group_topics` WRITE;
/*!40000 ALTER TABLE `engine4_group_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_group_topicwatches`
--

DROP TABLE IF EXISTS `engine4_group_topicwatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_group_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_group_topicwatches`
--

LOCK TABLES `engine4_group_topicwatches` WRITE;
/*!40000 ALTER TABLE `engine4_group_topicwatches` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_group_topicwatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_invites`
--

DROP TABLE IF EXISTS `engine4_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `recipient` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `send_request` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `new_user_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_invites`
--

LOCK TABLES `engine4_invites` WRITE;
/*!40000 ALTER TABLE `engine4_invites` DISABLE KEYS */;
INSERT INTO `engine4_invites` VALUES (1,20,'visal@gamil.com','b9904f3',1,'2016-05-19 08:04:36','You are being invited to join our social network.',0),(2,20,'hi@c.com','0643d11',1,'2016-05-19 08:04:36','You are being invited to join our social network.',0),(3,34,'visal.varghese@titechnolgies.in','273a867',1,'2016-05-24 08:36:02','You are being invited to join our social network.',0);
/*!40000 ALTER TABLE `engine4_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_conversations`
--

DROP TABLE IF EXISTS `engine4_messages_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_conversations` (
  `conversation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) unsigned NOT NULL,
  `recipients` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`conversation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_conversations`
--

LOCK TABLES `engine4_messages_conversations` WRITE;
/*!40000 ALTER TABLE `engine4_messages_conversations` DISABLE KEYS */;
INSERT INTO `engine4_messages_conversations` VALUES (1,'website',1,1,'2016-04-26 23:14:22',0,NULL,0),(2,'Test',49,1,'2016-06-07 09:49:21',0,NULL,0),(3,'Halo Jemy',37,1,'2016-06-16 11:09:03',0,NULL,0);
/*!40000 ALTER TABLE `engine4_messages_conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_messages`
--

DROP TABLE IF EXISTS `engine4_messages_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_messages` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `attachment_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `attachment_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `CONVERSATIONS` (`conversation_id`,`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_messages`
--

LOCK TABLES `engine4_messages_messages` WRITE;
/*!40000 ALTER TABLE `engine4_messages_messages` DISABLE KEYS */;
INSERT INTO `engine4_messages_messages` VALUES (1,1,1,'website','are u working on the ste','2016-04-26 23:09:52','',0),(2,1,6,'','yes','2016-04-26 23:14:22','',0),(3,2,49,'Test','Halo, this is a test message','2016-06-07 09:49:21','',0),(4,3,37,'Halo Jemy','Hi Jemy, this is a test message','2016-06-16 11:09:03','',0);
/*!40000 ALTER TABLE `engine4_messages_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_recipients`
--

DROP TABLE IF EXISTS `engine4_messages_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_recipients` (
  `user_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `inbox_message_id` int(11) unsigned DEFAULT NULL,
  `inbox_updated` datetime DEFAULT NULL,
  `inbox_read` tinyint(1) DEFAULT NULL,
  `inbox_deleted` tinyint(1) DEFAULT NULL,
  `outbox_message_id` int(11) unsigned DEFAULT NULL,
  `outbox_updated` datetime DEFAULT NULL,
  `outbox_deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`conversation_id`),
  KEY `INBOX_UPDATED` (`user_id`,`conversation_id`,`inbox_updated`),
  KEY `OUTBOX_UPDATED` (`user_id`,`conversation_id`,`outbox_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_recipients`
--

LOCK TABLES `engine4_messages_recipients` WRITE;
/*!40000 ALTER TABLE `engine4_messages_recipients` DISABLE KEYS */;
INSERT INTO `engine4_messages_recipients` VALUES (1,1,2,'2016-04-26 23:14:22',1,0,1,'2016-04-26 23:09:52',0),(6,1,1,'2016-04-26 23:09:52',1,0,2,'2016-04-26 23:14:22',0),(37,3,NULL,NULL,1,1,4,'2016-06-16 11:09:03',0),(49,2,NULL,NULL,1,1,3,'2016-06-07 09:49:21',0),(49,3,4,'2016-06-16 11:09:03',0,0,0,NULL,1),(57,2,3,'2016-06-07 09:49:21',0,0,0,NULL,1);
/*!40000 ALTER TABLE `engine4_messages_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_network_membership`
--

DROP TABLE IF EXISTS `engine4_network_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_network_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_network_membership`
--

LOCK TABLES `engine4_network_membership` WRITE;
/*!40000 ALTER TABLE `engine4_network_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_network_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_network_networks`
--

DROP TABLE IF EXISTS `engine4_network_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_network_networks` (
  `network_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pattern` text COLLATE utf8_unicode_ci,
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `assignment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`network_id`),
  KEY `assignment` (`assignment`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_network_networks`
--

LOCK TABLES `engine4_network_networks` WRITE;
/*!40000 ALTER TABLE `engine4_network_networks` DISABLE KEYS */;
INSERT INTO `engine4_network_networks` VALUES (1,'North America','',0,NULL,0,0,0),(2,'South America','',0,NULL,0,0,0),(3,'Europe','',0,NULL,0,0,0),(4,'Asia','',0,NULL,0,0,0),(5,'Africa','',0,NULL,0,0,0),(6,'Australia','',0,NULL,0,0,0),(7,'Antarctica','',0,NULL,0,0,0);
/*!40000 ALTER TABLE `engine4_network_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_gateways`
--

DROP TABLE IF EXISTS `engine4_payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_gateways` (
  `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` mediumblob,
  `test_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`gateway_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_gateways`
--

LOCK TABLES `engine4_payment_gateways` WRITE;
/*!40000 ALTER TABLE `engine4_payment_gateways` DISABLE KEYS */;
INSERT INTO `engine4_payment_gateways` VALUES (1,'2Checkout',NULL,0,'Payment_Plugin_Gateway_2Checkout',NULL,0),(2,'PayPal',NULL,0,'Payment_Plugin_Gateway_PayPal',NULL,0),(3,'Testing',NULL,0,'Payment_Plugin_Gateway_Testing',NULL,1);
/*!40000 ALTER TABLE `engine4_payment_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_orders`
--

DROP TABLE IF EXISTS `engine4_payment_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_orders` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `gateway_id` int(10) unsigned NOT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` enum('pending','cancelled','failed','incomplete','complete') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `source_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`,`gateway_order_id`),
  KEY `state` (`state`),
  KEY `source_type` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_orders`
--

LOCK TABLES `engine4_payment_orders` WRITE;
/*!40000 ALTER TABLE `engine4_payment_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_packages`
--

DROP TABLE IF EXISTS `engine4_payment_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_packages` (
  `package_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `downgrade_level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) unsigned NOT NULL,
  `recurrence` int(11) unsigned NOT NULL,
  `recurrence_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `trial_duration` int(11) unsigned NOT NULL DEFAULT '0',
  `trial_duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `after_signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_packages`
--

LOCK TABLES `engine4_payment_packages` WRITE;
/*!40000 ALTER TABLE `engine4_payment_packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_products`
--

DROP TABLE IF EXISTS `engine4_payment_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_products` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `extension_id` int(10) unsigned DEFAULT NULL,
  `sku` bigint(20) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `extension_type` (`extension_type`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_products`
--

LOCK TABLES `engine4_payment_products` WRITE;
/*!40000 ALTER TABLE `engine4_payment_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_subscriptions`
--

DROP TABLE IF EXISTS `engine4_payment_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_subscriptions` (
  `subscription_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `status` enum('initial','trial','pending','active','cancelled','expired','overdue','refunded') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'initial',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `gateway_profile_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `gateway_id` (`gateway_id`,`gateway_profile_id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  KEY `status` (`status`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_subscriptions`
--

LOCK TABLES `engine4_payment_subscriptions` WRITE;
/*!40000 ALTER TABLE `engine4_payment_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_transactions`
--

DROP TABLE IF EXISTS `engine4_payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_transactions` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `gateway_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `gateway_parent_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `currency` char(3) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `type` (`type`),
  KEY `state` (`state`),
  KEY `gateway_transaction_id` (`gateway_transaction_id`),
  KEY `gateway_parent_transaction_id` (`gateway_parent_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_transactions`
--

LOCK TABLES `engine4_payment_transactions` WRITE;
/*!40000 ALTER TABLE `engine4_payment_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_property_images`
--

DROP TABLE IF EXISTS `engine4_property_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_property_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `image` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_property_images`
--

LOCK TABLES `engine4_property_images` WRITE;
/*!40000 ALTER TABLE `engine4_property_images` DISABLE KEYS */;
INSERT INTO `engine4_property_images` VALUES (1,1,'public/images/property/93/5767ddab3684e.jpg'),(2,1,'public/images/property/93/5767ddab39583.jpeg'),(3,1,'public/images/property/93/5767ddab3af72.jpg'),(4,2,'public/images/property/77/5767de39e580b.jpg'),(5,2,'public/images/property/77/5767de39e754e.jpg'),(6,1,'public/images/property/93/5767de3ddf7f5.jpg'),(7,3,'public/images/property/77/5767df4615336.jpg'),(8,3,'public/images/property/77/5767df46171aa.jpg'),(9,3,'public/images/property/77/5767df4624a2a.jpg'),(10,3,'public/images/property/77/5767df4632d80.jpg'),(11,4,'public/images/property/77/5767e46c1a308.jpg'),(12,4,'public/images/property/77/5767e46c20e97.jpg'),(13,4,'public/images/property/77/5767e46c285d5.jpeg'),(14,4,'public/images/property/77/5767e46c2ad5c.jpeg'),(15,4,'public/images/property/77/5767e46c325a0.jpg');
/*!40000 ALTER TABLE `engine4_property_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_property_list`
--

DROP TABLE IF EXISTS `engine4_property_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_property_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_owner_id` int(11) NOT NULL,
  `property_name` varchar(250) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `zipcode` varchar(50) NOT NULL,
  `rental_type` varchar(50) NOT NULL,
  `no_of_rooms` int(11) NOT NULL,
  `housing_type` varchar(50) NOT NULL,
  `has_pets` varchar(50) NOT NULL,
  `pets_type` varchar(100) NOT NULL,
  `price` varchar(50) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `enable` int(11) NOT NULL,
  `landlord_enable` int(11) NOT NULL,
  `attachment_count` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `created_at` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_property_list`
--

LOCK TABLES `engine4_property_list` WRITE;
/*!40000 ALTER TABLE `engine4_property_list` DISABLE KEYS */;
INSERT INTO `engine4_property_list` VALUES (1,93,'Olive Apartments',1,1,1,'90001','Rent',0,'Apartment','Yes','Small pets','4,000 - 4,800','Olive Apartments is a luxurious 4-star hotel in London minutes from Old Spital fields Market and Tower of London. This 4-star apartment is close to London Bridge and London Dungeon.',1,1,4,0,'2016-06-20 12:14:53'),(2,77,'Mathers Apartments',1,1,1,'90002','Rent',2,'Apartment','No','','1,100 - 1,800','Mather builders is one of the prominent builders in the region with high repute, which has enjoyed a remarkable track record in reality sector. Unique vision and solid experience in construction industry places Mather Builders among the most reliable in the God\'s Own Country. Offering a wide range of sophisticated services blended with dedication, Mather Builders has carved out a niche in the realty industry',1,1,2,0,'2016-06-20 12:14:49'),(3,77,'Trinity Periyar winds Project',1,1,1,'90001','Rent',3,'Apartment','Yes','Dogs','4,000 - 4,800','Authority Approvals : Building Permit Trinity Builders and Developers was founded in 2005 by three individuals who have a strong background in architecture and construction; construction industry veterans with excellent industry experience as well established entrepreneurs in the past 25 years. Those years of experience at all levels of the business formed a rock-solid foundation - one which has allowed Trinity Arcade Pvt. Ltd. to consistently excel and grow. The latest offering from Trinity Builder, The Periyar winds will redefine waterfront living in Cochin. Coming up on 53 cents of land, on the banks of the ever mesmerizing Periyar River, this 13-floor complex comprising of just 51 units of 3 BHK apts. Itâ€™s your chance to wake up to the goodness and beauty of nature, every single day. * Project Area : 53 Cents * Total No. of Tower: 1 * Total No. of Floors: 13 * Total Units & available units: 51 Launch Date March 15',1,1,4,0,'2016-06-20 12:19:18'),(4,77,'Tranquil Villas',1,1,1,'90003','Rent',4,'Villa','Yes','Birds','4,000 - 4,800','Tranquil Villas , is one of the residential developments of Dhruthi Infra. It offers spacious 2 BHK and 3 BHK apartments. The project is well equipped with all the amenities to facilitate the needs of the residents',1,1,5,0,'2016-06-20 12:41:16');
/*!40000 ALTER TABLE `engine4_property_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_property_request`
--

DROP TABLE IF EXISTS `engine4_property_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_property_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `landlord_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `landlord_approve` int(11) NOT NULL,
  `admin_approve` int(11) NOT NULL,
  `admin_approve_date` varchar(50) NOT NULL,
  `landlord_approve_date` varchar(50) NOT NULL,
  `created_at` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_property_request`
--

LOCK TABLES `engine4_property_request` WRITE;
/*!40000 ALTER TABLE `engine4_property_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_property_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_sqlupdates_updates`
--

DROP TABLE IF EXISTS `engine4_sqlupdates_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_sqlupdates_updates` (
  `sql_id` int(11) NOT NULL AUTO_INCREMENT,
  `sql_version` varchar(11) NOT NULL,
  `sql_date` datetime NOT NULL,
  PRIMARY KEY (`sql_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_sqlupdates_updates`
--

LOCK TABLES `engine4_sqlupdates_updates` WRITE;
/*!40000 ALTER TABLE `engine4_sqlupdates_updates` DISABLE KEYS */;
INSERT INTO `engine4_sqlupdates_updates` VALUES (1,'1.1.2.1','2016-05-11 04:12:27'),(2,'1.1.2.2','2016-05-11 04:12:27'),(3,'1.1.2.3','2016-05-11 04:12:28'),(4,'1.1.2.4','2016-05-11 04:12:28'),(5,'1.1.2.5','2016-05-11 04:12:28'),(6,'1.1.2.6','2016-05-11 04:12:28'),(7,'1.1.3.1','2016-05-11 06:33:55'),(8,'1.1.2.7','2016-05-13 07:32:55'),(9,'1.1.2.8','2016-05-13 07:32:56'),(10,'1.1.2.9','2016-05-13 07:32:56'),(11,'1.1.2.10','2016-05-13 07:32:56'),(12,'1.1.2.11','2016-05-13 07:32:56'),(13,'1.1.2.12','2016-05-13 07:32:56'),(14,'1.1.2.13','2016-05-18 05:17:48'),(15,'1.1.2.14','2016-05-18 05:17:48'),(16,'1.1.2.15','2016-05-18 08:38:01'),(17,'1.1.2.16','2016-05-18 08:38:01'),(18,'1.1.2.17','2016-05-18 08:38:01'),(19,'1.1.2.18','2016-05-18 08:38:01'),(20,'1.1.2.19','2016-05-18 08:38:02'),(21,'1.1.2.20','2016-05-18 12:14:01'),(22,'1.1.2.21','2016-05-18 12:14:01'),(23,'1.1.3.2','2016-05-20 07:16:58'),(24,'1.1.2.22','2016-06-01 06:56:47'),(25,'1.1.2.23','2016-06-01 06:56:47'),(26,'1.1.2.24','2016-06-02 05:42:05'),(27,'1.1.2.25','2016-06-06 08:59:54'),(28,'1.1.2.26','2016-06-06 08:59:54'),(29,'1.1.2.27','2016-06-06 08:59:54'),(30,'1.1.2.28','2016-06-06 08:59:54'),(31,'1.1.2.29','2016-06-06 08:59:55'),(32,'1.1.2.30','2016-06-06 12:36:03'),(33,'1.1.2.31','2016-06-08 04:55:14'),(34,'1.1.2.32','2016-06-08 08:39:07'),(35,'1.1.2.34','2016-06-08 13:41:56'),(36,'1.1.2.35','2016-06-08 13:41:56'),(37,'1.1.2.36','2016-06-13 06:20:20'),(38,'1.1.2.37','2016-06-14 09:55:48'),(39,'1.1.2.38','2016-06-14 09:55:48'),(40,'1.1.2.39','2016-06-14 09:55:49'),(41,'1.1.2.40','2016-06-14 09:55:49'),(42,'1.1.2.41','2016-06-14 09:55:49'),(43,'1.1.2.42','2016-06-14 09:55:49'),(44,'1.1.3.3','2016-06-15 07:37:17'),(45,'1.1.3.4','2016-06-15 07:37:18'),(46,'1.1.3.5','2016-06-16 11:08:27'),(47,'1.1.2.43','2016-06-17 09:24:23'),(48,'1.1.2.44','2016-06-17 14:54:45');
/*!40000 ALTER TABLE `engine4_sqlupdates_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_state_list`
--

DROP TABLE IF EXISTS `engine4_state_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_state_list` (
  `state_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `state` varchar(100) NOT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_state_list`
--

LOCK TABLES `engine4_state_list` WRITE;
/*!40000 ALTER TABLE `engine4_state_list` DISABLE KEYS */;
INSERT INTO `engine4_state_list` VALUES (1,1,'California');
/*!40000 ALTER TABLE `engine4_state_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_chunks`
--

DROP TABLE IF EXISTS `engine4_storage_chunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_chunks` (
  `chunk_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`chunk_id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_chunks`
--

LOCK TABLES `engine4_storage_chunks` WRITE;
/*!40000 ALTER TABLE `engine4_storage_chunks` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_storage_chunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_files`
--

DROP TABLE IF EXISTS `engine4_storage_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_file_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `service_id` int(10) unsigned NOT NULL DEFAULT '1',
  `storage_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_major` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `mime_minor` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `parent_file_id` (`parent_file_id`,`type`),
  KEY `PARENT` (`parent_type`,`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_files`
--

LOCK TABLES `engine4_storage_files` WRITE;
/*!40000 ALTER TABLE `engine4_storage_files` DISABLE KEYS */;
INSERT INTO `engine4_storage_files` VALUES (1,NULL,NULL,'user',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/user/01/0001_9bd7.jpg','jpg','FullSizeRender_m.jpg','image','jpeg',30145,'293a9bd7fd08d6c8405b74e43565ba66'),(2,1,'thumb.profile','user',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/user/02/0002_a5fc.jpg','jpg','FullSizeRender_p.jpg','image','jpeg',3720,'9200a5fcb6a4864c8a0ef982a4ac12c9'),(3,1,'thumb.normal','user',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/user/03/0003_fffc.jpg','jpg','FullSizeRender_in.jpg','image','jpeg',2395,'a964fffc2bccf8e423ca0658772665bb'),(4,1,'thumb.icon','user',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/user/04/0004_e209.jpg','jpg','FullSizeRender_is.jpg','image','jpeg',1152,'f18ae20970af188b5009a476295357ac'),(5,NULL,NULL,'album_photo',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/album_photo/05/0005_1c11.jpg','jpg','FullSizeRender_m_m.jpg','image','jpeg',30085,'21b71c1141efd1a3c105c28291c47bef'),(6,5,'thumb.normal','album_photo',1,1,'2016-03-29 17:16:37','2016-03-29 17:16:37',1,'public/album_photo/06/0006_06f5.jpg','jpg','FullSizeRender_m_in.jpg','image','jpeg',2396,'171706f52a1c43b3e008aa2bf86e180b'),(19,NULL,NULL,'ynresponsivepurity_slider',1,1,'2016-04-26 13:04:42','2016-04-26 13:04:42',1,'public/ynresponsivepurity_slider/13/0013_05ea.jpeg','jpeg','m_d26a1d_16a5dddb8bc040e997019cbed058968a.jpeg','image','jpeg',71422,'1b7205eadac5552a2452e6c68e995650'),(20,19,'thumb.icon','ynresponsivepurity_slider',1,1,'2016-04-26 13:04:42','2016-04-26 13:04:42',1,'public/ynresponsivepurity_slider/14/0014_4d27.jpeg','jpeg','is_d26a1d_16a5dddb8bc040e997019cbed058968a.jpeg','image','jpeg',4606,'f2794d278a13464daf3dcef1a8f7d3c3'),(21,NULL,NULL,'ynresponsivepurity_slider',2,1,'2016-04-26 13:10:03','2016-04-26 13:10:03',1,'public/ynresponsivepurity_slider/15/0015_681e.jpg','jpg','m_d26a1d_6953ae6ef2014530ab7bf00ba8a61856.jpg','image','jpeg',179190,'e995681ef8689892bc574b0745b311a7'),(22,21,'thumb.icon','ynresponsivepurity_slider',2,1,'2016-04-26 13:10:03','2016-04-26 13:10:03',1,'public/ynresponsivepurity_slider/16/0016_46a9.jpg','jpg','is_d26a1d_6953ae6ef2014530ab7bf00ba8a61856.jpg','image','jpeg',3641,'eaaf46a95ada1ef028be34469d6db969'),(27,NULL,NULL,'ynresponsivepurity_slider',4,1,'2016-04-26 13:42:19','2016-04-26 13:42:19',1,'public/ynresponsivepurity_slider/1b/001b_f64b.jpg','jpg','m_d26a1d_ea3c5029ed1d45b89533fddd574ef1e1.jpg','image','jpeg',129943,'875ef64b07f3f22fd091e0d0e8fed43f'),(28,27,'thumb.icon','ynresponsivepurity_slider',4,1,'2016-04-26 13:42:19','2016-04-26 13:42:19',1,'public/ynresponsivepurity_slider/1c/001c_3014.jpg','jpg','is_d26a1d_ea3c5029ed1d45b89533fddd574ef1e1.jpg','image','jpeg',3726,'3aaa30146738dca41ceb963a5f2e0a51'),(45,NULL,NULL,'temporary',1,NULL,'2016-05-23 11:03:34','2016-05-23 11:03:34',1,'public/temporary/2d/002d_f396.jpg','jpg','m_spring-in-nature-wide-wallpaper-603794.jpg','image','jpeg',109239,'a96cf3968dda90cbb15508227a4862f7'),(46,45,'thumb.profile','temporary',1,NULL,'2016-05-23 11:03:34','2016-05-23 11:03:34',1,'public/temporary/2e/002e_d8df.jpg','jpg','p_spring-in-nature-wide-wallpaper-603794.jpg','image','jpeg',10703,'b250d8dfcc12ec4cdb49a6f5ed53f2bc'),(47,45,'thumb.normal','temporary',1,NULL,'2016-05-23 11:03:34','2016-05-23 11:03:34',1,'public/temporary/2f/002f_9815.jpg','jpg','n_spring-in-nature-wide-wallpaper-603794.jpg','image','jpeg',1338,'7afe98151bcbda3cb96e08379fe7bfdf'),(48,45,'thumb.icon','temporary',1,NULL,'2016-05-23 11:03:34','2016-05-23 11:03:34',1,'public/temporary/30/0030_91f2.jpg','jpg','s_spring-in-nature-wide-wallpaper-603794.jpg','image','jpeg',1644,'26cd91f24cbfeddbfca7754ef353df0e'),(59,NULL,NULL,'temporary',1,NULL,'2016-05-25 06:03:56','2016-05-25 06:03:56',1,'public/temporary/3b/003b_b02d.png','png','m_Screenshot from 2016-01-12 10:30:21.png','image','png',105240,'5b13b02d02c424f06f5a950906aea7c2'),(60,59,'thumb.profile','temporary',1,NULL,'2016-05-25 06:03:56','2016-05-25 06:03:56',1,'public/temporary/3c/003c_ede3.png','png','p_Screenshot from 2016-01-12 10:30:21.png','image','png',11255,'3160ede385b3e9a3897178f4326d81c0'),(61,59,'thumb.normal','temporary',1,NULL,'2016-05-25 06:03:57','2016-05-25 06:03:57',1,'public/temporary/3d/003d_7f86.png','png','n_Screenshot from 2016-01-12 10:30:21.png','image','png',1587,'11447f8699202e0f5732a106eb40f6c7'),(62,59,'thumb.icon','temporary',1,NULL,'2016-05-25 06:03:57','2016-05-25 06:03:57',1,'public/temporary/3e/003e_8e96.png','png','s_Screenshot from 2016-01-12 10:30:21.png','image','png',1353,'5fb78e9617ad97c0a3aea79a92e32333'),(71,NULL,NULL,'temporary',1,NULL,'2016-05-25 07:31:30','2016-05-25 07:31:30',1,'public/temporary/47/0047_3abc.jpg','jpg','m_11230901_886589094755731_6774415355774420168_n.jpg','image','jpeg',67615,'d91a3abc935fb6f1ca3f68f6b72494c4'),(72,71,'thumb.profile','temporary',1,NULL,'2016-05-25 07:31:30','2016-05-25 07:31:30',1,'public/temporary/48/0048_9130.jpg','jpg','p_11230901_886589094755731_6774415355774420168_n.jpg','image','jpeg',19770,'ad3c9130e5b200299a908e6ff390dd7f'),(73,71,'thumb.normal','temporary',1,NULL,'2016-05-25 07:31:30','2016-05-25 07:31:30',1,'public/temporary/49/0049_b6e2.jpg','jpg','n_11230901_886589094755731_6774415355774420168_n.jpg','image','jpeg',2193,'8c09b6e2647ad5eaa788f8d17cb457d5'),(74,71,'thumb.icon','temporary',1,NULL,'2016-05-25 07:31:30','2016-05-25 07:31:30',1,'public/temporary/4a/004a_4d1d.jpg','jpg','s_11230901_886589094755731_6774415355774420168_n.jpg','image','jpeg',1605,'c4f24d1d6a19bb104e0cdd79a5d3a7f2'),(75,NULL,NULL,'temporary',1,NULL,'2016-05-25 07:34:06','2016-05-25 07:34:06',1,'public/temporary/4b/004b_b048.jpg','jpg','m_326_1406_1604_2232.jpg','image','jpeg',93916,'2cffb0489ab17f055974266c1e376900'),(76,75,'thumb.profile','temporary',1,NULL,'2016-05-25 07:34:07','2016-05-25 07:34:07',1,'public/temporary/4c/004c_cc42.jpg','jpg','p_326_1406_1604_2232.jpg','image','jpeg',9365,'888dcc42748fe9eabab977d5fc055098'),(77,75,'thumb.normal','temporary',1,NULL,'2016-05-25 07:34:07','2016-05-25 07:34:07',1,'public/temporary/4d/004d_f4fd.jpg','jpg','n_326_1406_1604_2232.jpg','image','jpeg',1238,'9793f4fda705bbfec439fbb88912bb94'),(78,75,'thumb.icon','temporary',1,NULL,'2016-05-25 07:34:07','2016-05-25 07:34:07',1,'public/temporary/4e/004e_ee7e.jpg','jpg','s_326_1406_1604_2232.jpg','image','jpeg',1476,'827fee7e73bcb519d910753d1d20b82a'),(83,NULL,NULL,'user',39,NULL,'2016-05-25 07:52:41','2016-05-25 07:52:41',1,'public/user/53/0053_bc18.jpg','jpg','m_IMG-20151121-WA0003.jpg','image','jpeg',19732,'6641bc187c049e8d9ecad0e886c9be1c'),(84,83,'thumb.profile','user',39,NULL,'2016-05-25 07:52:41','2016-05-25 07:52:41',1,'public/user/54/0054_6400.jpg','jpg','p_IMG-20151121-WA0003.jpg','image','jpeg',6347,'71f06400a35da2778ae404128df8052c'),(85,83,'thumb.normal','user',39,NULL,'2016-05-25 07:52:42','2016-05-25 07:52:42',1,'public/user/55/0055_517d.jpg','jpg','n_IMG-20151121-WA0003.jpg','image','jpeg',1345,'b9f7517d986dba1d44e6e96584227da5'),(86,83,'thumb.icon','user',39,NULL,'2016-05-25 07:52:42','2016-05-25 07:52:42',1,'public/user/56/0056_6db2.jpg','jpg','s_IMG-20151121-WA0003.jpg','image','jpeg',1213,'cace6db2696a8833dd3e55baa5961245'),(95,NULL,NULL,'temporary',1,NULL,'2016-05-25 09:57:48','2016-05-25 09:57:48',1,'public/temporary/5f/005f_b048.jpg','jpg','m_326_1406_1604_2232.jpg','image','jpeg',93916,'2cffb0489ab17f055974266c1e376900'),(96,95,'thumb.profile','temporary',1,NULL,'2016-05-25 09:57:48','2016-05-25 09:57:48',1,'public/temporary/60/0060_cc42.jpg','jpg','p_326_1406_1604_2232.jpg','image','jpeg',9365,'888dcc42748fe9eabab977d5fc055098'),(97,95,'thumb.normal','temporary',1,NULL,'2016-05-25 09:57:48','2016-05-25 09:57:48',1,'public/temporary/61/0061_f4fd.jpg','jpg','n_326_1406_1604_2232.jpg','image','jpeg',1238,'9793f4fda705bbfec439fbb88912bb94'),(98,95,'thumb.icon','temporary',1,NULL,'2016-05-25 09:57:48','2016-05-25 09:57:48',1,'public/temporary/62/0062_ee7e.jpg','jpg','s_326_1406_1604_2232.jpg','image','jpeg',1476,'827fee7e73bcb519d910753d1d20b82a'),(103,NULL,NULL,'user',39,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/user/67/0067_23c9.jpg','jpg','download_m.jpg','image','jpeg',8616,'c36323c9ccacf1dff39868b63183bcd8'),(104,103,'thumb.profile','user',39,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/user/68/0068_23c9.jpg','jpg','download_p.jpg','image','jpeg',8616,'c36323c9ccacf1dff39868b63183bcd8'),(105,103,'thumb.normal','user',39,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/user/69/0069_40b8.jpg','jpg','download_in.jpg','image','jpeg',5395,'cc9d40b86c183b1daf0501f238e3af53'),(106,103,'thumb.icon','user',39,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/user/6a/006a_d233.jpg','jpg','download_is.jpg','image','jpeg',1449,'9e36d2332a2c371a89117e973eaf002a'),(107,NULL,NULL,'album_photo',2,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/album_photo/6b/006b_5fcb.jpg','jpg','download_m_m.jpg','image','jpeg',8594,'026e5fcbd063fe2b6553eceb791aad42'),(108,107,'thumb.normal','album_photo',2,39,'2016-05-26 04:55:22','2016-05-26 04:55:22',1,'public/album_photo/6c/006c_0a49.jpg','jpg','download_m_in.jpg','image','jpeg',5298,'ddcb0a493fb9ab9e684d927322905dc0'),(109,NULL,NULL,'user',39,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/user/6d/006d_ddea.jpg','jpg','Minutewin_m.jpg','image','jpeg',5585,'2f26ddeadec0d42ab43053b152fa4fa8'),(110,109,'thumb.profile','user',39,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/user/6e/006e_ddea.jpg','jpg','Minutewin_p.jpg','image','jpeg',5585,'2f26ddeadec0d42ab43053b152fa4fa8'),(111,109,'thumb.normal','user',39,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/user/6f/006f_ddea.jpg','jpg','Minutewin_in.jpg','image','jpeg',5585,'2f26ddeadec0d42ab43053b152fa4fa8'),(112,109,'thumb.icon','user',39,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/user/70/0070_7bf4.jpg','jpg','Minutewin_is.jpg','image','jpeg',1480,'222e7bf42eae8ddeb0537efe960d1a7f'),(113,NULL,NULL,'album_photo',3,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/album_photo/71/0071_6416.jpg','jpg','Minutewin_m_m.jpg','image','jpeg',5584,'14df6416bfa3b45ae0d707d5192b76e6'),(114,113,'thumb.normal','album_photo',3,39,'2016-05-26 04:56:27','2016-05-26 04:56:27',1,'public/album_photo/72/0072_6416.jpg','jpg','Minutewin_m_in.jpg','image','jpeg',5584,'14df6416bfa3b45ae0d707d5192b76e6'),(169,NULL,NULL,'temporary',1,NULL,'2016-06-03 04:19:58','2016-06-03 04:19:58',1,'public/temporary/a9/00a9_c4f4.jpg','jpg','m_funny-cute-baby-hd-wallpapers.jpg','image','jpeg',46675,'3ee6c4f4b620f5d84bb0a35b0d31ec92'),(170,169,'thumb.profile','temporary',1,NULL,'2016-06-03 04:19:58','2016-06-03 04:19:58',1,'public/temporary/aa/00aa_9592.jpg','jpg','p_funny-cute-baby-hd-wallpapers.jpg','image','jpeg',6445,'fb829592ffb8ae7969e6b17ebfcc5f6b'),(171,169,'thumb.normal','temporary',1,NULL,'2016-06-03 04:19:59','2016-06-03 04:19:59',1,'public/temporary/ab/00ab_98ab.jpg','jpg','n_funny-cute-baby-hd-wallpapers.jpg','image','jpeg',1131,'a56298abdad67285e22f61737ee3eac8'),(172,169,'thumb.icon','temporary',1,NULL,'2016-06-03 04:19:59','2016-06-03 04:19:59',1,'public/temporary/ac/00ac_6c47.jpg','jpg','s_funny-cute-baby-hd-wallpapers.jpg','image','jpeg',1383,'7a0e6c47d9917fa19d1aad5a1baee8e3'),(218,NULL,NULL,'temporary',1,NULL,'2016-06-08 11:20:04','2016-06-08 11:20:04',1,'public/temporary/da/00da_fb9b.jpg','jpg','m_Desert.jpg','image','jpeg',58069,'39cefb9b7fa57e0e16037f2daf75fc8b'),(219,218,'thumb.profile','temporary',1,NULL,'2016-06-08 11:20:05','2016-06-08 11:20:05',1,'public/temporary/db/00db_a084.jpg','jpg','p_Desert.jpg','image','jpeg',5858,'38b1a0847a0f3952e0d7afc7510c6f75'),(220,218,'thumb.normal','temporary',1,NULL,'2016-06-08 11:20:05','2016-06-08 11:20:05',1,'public/temporary/dc/00dc_5d27.jpg','jpg','n_Desert.jpg','image','jpeg',1121,'801e5d27aad5d10e1865f4c12afb5d36'),(221,218,'thumb.icon','temporary',1,NULL,'2016-06-08 11:20:05','2016-06-08 11:20:05',1,'public/temporary/dd/00dd_ff2b.jpg','jpg','s_Desert.jpg','image','jpeg',1204,'5d4cff2bcc865df49f8d5cfb641ff754'),(242,NULL,'artarticle','artarticle',1,7,'2016-06-14 10:05:00','2016-06-14 10:05:00',1,'public/artarticle/f2/00f2_e927.jpeg','jpeg','cq5dam.web.672.378_m.jpeg','image','jpeg',44769,'86dbe92798de23f82f1887bb5016bd63'),(243,242,'thumb.profile','artarticle',1,7,'2016-06-14 10:05:00','2016-06-14 10:05:00',1,'public/artarticle/f3/00f3_8f1d.jpeg','jpeg','cq5dam.web.672.378_p.jpeg','image','jpeg',5370,'4ad78f1d51d2d3ab46844fa76533a5d7'),(244,242,'thumb.normal','artarticle',1,7,'2016-06-14 10:05:00','2016-06-14 10:05:00',1,'public/artarticle/f4/00f4_271b.jpeg','jpeg','cq5dam.web.672.378_n.jpeg','image','jpeg',3169,'da16271b1b2d413bbe6cbea20343675a'),(245,242,'thumb.icon','artarticle',1,7,'2016-06-14 10:05:00','2016-06-14 10:05:00',1,'public/artarticle/f5/00f5_879c.jpeg','jpeg','cq5dam.web.672.378_i.jpeg','image','jpeg',1482,'8a3b879c7e3977be505c6a624b046472'),(246,NULL,'artarticle','artarticle',2,39,'2016-06-14 12:10:07','2016-06-14 12:10:07',1,'public/artarticle/f6/00f6_1e29.jpg','jpg','room-1_m.jpg','image','jpeg',50182,'961c1e294ebbd79b50a48e852a61e580'),(247,246,'thumb.profile','artarticle',2,39,'2016-06-14 12:10:07','2016-06-14 12:10:07',1,'public/artarticle/f7/00f7_edac.jpg','jpg','room-1_p.jpg','image','jpeg',5611,'49d8edacf324f8e5493ecfe32de41792'),(248,246,'thumb.normal','artarticle',2,39,'2016-06-14 12:10:07','2016-06-14 12:10:07',1,'public/artarticle/f8/00f8_2d81.jpg','jpg','room-1_n.jpg','image','jpeg',3309,'da8b2d817a1817e6eeca15ac25175e23'),(249,246,'thumb.icon','artarticle',2,39,'2016-06-14 12:10:07','2016-06-14 12:10:07',1,'public/artarticle/f9/00f9_2ef9.jpg','jpg','room-1_i.jpg','image','jpeg',1255,'83102ef983eb762e5923069508500c33'),(260,NULL,NULL,'user',73,NULL,'2016-06-17 05:22:26','2016-06-17 05:22:26',1,'public/user/05/01/0104_5ef2.jpeg','jpeg','m_cartoon-animated-wallpapers-53.jpeg','image','jpeg',25555,'0c535ef2524ed06b425dbed385cbd9a2'),(261,260,'thumb.profile','user',73,NULL,'2016-06-17 05:22:26','2016-06-17 05:22:26',1,'public/user/06/01/0105_bc9d.jpeg','jpeg','p_cartoon-animated-wallpapers-53.jpeg','image','jpeg',4169,'6c47bc9d5aab1da77f8bbae3eae0d0bd'),(262,260,'thumb.normal','user',73,NULL,'2016-06-17 05:22:26','2016-06-17 05:22:26',1,'public/user/07/01/0106_f7ff.jpeg','jpeg','n_cartoon-animated-wallpapers-53.jpeg','image','jpeg',1125,'596af7ff03a076d904f4cc842e5e775e'),(263,260,'thumb.icon','user',73,NULL,'2016-06-17 05:22:26','2016-06-17 05:22:26',1,'public/user/08/01/0107_44df.jpeg','jpeg','s_cartoon-animated-wallpapers-53.jpeg','image','jpeg',1379,'dac744df370c4935648b31ee962fe015'),(264,NULL,NULL,'user',75,NULL,'2016-06-17 08:38:42','2016-06-17 08:38:42',1,'public/user/09/01/0108_2d59.jpg','jpg','m_Cute Baby Girl With Red Flowers HD Wallpapers-1280x800-cutelittlebabies.blogspot.com.jpg','image','jpeg',70392,'04ed2d59afaad0016d0a2999eb7cab31'),(265,264,'thumb.profile','user',75,NULL,'2016-06-17 08:38:42','2016-06-17 08:38:42',1,'public/user/0a/01/0109_cf0c.jpg','jpg','p_Cute Baby Girl With Red Flowers HD Wallpapers-1280x800-cutelittlebabies.blogspot.com.jpg','image','jpeg',8418,'e451cf0c7e519c29d312f0bc1018762b'),(266,264,'thumb.normal','user',75,NULL,'2016-06-17 08:38:42','2016-06-17 08:38:42',1,'public/user/0b/01/010a_5860.jpg','jpg','n_Cute Baby Girl With Red Flowers HD Wallpapers-1280x800-cutelittlebabies.blogspot.com.jpg','image','jpeg',1180,'ddad5860f03d77abcf5dce81286bca02'),(267,264,'thumb.icon','user',75,NULL,'2016-06-17 08:38:42','2016-06-17 08:38:42',1,'public/user/0c/01/010b_5af3.jpg','jpg','s_Cute Baby Girl With Red Flowers HD Wallpapers-1280x800-cutelittlebabies.blogspot.com.jpg','image','jpeg',1518,'fa985af3089645702753958b67696d1c'),(268,NULL,NULL,'user',74,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/user/0d/01/010c_ac21.jpg','jpg','12_m.jpg','image','jpeg',60189,'6fb0ac214df189ae5299675b969bab93'),(269,268,'thumb.profile','user',74,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/user/0e/01/010d_bf4e.jpg','jpg','12_p.jpg','image','jpeg',8788,'9d82bf4ee5be16659ffa8f8147b5ddca'),(270,268,'thumb.normal','user',74,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/user/0f/01/010e_25d8.jpg','jpg','12_in.jpg','image','jpeg',5317,'ac3a25d88814c618cf8ac2f4c4c4ae92'),(271,268,'thumb.icon','user',74,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/user/10/01/010f_d941.jpg','jpg','nis_010d_bf4e.jpg','image','jpeg',1381,'0007d94177821a29a55f7493660c5cba'),(272,NULL,NULL,'album_photo',12,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/album_photo/11/01/0110_ad5e.jpg','jpg','12_m_m.jpg','image','jpeg',60151,'1038ad5e50d594f3ae8f13239dc71986'),(273,272,'thumb.normal','album_photo',12,74,'2016-06-17 08:43:53','2016-06-17 08:43:53',1,'public/album_photo/12/01/0111_69ce.jpg','jpg','12_m_in.jpg','image','jpeg',5295,'03d469ced9fca31f57dc82fae9ef6f26'),(274,NULL,NULL,'user',76,NULL,'2016-06-17 08:49:30','2016-06-17 08:49:30',1,'public/user/13/01/0112_20c1.jpg','jpg','m_8.jpg','image','jpeg',53846,'ae7e20c1db54486c2d26b74857c00d93'),(275,274,'thumb.profile','user',76,NULL,'2016-06-17 08:49:30','2016-06-17 08:49:30',1,'public/user/14/01/0113_a71f.jpg','jpg','p_8.jpg','image','jpeg',12252,'be11a71f70f78976e0c446cbe3227344'),(276,274,'thumb.normal','user',76,NULL,'2016-06-17 08:49:30','2016-06-17 08:49:30',1,'public/user/15/01/0114_097e.jpg','jpg','n_8.jpg','image','jpeg',1654,'5129097e70ed109bd4aa7a88c6b3bd37'),(277,274,'thumb.icon','user',76,76,'2016-06-17 08:49:30','2016-06-17 08:49:30',1,'public/user/16/01/0115_13b8.jpg','jpg','nis_0113_a71f.jpg','image','jpeg',1246,'614213b8c0cccb77a4cabf00af65b5cf'),(278,NULL,NULL,'user',77,NULL,'2016-06-17 08:51:04','2016-06-17 08:51:04',1,'public/user/17/01/0116_69fc.jpg','jpg','m_7.jpg','image','jpeg',41302,'e59d69fc1a610a2603d9cdc6980c0218'),(279,278,'thumb.profile','user',77,NULL,'2016-06-17 08:51:04','2016-06-17 08:51:04',1,'public/user/18/01/0117_02fa.jpg','jpg','p_7.jpg','image','jpeg',10576,'4f1b02fa260f710c4cb1f982f9511c00'),(280,278,'thumb.normal','user',77,NULL,'2016-06-17 08:51:04','2016-06-17 08:51:04',1,'public/user/19/01/0118_f3ef.jpg','jpg','n_7.jpg','image','jpeg',1675,'e521f3ef67baf68a21011411c35227fe'),(281,278,'thumb.icon','user',77,77,'2016-06-17 08:51:04','2016-06-17 08:51:04',1,'public/user/1a/01/0119_b4e1.jpg','jpg','nis_0117_02fa.jpg','image','jpeg',1326,'ebb8b4e128a7525767aa3ca4cdae1a07'),(282,NULL,NULL,'user',78,NULL,'2016-06-17 08:57:59','2016-06-17 08:57:59',1,'public/user/1b/01/011a_bcfc.jpg','jpg','m_3.jpg','image','jpeg',58864,'cde8bcfc63d979059903f0a438ee3942'),(283,282,'thumb.profile','user',78,NULL,'2016-06-17 08:57:59','2016-06-17 08:57:59',1,'public/user/1c/01/011b_029c.jpg','jpg','p_3.jpg','image','jpeg',15405,'15ee029c62987c76c2b91222855bf7bc'),(284,282,'thumb.normal','user',78,NULL,'2016-06-17 08:57:59','2016-06-17 08:57:59',1,'public/user/1d/01/011c_2303.jpg','jpg','n_3.jpg','image','jpeg',2006,'9c9423033d38931072650aad40d67729'),(285,282,'thumb.icon','user',78,78,'2016-06-17 08:57:59','2016-06-17 08:57:59',1,'public/user/1e/01/011d_3b43.jpg','jpg','nis_011b_029c.jpg','image','jpeg',1566,'7ff83b4355a8481d202def091b251d05'),(286,NULL,NULL,'user',79,NULL,'2016-06-17 09:00:26','2016-06-17 09:00:26',1,'public/user/1f/01/011e_19e8.jpg','jpg','m_9.1.jpg','image','jpeg',75374,'445119e872c107ff92392547102da789'),(287,286,'thumb.profile','user',79,NULL,'2016-06-17 09:00:26','2016-06-17 09:00:26',1,'public/user/20/01/011f_3d7c.jpg','jpg','p_9.1.jpg','image','jpeg',9739,'125d3d7c1710bc55fc75b672c9cb352d'),(288,286,'thumb.normal','user',79,NULL,'2016-06-17 09:00:26','2016-06-17 09:00:26',1,'public/user/21/01/0120_232a.jpg','jpg','n_9.1.jpg','image','jpeg',1407,'81a3232a580e836915e693d57a844512'),(289,286,'thumb.icon','user',79,NULL,'2016-06-17 09:00:26','2016-06-17 09:00:26',1,'public/user/22/01/0121_1fab.jpg','jpg','s_9.1.jpg','image','jpeg',1733,'56431fab901145b9aefb50d4561400f0'),(290,NULL,NULL,'user',80,NULL,'2016-06-17 09:23:40','2016-06-17 09:23:40',1,'public/user/23/01/0122_474f.jpg','jpg','m_free-puppy-wallpaper-3.jpg','image','jpeg',53491,'46c6474fc5a9aa81379bd575550d53e7'),(291,290,'thumb.profile','user',80,NULL,'2016-06-17 09:23:40','2016-06-17 09:23:40',1,'public/user/24/01/0123_8f91.jpg','jpg','p_free-puppy-wallpaper-3.jpg','image','jpeg',7353,'b1d88f919e7a6c690e96d967f27d770d'),(292,290,'thumb.normal','user',80,NULL,'2016-06-17 09:23:40','2016-06-17 09:23:40',1,'public/user/25/01/0124_3fae.jpg','jpg','n_free-puppy-wallpaper-3.jpg','image','jpeg',1336,'c3653faeff706e1106f34171acaf938d'),(293,290,'thumb.icon','user',80,80,'2016-06-17 09:23:40','2016-06-17 09:23:40',1,'public/user/26/01/0125_1a45.jpg','jpg','nis_0123_8f91.jpg','image','jpeg',1146,'324e1a454b24fa9e5423d0c5dd142fc8'),(294,NULL,NULL,'album_photo',13,74,'2016-06-17 16:25:18','2016-06-17 16:25:18',1,'public/album_photo/27/01/0126_c380.jpg','jpg','4_m.jpg','image','jpeg',60623,'02b6c3807e099a78452b72db6a444b2c'),(295,294,'thumb.normal','album_photo',13,74,'2016-06-17 16:25:18','2016-06-17 16:25:18',1,'public/album_photo/28/01/0127_5622.jpg','jpg','4_in.jpg','image','jpeg',5926,'4b585622e25c82f2f7a3cd811c0bb0ab'),(296,NULL,NULL,'album_photo',14,74,'2016-06-17 16:27:03','2016-06-17 16:27:03',1,'public/album_photo/29/01/0128_ac21.jpg','jpg','12_m.jpg','image','jpeg',60189,'6fb0ac214df189ae5299675b969bab93'),(297,296,'thumb.normal','album_photo',14,74,'2016-06-17 16:27:03','2016-06-17 16:27:03',1,'public/album_photo/2a/01/0129_25d8.jpg','jpg','12_in.jpg','image','jpeg',5317,'ac3a25d88814c618cf8ac2f4c4c4ae92'),(298,NULL,NULL,'album_photo',15,74,'2016-06-17 16:27:18','2016-06-17 16:27:18',1,'public/album_photo/2b/01/012a_c380.jpg','jpg','4_m.jpg','image','jpeg',60623,'02b6c3807e099a78452b72db6a444b2c'),(299,298,'thumb.normal','album_photo',15,74,'2016-06-17 16:27:18','2016-06-17 16:27:18',1,'public/album_photo/2c/01/012b_5622.jpg','jpg','4_in.jpg','image','jpeg',5926,'4b585622e25c82f2f7a3cd811c0bb0ab'),(300,NULL,'artarticle','artarticle',3,39,'2016-06-17 16:28:33','2016-06-17 16:28:33',1,'public/artarticle/2d/01/012c_ffc7.jpg','jpg','eJw1xVsKgCAQAMAbuZZSbpcRfBOiktvj+EHY%2FEwiahuAm2UPD4puor0vZnM9XThqIVY8Qarkc4eVf2BROFYcxwrFv56kNmxv8QVfDRsN (1)_m.jpg','image','jpeg',15131,'c47fffc7ebce1e55269bb891d7e113c6'),(301,300,'thumb.profile','artarticle',3,39,'2016-06-17 16:28:33','2016-06-17 16:28:33',1,'public/artarticle/2e/01/012d_dd06.jpg','jpg','eJw1xVsKgCAQAMAbuZZSbpcRfBOiktvj+EHY%2FEwiahuAm2UPD4puor0vZnM9XThqIVY8Qarkc4eVf2BROFYcxwrFv56kNmxv8QVfDRsN (1)_p.jpg','image','jpeg',6090,'266edd06bb02232b726d1c2a7b9f40a2'),(302,300,'thumb.normal','artarticle',3,39,'2016-06-17 16:28:33','2016-06-17 16:28:33',1,'public/artarticle/2f/01/012e_c136.jpg','jpg','eJw1xVsKgCAQAMAbuZZSbpcRfBOiktvj+EHY%2FEwiahuAm2UPD4puor0vZnM9XThqIVY8Qarkc4eVf2BROFYcxwrFv56kNmxv8QVfDRsN (1)_n.jpg','image','jpeg',3788,'812ac136ec40531dcdbdaa6407547fe9'),(303,300,'thumb.icon','artarticle',3,39,'2016-06-17 16:28:33','2016-06-17 16:28:33',1,'public/artarticle/30/01/012f_ad3a.jpg','jpg','eJw1xVsKgCAQAMAbuZZSbpcRfBOiktvj+EHY%2FEwiahuAm2UPD4puor0vZnM9XThqIVY8Qarkc4eVf2BROFYcxwrFv56kNmxv8QVfDRsN (1)_i.jpg','image','jpeg',1346,'0460ad3a18e021a0dd46ce255b1b3c71'),(304,NULL,NULL,'album_photo',16,77,'2016-06-17 17:19:24','2016-06-17 17:19:24',1,'public/album_photo/31/01/0130_c380.jpg','jpg','4_m.jpg','image','jpeg',60623,'02b6c3807e099a78452b72db6a444b2c'),(305,304,'thumb.normal','album_photo',16,77,'2016-06-17 17:19:24','2016-06-17 17:19:24',1,'public/album_photo/32/01/0131_5622.jpg','jpg','4_in.jpg','image','jpeg',5926,'4b585622e25c82f2f7a3cd811c0bb0ab'),(306,NULL,NULL,'temporary',1,NULL,'2016-06-18 15:37:20','2016-06-18 15:37:20',1,'public/temporary/33/01/0132_ba33.jpeg','jpeg','m_image.jpeg','image','jpeg',48007,'922eba335f4021aef31a25c8b110395f'),(307,306,'thumb.profile','temporary',1,NULL,'2016-06-18 15:37:20','2016-06-18 15:37:20',1,'public/temporary/34/01/0133_d8f6.jpeg','jpeg','p_image.jpeg','image','jpeg',10030,'b748d8f65c3984d75d1caccca2969371'),(308,306,'thumb.normal','temporary',1,NULL,'2016-06-18 15:37:21','2016-06-18 15:37:21',1,'public/temporary/35/01/0134_ba53.jpeg','jpeg','n_image.jpeg','image','jpeg',1522,'13c8ba53a717a688d9c663e8f89fc401'),(309,306,'thumb.icon','temporary',1,NULL,'2016-06-18 15:37:21','2016-06-18 15:37:21',1,'public/temporary/36/01/0135_687d.jpeg','jpeg','s_image.jpeg','image','jpeg',1354,'c999687dd4bcb8bebde17ebb646b10da'),(310,NULL,NULL,'user',86,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/user/37/01/0136_52f5.jpeg','jpeg','image_m.jpeg','image','jpeg',64708,'e00252f5a04207a44e1568bdb897af12'),(311,310,'thumb.profile','user',86,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/user/38/01/0137_9bfd.jpeg','jpeg','image_p.jpeg','image','jpeg',11508,'1d309bfd8c90630f16dcbc4c9216fea9'),(312,310,'thumb.normal','user',86,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/user/39/01/0138_919a.jpeg','jpeg','image_in.jpeg','image','jpeg',4816,'757c919aa058ce504608e14ad3b8d4eb'),(313,310,'thumb.icon','user',86,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/user/3a/01/0139_b13b.jpeg','jpeg','image_is.jpeg','image','jpeg',1275,'b92fb13b4f87b80d803a0789d94ce3a9'),(314,NULL,NULL,'album_photo',17,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/album_photo/3b/01/013a_0740.jpeg','jpeg','image_m_m.jpeg','image','jpeg',64648,'3f4a074066aa28b154092c87e2ca296d'),(315,314,'thumb.normal','album_photo',17,86,'2016-06-18 17:25:42','2016-06-18 17:25:42',1,'public/album_photo/3c/01/013b_0821.jpeg','jpeg','image_m_in.jpeg','image','jpeg',4769,'1e02082112a8c13704037b6d89b310dc'),(316,NULL,NULL,'album_photo',19,78,'2016-06-20 05:12:53','2016-06-20 05:12:53',1,'public/album_photo/3d/01/013c_9f9e.jpg','jpg','interior-designing-inside-heavenly-interior-design-ideas-for-interior-design-schools_m.jpg','image','jpeg',40181,'4bf99f9e00f9299eda462215b0a6c4af'),(317,316,'thumb.normal','album_photo',19,78,'2016-06-20 05:12:53','2016-06-20 05:12:53',1,'public/album_photo/3e/01/013d_63e4.jpg','jpg','interior-designing-inside-heavenly-interior-design-ideas-for-interior-design-schools_in.jpg','image','jpeg',3536,'c86f63e45d5bd9a1e01010d00aef26b9'),(322,NULL,NULL,'user',88,NULL,'2016-06-20 07:56:50','2016-06-20 07:56:50',1,'public/user/43/01/0142_6bfa.jpg','jpg','m_5174501070_cddcb849ae_o.jpg','image','jpeg',18519,'174f6bfa86ec158614e06b2745357521'),(323,322,'thumb.profile','user',88,NULL,'2016-06-20 07:56:50','2016-06-20 07:56:50',1,'public/user/44/01/0143_fb6a.jpg','jpg','p_5174501070_cddcb849ae_o.jpg','image','jpeg',3185,'7b3ffb6a9a4db101d71ef248bb237d8c'),(324,322,'thumb.normal','user',88,NULL,'2016-06-20 07:56:50','2016-06-20 07:56:50',1,'public/user/45/01/0144_0000.jpg','jpg','n_5174501070_cddcb849ae_o.jpg','image','jpeg',959,'7200000074a59d98fa349ea7fe280ee3'),(325,322,'thumb.icon','user',88,88,'2016-06-20 07:56:50','2016-06-20 07:56:50',1,'public/user/46/01/0145_5b87.jpg','jpg','nis_0143_fb6a.jpg','image','jpeg',1189,'58e75b87d131090b94e01394b1815bcd'),(326,NULL,NULL,'user',87,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/user/47/01/0146_1d8c.jpg','jpg','fghfgh_m.jpg','image','jpeg',7310,'bb3d1d8cac4bcdf8a160c44607f33ecf'),(327,326,'thumb.profile','user',87,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/user/48/01/0147_d14b.jpg','jpg','fghfgh_p.jpg','image','jpeg',4748,'c3ffd14b99ce8134a10c60a92555770b'),(328,326,'thumb.normal','user',87,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/user/49/01/0148_60be.jpg','jpg','fghfgh_in.jpg','image','jpeg',3022,'55cd60be375e21cbf8245f3d4fae10bc'),(329,326,'thumb.icon','user',87,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/user/4a/01/0149_fa4f.jpg','jpg','nis_0147_d14b.jpg','image','jpeg',1263,'d07cfa4fa760c3a009f570732d347a57'),(330,NULL,NULL,'album_photo',20,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/album_photo/4b/01/014a_c415.jpg','jpg','fghfgh_m_m.jpg','image','jpeg',7293,'a9e6c415410e3fb48387effdb714d662'),(331,330,'thumb.normal','album_photo',20,87,'2016-06-20 09:28:45','2016-06-20 09:28:45',1,'public/album_photo/4c/01/014b_dfec.jpg','jpg','fghfgh_m_in.jpg','image','jpeg',3019,'c047dfec37082dcea646409f987ae601'),(332,NULL,NULL,'user',89,NULL,'2016-06-20 10:01:44','2016-06-20 10:01:44',1,'public/user/4d/01/014c_6f3a.jpg','jpg','m_95943_original.jpg','image','jpeg',9349,'b4766f3ad6dc608eb131e555ff25cb63'),(333,332,'thumb.profile','user',89,NULL,'2016-06-20 10:01:44','2016-06-20 10:01:44',1,'public/user/4e/01/014d_6f3a.jpg','jpg','p_95943_original.jpg','image','jpeg',9349,'b4766f3ad6dc608eb131e555ff25cb63'),(334,332,'thumb.normal','user',89,NULL,'2016-06-20 10:01:44','2016-06-20 10:01:44',1,'public/user/4f/01/014e_d01a.jpg','jpg','n_95943_original.jpg','image','jpeg',1445,'1ea2d01ade22af91a34e0e2a0f7cfea5'),(335,332,'thumb.icon','user',89,NULL,'2016-06-20 10:01:44','2016-06-20 10:01:44',1,'public/user/50/01/014f_d01a.jpg','jpg','s_95943_original.jpg','image','jpeg',1445,'1ea2d01ade22af91a34e0e2a0f7cfea5'),(336,NULL,NULL,'user',90,NULL,'2016-06-20 10:24:28','2016-06-20 10:24:28',1,'public/user/51/01/0150_c0f1.jpg','jpg','m_ramona.jpg','image','jpeg',11143,'f0eec0f1d05c2cb21a7823271cc327b6'),(337,336,'thumb.profile','user',90,NULL,'2016-06-20 10:24:28','2016-06-20 10:24:28',1,'public/user/52/01/0151_c0f1.jpg','jpg','p_ramona.jpg','image','jpeg',11143,'f0eec0f1d05c2cb21a7823271cc327b6'),(338,336,'thumb.normal','user',90,NULL,'2016-06-20 10:24:28','2016-06-20 10:24:28',1,'public/user/53/01/0152_fcad.jpg','jpg','n_ramona.jpg','image','jpeg',1706,'0c03fcaddcdeac78d1b132084a3c1e8e'),(339,336,'thumb.icon','user',90,90,'2016-06-20 10:24:28','2016-06-20 10:24:28',1,'public/user/54/01/0153_af21.jpg','jpg','nis_0151_c0f1.jpg','image','jpeg',1441,'2ac0af21bca091aa96ea51d25996d990'),(340,NULL,NULL,'user',91,NULL,'2016-06-20 11:07:29','2016-06-20 11:07:29',1,'public/user/55/01/0154_8aea.jpg','jpg','m_Children-Girls-Profile-Hat-Cap-Dutch-768x1366.jpg','image','jpeg',36002,'1d148aea03c0c13f1c5d11889dd42177'),(341,340,'thumb.profile','user',91,NULL,'2016-06-20 11:07:29','2016-06-20 11:07:29',1,'public/user/56/01/0155_164c.jpg','jpg','p_Children-Girls-Profile-Hat-Cap-Dutch-768x1366.jpg','image','jpeg',4438,'b120164c349150cac586469bad3f6909'),(342,340,'thumb.normal','user',91,NULL,'2016-06-20 11:07:29','2016-06-20 11:07:29',1,'public/user/57/01/0156_8079.jpg','jpg','n_Children-Girls-Profile-Hat-Cap-Dutch-768x1366.jpg','image','jpeg',1062,'d0798079da2678deca64b8b69f64c764'),(343,340,'thumb.icon','user',91,91,'2016-06-20 11:07:29','2016-06-20 11:07:29',1,'public/user/58/01/0157_275a.jpg','jpg','nis_0155_164c.jpg','image','jpeg',1321,'7700275a07353572f7ad4ef2697fb7d8'),(344,NULL,NULL,'user',39,39,'2016-06-20 11:08:58','2016-06-20 11:08:58',1,'public/user/59/01/0158_2960.jpg','jpg','13076878_985906198157353_4237471766253000693_n_m.jpg','image','jpeg',7775,'722e296062e721561a0a38a5a0c4d3ab'),(345,344,'thumb.profile','user',39,39,'2016-06-20 11:08:58','2016-06-20 11:08:58',1,'public/user/5a/01/0159_2960.jpg','jpg','13076878_985906198157353_4237471766253000693_n_p.jpg','image','jpeg',7775,'722e296062e721561a0a38a5a0c4d3ab'),(346,344,'thumb.normal','user',39,39,'2016-06-20 11:08:58','2016-06-20 11:08:58',1,'public/user/5b/01/015a_3d65.jpg','jpg','13076878_985906198157353_4237471766253000693_n_in.jpg','image','jpeg',4612,'64153d650799a90465c301d9542aa790'),(347,344,'thumb.icon','user',39,39,'2016-06-20 11:08:58','2016-06-20 11:08:58',1,'public/user/5c/01/015b_f907.jpg','jpg','13076878_985906198157353_4237471766253000693_n_is.jpg','image','jpeg',1345,'be9ef90704c9e6caea5b4213b5b5feca'),(348,NULL,NULL,'album_photo',21,39,'2016-06-20 11:09:08','2016-06-20 11:09:08',1,'public/album_photo/5d/01/015c_9e63.jpg','jpg','13076878_985906198157353_4237471766253000693_n_m_m.jpg','image','jpeg',7777,'bce59e638462dbd95bf375fea8e2d98b'),(349,348,'thumb.normal','album_photo',21,39,'2016-06-20 11:09:08','2016-06-20 11:09:08',1,'public/album_photo/5e/01/015d_f55d.jpg','jpg','13076878_985906198157353_4237471766253000693_n_m_in.jpg','image','jpeg',4597,'acedf55d7684bcf8c149805a8445a282'),(350,NULL,NULL,'user',92,NULL,'2016-06-20 11:12:25','2016-06-20 11:12:25',1,'public/user/5f/01/015e_0700.jpg','jpg','m_fghfhggh.jpg','image','jpeg',5474,'78f40700dea9b2e05a40293cb4d5b827'),(351,350,'thumb.profile','user',92,NULL,'2016-06-20 11:12:25','2016-06-20 11:12:25',1,'public/user/60/01/015f_970a.jpg','jpg','p_fghfhggh.jpg','image','jpeg',3129,'0bba970a76aa04d7c317671a3154b082'),(352,350,'thumb.normal','user',92,NULL,'2016-06-20 11:12:25','2016-06-20 11:12:25',1,'public/user/61/01/0160_32b4.jpg','jpg','n_fghfhggh.jpg','image','jpeg',996,'3f9032b4da3d733527b4b303ac031dfc'),(353,350,'thumb.icon','user',92,92,'2016-06-20 11:12:25','2016-06-20 11:12:25',1,'public/user/62/01/0161_bffd.jpg','jpg','nis_015f_970a.jpg','image','jpeg',1222,'7e75bffdbcf8831c24dcce29ed44fa7d'),(354,NULL,NULL,'user',77,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/user/63/01/0162_9994.jpg','jpg','5_m.jpg','image','jpeg',45780,'be8c99940b20196b8c25741756e226db'),(355,354,'thumb.profile','user',77,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/user/64/01/0163_08c7.jpg','jpg','5_p.jpg','image','jpeg',12413,'75d408c73edf4448c56246dd360871c4'),(356,354,'thumb.normal','user',77,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/user/65/01/0164_ddbc.jpg','jpg','5_in.jpg','image','jpeg',4957,'c313ddbc1fa70546e93ff8b1b7e0974d'),(357,354,'thumb.icon','user',77,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/user/66/01/0165_699f.jpg','jpg','nis_0163_08c7.jpg','image','jpeg',1406,'5fb1699f2cec48892b02a6b470cc294b'),(358,NULL,NULL,'album_photo',22,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/album_photo/67/01/0166_f89e.jpg','jpg','5_m_m.jpg','image','jpeg',45768,'2f07f89ec442caca1d2b27a95cb1e67e'),(359,358,'thumb.normal','album_photo',22,77,'2016-06-20 11:15:21','2016-06-20 11:15:21',1,'public/album_photo/68/01/0167_5f80.jpg','jpg','5_m_in.jpg','image','jpeg',4914,'e8215f808779ef9427fbc2beafae5126'),(360,NULL,NULL,'user',88,88,'2016-06-20 11:39:49','2016-06-20 11:39:49',1,'public/user/69/01/0168_1794.jpg','jpg','5174501070_cddcb849ae_o_m.jpg','image','jpeg',18515,'6b5c17947bbbcf186bb84a8403e31e3e'),(361,360,'thumb.profile','user',88,88,'2016-06-20 11:39:49','2016-06-20 11:39:49',1,'public/user/6a/01/0169_b954.jpg','jpg','5174501070_cddcb849ae_o_p.jpg','image','jpeg',3185,'5c7bb95466d8a486e5d595a14ad50da9'),(362,360,'thumb.normal','user',88,88,'2016-06-20 11:39:49','2016-06-20 11:39:49',1,'public/user/6b/01/016a_104a.jpg','jpg','5174501070_cddcb849ae_o_in.jpg','image','jpeg',2075,'e23b104a1d1abc847adf9ea23171705e'),(363,360,'thumb.icon','user',88,88,'2016-06-20 11:39:49','2016-06-20 11:39:49',1,'public/user/6c/01/016b_0310.jpg','jpg','nis_0169_b954.jpg','image','jpeg',1193,'1b2a0310f35ba36a018c0b26b459a31e'),(364,NULL,NULL,'album_photo',23,88,'2016-06-20 11:39:50','2016-06-20 11:39:50',1,'public/album_photo/6d/01/016c_2c68.jpg','jpg','5174501070_cddcb849ae_o_m_m.jpg','image','jpeg',18477,'b0cf2c689ba6ee2325b891d39d622dec'),(365,364,'thumb.normal','album_photo',23,88,'2016-06-20 11:39:50','2016-06-20 11:39:50',1,'public/album_photo/6e/01/016d_8703.jpg','jpg','5174501070_cddcb849ae_o_m_in.jpg','image','jpeg',2059,'58c6870310ba36f9d8966587cb4bb3f6'),(366,NULL,NULL,'user',89,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/user/6f/01/016e_b457.jpg','jpg','95943_original_m.jpg','image','jpeg',9349,'3c4bb457d47a0b63e51cc2760d16f943'),(367,366,'thumb.profile','user',89,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/user/70/01/016f_b457.jpg','jpg','95943_original_p.jpg','image','jpeg',9349,'3c4bb457d47a0b63e51cc2760d16f943'),(368,366,'thumb.normal','user',89,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/user/71/01/0170_eeda.jpg','jpg','95943_original_in.jpg','image','jpeg',4920,'ec4aeeda21de0cc9b201983f21486e1e'),(369,366,'thumb.icon','user',89,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/user/72/01/0171_5c2e.jpg','jpg','95943_original_is.jpg','image','jpeg',1446,'a9f45c2ef66bace029c90bc8e4dd470e'),(370,NULL,NULL,'album_photo',24,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/album_photo/73/01/0172_0536.jpg','jpg','95943_original_m_m.jpg','image','jpeg',9341,'52880536ea438e7002b436882ff165ae'),(371,370,'thumb.normal','album_photo',24,89,'2016-06-20 11:42:08','2016-06-20 11:42:08',1,'public/album_photo/74/01/0173_9894.jpg','jpg','95943_original_m_in.jpg','image','jpeg',5079,'a7dd989416e7f257adb3115b6fb6a667'),(372,NULL,NULL,'user',78,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/user/75/01/0174_7a6b.jpg','jpg','3_m.jpg','image','jpeg',58873,'c4a47a6bd071136670180856213db5f3'),(373,372,'thumb.profile','user',78,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/user/76/01/0175_b0fe.jpg','jpg','3_p.jpg','image','jpeg',15405,'a622b0fe8302f0834f18a07ce946dd55'),(374,372,'thumb.normal','user',78,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/user/77/01/0176_e741.jpg','jpg','3_in.jpg','image','jpeg',5991,'85cbe74191cd74a8706edb815295b9c8'),(375,372,'thumb.icon','user',78,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/user/78/01/0177_9797.jpg','jpg','nis_0175_b0fe.jpg','image','jpeg',1370,'604897977f820a3e28e8acd3e4770094'),(376,NULL,NULL,'album_photo',25,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/album_photo/79/01/0178_eecc.jpg','jpg','3_m_m.jpg','image','jpeg',58759,'5e67eecc0a07b83c331c5866ca31dc44'),(377,376,'thumb.normal','album_photo',25,78,'2016-06-20 11:43:38','2016-06-20 11:43:38',1,'public/album_photo/7a/01/0179_5d90.jpg','jpg','3_m_in.jpg','image','jpeg',5935,'c9b15d90bdddcacb9c07cb850b330638'),(378,NULL,NULL,'user',74,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/user/7b/01/017a_8752.jpg','jpg','12_m.jpg','image','jpeg',60186,'ae8d875223b73fbcebb46fbca844e6f9'),(379,378,'thumb.profile','user',74,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/user/7c/01/017b_f889.jpg','jpg','12_p.jpg','image','jpeg',8787,'1ee0f889c2f4c565e893b0cc32d878e3'),(380,378,'thumb.normal','user',74,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/user/7d/01/017c_ba10.jpg','jpg','12_in.jpg','image','jpeg',5316,'c76aba10c00fe3b18bd688970b272408'),(381,378,'thumb.icon','user',74,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/user/7e/01/017d_cd93.jpg','jpg','nis_017b_f889.jpg','image','jpeg',1240,'6602cd93c4945ad4bc054b47a62f7e12'),(382,NULL,NULL,'album_photo',26,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/album_photo/7f/01/017e_3500.jpg','jpg','12_m_m.jpg','image','jpeg',60154,'d1c235006b10a96fec996721ea58d94c'),(383,382,'thumb.normal','album_photo',26,74,'2016-06-20 11:44:49','2016-06-20 11:44:49',1,'public/album_photo/80/01/017f_0137.jpg','jpg','12_m_in.jpg','image','jpeg',5294,'499401377e0c0de59b180b05ceec24ae'),(384,NULL,NULL,'user',90,90,'2016-06-20 11:45:59','2016-06-20 11:45:59',1,'public/user/81/01/0180_f061.jpg','jpg','PSX_20160430_133601_m.jpg','image','jpeg',50324,'e9d7f0618455835cc649524c4f39326a'),(385,384,'thumb.profile','user',90,90,'2016-06-20 11:45:59','2016-06-20 11:45:59',1,'public/user/82/01/0181_1472.jpg','jpg','PSX_20160430_133601_p.jpg','image','jpeg',12051,'f009147228d16a76b5d2cb594428c46b'),(386,384,'thumb.normal','user',90,90,'2016-06-20 11:45:59','2016-06-20 11:45:59',1,'public/user/83/01/0182_f666.jpg','jpg','PSX_20160430_133601_in.jpg','image','jpeg',4736,'d961f666f29dbc8f428d3db755ddc984'),(387,384,'thumb.icon','user',90,90,'2016-06-20 11:45:59','2016-06-20 11:45:59',1,'public/user/84/01/0183_43d9.jpg','jpg','nis_0181_1472.jpg','image','jpeg',1376,'203943d9db8ff2ffc406207429f9afe8'),(388,NULL,NULL,'album_photo',27,90,'2016-06-20 11:46:00','2016-06-20 11:46:00',1,'public/album_photo/85/01/0184_839e.jpg','jpg','PSX_20160430_133601_m_m.jpg','image','jpeg',50312,'88ef839e3d9f5c2a844fc96bb1600cd9'),(389,388,'thumb.normal','album_photo',27,90,'2016-06-20 11:46:00','2016-06-20 11:46:00',1,'public/album_photo/86/01/0185_4f3b.jpg','jpg','PSX_20160430_133601_m_in.jpg','image','jpeg',4700,'d7354f3bd7af08098d93b304db267d74'),(390,NULL,NULL,'user',87,87,'2016-06-20 11:48:42','2016-06-20 11:48:42',1,'public/user/87/01/0186_416f.jpg','jpg','8_m.jpg','image','jpeg',53880,'6de2416f28c77f96fe97eb6505d1d549'),(391,390,'thumb.profile','user',87,87,'2016-06-20 11:48:42','2016-06-20 11:48:42',1,'public/user/88/01/0187_9852.jpg','jpg','8_p.jpg','image','jpeg',12203,'6689985228723b67d80b5cb4b003fee9'),(392,390,'thumb.normal','user',87,87,'2016-06-20 11:48:42','2016-06-20 11:48:42',1,'public/user/89/01/0188_06c3.jpg','jpg','8_in.jpg','image','jpeg',4533,'2b8f06c38492f30d85b2c6a0c48b5558'),(393,390,'thumb.icon','user',87,87,'2016-06-20 11:48:42','2016-06-20 11:48:42',1,'public/user/8a/01/0189_4ed4.jpg','jpg','8_is.jpg','image','jpeg',1303,'118f4ed4c8df7a5b8da293b718eff37c'),(394,NULL,NULL,'album_photo',28,87,'2016-06-20 11:48:43','2016-06-20 11:48:43',1,'public/album_photo/8b/01/018a_0096.jpg','jpg','8_m_m.jpg','image','jpeg',53837,'6bdf0096e8bfd443c7d4eeebd9c03bd4'),(395,394,'thumb.normal','album_photo',28,87,'2016-06-20 11:48:43','2016-06-20 11:48:43',1,'public/album_photo/8c/01/018b_2577.jpg','jpg','8_m_in.jpg','image','jpeg',4488,'d1ca2577909fab3d7fb9b0d34585e6d0'),(396,NULL,NULL,'user',87,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/user/8d/01/018c_a5a9.JPG','JPG','IMG_2064_m.JPG','image','jpeg',53376,'8e43a5a9e75a553def5e2935dcdf39f0'),(397,396,'thumb.profile','user',87,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/user/8e/01/018d_6e11.JPG','JPG','IMG_2064_p.JPG','image','jpeg',7603,'815b6e11729cb99c75b73cf166553d74'),(398,396,'thumb.normal','user',87,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/user/8f/01/018e_5aa1.JPG','JPG','IMG_2064_in.JPG','image','jpeg',4646,'d8585aa130dd9e6a9b05061fe8df4677'),(399,396,'thumb.icon','user',87,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/user/90/01/018f_8482.JPG','JPG','IMG_2064_is.JPG','image','jpeg',1574,'52a584820e7da336251eced1f7021849'),(400,NULL,NULL,'album_photo',29,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/album_photo/91/01/0190_b4d0.JPG','JPG','IMG_2064_m_m.JPG','image','jpeg',53329,'b307b4d09c0de04a3bfbae00b2dcdaf4'),(401,400,'thumb.normal','album_photo',29,87,'2016-06-20 11:49:33','2016-06-20 11:49:33',1,'public/album_photo/92/01/0191_2235.JPG','JPG','IMG_2064_m_in.JPG','image','jpeg',4609,'3c9f22354da5d947808a974a27f36b7f'),(402,NULL,NULL,'user',93,NULL,'2016-06-20 12:04:54','2016-06-20 12:04:54',1,'public/user/93/01/0192_a1f3.jpg','jpg','m_e30829903af879505b9a24effde292f8.jpg','image','jpeg',56635,'81aba1f3826496b4f5c8229db20f04e5'),(403,402,'thumb.profile','user',93,NULL,'2016-06-20 12:04:54','2016-06-20 12:04:54',1,'public/user/94/01/0193_2be7.jpg','jpg','p_e30829903af879505b9a24effde292f8.jpg','image','jpeg',13621,'75542be72d90c9832312a1576a129ba9'),(404,402,'thumb.normal','user',93,NULL,'2016-06-20 12:04:54','2016-06-20 12:04:54',1,'public/user/95/01/0194_1d79.jpg','jpg','n_e30829903af879505b9a24effde292f8.jpg','image','jpeg',1863,'58631d79634684ae857146414b3af741'),(405,402,'thumb.icon','user',93,93,'2016-06-20 12:04:54','2016-06-20 12:04:54',1,'public/user/96/01/0195_1210.jpg','jpg','nis_0193_2be7.jpg','image','jpeg',1373,'c40012105e51f217a56256ac9672f470'),(406,NULL,'artarticle','artarticle',6,7,'2016-06-20 12:39:17','2016-06-20 12:39:17',1,'public/artarticle/97/01/0196_dcf9.jpg','jpg','17824_1_m.jpg','image','jpeg',17754,'5214dcf986dfefcd88bf9b08068843a4'),(407,406,'thumb.profile','artarticle',6,7,'2016-06-20 12:39:17','2016-06-20 12:39:17',1,'public/artarticle/98/01/0197_ca9f.jpg','jpg','17824_1_p.jpg','image','jpeg',5334,'7ac5ca9f6ba97e7c77b290a6a32a5d0f'),(408,406,'thumb.normal','artarticle',6,7,'2016-06-20 12:39:17','2016-06-20 12:39:17',1,'public/artarticle/99/01/0198_71a5.jpg','jpg','17824_1_n.jpg','image','jpeg',3159,'199971a5f411f0e4a71872de3b59a2ac'),(409,406,'thumb.icon','artarticle',6,7,'2016-06-20 12:39:17','2016-06-20 12:39:17',1,'public/artarticle/9a/01/0199_feff.jpg','jpg','17824_1_i.jpg','image','jpeg',1161,'f14afeff0585224a6272335b32568135'),(410,NULL,NULL,'user',73,73,'2016-06-20 12:50:37','2016-06-20 12:50:37',1,'public/user/9b/01/019a_f6dd.jpg','jpg','alberto contador 1_m.jpg','image','jpeg',5595,'6c10f6ddb358585590806eaaad8db6e4'),(411,410,'thumb.profile','user',73,73,'2016-06-20 12:50:37','2016-06-20 12:50:37',1,'public/user/9c/01/019b_a46c.jpg','jpg','alberto contador 1_p.jpg','image','jpeg',4263,'8662a46cf2a7d04aef0499d47e6b4707'),(412,410,'thumb.normal','user',73,73,'2016-06-20 12:50:37','2016-06-20 12:50:37',1,'public/user/9d/01/019c_9d51.jpg','jpg','alberto contador 1_in.jpg','image','jpeg',2827,'a0119d510d4e28e46f48f6afac148a5d'),(413,410,'thumb.icon','user',73,73,'2016-06-20 12:50:37','2016-06-20 12:50:37',1,'public/user/9e/01/019d_2a25.jpg','jpg','alberto contador 1_is.jpg','image','jpeg',1263,'6a332a2557fc474e471bff254d5218ef'),(414,NULL,NULL,'album_photo',30,73,'2016-06-20 12:50:38','2016-06-20 12:50:38',1,'public/album_photo/9f/01/019e_0d4b.jpg','jpg','alberto contador 1_m_m.jpg','image','jpeg',5606,'f82c0d4b5668001650101472d212adaf'),(415,414,'thumb.normal','album_photo',30,73,'2016-06-20 12:50:38','2016-06-20 12:50:38',1,'public/album_photo/a0/01/019f_4462.jpg','jpg','alberto contador 1_m_in.jpg','image','jpeg',2831,'8eaa44628a1ecfe4b910a563c1387773');
/*!40000 ALTER TABLE `engine4_storage_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_mirrors`
--

DROP TABLE IF EXISTS `engine4_storage_mirrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_mirrors` (
  `file_id` bigint(20) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`file_id`,`service_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_mirrors`
--

LOCK TABLES `engine4_storage_mirrors` WRITE;
/*!40000 ALTER TABLE `engine4_storage_mirrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_storage_mirrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_services`
--

DROP TABLE IF EXISTS `engine4_storage_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicetype_id` int(10) unsigned NOT NULL,
  `config` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_services`
--

LOCK TABLES `engine4_storage_services` WRITE;
/*!40000 ALTER TABLE `engine4_storage_services` DISABLE KEYS */;
INSERT INTO `engine4_storage_services` VALUES (1,1,NULL,1,1);
/*!40000 ALTER TABLE `engine4_storage_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_servicetypes`
--

DROP TABLE IF EXISTS `engine4_storage_servicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `plugin` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_servicetypes`
--

LOCK TABLES `engine4_storage_servicetypes` WRITE;
/*!40000 ALTER TABLE `engine4_storage_servicetypes` DISABLE KEYS */;
INSERT INTO `engine4_storage_servicetypes` VALUES (1,'Local Storage','Storage_Service_Local','Storage_Form_Admin_Service_Local',1),(2,'Database Storage','Storage_Service_Db','Storage_Form_Admin_Service_Db',0),(3,'Amazon S3','Storage_Service_S3','Storage_Form_Admin_Service_S3',1),(4,'Virtual File System','Storage_Service_Vfs','Storage_Form_Admin_Service_Vfs',1),(5,'Round-Robin','Storage_Service_RoundRobin','Storage_Form_Admin_Service_RoundRobin',0),(6,'Mirrored','Storage_Service_Mirrored','Storage_Form_Admin_Service_Mirrored',0);
/*!40000 ALTER TABLE `engine4_storage_servicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_block`
--

DROP TABLE IF EXISTS `engine4_user_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_block` (
  `user_id` int(11) unsigned NOT NULL,
  `blocked_user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`blocked_user_id`),
  KEY `REVERSE` (`blocked_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_block`
--

LOCK TABLES `engine4_user_block` WRITE;
/*!40000 ALTER TABLE `engine4_user_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_documents`
--

DROP TABLE IF EXISTS `engine4_user_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `document_name` varchar(250) NOT NULL,
  `document` varchar(500) NOT NULL,
  `created_at` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_documents`
--

LOCK TABLES `engine4_user_documents` WRITE;
/*!40000 ALTER TABLE `engine4_user_documents` DISABLE KEYS */;
INSERT INTO `engine4_user_documents` VALUES (1,36,'test document','public/documents/36/57550d261bbd4.pdf','2016-06-06'),(2,36,'test document','public/documents/36/57550d844dd44.docx','2016-06-06'),(3,39,'Test','public/documents/39/5757f84fc10e4.txt','2016-06-08'),(4,46,'Test','public/documents/46/5758f102c08bc.docx','2016-06-09'),(5,46,'Test 1','public/documents/46/5758f186797f8.txt','2016-06-09'),(6,46,'test 2','public/documents/46/5758f62279d93.csv','2016-06-09'),(7,46,'test 2','public/documents/46/5758f66056c7d.csv','2016-06-09'),(8,46,'test','public/documents/46/57627d5d29c17.jpg','2016-06-16'),(9,46,'test 1','public/documents/46/57627d780d577.jpg','2016-06-16'),(10,68,'Pay stubs','public/documents/68/5762833b56640.jpg','2016-06-16'),(11,68,'Birthday','public/documents/68/576283b0a913d.jpg','2016-06-16'),(12,68,'Christmas Time','public/documents/68/576283d2a3026.jpg','2016-06-16'),(13,68,'Tax  Estimator 2016','public/documents/68/57628409c0553.xls','2016-06-16'),(14,74,'Pay stubs','public/documents/74/57640d171163f.docx','2016-06-17'),(15,74,'My Doc 1','public/documents/74/57640d383f053.pptx','2016-06-17'),(16,86,'Resource ','public/documents/86/57656d4791062.jpg','2016-06-18');
/*!40000 ALTER TABLE `engine4_user_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_facebook`
--

DROP TABLE IF EXISTS `engine4_user_facebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_facebook` (
  `user_id` int(11) unsigned NOT NULL,
  `facebook_uid` bigint(20) unsigned NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `facebook_uid` (`facebook_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_facebook`
--

LOCK TABLES `engine4_user_facebook` WRITE;
/*!40000 ALTER TABLE `engine4_user_facebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_facebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_maps`
--

DROP TABLE IF EXISTS `engine4_user_fields_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_maps`
--

LOCK TABLES `engine4_user_fields_maps` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_maps` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_maps` VALUES (0,0,1,1),(1,1,2,1),(1,1,3,2),(1,1,4,3),(1,1,5,4),(1,1,6,5),(1,1,7,9),(1,1,8,10),(1,1,9,11),(1,1,10,12),(1,1,11,13),(1,1,12,14),(1,1,13,15),(1,1,14,16),(1,1,15,19),(1,1,16,20),(1,1,65,21),(1,1,66,22),(1,1,67,23),(1,1,69,6),(1,1,70,7),(1,1,71,8),(1,1,72,17),(1,1,73,18),(1,4,17,2),(1,4,18,3),(1,4,19,4),(1,4,21,1),(1,4,30,7),(1,4,31,8),(1,4,33,6),(1,4,34,9),(1,5,35,2),(1,5,36,3),(1,5,37,4),(1,5,39,1),(1,5,40,10),(1,5,41,12),(1,5,42,13),(1,5,43,8),(1,5,44,7),(1,5,45,6),(1,5,46,9),(1,5,47,9999),(1,6,48,1),(1,6,49,2),(1,6,50,3),(1,6,51,4),(1,6,52,5),(1,6,53,6),(1,6,54,7),(1,6,55,8),(1,6,56,10),(1,6,57,11),(1,6,58,12),(1,6,59,13),(1,6,60,14),(1,6,61,15),(1,6,62,16),(1,6,63,17),(1,6,64,18),(1,6,68,9);
/*!40000 ALTER TABLE `engine4_user_fields_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_meta`
--

DROP TABLE IF EXISTS `engine4_user_fields_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_meta`
--

LOCK TABLES `engine4_user_fields_meta` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_meta` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_meta` VALUES (1,'profile_type','Profile Type','','profile_type',1,0,0,2,1,999,'',NULL,NULL,NULL,NULL),(2,'heading','Personal Information','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(3,'first_name','First Name','','first_name',1,1,0,2,1,999,'[]','[[\"StringLength\",false,[1,32]]]',NULL,'',''),(4,'last_name','Last Name','','last_name',1,1,0,2,1,999,'','[[\"StringLength\",false,[1,32]]]',NULL,NULL,NULL),(5,'gender','Gender','','gender',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(6,'birthdate','Birthday','','birthdate',1,1,0,0,1,999,'{\"min_age\":\"18\"}',NULL,NULL,'',''),(7,'heading','Contact Information','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(8,'website','Website','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(9,'twitter','Twitter','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(10,'facebook','Facebook','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(11,'aim','AIM','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(12,'heading','Personal Details','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(13,'about_me','Bio','','about_me',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(14,'select','Education','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(15,'select','Annual Income','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(16,'text','Credit Score','','',0,0,0,0,0,999,'[]',NULL,NULL,'',''),(17,'first_name','First Name','','first_name',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(18,'last_name','Last Name','','last_name',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(19,'gender','Gender','','gender',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(21,'heading','Personal information','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(30,'text','State','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(31,'text','City','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(33,'text','Country','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(34,'text','Zip code ','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(35,'text','First Name','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(36,'text','Last Name','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(37,'text','Gender','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(39,'heading','Business Profile','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(40,'heading','Business info','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(41,'text','Service Provided','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(42,'text','How long in business','','',1,1,0,0,1,999,'[]',NULL,NULL,'',''),(43,'text','State','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(44,'text','City','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(45,'text','County','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(46,'text','Zip code ','','',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(47,'about_me','Cover Letter','','about_me',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(48,'heading','Personal Information','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(49,'first_name','First Name','','first_name',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(50,'last_name','Last Name','','last_name',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(51,'gender','Gender','','gender',1,1,0,0,1,999,'[]',NULL,NULL,'',''),(52,'birthdate','Birthday','','birthdate',1,1,0,0,1,999,'{\"min_age\":\"18\"}',NULL,NULL,'',''),(53,'text','Country','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(54,'text','State','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(55,'text','City','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(56,'heading','Contact Information','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(57,'aim','AIM','','aim',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(58,'facebook','Facebook','','facebook',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(59,'twitter','Twitter','','twitter',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(60,'website','Website','','website',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(61,'heading','Professional Information','','',0,1,0,0,1,999,'[]',NULL,NULL,NULL,NULL),(62,'text','Company Name','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(63,'textarea','Address','','',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(64,'text','Years in Business','','',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(65,'text','Employment','','',0,1,0,0,0,999,'[]',NULL,NULL,'',''),(66,'text','Cover Letter','','',0,1,0,0,0,999,'[]',NULL,NULL,'',''),(67,'textarea','New Cover Letter','','',0,1,0,0,0,999,'[]',NULL,NULL,'',''),(68,'text','Zip Code','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(69,'text','Zip Code','','',1,1,0,1,1,999,'[]',NULL,NULL,'',''),(70,'select','I have pets','','',1,1,0,0,1,999,'[]',NULL,NULL,'',''),(71,'select','Type of pets','','',0,1,0,0,1,999,'[]',NULL,NULL,'',''),(72,'select','Specialization','','',0,1,0,1,1,999,'[]',NULL,NULL,'',''),(73,'select','Specialization','','',0,1,0,1,1,999,'[]',NULL,NULL,'','');
/*!40000 ALTER TABLE `engine4_user_fields_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_options`
--

DROP TABLE IF EXISTS `engine4_user_fields_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_options`
--

LOCK TABLES `engine4_user_fields_options` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_options` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_options` VALUES (1,1,'Tenant',1),(2,5,'Male',1),(3,5,'Female',2),(4,1,'Landlord',999),(5,1,'Legal Aide',999),(6,1,'Services',999),(7,51,'Male',1),(8,51,'Female',2),(9,19,'Male',999),(10,19,'Female',999),(11,70,'Yes',3),(12,70,'No',4),(13,71,'Cats',7),(14,71,'Dogs',8),(15,71,'Cats & Dogs',5),(16,71,'Birds',6),(17,71,'Small pets',9),(18,14,'High school',10),(19,14,'College',11),(20,72,'Diploma or equivalent',12),(21,73,'Associate',14),(22,73,'Bachelor',13),(23,73,'Master',15),(24,73,'Doctorate',16),(25,15,'20,000 - 30,000',17),(26,15,'40,000 - 50,000',18),(27,15,'60,000 - 70,000',19),(28,15,'80,000 - 90,000',20),(29,15,'100, 000 - 150,000',21),(30,15,'200,000+',22);
/*!40000 ALTER TABLE `engine4_user_fields_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_search`
--

DROP TABLE IF EXISTS `engine4_user_fields_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` enum('1','4','5','6') COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `field_15` enum('25','26','27','28','29','30') COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_14` enum('18','19') COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_18` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_17` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_19` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_20` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `about_me` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_30` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_31` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_33` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_41` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_35` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_53` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_54` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_55` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_34` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_69` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_68` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_72` enum('20') COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_73` enum('22','21','23','24') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `field_18` (`field_18`),
  KEY `field_17` (`field_17`),
  KEY `field_19` (`field_19`),
  KEY `field_20` (`field_20`),
  KEY `about_me` (`about_me`),
  KEY `field_41` (`field_41`),
  KEY `field_35` (`field_35`),
  KEY `profile_type` (`profile_type`),
  KEY `gender` (`gender`),
  KEY `birthdate` (`birthdate`),
  KEY `field_33` (`field_33`),
  KEY `field_53` (`field_53`),
  KEY `field_54` (`field_54`),
  KEY `field_55` (`field_55`),
  KEY `field_30` (`field_30`),
  KEY `field_31` (`field_31`),
  KEY `field_69` (`field_69`),
  KEY `field_68` (`field_68`),
  KEY `field_34` (`field_34`),
  KEY `field_14` (`field_14`),
  KEY `field_15` (`field_15`),
  KEY `field_72` (`field_72`),
  KEY `field_73` (`field_73`),
  KEY `last_name` (`last_name`),
  KEY `first_name` (`first_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_search`
--

LOCK TABLES `engine4_user_fields_search` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_search` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_search` VALUES (1,'1','mic','b','2','1991-03-03','','',NULL,NULL,NULL,NULL,'top landlord',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'1','jithesh','pk','','2004-01-01','','',NULL,NULL,NULL,NULL,'bio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,'1','Visal','Varghese','2','1998-01-01','26','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123456',NULL,'20','21'),(71,'1','Ashikh','C K','2','1998-01-01','26','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90001',NULL,'20','22'),(72,'1','Catherine','Glenita','3','1998-01-01','27','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90001',NULL,'20','21'),(73,'1','Frank','Mark','2','1987-04-07','29','18',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123456',NULL,'',''),(74,'1','Sulthan','Kareem','2','1998-01-01','26','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90001',NULL,'','22'),(75,'1','Jemy','Thomas','3','1991-09-21','29','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123456',NULL,'','22'),(76,'1','Rita','Jose','3','1998-01-01','25','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90001',NULL,'','22'),(77,'4',NULL,NULL,'9',NULL,NULL,NULL,'Prakash','Bindiya',NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90001',NULL,NULL,NULL,NULL),(78,'4',NULL,NULL,'10',NULL,NULL,NULL,'Biju','Deepthy',NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90002',NULL,NULL,NULL,NULL),(79,'6','Ganesh','Nath','7','1998-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','','1',NULL,NULL,'90002',NULL,NULL),(80,'6','Helen','Cruce','7','1992-07-07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','','1',NULL,NULL,'123456',NULL,NULL),(82,'4',NULL,NULL,'10',NULL,NULL,NULL,'Vasudev','Meera',NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'123456',NULL,NULL,NULL,NULL),(83,'4',NULL,NULL,'9',NULL,NULL,NULL,'vcbcvb','ewrwer',NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'123456',NULL,NULL,NULL,NULL),(84,'1','Fabia','Hinds','3','1972-01-03','28','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11236',NULL,'','22'),(85,'1','Teenu','Thomas','3','1998-01-01','26','18',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123456',NULL,'20',''),(86,'1','Fabia','Hinds','3','1998-01-01','28','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11236',NULL,'','22'),(87,'4','Lima','Philip','10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90002',NULL,NULL,NULL,NULL),(88,'4','Bianca','Kristine','10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90005',NULL,NULL,NULL,NULL),(89,'1','natasha ','Gomes','3','1998-01-01','27','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90006',NULL,'','21'),(90,'1','Sophia','Claire','3','1989-08-12','29','18',NULL,NULL,NULL,NULL,'Halo, I am Claire',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90003',NULL,'20',''),(91,'4','Angela','Cathy','10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90005',NULL,NULL,NULL,NULL),(92,'1','Tom','Sawyer','2','1984-08-04','29','19',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'90001',NULL,'','22'),(93,'4','Jamie','Sullivan','10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1',NULL,NULL,NULL,NULL,NULL,'90001',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `engine4_user_fields_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_values`
--

DROP TABLE IF EXISTS `engine4_user_fields_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_values`
--

LOCK TABLES `engine4_user_fields_values` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_values` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_values` VALUES (1,1,0,'1',NULL),(1,3,0,'mic','everyone'),(1,4,0,'b','everyone'),(1,5,0,'2','everyone'),(1,6,0,'1991-3-3','everyone'),(1,8,0,'','everyone'),(1,9,0,'','everyone'),(1,10,0,'','everyone'),(1,11,0,'','everyone'),(1,13,0,'top landlord','everyone'),(1,14,0,'',NULL),(1,15,0,'',NULL),(1,16,0,'',NULL),(1,65,0,'',NULL),(1,66,0,'',NULL),(1,67,0,'',NULL),(7,1,0,'1',NULL),(7,3,0,'jithesh',NULL),(7,4,0,'pk',NULL),(7,5,0,'2',NULL),(7,6,0,'2004-1-1',NULL),(7,8,0,'',NULL),(7,9,0,'',NULL),(7,10,0,'',NULL),(7,11,0,'',NULL),(7,13,0,'bio',NULL),(7,14,0,'',NULL),(7,15,0,'',NULL),(7,16,0,'',NULL),(39,1,0,'1',NULL),(39,3,0,'Visal',NULL),(39,4,0,'Varghese',NULL),(39,5,0,'2',NULL),(39,6,0,'1998-1-1',NULL),(39,8,0,'',NULL),(39,9,0,'',NULL),(39,10,0,'',NULL),(39,11,0,'',NULL),(39,13,0,'',NULL),(39,14,0,'19',NULL),(39,15,0,'26',NULL),(39,16,0,'100',NULL),(39,65,0,'',NULL),(39,66,0,'',NULL),(39,67,0,'',NULL),(39,69,0,'123456',NULL),(39,70,0,'11',NULL),(39,71,0,'17',NULL),(39,72,0,'20',NULL),(39,73,0,'21',NULL),(71,1,0,'1',NULL),(71,3,0,'Ashikh',NULL),(71,4,0,'C K',NULL),(71,5,0,'2',NULL),(71,6,0,'1998-1-1',NULL),(71,8,0,'',NULL),(71,9,0,'',NULL),(71,10,0,'',NULL),(71,11,0,'',NULL),(71,13,0,'',NULL),(71,14,0,'19',NULL),(71,15,0,'26',NULL),(71,16,0,'',NULL),(71,69,0,'90001',NULL),(71,70,0,'',NULL),(71,71,0,'',NULL),(71,72,0,'20',NULL),(71,73,0,'22',NULL),(72,1,0,'1',NULL),(72,3,0,'Catherine',NULL),(72,4,0,'Glenita',NULL),(72,5,0,'3',NULL),(72,6,0,'1998-1-1',NULL),(72,8,0,'',NULL),(72,9,0,'',NULL),(72,10,0,'',NULL),(72,11,0,'',NULL),(72,13,0,'',NULL),(72,14,0,'19',NULL),(72,15,0,'27',NULL),(72,16,0,'',NULL),(72,69,0,'90001',NULL),(72,70,0,'',NULL),(72,71,0,'',NULL),(72,72,0,'20',NULL),(72,73,0,'21',NULL),(73,1,0,'1',NULL),(73,3,0,'Frank',NULL),(73,4,0,'Mark',NULL),(73,5,0,'2',NULL),(73,6,0,'1987-4-7',NULL),(73,8,0,'',NULL),(73,9,0,'',NULL),(73,10,0,'',NULL),(73,11,0,'',NULL),(73,13,0,'',NULL),(73,14,0,'18',NULL),(73,15,0,'29',NULL),(73,16,0,'',NULL),(73,65,0,'',NULL),(73,66,0,' ',NULL),(73,67,0,'',NULL),(73,69,0,'123456',NULL),(73,70,0,'11',NULL),(73,71,0,'17',NULL),(73,72,0,'',NULL),(73,73,0,'',NULL),(74,1,0,'1',NULL),(74,3,0,'Sulthan',NULL),(74,4,0,'Kareem',NULL),(74,5,0,'2',NULL),(74,6,0,'1998-1-1',NULL),(74,8,0,'',NULL),(74,9,0,'',NULL),(74,10,0,'',NULL),(74,11,0,'',NULL),(74,13,0,'',NULL),(74,14,0,'19',NULL),(74,15,0,'26',NULL),(74,16,0,'',NULL),(74,65,0,'',NULL),(74,66,0,'2',NULL),(74,67,0,'',NULL),(74,69,0,'90001',NULL),(74,70,0,'11',NULL),(74,71,0,'14',NULL),(74,72,0,'',NULL),(74,73,0,'22',NULL),(75,1,0,'1',NULL),(75,3,0,'Jemy',NULL),(75,4,0,'Thomas',NULL),(75,5,0,'3',NULL),(75,6,0,'1991-9-21',NULL),(75,8,0,'',NULL),(75,9,0,'',NULL),(75,10,0,'',NULL),(75,11,0,'',NULL),(75,13,0,'',NULL),(75,14,0,'19',NULL),(75,15,0,'29',NULL),(75,69,0,'123456',NULL),(75,70,0,'11',NULL),(75,71,0,'17',NULL),(75,72,0,'',NULL),(75,73,0,'22',NULL),(76,1,0,'1',NULL),(76,3,0,'Rita',NULL),(76,4,0,'Jose',NULL),(76,5,0,'3',NULL),(76,6,0,'1998-1-1',NULL),(76,8,0,'',NULL),(76,9,0,'',NULL),(76,10,0,'',NULL),(76,11,0,'',NULL),(76,13,0,'',NULL),(76,14,0,'19',NULL),(76,15,0,'25',NULL),(76,16,0,'',NULL),(76,69,0,'90001',NULL),(76,70,0,'11',NULL),(76,71,0,'16',NULL),(76,72,0,'',NULL),(76,73,0,'22',NULL),(77,1,0,'4',NULL),(77,17,0,'Bindiya',NULL),(77,18,0,'Prakash',NULL),(77,19,0,'9',NULL),(77,30,0,'1',NULL),(77,31,0,'1',NULL),(77,33,0,'1',NULL),(77,34,0,'90001',NULL),(78,1,0,'4',NULL),(78,17,0,'Deepthy',NULL),(78,18,0,'Biju',NULL),(78,19,0,'10',NULL),(78,30,0,'1',NULL),(78,31,0,'1',NULL),(78,33,0,'1',NULL),(78,34,0,'90002',NULL),(79,1,0,'6',NULL),(79,49,0,'Ganesh',NULL),(79,50,0,'Nath',NULL),(79,51,0,'7',NULL),(79,52,0,'1998-1-1',NULL),(79,53,0,'1',NULL),(79,54,0,'',NULL),(79,55,0,'1',NULL),(79,57,0,'',NULL),(79,58,0,'',NULL),(79,59,0,'',NULL),(79,60,0,'',NULL),(79,62,0,'',NULL),(79,63,0,'',NULL),(79,64,0,'',NULL),(79,68,0,'90002',NULL),(80,1,0,'6',NULL),(80,49,0,'Helen',NULL),(80,50,0,'Cruce',NULL),(80,51,0,'7',NULL),(80,52,0,'1992-7-7',NULL),(80,53,0,'1',NULL),(80,54,0,'',NULL),(80,55,0,'1',NULL),(80,57,0,'',NULL),(80,58,0,'',NULL),(80,59,0,'',NULL),(80,60,0,'',NULL),(80,62,0,'',NULL),(80,63,0,'',NULL),(80,64,0,'',NULL),(80,68,0,'123456',NULL),(82,1,0,'4',NULL),(82,17,0,'Meera',NULL),(82,18,0,'Vasudev',NULL),(82,19,0,'10',NULL),(82,30,0,'1',NULL),(82,31,0,'1',NULL),(82,33,0,'1',NULL),(82,34,0,'123456',NULL),(83,1,0,'4',NULL),(83,17,0,'ewrwer',NULL),(83,18,0,'vcbcvb',NULL),(83,19,0,'9',NULL),(83,30,0,'1',NULL),(83,31,0,'1',NULL),(83,33,0,'1',NULL),(83,34,0,'123456',NULL),(84,1,0,'1',NULL),(84,3,0,'Fabia',NULL),(84,4,0,'Hinds',NULL),(84,5,0,'3',NULL),(84,6,0,'1972-1-3',NULL),(84,8,0,'',NULL),(84,9,0,'',NULL),(84,10,0,'',NULL),(84,11,0,'',NULL),(84,13,0,'',NULL),(84,14,0,'19',NULL),(84,15,0,'28',NULL),(84,69,0,'11236',NULL),(84,70,0,'12',NULL),(84,71,0,'',NULL),(84,72,0,'',NULL),(84,73,0,'22',NULL),(85,1,0,'1',NULL),(85,3,0,'Teenu',NULL),(85,4,0,'Thomas',NULL),(85,5,0,'3',NULL),(85,6,0,'1998-1-1',NULL),(85,8,0,'',NULL),(85,9,0,'',NULL),(85,10,0,'',NULL),(85,11,0,'',NULL),(85,13,0,'',NULL),(85,14,0,'18',NULL),(85,15,0,'26',NULL),(85,16,0,'',NULL),(85,65,0,'',NULL),(85,66,0,'2',NULL),(85,67,0,'',NULL),(85,69,0,'123456',NULL),(85,70,0,'11',NULL),(85,71,0,'13',NULL),(85,72,0,'20',NULL),(85,73,0,'',NULL),(86,1,0,'1',NULL),(86,3,0,'Fabia',NULL),(86,4,0,'Hinds',NULL),(86,5,0,'3',NULL),(86,6,0,'1998-1-1',NULL),(86,8,0,'',NULL),(86,9,0,'',NULL),(86,10,0,'',NULL),(86,11,0,'',NULL),(86,13,0,'',NULL),(86,14,0,'19',NULL),(86,15,0,'28',NULL),(86,16,0,'',NULL),(86,65,0,'Registered nurse',NULL),(86,66,0,' ',NULL),(86,67,0,'',NULL),(86,69,0,'11236',NULL),(86,70,0,'12',NULL),(86,71,0,'',NULL),(86,72,0,'',NULL),(86,73,0,'22',NULL),(87,1,0,'4',NULL),(87,17,0,'Lima',NULL),(87,18,0,'Philip',NULL),(87,19,0,'10',NULL),(87,30,0,'1',NULL),(87,31,0,'1',NULL),(87,33,0,'1',NULL),(87,34,0,'90002',NULL),(88,1,0,'4',NULL),(88,17,0,'Bianca',NULL),(88,18,0,'Kristine',NULL),(88,19,0,'10',NULL),(88,30,0,'1',NULL),(88,31,0,'1',NULL),(88,33,0,'1',NULL),(88,34,0,'90005',NULL),(89,1,0,'1',NULL),(89,3,0,'natasha ',NULL),(89,4,0,'Gomes',NULL),(89,5,0,'3',NULL),(89,6,0,'1998-1-1',NULL),(89,8,0,'',NULL),(89,9,0,'',NULL),(89,10,0,'',NULL),(89,11,0,'',NULL),(89,13,0,'',NULL),(89,14,0,'19',NULL),(89,15,0,'27',NULL),(89,16,0,'',NULL),(89,69,0,'90006',NULL),(89,70,0,'11',NULL),(89,71,0,'13',NULL),(89,72,0,'',NULL),(89,73,0,'21',NULL),(90,1,0,'1',NULL),(90,3,0,'Sophia',NULL),(90,4,0,'Claire',NULL),(90,5,0,'3',NULL),(90,6,0,'1989-8-12',NULL),(90,8,0,'',NULL),(90,9,0,'',NULL),(90,10,0,'',NULL),(90,11,0,'',NULL),(90,13,0,'Halo, I am Claire',NULL),(90,14,0,'18',NULL),(90,15,0,'29',NULL),(90,16,0,'',NULL),(90,69,0,'90003',NULL),(90,70,0,'11',NULL),(90,71,0,'17',NULL),(90,72,0,'20',NULL),(90,73,0,'',NULL),(91,1,0,'4',NULL),(91,17,0,'Angela',NULL),(91,18,0,'Cathy',NULL),(91,19,0,'10',NULL),(91,30,0,'1',NULL),(91,31,0,'1',NULL),(91,33,0,'1',NULL),(91,34,0,'90005',NULL),(92,1,0,'1',NULL),(92,3,0,'Tom',NULL),(92,4,0,'Sawyer',NULL),(92,5,0,'2',NULL),(92,6,0,'1984-8-4',NULL),(92,8,0,'',NULL),(92,9,0,'',NULL),(92,10,0,'',NULL),(92,11,0,'',NULL),(92,13,0,'',NULL),(92,14,0,'19',NULL),(92,15,0,'29',NULL),(92,16,0,'',NULL),(92,69,0,'90001',NULL),(92,70,0,'11',NULL),(92,71,0,'17',NULL),(92,72,0,'',NULL),(92,73,0,'22',NULL),(93,1,0,'4',NULL),(93,17,0,'Jamie',NULL),(93,18,0,'Sullivan',NULL),(93,19,0,'10',NULL),(93,30,0,'1',NULL),(93,31,0,'1',NULL),(93,33,0,'1',NULL),(93,34,0,'90001',NULL);
/*!40000 ALTER TABLE `engine4_user_fields_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_forgot`
--

DROP TABLE IF EXISTS `engine4_user_forgot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_forgot` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_forgot`
--

LOCK TABLES `engine4_user_forgot` WRITE;
/*!40000 ALTER TABLE `engine4_user_forgot` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_forgot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_janrain`
--

DROP TABLE IF EXISTS `engine4_user_janrain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_janrain` (
  `user_id` int(11) unsigned NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_janrain`
--

LOCK TABLES `engine4_user_janrain` WRITE;
/*!40000 ALTER TABLE `engine4_user_janrain` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_janrain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_listitems`
--

DROP TABLE IF EXISTS `engine4_user_listitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_listitems`
--

LOCK TABLES `engine4_user_listitems` WRITE;
/*!40000 ALTER TABLE `engine4_user_listitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_listitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_lists`
--

DROP TABLE IF EXISTS `engine4_user_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_lists`
--

LOCK TABLES `engine4_user_lists` WRITE;
/*!40000 ALTER TABLE `engine4_user_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_logins`
--

DROP TABLE IF EXISTS `engine4_user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_logins` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varbinary(16) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` enum('success','no-member','bad-password','disabled','unpaid','third-party','v3-migration','unknown') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'unknown',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=708 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_logins`
--

LOCK TABLES `engine4_user_logins` WRITE;
/*!40000 ALTER TABLE `engine4_user_logins` DISABLE KEYS */;
INSERT INTO `engine4_user_logins` VALUES (1,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-06 01:42:49','no-member',NULL,0),(2,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-06 01:43:04','no-member',NULL,0),(3,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-06 01:44:40','no-member',NULL,0),(4,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-06 01:44:54','no-member',NULL,0),(5,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-06 01:49:25','no-member',NULL,0),(6,1,'admin@suitecontact.com','DÁ\\œ','2016-03-06 03:54:52','success',NULL,0),(7,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-14 19:51:52','no-member',NULL,0),(8,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-14 19:52:05','no-member',NULL,0),(9,1,'admin@suitecontact.com','DÁ\\œ','2016-03-14 19:58:15','success',NULL,1),(10,1,'admin@suitecontact.com','DÁ\\œ','2016-03-14 19:58:46','success',NULL,0),(11,1,'admin@suitecontact.com','DÁ\\œ','2016-03-15 17:24:29','success',NULL,1),(12,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:35:32','no-member',NULL,0),(13,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:35:41','no-member',NULL,0),(14,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:35:57','no-member',NULL,0),(15,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:49:00','no-member',NULL,0),(16,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:49:09','no-member',NULL,0),(17,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:49:26','no-member',NULL,0),(18,NULL,'michael-bertrand@hotmail.com','U»a2','2016-03-15 21:49:35','no-member',NULL,0),(19,NULL,'Fjhinds@live.com','pK','2016-03-17 08:57:22','no-member',NULL,0),(20,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:30:41','no-member',NULL,0),(21,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:30:53','no-member',NULL,0),(22,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:31:06','no-member',NULL,0),(23,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:31:18','no-member',NULL,0),(24,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:35:55','no-member',NULL,0),(25,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:36:45','no-member',NULL,0),(26,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:40:56','no-member',NULL,0),(27,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:41:10','no-member',NULL,0),(28,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 19:48:00','no-member',NULL,0),(29,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 21:50:48','no-member',NULL,0),(30,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 21:54:41','no-member',NULL,0),(31,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 21:56:27','no-member',NULL,0),(32,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-28 22:04:04','no-member',NULL,0),(33,1,'admin@suitecontact.com','U»a2','2016-03-28 22:30:14','success',NULL,1),(34,NULL,'michael-bertrand@hotmail.com','¬82','2016-03-28 22:50:34','no-member',NULL,0),(35,NULL,'michael-bertrand@hotmail.com','Ð6$õ','2016-03-29 02:36:15','no-member',NULL,0),(36,NULL,'michael-bertrand@hotmail.com','Ð6$õ','2016-03-29 02:36:45','no-member',NULL,0),(37,NULL,'michael-bertrand@hotmail.com','Ð6$õ','2016-03-29 02:42:11','no-member',NULL,0),(38,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 05:15:54','no-member',NULL,0),(39,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 05:16:39','no-member',NULL,0),(40,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 05:18:30','no-member',NULL,0),(41,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 05:18:53','no-member',NULL,0),(42,1,'admin@suitecontact.com','NS_','2016-03-29 14:40:16','success',NULL,0),(43,1,'admin@suitecontact.com','NS_','2016-03-29 14:46:29','success',NULL,1),(44,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:14:18','no-member',NULL,0),(45,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:15:37','no-member',NULL,0),(46,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:15:38','no-member',NULL,0),(47,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:15:48','no-member',NULL,0),(48,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:15:56','no-member',NULL,0),(49,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:16:04','no-member',NULL,0),(50,NULL,'fjhinds@live.com','DÁ\\œ','2016-03-29 15:16:25','no-member',NULL,0),(51,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 15:16:50','no-member',NULL,0),(52,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 15:17:05','no-member',NULL,0),(53,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 15:17:28','no-member',NULL,0),(54,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:18:25','no-member',NULL,0),(55,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:18:53','no-member',NULL,0),(56,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:21:48','no-member',NULL,0),(57,NULL,'michael-bertrand@hotmail.com','DÁ\\œ','2016-03-29 15:22:22','no-member',NULL,0),(58,NULL,'ju11236@yahoo.com','DÁ\\œ','2016-03-29 15:22:48','no-member',NULL,0),(59,1,'admin@suitecontact.com','DÁ\\œ','2016-03-29 15:27:26','success',NULL,0),(60,1,'admin@suitecontact.com','pK','2016-03-30 06:08:17','success',NULL,0),(61,1,'admin@suitecontact.com','pK','2016-03-30 09:38:56','success',NULL,1),(62,1,'admin@suitecontact.com','ÑŒ ¤','2016-03-30 13:14:30','success',NULL,0),(63,1,'admin@suitecontact.com','DÁ\\œ','2016-03-30 13:49:32','success',NULL,0),(64,1,'admin@suitecontact.com','DÁ\\œ','2016-03-30 14:40:40','success',NULL,1),(65,NULL,'mmanishjha@gmail.com','tËÓ','2016-04-05 17:19:06','no-member',NULL,0),(66,4,'mmanishjha@gmail.com','s»?Ô','2016-04-06 11:14:21','success',NULL,0),(67,1,'admin@suitecontact.com','DÁWU','2016-04-06 19:44:30','success',NULL,1),(68,4,'mmanishjha@gmail.com','tËØÀ','2016-04-06 19:48:24','success',NULL,1),(69,4,'mmanishjha@gmail.com','tËØÀ','2016-04-06 19:48:52','bad-password',NULL,0),(70,4,'mmanishjha@gmail.com','tËØÀ','2016-04-06 19:49:00','success',NULL,0),(71,1,'admin@suitecontact.com','¬8#)','2016-04-07 01:42:47','success',NULL,1),(72,4,'mmanishjha@gmail.com','s»?Ô','2016-04-07 05:39:39','bad-password',NULL,0),(73,4,'mmanishjha@gmail.com','s»?Ô','2016-04-07 05:39:44','success',NULL,1),(74,1,'admin@suitecontact.com','ÑŒ#','2016-04-13 21:36:03','success',NULL,1),(75,1,'admin@suitecontact.com','DÁWU','2016-04-17 15:59:07','success',NULL,0),(76,1,'admin@suitecontact.com','DÁWU','2016-04-18 21:24:29','bad-password',NULL,0),(77,1,'admin@suitecontact.com','DÁWU','2016-04-18 21:24:42','bad-password',NULL,0),(78,1,'admin@suitecontact.com','DÁWU','2016-04-18 21:24:55','bad-password',NULL,0),(79,1,'admin@suitecontact.com','DÁWU','2016-04-18 21:25:14','bad-password',NULL,0),(80,1,'admin@suitecontact.com','DÁWU','2016-04-18 21:31:49','success',NULL,0),(81,1,'admin@suitecontact.com','¬8\n7','2016-04-19 22:46:44','bad-password',NULL,0),(82,1,'admin@suitecontact.com','¬8\n7','2016-04-19 22:47:09','bad-password',NULL,0),(83,1,'admin@suitecontact.com','¬8\n7','2016-04-19 22:47:21','bad-password',NULL,0),(84,1,'admin@suitecontact.com','¬:$','2016-04-21 22:42:18','success',NULL,1),(85,1,'admin@suitecontact.com','pK','2016-04-22 14:32:56','bad-password',NULL,0),(86,1,'admin@suitecontact.com','pK','2016-04-22 14:33:14','bad-password',NULL,0),(87,1,'admin@suitecontact.com','pK','2016-04-22 14:33:43','bad-password',NULL,0),(88,1,'admin@suitecontact.com','pK','2016-04-22 14:33:48','bad-password',NULL,0),(89,1,'admin@suitecontact.com','pK','2016-04-22 14:33:53','bad-password',NULL,0),(90,1,'admin@suitecontact.com','pK','2016-04-22 14:33:59','bad-password',NULL,0),(91,1,'admin@suitecontact.com','pK','2016-04-22 14:34:26','bad-password',NULL,0),(92,1,'admin@suitecontact.com','DÁWU','2016-04-24 11:08:08','success',NULL,0),(93,NULL,'michael-bertrand@hotmail.com','NS_','2016-04-24 18:07:45','no-member',NULL,0),(94,NULL,'michael-bertrand@hotmail.com','NS_','2016-04-24 18:08:08','no-member',NULL,0),(95,NULL,'admin@suitcontact.com','NS_','2016-04-24 19:18:03','no-member',NULL,0),(96,NULL,'admin@suitcontact.com','NS_','2016-04-24 19:20:42','no-member',NULL,0),(97,1,'admin@suitecontact.com','NS_','2016-04-24 20:38:59','success',NULL,1),(98,1,'admin@suitecontact.com','¬8\"+','2016-04-24 22:37:16','success',NULL,0),(99,1,'admin@suitecontact.com','¶D3','2016-04-25 17:27:41','bad-password',NULL,0),(100,1,'admin@suitecontact.com','¶D3','2016-04-25 17:28:08','bad-password',NULL,0),(101,1,'admin@suitecontact.com','ÑŒ!¨','2016-04-25 17:30:02','success',NULL,0),(102,1,'admin@suitecontact.com','ÑŒ!¨','2016-04-25 17:35:08','success',NULL,0),(103,5,'ju11236@yahoo.com','DÁWU','2016-04-25 17:55:22','disabled',NULL,0),(104,5,'ju11236@yahoo.com','DÁWU','2016-04-25 17:58:23','disabled',NULL,0),(105,1,'admin@suitecontact.com','DÁWU','2016-04-25 17:59:04','success',NULL,0),(106,5,'ju11236@yahoo.com','DÁWU','2016-04-25 18:00:33','disabled',NULL,0),(107,5,'ju11236@yahoo.com','DÁWU','2016-04-25 18:01:54','disabled',NULL,0),(108,5,'ju11236@yahoo.com','DÁWU','2016-04-25 18:01:58','disabled',NULL,0),(109,5,'ju11236@yahoo.com','DÁWU','2016-04-25 18:04:52','disabled',NULL,0),(110,1,'admin@suitecontact.com','DÁWU','2016-04-25 18:53:26','success',NULL,0),(111,1,'admin@suitecontact.com','DÁWU','2016-04-25 18:57:48','success',NULL,0),(112,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:17:00','success',NULL,0),(113,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:21:31','success',NULL,0),(114,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:25:07','success',NULL,0),(115,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:27:04','success',NULL,0),(116,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:28:29','success',NULL,0),(117,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:30:02','success',NULL,0),(118,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:32:12','success',NULL,0),(119,1,'admin@suitecontact.com','DÁWU','2016-04-25 19:44:25','success',NULL,0),(120,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:02:09','success',NULL,0),(121,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:06:08','success',NULL,0),(122,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:07:35','success',NULL,0),(123,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:09:37','success',NULL,0),(124,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:16:59','success',NULL,0),(125,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:18:04','success',NULL,0),(126,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:20:51','success',NULL,0),(127,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:23:17','success',NULL,0),(128,1,'admin@suitecontact.com','DÁWU','2016-04-25 20:25:41','success',NULL,0),(129,1,'admin@suitecontact.com','DÁWU','2016-04-25 21:02:37','success',NULL,0),(130,1,'admin@suitecontact.com','DÁWU','2016-04-25 21:03:56','success',NULL,0),(131,1,'admin@suitecontact.com','DÁWU','2016-04-25 21:10:40','success',NULL,0),(132,1,'admin@suitecontact.com','¬8{','2016-04-26 01:06:30','bad-password',NULL,0),(133,1,'admin@suitecontact.com','¬8{','2016-04-26 01:07:12','bad-password',NULL,0),(134,1,'admin@suitecontact.com','¬8{','2016-04-26 01:16:04','success',NULL,0),(135,1,'admin@suitecontact.com','DÁWU','2016-04-26 01:35:16','success',NULL,0),(136,1,'admin@suitecontact.com','DÁWU','2016-04-26 01:39:13','success',NULL,0),(137,1,'admin@suitecontact.com','DÁWU','2016-04-26 02:31:04','success',NULL,0),(138,1,'admin@suitecontact.com','DÁWU','2016-04-26 12:08:50','success',NULL,0),(139,6,'ju11236@yahoo.com','DÁWU','2016-04-26 12:11:01','success',NULL,0),(140,6,'ju11236@yahoo.com','DÁWU','2016-04-26 19:00:25','success',NULL,0),(141,1,'admin@suitecontact.com','DÁWU','2016-04-26 19:22:31','bad-password',NULL,0),(142,1,'admin@suitecontact.com','DÁWU','2016-04-26 19:24:09','success',NULL,0),(143,1,'admin@suitecontact.com','¬8\"Ô','2016-04-26 22:11:27','success',NULL,1),(144,6,'ju11236@yahoo.com','DÁWU','2016-04-26 22:26:01','success',NULL,0),(145,1,'admin@suitecontact.com','DÁWU','2016-04-26 22:30:39','success',NULL,0),(146,6,'ju11236@yahoo.com','DÁWU','2016-04-26 23:13:47','success',NULL,0),(147,1,'admin@suitecontact.com','DÁWU','2016-04-26 23:26:35','success',NULL,0),(148,1,'admin@suitecontact.com','DÁWU','2016-04-26 23:46:13','success',NULL,0),(149,1,'admin@suitecontact.com','¬8##','2016-04-27 01:06:10','bad-password',NULL,0),(150,1,'admin@suitecontact.com','¬8##','2016-04-27 01:06:46','bad-password',NULL,0),(151,1,'admin@suitecontact.com','¬8##','2016-04-27 01:08:00','success',NULL,0),(152,1,'admin@suitecontact.com','Ð6,³','2016-04-27 01:47:59','success',NULL,0),(153,1,'admin@suitecontact.com','Ð6,³','2016-04-27 02:58:33','success',NULL,0),(154,1,'admin@suitecontact.com','DÁWU','2016-04-27 05:30:08','success',NULL,0),(155,1,'admin@suitecontact.com','DÁWU','2016-04-27 19:01:46','success',NULL,0),(156,1,'admin@suitecontact.com','DÁWU','2016-04-27 19:28:46','success',NULL,1),(157,6,'ju11236@yahoo.com','?Éë','2016-04-27 23:12:42','success',NULL,1),(158,1,'admin@suitecontact.com','¬:„','2016-04-28 03:25:32','success',NULL,0),(159,NULL,'michael-bertrand@hotmail.com','¬:„','2016-04-28 03:35:49','no-member',NULL,0),(160,NULL,'michael-bertrand@hotmail.com','¬:„','2016-04-28 03:36:07','no-member',NULL,0),(161,1,'admin@suitecontact.com','¬:„','2016-04-28 03:36:25','success',NULL,1),(162,7,'jithesh.pk@titechnologies.in','À¨','2016-04-28 11:27:40','success',NULL,0),(163,NULL,'jithesh.pk@titechnologies.org','À¨','2016-05-02 04:29:06','no-member',NULL,0),(164,7,'jithesh.pk@titechnologies.in','À¨','2016-05-02 04:29:16','success',NULL,0),(165,7,'jithesh.pk@titechnologies.in','À¨','2016-05-02 09:53:17','success',NULL,1),(166,7,'jithesh.pk@titechnologies.in','À¨','2016-05-02 10:59:15','bad-password',NULL,0),(167,7,'jithesh.pk@titechnologies.in','À¨','2016-05-02 10:59:21','success',NULL,1),(168,7,'jithesh.pk@titechnologies.in','À¨','2016-05-02 12:28:19','success',NULL,1),(169,NULL,'admin@suitcontact.com','¬8Œ','2016-05-02 18:07:49','no-member',NULL,0),(170,NULL,'admin@suitcontact.com','¬8Œ','2016-05-02 18:08:20','no-member',NULL,0),(171,1,'admin@suitecontact.com','¬8Œ','2016-05-02 21:38:32','success',NULL,0),(172,7,'jithesh.pk@titechnologies.in','À¨','2016-05-03 04:16:51','success',NULL,1),(173,7,'jithesh.pk@titechnologies.in','À¨','2016-05-03 06:30:33','success',NULL,0),(174,7,'jithesh.pk@titechnologies.in','À¨','2016-05-03 09:38:56','success',NULL,1),(175,7,'jithesh.pk@titechnologies.in','À¨','2016-05-04 04:13:16','success',NULL,0),(176,NULL,'admin@suitecontact.con','DÁWU','2016-05-04 05:25:10','no-member',NULL,0),(177,1,'admin@suitecontact.com','DÁWU','2016-05-04 05:25:47','success',NULL,0),(178,7,'jithesh.pk@titechnologies.in','À¨','2016-05-04 07:42:40','bad-password',NULL,0),(179,7,'jithesh.pk@titechnologies.in','À¨','2016-05-04 07:42:49','success',NULL,1),(180,11,'teenu.thomas@titechnologies.org','À¨','2016-05-05 11:16:46','success',NULL,1),(181,1,'admin@suitecontact.com','DÁWU','2016-05-07 05:03:47','success',NULL,1),(182,7,'jithesh.pk@titechnologies.in','À¨','2016-05-10 04:09:47','success',NULL,1),(183,7,'jithesh.pk@titechnologies.in','À¨','2016-05-10 13:05:07','success',NULL,1),(184,7,'jithesh.pk@titechnologies.in','À¨','2016-05-11 04:17:28','success',NULL,1),(185,7,'jithesh.pk@titechnologies.in','À¨','2016-05-11 04:46:54','success',NULL,0),(186,7,'jithesh.pk@titechnologies.in','À¨','2016-05-11 05:16:58','success',NULL,1),(187,7,'jithesh.pk@titechnologies.in','À¨','2016-05-12 04:46:26','success',NULL,1),(188,7,'jithesh.pk@titechnologies.in','À¨','2016-05-12 07:17:15','success',NULL,1),(189,12,'john@test.com','À¨','2016-05-12 07:30:06','success',NULL,0),(190,7,'jithesh.pk@titechnologies.in','À¨','2016-05-13 08:34:40','success',NULL,1),(191,7,'jithesh.pk@titechnologies.in','À¨','2016-05-13 09:11:56','success',NULL,1),(192,7,'jithesh.pk@titechnologies.in','À¨','2016-05-17 07:05:58','success',NULL,1),(193,7,'jithesh.pk@titechnologies.in','À¨','2016-05-18 05:12:50','success',NULL,1),(194,11,'teenu.thomas@titechnologies.org','À¨','2016-05-18 05:13:23','success',NULL,1),(195,7,'jithesh.pk@titechnologies.in','À¨','2016-05-19 04:27:45','success',NULL,1),(196,NULL,'bindiya.prakash@titechnologies.in','À¨','2016-05-19 07:59:16','no-member',NULL,0),(197,11,'teenu.thomas@titechnologies.org','À¨','2016-05-19 08:14:55','success',NULL,0),(198,7,'jithesh.pk@titechnologies.in','À¨','2016-05-19 12:51:43','success',NULL,1),(199,12,'john@test.com','À¨','2016-05-19 12:57:59','success',NULL,1),(200,7,'jithesh.pk@titechnologies.in','À¨','2016-05-20 07:29:50','success',NULL,1),(201,7,'jithesh.pk@titechnologies.in','À¨','2016-05-20 07:40:53','success',NULL,1),(202,7,'jithesh.pk@titechnologies.in','À¨','2016-05-20 07:43:00','success',NULL,0),(203,7,'jithesh.pk@titechnologies.in','À¨','2016-05-20 07:48:56','success',NULL,1),(204,7,'jithesh.pk@titechnologies.in','À¨','2016-05-20 09:08:15','success',NULL,1),(205,1,'admin@suitecontact.com','DÁWU','2016-05-22 02:37:42','bad-password',NULL,0),(206,1,'admin@suitecontact.com','DÁWU','2016-05-22 02:38:16','bad-password',NULL,0),(207,1,'admin@suitecontact.com','DÁWU','2016-05-22 02:40:39','success',NULL,1),(208,1,'admin@suitecontact.com','¬8\"W','2016-05-22 22:46:23','bad-password',NULL,0),(209,1,'admin@suitecontact.com','¬8\"W','2016-05-23 01:10:05','bad-password',NULL,0),(210,1,'admin@suitecontact.com','¬8\"W','2016-05-23 01:10:28','bad-password',NULL,0),(211,1,'admin@suitecontact.com','¬8\"W','2016-05-23 01:14:05','bad-password',NULL,0),(212,1,'admin@suitecontact.com','¬8\"W','2016-05-23 01:16:43','bad-password',NULL,0),(213,1,'admin@suitecontact.com','¬8\"W','2016-05-23 01:18:32','success',NULL,1),(214,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-23 04:46:47','bad-password',NULL,0),(215,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-23 04:46:53','success',NULL,0),(216,7,'jithesh.pk@titechnologies.in','À¨','2016-05-23 05:30:48','bad-password',NULL,0),(217,7,'jithesh.pk@titechnologies.in','À¨','2016-05-23 05:30:56','success',NULL,1),(218,7,'jithesh.pk@titechnologies.in','À¨','2016-05-23 06:13:41','success',NULL,1),(219,25,'visal.varghese@titechnologies.in','À¨','2016-05-23 09:34:01','success',NULL,0),(220,26,'nithinkumar.cn@titechnologies.in','À¨','2016-05-23 09:40:39','disabled',NULL,0),(221,NULL,'visal.varghese@titechnolgies.in','À¨','2016-05-23 09:52:29','no-member',NULL,0),(222,NULL,'visal.varghese@titechnolgies.in','À¨','2016-05-23 10:04:21','no-member',NULL,0),(223,25,'visal.varghese@titechnologies.in','À¨','2016-05-23 10:04:43','success',NULL,0),(224,28,'visal2@gmail.com','À¨','2016-05-23 10:12:11','disabled',NULL,0),(225,25,'visal.varghese@titechnologies.in','À¨','2016-05-23 10:31:06','success',NULL,0),(226,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-23 11:02:40','success',NULL,0),(227,25,'visal.varghese@titechnologies.in','À¨','2016-05-23 12:32:07','success',NULL,1),(228,6,'ju11236@yahoo.com','DÁWU','2016-05-23 12:36:57','success',NULL,1),(229,30,'anwin.cherian@titechnologies.org','À¨','2016-05-23 13:18:31','success',NULL,1),(230,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-24 06:18:07','success',NULL,0),(231,7,'jithesh.pk@titechnologies.in','À¨','2016-05-24 06:55:49','success',NULL,0),(232,7,'jithesh.pk@titechnologies.in','À¨','2016-05-24 07:05:36','success',NULL,0),(233,31,'nibi.mathew@titechnologies.in','À¨','2016-05-24 07:09:24','success',NULL,0),(234,25,'visal.varghese@titechnologies.in','À¨','2016-05-24 07:13:31','success',NULL,0),(235,7,'jithesh.pk@titechnologies.in','À¨','2016-05-24 07:42:14','success',NULL,0),(236,19,'qateam@titechnologies.in','À¨','2016-05-24 08:29:37','success',NULL,1),(237,34,'qateam@titechnologies.in','À¨','2016-05-24 08:39:00','success',NULL,1),(238,18,'teenuthomas12@gmail.com','À¨','2016-05-24 09:29:46','success',NULL,0),(239,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-24 10:01:35','success',NULL,0),(240,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-24 11:01:00','success',NULL,0),(241,7,'jithesh.pk@titechnologies.in','À¨','2016-05-24 11:08:57','success',NULL,1),(242,18,'teenuthomas12@gmail.com','À¨','2016-05-24 11:33:11','success',NULL,0),(243,7,'jithesh.pk@titechnologies.in','À¨','2016-05-24 11:49:12','success',NULL,1),(244,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-24 11:53:40','success',NULL,0),(245,18,'teenuthomas12@gmail.com','À¨','2016-05-24 12:10:02','success',NULL,1),(246,34,'qateam@titechnologies.in','À¨','2016-05-24 12:27:57','success',NULL,1),(247,35,'teenutc12@gmail.com','À¨','2016-05-24 12:35:05','success',NULL,1),(248,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 03:59:34','success',NULL,1),(249,20,'bindiya.prakash@titechnologies.in','À¨','2016-05-25 04:59:40','success',NULL,0),(250,34,'qateam@titechnologies.in','À¨','2016-05-25 05:04:43','success',NULL,0),(251,25,'visal.varghese@titechnologies.in','À¨','2016-05-25 05:37:32','success',NULL,1),(252,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 05:38:14','success',NULL,1),(253,NULL,'teenutc12@gmail.com','À¨','2016-05-25 06:07:32','no-member',NULL,0),(254,NULL,'teenutc12@gmail.com','À¨','2016-05-25 06:07:39','no-member',NULL,0),(255,NULL,'teenuthomas12@gmail.com','À¨','2016-05-25 06:07:51','no-member',NULL,0),(256,NULL,'teenu.thomas@titechnologies.org','À¨','2016-05-25 06:08:39','no-member',NULL,0),(257,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 06:17:56','success',NULL,1),(258,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-25 06:41:07','success',NULL,0),(259,NULL,'visal.varghese@titechnologies.in','À¨','2016-05-25 07:43:47','no-member',NULL,0),(260,39,'visal.varghese@titechnologies.in','À¨','2016-05-25 07:54:37','success',NULL,0),(261,38,'qateam@titechnologies.in','À¨','2016-05-25 07:58:23','disabled',NULL,0),(262,38,'qateam@titechnologies.in','À¨','2016-05-25 07:58:58','success',NULL,0),(263,40,'shaiju@technopolis.com','À¨','2016-05-25 08:53:41','disabled',NULL,0),(264,41,'shaiju@technipolis.com','À¨','2016-05-25 08:53:50','success',NULL,0),(265,38,'qateam@titechnologies.in','À¨','2016-05-25 10:08:08','success',NULL,0),(266,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 10:32:11','bad-password',NULL,0),(267,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 10:32:31','success',NULL,0),(268,38,'qateam@titechnologies.in','À¨','2016-05-25 10:59:16','success',NULL,0),(269,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 11:04:18','success',NULL,0),(270,38,'qateam@titechnologies.in','À¨','2016-05-25 11:10:23','success',NULL,0),(271,38,'qateam@titechnologies.in','À¨','2016-05-25 11:20:49','success',NULL,1),(272,38,'qateam@titechnologies.in','À¨','2016-05-25 11:25:32','success',NULL,0),(273,39,'visal.varghese@titechnologies.in','À¨','2016-05-25 11:26:32','success',NULL,0),(274,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 11:28:34','bad-password',NULL,0),(275,7,'jithesh.pk@titechnologies.in','À¨','2016-05-25 11:28:40','success',NULL,0),(276,38,'qateam@titechnologies.in','À¨','2016-05-25 11:30:22','bad-password',NULL,0),(277,38,'qateam@titechnologies.in','À¨','2016-05-25 11:30:26','success',NULL,1),(278,39,'visal.varghese@titechnologies.in','À¨','2016-05-26 04:27:28','success',NULL,0),(279,38,'qateam@titechnologies.in','À¨','2016-05-26 04:27:49','success',NULL,1),(280,39,'visal.varghese@titechnologies.in','À¨','2016-05-26 04:54:24','success',NULL,1),(281,7,'jithesh.pk@titechnologies.in','À¨','2016-05-26 05:08:36','success',NULL,0),(282,7,'jithesh.pk@titechnologies.in','À¨','2016-05-26 07:08:27','success',NULL,0),(283,43,'nithinkumar.cn@titechnologies.in','À¨','2016-05-26 09:28:01','disabled',NULL,0),(284,36,'teenu.thomas@titechnologies.org','À¨','2016-05-26 09:33:40','disabled',NULL,0),(285,36,'teenu.thomas@titechnologies.org','À¨','2016-05-26 09:33:47','disabled',NULL,0),(286,7,'jithesh.pk@titechnologies.in','À¨','2016-05-26 09:34:17','bad-password',NULL,0),(287,7,'jithesh.pk@titechnologies.in','À¨','2016-05-26 09:34:29','success',NULL,1),(288,36,'teenu.thomas@titechnologies.org','À¨','2016-05-26 09:39:06','success',NULL,0),(289,36,'teenu.thomas@titechnologies.org','À¨','2016-05-26 10:01:53','success',NULL,1),(290,36,'teenu.thomas@titechnologies.org','À¨','2016-05-26 10:42:57','success',NULL,1),(291,38,'qateam@titechnologies.in','À¨','2016-05-26 11:01:39','success',NULL,1),(292,38,'qateam@titechnologies.in','À¨','2016-05-27 05:25:41','success',NULL,0),(293,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-27 05:31:20','success',NULL,1),(294,36,'teenu.thomas@titechnologies.org','À¨','2016-05-27 05:37:31','success',NULL,0),(295,38,'qateam@titechnologies.in','À¨','2016-05-27 06:07:00','success',NULL,1),(296,NULL,'sulthan.kareem@titechnologies.org','À¨','2016-05-27 07:23:30','no-member',NULL,0),(297,7,'jithesh.pk@titechnologies.in','À¨','2016-05-27 08:54:40','success',NULL,1),(298,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-30 05:03:21','success',NULL,0),(299,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-30 05:25:24','success',NULL,0),(300,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-30 06:45:38','success',NULL,0),(301,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-30 06:46:54','success',NULL,1),(302,7,'jithesh.pk@titechnologies.in','À¨','2016-05-30 06:58:55','bad-password',NULL,0),(303,7,'jithesh.pk@titechnologies.in','À¨','2016-05-30 07:00:12','success',NULL,1),(304,36,'teenu.thomas@titechnologies.org','À¨','2016-05-30 09:29:34','success',NULL,1),(305,44,'teenuthomas12@gmail.com','À¨','2016-05-30 10:27:28','success',NULL,0),(306,7,'jithesh.pk@titechnologies.in','À¨','2016-05-30 10:28:06','success',NULL,1),(307,NULL,'jay@test.com','À¨','2016-05-30 12:46:41','no-member',NULL,0),(308,NULL,'jay@test.com','À¨','2016-05-30 12:47:02','no-member',NULL,0),(309,36,'teenu.thomas@titechnologies.org','À¨','2016-05-30 12:47:30','success',NULL,1),(310,49,'jemy.thomas@titechnologies.org','À¨','2016-05-30 12:49:26','success',NULL,1),(311,36,'teenu.thomas@titechnologies.org','À¨','2016-05-31 04:18:37','success',NULL,0),(312,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 05:01:58','success',NULL,0),(313,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-31 05:03:26','success',NULL,0),(314,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 05:06:59','success',NULL,0),(315,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-31 05:07:29','success',NULL,0),(316,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 05:29:15','success',NULL,1),(317,7,'jithesh.pk@titechnologies.in','À¨','2016-05-31 05:52:04','success',NULL,1),(318,7,'jithesh.pk@titechnologies.in','À¨','2016-05-31 05:52:17','success',NULL,0),(319,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 06:01:21','success',NULL,0),(320,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-31 06:06:21','success',NULL,0),(321,49,'jemy.thomas@titechnologies.org','À¨','2016-05-31 07:00:01','success',NULL,0),(322,NULL,'qateam@titechnologies.org','À¨','2016-05-31 07:00:59','no-member',NULL,0),(323,38,'qateam@titechnologies.in','À¨','2016-05-31 07:01:10','success',NULL,0),(324,44,'teenuthomas12@gmail.com','À¨','2016-05-31 07:01:29','success',NULL,0),(325,46,'sulthan.kareem@titechnologies.org','À¨','2016-05-31 07:02:15','success',NULL,0),(326,36,'teenu.thomas@titechnologies.org','À¨','2016-05-31 07:06:52','success',NULL,0),(327,36,'teenu.thomas@titechnologies.org','À¨','2016-05-31 07:07:36','success',NULL,0),(328,44,'teenuthomas12@gmail.com','À¨','2016-05-31 07:08:53','success',NULL,0),(329,50,'rita.jose@titechnologies.org','À¨','2016-05-31 09:53:05','success',NULL,1),(330,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 10:43:21','success',NULL,1),(331,38,'qateam@titechnologies.in','À¨','2016-05-31 10:43:36','success',NULL,0),(332,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 10:44:02','success',NULL,1),(333,37,'bindiya.prakash@titechnologies.in','À¨','2016-05-31 10:44:43','success',NULL,0),(334,38,'qateam@titechnologies.in','À¨','2016-05-31 10:45:07','success',NULL,0),(335,36,'teenu.thomas@titechnologies.org','À¨','2016-05-31 11:46:36','success',NULL,0),(336,49,'jemy.thomas@titechnologies.org','À¨','2016-05-31 11:47:22','success',NULL,0),(337,36,'teenu.thomas@titechnologies.org','À¨','2016-05-31 11:47:46','success',NULL,0),(338,7,'jithesh.pk@titechnologies.in','À¨','2016-05-31 11:54:02','success',NULL,1),(339,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-01 04:17:18','success',NULL,1),(340,38,'qateam@titechnologies.in','À¨','2016-06-01 04:17:43','success',NULL,0),(341,50,'rita.jose@titechnologies.org','À¨','2016-06-01 04:18:16','success',NULL,0),(342,7,'jithesh.pk@titechnologies.in','À¨','2016-06-01 06:04:52','success',NULL,1),(343,NULL,'bindiya.prakash@gmail.com','À¨','2016-06-01 06:48:46','no-member',NULL,0),(344,NULL,'bindiya.prakash@gmail.com','À¨','2016-06-01 06:48:51','no-member',NULL,0),(345,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-01 06:49:05','success',NULL,1),(346,7,'jithesh.pk@titechnologies.in','À¨','2016-06-01 06:50:39','success',NULL,0),(347,36,'teenu.thomas@titechnologies.org','À¨','2016-06-02 05:33:32','success',NULL,0),(348,44,'teenuthomas12@gmail.com','À¨','2016-06-02 06:48:46','success',NULL,0),(349,7,'jithesh.pk@titechnologies.in','À¨','2016-06-02 06:51:09','success',NULL,1),(350,36,'teenu.thomas@titechnologies.org','À¨','2016-06-02 06:58:59','success',NULL,0),(351,51,'ton@test.com','À¨','2016-06-02 07:27:47','success',NULL,0),(352,NULL,'bimdiya.prakash@titechnologies.org','À¨','2016-06-02 09:41:38','no-member',NULL,0),(353,NULL,'bimdiya.prakash@titechnologies.in','À¨','2016-06-02 09:41:46','no-member',NULL,0),(354,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-02 09:41:54','success',NULL,1),(355,44,'teenuthomas12@gmail.com','À¨','2016-06-02 11:16:56','success',NULL,1),(356,6,'ju11236@yahoo.com','DÁWU','2016-06-02 16:27:42','bad-password',NULL,0),(357,6,'ju11236@yahoo.com','DÁWU','2016-06-02 16:27:58','bad-password',NULL,0),(358,6,'ju11236@yahoo.com','DÁWU','2016-06-02 16:28:05','bad-password',NULL,0),(359,6,'ju11236@yahoo.com','DÁWU','2016-06-02 16:28:15','bad-password',NULL,0),(360,6,'ju11236@yahoo.com','DÁWU','2016-06-02 16:28:45','bad-password',NULL,0),(361,7,'jithesh.pk@titechnologies.in','À¨','2016-06-03 04:21:22','success',NULL,1),(362,NULL,'jay@test.com','À¨','2016-06-03 04:27:52','no-member',NULL,0),(363,36,'teenu.thomas@titechnologies.org','À¨','2016-06-03 04:35:06','success',NULL,1),(364,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-06 04:21:27','success',NULL,1),(365,36,'teenu.thomas@titechnologies.org','À¨','2016-06-06 05:37:56','success',NULL,1),(366,7,'jithesh.pk@titechnologies.in','À¨','2016-06-06 05:45:13','success',NULL,0),(367,7,'jithesh.pk@titechnologies.in','À¨','2016-06-06 10:04:04','success',NULL,0),(368,44,'teenuthomas12@gmail.com','À¨','2016-06-06 10:15:28','success',NULL,1),(369,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-06 10:26:45','success',NULL,1),(370,NULL,'jithesh.pk@titechnologies.in','À¨','2016-06-06 10:31:42','no-member',NULL,0),(371,7,'teenutc12@gmail.com','À¨','2016-06-06 10:32:02','success',NULL,1),(372,49,'jemy.thomas@titechnologies.org','À¨','2016-06-06 12:45:01','success',NULL,1),(373,1,'admin@suitecontact.com','¬8#E','2016-06-06 12:46:56','success',NULL,1),(374,1,'admin@suitecontact.com','DÁWU','2016-06-07 02:20:55','success',NULL,1),(375,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-07 06:10:56','success',NULL,1),(376,7,'jithesh.pk@titechnologies.in','À¨','2016-06-07 09:23:02','success',NULL,0),(377,57,'jemy@test.com','À¨','2016-06-07 09:29:53','success',NULL,1),(378,49,'jemy.thomas@titechnologies.org','À¨','2016-06-07 09:39:54','success',NULL,0),(379,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-07 10:11:58','success',NULL,1),(380,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 04:33:54','success',NULL,1),(381,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 04:38:19','success',NULL,0),(382,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 04:47:10','success',NULL,1),(383,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 04:54:15','success',NULL,1),(384,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 04:56:56','success',NULL,0),(385,49,'jemy.thomas@titechnologies.org','À¨','2016-06-08 05:03:58','success',NULL,0),(386,7,'jithesh.pk@titechnologies.in','À¨','2016-06-08 05:50:33','success',NULL,0),(387,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 06:10:47','success',NULL,1),(388,NULL,'bindiya.prakash@titechnologies.org','À¨','2016-06-08 08:34:19','no-member',NULL,0),(389,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 08:34:27','success',NULL,1),(390,7,'jithesh.pk@titechnologies.in','À¨','2016-06-08 08:36:41','success',NULL,1),(391,36,'teenu.thomas@titechnologies.org','À¨','2016-06-08 08:47:10','success',NULL,0),(392,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 08:51:40','success',NULL,1),(393,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 10:35:39','success',NULL,0),(394,38,'qateam@titechnologies.in','À¨','2016-06-08 10:41:48','success',NULL,0),(395,38,'qateam@titechnologies.in','À¨','2016-06-08 11:14:58','success',NULL,0),(396,38,'qateam@titechnologies.in','À¨','2016-06-08 11:21:50','success',NULL,0),(397,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-08 11:37:49','success',NULL,1),(398,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 12:07:50','success',NULL,0),(399,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 12:18:33','success',NULL,0),(400,NULL,'jithesh.p.k@titechnologies.in','À¨','2016-06-08 12:21:44','no-member',NULL,0),(401,NULL,'jithesh.p.k@titechnologies.in','À¨','2016-06-08 12:21:51','no-member',NULL,0),(402,7,'jithesh.pk@titechnologies.in','À¨','2016-06-08 12:22:02','success',NULL,0),(403,38,'qateam@titechnologies.in','À¨','2016-06-08 12:59:41','success',NULL,0),(404,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 13:27:08','success',NULL,0),(405,38,'qateam@titechnologies.in','À¨','2016-06-08 13:30:08','success',NULL,0),(406,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-08 13:31:39','success',NULL,0),(407,NULL,'ardra.thambi@titechnologies.in','À¨','2016-06-08 13:35:39','no-member',NULL,0),(408,NULL,'ardra.thambi@titechnologies.org','À¨','2016-06-08 13:35:49','no-member',NULL,0),(409,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 13:36:20','success',NULL,0),(410,61,'rita.jose@titechnologies.org','À¨','2016-06-08 13:37:17','success',NULL,0),(411,38,'qateam@titechnologies.in','À¨','2016-06-08 13:38:02','success',NULL,1),(412,NULL,'visal.varghese@titechnologies.org','À¨','2016-06-08 13:40:00','no-member',NULL,0),(413,39,'visal.varghese@titechnologies.in','À¨','2016-06-08 13:40:06','success',NULL,1),(414,NULL,'rita.jose.ti@titechnologies.org','À¨','2016-06-08 13:40:59','no-member',NULL,0),(415,61,'rita.jose@titechnologies.org','À¨','2016-06-08 13:41:06','success',NULL,0),(416,44,'teenuthomas12@gmail.com','À¨','2016-06-08 13:45:55','success',NULL,1),(417,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-09 04:27:01','success',NULL,1),(418,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-09 04:27:30','success',NULL,1),(419,45,'sulthan.kareem@titechnologies.in','À¨','2016-06-09 04:29:09','disabled',NULL,0),(420,45,'sulthan.kareem@titechnologies.in','À¨','2016-06-09 04:29:18','disabled',NULL,0),(421,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-09 04:29:44','success',NULL,1),(422,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-09 04:35:11','success',NULL,1),(423,36,'teenu.thomas@titechnologies.org','À¨','2016-06-09 04:46:31','success',NULL,0),(424,NULL,'qateam@titechnologies.org','À¨','2016-06-09 05:00:46','no-member',NULL,0),(425,38,'qateam@titechnologies.in','À¨','2016-06-09 05:00:57','success',NULL,0),(426,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-09 05:09:35','success',NULL,0),(427,39,'visal.varghese@titechnologies.in','À¨','2016-06-09 05:19:08','success',NULL,1),(428,39,'visal.varghese@titechnologies.in','À¨','2016-06-09 05:26:57','success',NULL,0),(429,NULL,'qateam@titechnologies.org','À¨','2016-06-09 05:28:31','no-member',NULL,0),(430,38,'qateam@titechnologies.in','À¨','2016-06-09 05:28:42','success',NULL,1),(431,39,'visal.varghese@titechnologies.in','À¨','2016-06-09 05:30:45','success',NULL,1),(432,39,'visal.varghese@titechnologies.in','À¨','2016-06-09 05:30:45','success',NULL,0),(433,39,'visal.varghese@titechnologies.in','À¨','2016-06-09 05:30:45','success',NULL,1),(434,61,'rita.jose@titechnologies.org','À¨','2016-06-09 05:31:12','success',NULL,1),(435,NULL,'jithesh.pk@titechnologiers.in','À¨','2016-06-09 05:42:14','no-member',NULL,0),(436,7,'jithesh.pk@titechnologies.in','À¨','2016-06-09 05:42:22','success',NULL,1),(437,7,'jithesh.pk@titechnologies.in','À¨','2016-06-09 05:56:35','success',NULL,1),(438,44,'teenuthomas12@gmail.com','À¨','2016-06-09 09:15:37','success',NULL,1),(439,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-09 10:38:41','success',NULL,0),(440,36,'teenu.thomas@titechnologies.org','À¨','2016-06-09 10:44:54','success',NULL,1),(441,61,'rita.jose@titechnologies.org','À¨','2016-06-09 10:48:28','success',NULL,1),(442,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-09 12:23:30','success',NULL,1),(443,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-09 12:29:57','success',NULL,0),(444,49,'jemy.thomas@titechnologies.org','À¨','2016-06-09 12:37:03','success',NULL,1),(445,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-09 13:10:26','success',NULL,1),(446,7,'jithesh.pk@titechnologies.in','À¨','2016-06-09 14:00:40','success',NULL,1),(447,36,'teenu.thomas@titechnologies.org','À¨','2016-06-10 05:26:17','success',NULL,1),(448,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-10 05:27:24','success',NULL,1),(449,7,'jithesh.pk@titechnologies.in','À¨','2016-06-10 06:04:47','success',NULL,1),(450,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-10 06:31:25','success',NULL,1),(451,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-10 10:41:53','success',NULL,1),(452,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-10 11:14:40','success',NULL,1),(453,62,'ganesh.nath@titechnologies.org','À¨','2016-06-10 13:10:40','bad-password',NULL,0),(454,62,'ganesh.nath@titechnologies.org','À¨','2016-06-10 13:11:54','success',NULL,1),(455,7,'jithesh.pk@titechnologies.in','À¨','2016-06-13 04:21:36','success',NULL,1),(456,44,'teenuthomas12@gmail.com','À¨','2016-06-13 04:45:18','success',NULL,0),(457,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-13 05:11:42','success',NULL,0),(458,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-13 05:33:06','success',NULL,1),(459,49,'jemy.thomas@titechnologies.org','À¨','2016-06-13 06:18:13','success',NULL,0),(460,36,'teenu.thomas@titechnologies.org','À¨','2016-06-13 07:27:59','success',NULL,1),(461,7,'jithesh.pk@titechnologies.in','À¨','2016-06-13 07:58:25','success',NULL,1),(462,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-13 10:55:00','success',NULL,1),(463,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-13 11:19:18','success',NULL,0),(464,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-13 12:19:45','success',NULL,0),(465,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-13 12:33:17','success',NULL,1),(466,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 04:23:41','success',NULL,0),(467,39,'visal.varghese@titechnologies.in','À¨','2016-06-14 04:38:21','success',NULL,0),(468,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 06:29:05','success',NULL,0),(469,NULL,'qateam@titechnologies.in','À¨','2016-06-14 06:59:35','no-member',NULL,0),(470,65,'qateam@titechnologies.in','À¨','2016-06-14 07:08:45','success',NULL,1),(471,39,'visal.varghese@titechnologies.in','À¨','2016-06-14 07:21:32','success',NULL,0),(472,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 07:23:24','success',NULL,0),(473,36,'teenu.thomas@titechnologies.org','À¨','2016-06-14 09:09:50','success',NULL,0),(474,44,'teenuthomas12@gmail.com','À¨','2016-06-14 09:10:17','success',NULL,0),(475,45,'sulthan.kareem@titechnologies.in','À¨','2016-06-14 09:29:03','disabled',NULL,0),(476,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-14 09:29:33','success',NULL,1),(477,7,'jithesh.pk@titechnologies.in','À¨','2016-06-14 09:33:38','success',NULL,1),(478,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 09:36:28','success',NULL,0),(479,49,'jemy.thomas@titechnologies.org','À¨','2016-06-14 09:37:03','success',NULL,0),(480,39,'visal.varghese@titechnologies.in','À¨','2016-06-14 09:38:19','success',NULL,0),(481,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-14 10:37:42','success',NULL,1),(482,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-14 10:39:25','success',NULL,0),(483,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-14 10:49:57','success',NULL,0),(484,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 11:33:41','success',NULL,1),(485,39,'visal.varghese@titechnologies.in','À¨','2016-06-14 11:35:23','success',NULL,0),(486,7,'jithesh.pk@titechnologies.in','À¨','2016-06-14 11:39:41','success',NULL,1),(487,44,'teenuthomas12@gmail.com','À¨','2016-06-14 12:25:54','success',NULL,1),(488,NULL,'michaelbertrand@rentstaz.com','DÁWU','2016-06-14 12:35:22','no-member',NULL,0),(489,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-14 12:35:46','no-member',NULL,0),(490,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-14 12:36:34','no-member',NULL,0),(491,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-14 12:37:43','no-member',NULL,0),(492,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 12:41:44','success',NULL,1),(493,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-14 13:17:03','success',NULL,1),(494,36,'teenu.thomas@titechnologies.org','À¨','2016-06-14 13:30:20','success',NULL,1),(495,36,'teenu.thomas@titechnologies.org','À¨','2016-06-15 05:02:08','success',NULL,1),(496,39,'visal.varghese@titechnologies.in','À¨','2016-06-15 05:06:29','success',NULL,1),(497,7,'jithesh.pk@titechnologies.in','À¨','2016-06-15 05:07:55','success',NULL,1),(498,66,'geethika.antony@titechnologies.org','À¨','2016-06-15 05:10:31','success',NULL,0),(499,7,'jithesh.pk@titechnologies.in','À¨','2016-06-15 05:20:41','success',NULL,1),(500,65,'qateam@titechnologies.in','À¨','2016-06-15 05:43:39','success',NULL,0),(501,36,'teenu.thomas@titechnologies.org','À¨','2016-06-15 05:45:20','success',NULL,1),(502,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-15 06:05:27','success',NULL,1),(503,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-15 06:24:46','success',NULL,1),(504,49,'jemy.thomas@titechnologies.org','À¨','2016-06-15 06:30:01','success',NULL,0),(505,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-15 06:33:31','success',NULL,1),(506,44,'teenuthomas12@gmail.com','À¨','2016-06-15 11:44:11','success',NULL,0),(507,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-15 12:20:22','success',NULL,1),(508,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-15 12:33:12','success',NULL,1),(509,7,'jithesh.pk@titechnologies.in','À¨','2016-06-15 13:07:46','success',NULL,0),(510,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 04:18:17','success',NULL,0),(511,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-16 04:24:18','success',NULL,0),(512,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 04:25:16','success',NULL,0),(513,65,'qateam@titechnologies.in','À¨','2016-06-16 04:33:43','success',NULL,0),(514,39,'visal.varghese@titechnologies.in','À¨','2016-06-16 04:34:16','success',NULL,0),(515,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 04:34:19','success',NULL,0),(516,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-16 04:45:08','success',NULL,1),(517,36,'teenu.thomas@titechnologies.org','À¨','2016-06-16 05:23:04','bad-password',NULL,0),(518,36,'teenu.thomas@titechnologies.org','À¨','2016-06-16 05:23:19','success',NULL,1),(519,NULL,'teenuthomas@titechnologies.org','À¨','2016-06-16 05:24:12','no-member',NULL,0),(520,NULL,'teenuthomas@titechnologies.org','À¨','2016-06-16 05:24:20','no-member',NULL,0),(521,36,'teenu.thomas@titechnologies.org','À¨','2016-06-16 05:24:30','success',NULL,0),(522,45,'sulthan.kareem@titechnologies.in','À¨','2016-06-16 05:25:59','disabled',NULL,0),(523,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-16 05:26:13','success',NULL,0),(524,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:28:02','success',NULL,1),(525,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:28:10','success',NULL,0),(526,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 05:30:16','success',NULL,1),(527,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:33:25','success',NULL,0),(528,NULL,'bindiya.prakash@titechnologies.org','À¨','2016-06-16 05:35:49','no-member',NULL,0),(529,NULL,'bindiya.prakash@titechnologies.org','À¨','2016-06-16 05:35:58','no-member',NULL,0),(530,NULL,'bindya.prakash@titechnologies.org','À¨','2016-06-16 05:36:12','no-member',NULL,0),(531,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:36:57','success',NULL,1),(532,39,'visal.varghese@titechnologies.in','À¨','2016-06-16 05:45:25','success',NULL,1),(533,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:48:55','success',NULL,1),(534,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 05:56:52','success',NULL,0),(535,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 06:24:16','success',NULL,0),(536,39,'visal.varghese@titechnologies.in','À¨','2016-06-16 06:45:37','bad-password',NULL,0),(537,39,'visal.varghese@titechnologies.in','À¨','2016-06-16 06:45:43','success',NULL,1),(538,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 06:47:15','success',NULL,0),(539,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 07:13:18','success',NULL,0),(540,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 08:18:00','success',NULL,0),(541,NULL,'roshan.joseph@titechnologies.in','À¨','2016-06-16 08:57:55','no-member',NULL,0),(542,NULL,'roshan.joseph@technipolis.in','À¨','2016-06-16 08:58:28','no-member',NULL,0),(543,68,'roshan.joseph@technipolis.com','À¨','2016-06-16 08:58:47','success',NULL,1),(544,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 08:59:48','success',NULL,1),(545,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-16 09:03:52','success',NULL,0),(546,39,'visal.varghese@titechnologies.in','À¨','2016-06-16 10:06:45','success',NULL,0),(547,68,'roshan.joseph@technipolis.com','À¨','2016-06-16 10:14:44','success',NULL,1),(548,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-16 10:16:30','success',NULL,1),(549,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 10:41:31','success',NULL,1),(550,44,'teenuthomas12@gmail.com','À¨','2016-06-16 10:44:26','success',NULL,1),(551,69,'tester@test.com','À¨','2016-06-16 11:13:56','success',NULL,0),(552,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-16 11:26:42','success',NULL,1),(553,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 12:43:58','success',NULL,1),(554,65,'qateam@titechnologies.in','À¨','2016-06-16 13:05:58','success',NULL,1),(555,7,'jithesh.pk@titechnologies.in','À¨','2016-06-16 13:09:06','success',NULL,0),(556,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 03:43:01','success',NULL,0),(557,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 04:15:37','success',NULL,1),(558,65,'qateam@titechnologies.in','À¨','2016-06-17 04:23:24','success',NULL,0),(559,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 04:40:20','success',NULL,0),(560,7,'jithesh.pk@titechnologies.in','À¨','2016-06-17 04:42:45','success',NULL,1),(561,44,'teenuthomas12@gmail.com','À¨','2016-06-17 04:48:14','success',NULL,1),(562,36,'teenu.thomas@titechnologies.org','À¨','2016-06-17 04:48:33','success',NULL,1),(563,49,'jemy.thomas@titechnologies.org','À¨','2016-06-17 04:59:36','success',NULL,0),(564,46,'sulthan.kareem@titechnologies.org','À¨','2016-06-17 05:07:42','success',NULL,0),(565,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 05:23:27','success',NULL,0),(566,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 06:16:54','success',NULL,0),(567,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 06:24:42','success',NULL,1),(568,37,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 06:41:53','success',NULL,1),(569,73,'frank@test.com','À¨','2016-06-17 06:45:32','success',NULL,0),(570,7,'jithesh.pk@titechnologies.in','À¨','2016-06-17 07:37:12','success',NULL,0),(571,7,'jithesh.pk@titechnologies.in','À¨','2016-06-17 08:17:01','success',NULL,1),(572,NULL,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 08:29:53','no-member',NULL,0),(573,NULL,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 08:30:09','no-member',NULL,0),(574,74,'sulthan.kareem@titechnologies.org','À¨','2016-06-17 08:43:22','success',NULL,0),(575,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 08:50:06','success',NULL,0),(576,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 08:52:00','success',NULL,0),(577,NULL,'teenu.thomas@titechnologies.org','À¨','2016-06-17 09:24:39','no-member',NULL,0),(578,NULL,'teenu.thomas@titechnologies.org','À¨','2016-06-17 09:24:51','no-member',NULL,0),(579,NULL,'bindiya.prakash@titechnologies.org','À¨','2016-06-17 09:25:14','no-member',NULL,0),(580,NULL,'teenu.thomas@titechnologies.org','À¨','2016-06-17 09:25:27','no-member',NULL,0),(581,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 09:25:44','success',NULL,0),(582,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 09:26:19','success',NULL,0),(583,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 09:26:53','success',NULL,1),(584,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 09:37:23','success',NULL,0),(585,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 10:00:14','success',NULL,1),(586,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 10:05:30','success',NULL,1),(587,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 10:19:10','success',NULL,0),(588,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 10:19:50','success',NULL,1),(589,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 11:03:49','success',NULL,0),(590,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 11:10:52','success',NULL,0),(591,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 11:14:15','success',NULL,0),(592,71,'ashikh.ck@titechnologies.org','À¨','2016-06-17 11:16:42','bad-password',NULL,0),(593,71,'ashikh.ck@titechnologies.org','À¨','2016-06-17 11:17:00','bad-password',NULL,0),(594,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 11:34:09','success',NULL,0),(595,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 11:35:34','success',NULL,0),(596,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 11:44:38','success',NULL,0),(597,39,'visal.varghese@titechnologies.in','À¨','2016-06-17 11:49:10','success',NULL,0),(598,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 11:54:22','success',NULL,0),(599,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 12:28:50','success',NULL,1),(600,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 12:29:37','success',NULL,0),(601,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 12:34:44','success',NULL,0),(602,75,'jemy.thomas@titechnologies.org','À¨','2016-06-17 12:36:43','success',NULL,0),(603,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 12:54:28','success',NULL,0),(604,81,'dsf@sf.com','À¨','2016-06-17 13:10:18','success',NULL,1),(605,82,'meera@test.com','À¨','2016-06-17 13:14:29','success',NULL,0),(606,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 13:28:51','success',NULL,1),(607,78,'deepthy.s@titechnologies.in','À¨','2016-06-17 13:39:06','success',NULL,0),(608,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 13:59:07','success',NULL,0),(609,73,'Frank@test.com','À¨','2016-06-17 14:20:14','success',NULL,0),(610,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 14:22:51','success',NULL,1),(611,74,'sulthan.kareem@titechnologies.org','À¨','2016-06-17 14:42:17','success',NULL,1),(612,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:19:23','no-member',NULL,0),(613,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:19:51','no-member',NULL,0),(614,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:20:42','no-member',NULL,0),(615,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:21:17','no-member',NULL,0),(616,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:22:05','no-member',NULL,0),(617,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:22:54','no-member',NULL,0),(618,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:24:20','no-member',NULL,0),(619,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:25:14','no-member',NULL,0),(620,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:25:29','no-member',NULL,0),(621,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:25:55','no-member',NULL,0),(622,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:27:08','no-member',NULL,0),(623,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-17 15:29:48','no-member',NULL,0),(624,84,'michael-bertrand@rentstarz.com','DÁWU','2016-06-17 15:41:03','disabled',NULL,0),(625,84,'michael-bertrand@rentstarz.com','DÁWU','2016-06-17 15:41:17','disabled',NULL,0),(626,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 15:52:00','success',NULL,0),(627,NULL,'teenuthomas12@gmail.com','À¨','2016-06-17 16:10:34','no-member',NULL,0),(628,NULL,'teenuthomas12@gmail.com','À¨','2016-06-17 16:10:36','no-member',NULL,0),(629,78,'deepthy.s@titechnologies.in','À¨','2016-06-17 16:11:19','success',NULL,0),(630,73,'Frank@test.com','À¨','2016-06-17 16:11:25','success',NULL,1),(631,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 16:12:14','success',NULL,0),(632,85,'teenu.thomas@titechnologies.org','À¨','2016-06-17 16:24:22','success',NULL,1),(633,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 17:11:02','success',NULL,1),(634,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-17 17:19:12','success',NULL,1),(635,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-18 12:13:22','no-member',NULL,0),(636,NULL,'ju11236@yahoo.com','Ð6Z¿','2016-06-18 15:34:25','no-member',NULL,0),(637,NULL,'fjhinds@live.com','Ð6Z¿','2016-06-18 15:34:51','no-member',NULL,0),(638,86,'ju11236@yahoo.com','Ð6Z¿','2016-06-18 15:42:39','success',NULL,0),(639,86,'ju11236@yahoo.com','Ð6Z¿','2016-06-18 15:53:03','success',NULL,1),(640,7,'jithesh.pk@titechnologies.in','uÎ\'I','2016-06-19 13:18:35','success',NULL,1),(641,7,'jithesh.pk@titechnologies.in','À¨','2016-06-20 03:57:48','success',NULL,1),(642,85,'teenu.thomas@titechnologies.org','À¨','2016-06-20 04:15:46','success',NULL,0),(643,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 04:15:48','success',NULL,0),(644,NULL,'bindiya.prakash@titechnologies.org','À¨','2016-06-20 04:16:46','no-member',NULL,0),(645,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 04:17:13','success',NULL,0),(646,75,'jemy.thomas@titechnologies.org','À¨','2016-06-20 04:22:36','success',NULL,0),(647,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 04:29:04','success',NULL,0),(648,78,'deepthy.s@titechnologies.in','À¨','2016-06-20 04:55:38','success',NULL,0),(649,39,'visal.varghese@titechnologies.in','À¨','2016-06-20 05:01:04','success',NULL,1),(650,7,'jithesh.pk@titechnologies.in','À¨','2016-06-20 05:03:05','success',NULL,0),(651,74,'sulthan.kareem@titechnologies.org','À¨','2016-06-20 05:05:12','success',NULL,0),(652,NULL,'qateam@titechnologies.in','À¨','2016-06-20 05:58:53','no-member',NULL,0),(653,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 05:59:16','success',NULL,0),(654,39,'visal.varghese@titechnologies.in','À¨','2016-06-20 05:59:46','success',NULL,0),(655,7,'jithesh.pk@titechnologies.in','À¨','2016-06-20 06:00:01','success',NULL,1),(656,85,'teenu.thomas@titechnologies.org','À¨','2016-06-20 06:00:41','success',NULL,1),(657,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 06:15:11','success',NULL,1),(658,87,'lima@test.com','À¨','2016-06-20 07:23:10','success',NULL,0),(659,78,'deepthy.s@titechnologies.in','À¨','2016-06-20 07:23:46','success',NULL,0),(660,77,'bindiya.prakash@titechnologies.in','À¨','2016-06-20 07:59:34','success',NULL,1),(661,85,'teenu.thomas@titechnologies.org','À¨','2016-06-20 09:15:57','success',NULL,1),(662,87,'lima@test.com','À¨','2016-06-20 09:26:03','success',NULL,1),(663,39,'visal.varghese@titechnologies.in','À¨','2016-06-20 09:47:46','success',NULL,1),(664,89,'natasha@test.com','À¨','2016-06-20 10:19:23','success',NULL,1),(665,90,'sophia@test.com','À¨','2016-06-20 10:27:04','success',NULL,1),(666,7,'jithesh.pk@titechnologies.in','u÷º','2016-06-20 10:37:07','success',NULL,0),(667,NULL,'jithesh.pk@titechnologies.org','{?|º','2016-06-20 10:56:02','no-member',NULL,0),(668,7,'jithesh.pk@titechnologies.in','{?|º','2016-06-20 10:56:16','bad-password',NULL,0),(669,77,'bindiya.prakash@titechnologies.in','{?|º','2016-06-20 10:56:55','success',NULL,0),(670,7,'jithesh.pk@titechnologies.in','{?|º','2016-06-20 11:03:52','bad-password',NULL,0),(671,7,'jithesh.pk@titechnologies.in','{?|º','2016-06-20 11:04:10','success',NULL,1),(672,7,'jithesh.pk@titechnologies.in','u÷º','2016-06-20 11:05:06','success',NULL,0),(673,39,'visal.varghese@titechnologies.in','{?|º','2016-06-20 11:08:30','success',NULL,1),(674,77,'bindiya.prakash@titechnologies.in','{?|º','2016-06-20 11:13:35','success',NULL,1),(675,92,'tom@test.com','{?|º','2016-06-20 11:14:09','success',NULL,1),(676,92,'tom@test.com','{?|º','2016-06-20 11:15:49','success',NULL,1),(677,7,'jithesh.pk@titechnologies.in','u÷º','2016-06-20 11:21:02','success',NULL,1),(678,88,'bianca@test.com','{?|º','2016-06-20 11:38:47','success',NULL,0),(679,89,'natasha@test.com','{?|º','2016-06-20 11:40:44','success',NULL,0),(680,78,'deepthy.s@titechnologies.in','{?|º','2016-06-20 11:43:01','success',NULL,0),(681,92,'tom@test.com','{?|º','2016-06-20 11:43:17','success',NULL,0),(682,74,'sulthan.kareem@titechnologies.org','{?|º','2016-06-20 11:44:33','success',NULL,0),(683,90,'sophia@test.com','{?|º','2016-06-20 11:45:33','success',NULL,0),(684,87,'lima@test.com','{?|º','2016-06-20 11:47:17','success',NULL,0),(685,77,'bindiya.prakash@titechnologies.in','{?|º','2016-06-20 11:52:49','success',NULL,1),(686,90,'sophia@test.com','{?|º','2016-06-20 11:55:19','success',NULL,0),(687,7,'jithesh.pk@titechnologies.in','u÷º','2016-06-20 12:01:36','success',NULL,1),(688,77,'bindiya.prakash@titechnologies.in','u÷º','2016-06-20 12:02:51','success',NULL,1),(689,93,'jamie@test.com','{?|º','2016-06-20 12:08:56','success',NULL,1),(690,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:33:35','no-member',NULL,0),(691,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:33:52','no-member',NULL,0),(692,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:34:06','no-member',NULL,0),(693,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:34:30','no-member',NULL,0),(694,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:34:55','no-member',NULL,0),(695,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:49:13','no-member',NULL,0),(696,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:49:34','no-member',NULL,0),(697,73,'frank@test.com','{?|º','2016-06-20 12:49:47','success',NULL,1),(698,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:50:18','no-member',NULL,0),(699,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:50:29','no-member',NULL,0),(700,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:50:46','no-member',NULL,0),(701,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:51:00','no-member',NULL,0),(702,1,'admin@suitecontact.com','N‚˜Ç','2016-06-20 12:51:00','bad-password',NULL,0),(703,NULL,'michaelbertrand@rentstarz.com','DÁWU','2016-06-20 12:51:16','no-member',NULL,0),(704,1,'admin@suitecontact.com','N‚˜Ç','2016-06-20 12:51:20','bad-password',NULL,0),(705,1,'admin@suitecontact.com','N‚˜Ç','2016-06-20 12:52:05','bad-password',NULL,0),(706,1,'admin@suitecontact.com','DÁWU','2016-06-20 12:52:09','bad-password',NULL,0),(707,1,'admin@suitecontact.com','DÁWU','2016-06-20 12:52:22','bad-password',NULL,0);
/*!40000 ALTER TABLE `engine4_user_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_membership`
--

DROP TABLE IF EXISTS `engine4_user_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_membership`
--

LOCK TABLES `engine4_user_membership` WRITE;
/*!40000 ALTER TABLE `engine4_user_membership` DISABLE KEYS */;
INSERT INTO `engine4_user_membership` VALUES (1,75,1,1,1,NULL,NULL),(1,77,1,1,1,NULL,NULL),(1,78,1,1,1,NULL,NULL),(1,82,0,1,0,NULL,NULL),(74,78,1,1,1,NULL,NULL),(75,1,1,1,1,NULL,NULL),(77,1,1,1,1,NULL,NULL),(77,78,0,1,0,NULL,NULL),(77,88,1,1,1,NULL,NULL),(77,91,0,1,0,NULL,NULL),(78,1,1,1,1,NULL,NULL),(78,74,1,1,1,NULL,NULL),(78,77,0,0,1,NULL,NULL),(82,1,0,0,1,NULL,NULL),(88,77,1,1,1,NULL,NULL),(91,77,0,0,1,NULL,NULL);
/*!40000 ALTER TABLE `engine4_user_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_online`
--

DROP TABLE IF EXISTS `engine4_user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_online` (
  `ip` varbinary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `active` datetime NOT NULL,
  PRIMARY KEY (`ip`,`user_id`),
  KEY `LOOKUP` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_online`
--

LOCK TABLES `engine4_user_online` WRITE;
/*!40000 ALTER TABLE `engine4_user_online` DISABLE KEYS */;
INSERT INTO `engine4_user_online` VALUES ('{?|º',39,'2016-06-20 12:47:54'),('{?|º',7,'2016-06-20 12:48:05'),('{?|º',0,'2016-06-20 12:49:47'),('N‚˜Ç',0,'2016-06-20 12:52:05'),('DÁWU',0,'2016-06-20 12:52:22'),('{?|º',73,'2016-06-20 12:53:18'),('u÷º',77,'2016-06-20 12:53:25'),('u÷º',7,'2016-06-20 12:53:42'),('E¯)Ì',0,'2016-06-20 12:53:48'),('{?|º',93,'2016-06-20 12:54:06'),('{?|º',77,'2016-06-20 12:54:28');
/*!40000 ALTER TABLE `engine4_user_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_settings`
--

DROP TABLE IF EXISTS `engine4_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_settings`
--

LOCK TABLES `engine4_user_settings` WRITE;
/*!40000 ALTER TABLE `engine4_user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_signup`
--

DROP TABLE IF EXISTS `engine4_user_signup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_signup` (
  `signup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`signup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_signup`
--

LOCK TABLES `engine4_user_signup` WRITE;
/*!40000 ALTER TABLE `engine4_user_signup` DISABLE KEYS */;
INSERT INTO `engine4_user_signup` VALUES (1,'User_Plugin_Signup_Account',2,1),(2,'User_Plugin_Signup_Fields',3,1),(3,'User_Plugin_Signup_Photo',4,1),(4,'User_Plugin_Signup_Invite',5,1),(5,'Payment_Plugin_Signup_Subscription',1,0);
/*!40000 ALTER TABLE `engine4_user_signup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_twitter`
--

DROP TABLE IF EXISTS `engine4_user_twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_twitter` (
  `user_id` int(10) unsigned NOT NULL,
  `twitter_uid` bigint(20) unsigned NOT NULL,
  `twitter_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twitter_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `twitter_uid` (`twitter_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_twitter`
--

LOCK TABLES `engine4_user_twitter` WRITE;
/*!40000 ALTER TABLE `engine4_user_twitter` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_verify`
--

DROP TABLE IF EXISTS `engine4_user_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_verify` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_verify`
--

LOCK TABLES `engine4_user_verify` WRITE;
/*!40000 ALTER TABLE `engine4_user_verify` DISABLE KEYS */;
INSERT INTO `engine4_user_verify` VALUES (80,'da6827e57117ac0b9c156006cb2d6a13','2016-06-17 09:24:24'),(83,'912b137708aea0e7e52e12c60146bebc','2016-06-17 13:20:50'),(84,'0fc9fc1b5eea49a8802bddc3478b0132','2016-06-17 15:39:36');
/*!40000 ALTER TABLE `engine4_user_verify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_users`
--

DROP TABLE IF EXISTS `engine4_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_unicode_ci,
  `status_date` datetime DEFAULT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `salt` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'auto',
  `language` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'en_US',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `show_profileviewers` tinyint(1) NOT NULL DEFAULT '1',
  `level_id` int(11) unsigned NOT NULL,
  `services_type_id` int(11) NOT NULL,
  `invites_used` int(11) unsigned NOT NULL DEFAULT '0',
  `extra_invites` int(11) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `bg_verified` tinyint(1) NOT NULL,
  `creation_date` datetime NOT NULL,
  `creation_ip` varbinary(16) NOT NULL,
  `modified_date` datetime NOT NULL,
  `lastlogin_date` datetime DEFAULT NULL,
  `lastlogin_ip` varbinary(16) DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL,
  `member_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `USERNAME` (`username`),
  KEY `MEMBER_COUNT` (`member_count`),
  KEY `CREATION_DATE` (`creation_date`),
  KEY `search` (`search`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_users`
--

LOCK TABLES `engine4_users` WRITE;
/*!40000 ALTER TABLE `engine4_users` DISABLE KEYS */;
INSERT INTO `engine4_users` VALUES (1,'admin@suitecontact.com','admin','mic b',1,'','0000-00-00 00:00:00','1493ecc51e69922fe62379498cf90a7d','1234567','auto','en_US','US/Pacific',1,1,7,0,0,0,1,1,1,0,'2016-03-06 01:11:44','1314086686','2016-06-20 11:16:38','2016-06-07 02:20:55','DÁWU',NULL,1,21),(7,'jithesh.pk@titechnologies.in',NULL,'jithesh pk',0,NULL,NULL,'3bfaa068a45f7ff650aa65c5bba0e04e','7093624','English','English','US/Pacific',1,1,1,0,0,0,1,1,1,0,'2016-04-26 16:43:07','Ãì^','2016-04-26 16:43:08','2016-06-20 12:01:36','u÷º',NULL,0,3),(39,'visal.varghese@titechnologies.in',NULL,'Visal Varghese',344,NULL,NULL,'f33721481d1ccac749186ec8e2b148e9','7225988','English','English','US/Pacific',1,1,1,0,0,0,1,1,1,0,'2016-05-25 07:52:49','À¨','2016-06-20 11:09:08','2016-06-20 11:08:30','{?|º',NULL,0,11),(71,'ashikh.ck@titechnologies.org',NULL,'Ashikh C K',0,NULL,NULL,'826021ccb7fbb54796badf3badd74c69','4085009','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,1,'2016-06-17 04:16:58','À¨','2016-06-17 06:45:45',NULL,NULL,NULL,0,2),(72,'cathy@test.com',NULL,'Catherine Glenita',0,NULL,NULL,'d69016cdb02d9efa5ecb2cf22694930e','5435602','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,1,'2016-06-17 04:18:53','À¨','2016-06-17 06:25:08',NULL,NULL,NULL,0,3),(73,'Frank@test.com',NULL,'Frank Mark',410,NULL,NULL,'a6d54f7737a3bdc9271b13a7f24ad24c','8747375','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,0,'2016-06-17 05:22:40','À¨','2016-06-20 12:50:38','2016-06-20 12:49:47','{?|º',NULL,0,6),(74,'sulthan.kareem@titechnologies.org',NULL,'Sulthan Kareem',378,NULL,NULL,'961f18a0ece9832ab07ea8311acdc9f7','3050474','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,1,'2016-06-17 08:37:33','À¨','2016-06-20 11:44:49','2016-06-20 11:44:33','{?|º',NULL,1,12),(75,'Jemy.thomas@titechnologies.org',NULL,'Jemy Thomas',264,NULL,NULL,'fd3599838db2b68ff65e2a79d9908608','7115863','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,0,'2016-06-17 08:38:50','À¨','2016-06-20 04:23:00','2016-06-20 04:22:36','À¨',NULL,0,4),(76,'rita.jose@titechnologies.org',NULL,'Rita Jose',274,NULL,NULL,'19efdbeaf1db9f1767e03125af1256cd','3147917','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,0,'2016-06-17 08:49:49','À¨','2016-06-17 08:50:17',NULL,NULL,NULL,0,3),(77,'bindiya.prakash@titechnologies.in',NULL,'',354,NULL,NULL,'5d095724b852e14e0538d4b90d423078','8614917','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-17 08:51:15','À¨','2016-06-20 11:38:59','2016-06-20 12:02:51','u÷º',NULL,1,8),(78,'deepthy.s@titechnologies.in',NULL,'',372,NULL,NULL,'15144f562cdac8396200c27adb168daf','4040505','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-17 08:58:18','À¨','2016-06-20 11:43:38','2016-06-20 11:43:01','{?|º',NULL,1,8),(79,'ganesh.nath@titechnologies.org',NULL,'Ganesh Nath',286,NULL,NULL,'10c17d11bea62dd24d46b25e957e93a4','4699280','English','English','US/Pacific',1,1,8,3,0,0,1,1,1,0,'2016-06-17 09:00:39','À¨','2016-06-17 09:00:53',NULL,NULL,NULL,0,11),(80,'helen@test.com',NULL,'Helen Cruce',290,NULL,NULL,'4a21b76e54378ca7e14a2a5a657ce8fa','2473955','English','English','US/Pacific',1,1,8,3,0,0,0,0,1,0,'2016-06-17 09:24:24','À¨','2016-06-17 09:24:24',NULL,NULL,NULL,0,0),(82,'meera@test.com',NULL,'',0,NULL,NULL,'bc89c38e778659abde313631fd149592','1918432','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-17 13:13:27','À¨','2016-06-17 13:13:46','2016-06-17 13:14:29','À¨',NULL,0,3),(83,'fdgdfg@dfd.com',NULL,'',0,NULL,NULL,'c3ceca99004fa3317d6e93fc3731a470','5717725','English','English','US/Pacific',1,1,6,0,0,0,0,0,1,0,'2016-06-17 13:20:50','À¨','2016-06-17 13:20:50',NULL,NULL,NULL,0,0),(84,'michael-bertrand@rentstarz.com',NULL,'Fabia Hinds',0,NULL,NULL,'769826f679996e4769120d786ea3e228','3332585','English','English','US/Eastern',1,1,7,0,0,0,0,0,1,0,'2016-06-17 15:39:36','DÁWU','2016-06-17 15:39:36',NULL,NULL,NULL,0,0),(85,'teenu.thomas@titechnologies.org',NULL,'Teenu Thomas',0,NULL,NULL,'46db256152db947f7bf789e68b6da741','2635047','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,0,'2016-06-17 16:23:51','À¨','2016-06-17 16:24:14','2016-06-20 09:15:57','À¨',NULL,0,2),(86,'ju11236@yahoo.com',NULL,'Fabia Hinds',310,NULL,NULL,'b16a77cd95912a2716fe5b42e18fd7c5','7348410','English','English','US/Eastern',1,1,7,0,0,0,1,1,1,0,'2016-06-18 15:37:51','Ð6Z¿','2016-06-18 17:25:42','2016-06-18 15:53:03','Ð6Z¿',NULL,0,0),(87,'lima@test.com',NULL,'Lima Philip',396,NULL,NULL,'d49861313b45a36c8b1694d8e6d6383f','5454359','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-20 07:21:59','À¨','2016-06-20 11:49:33','2016-06-20 11:47:17','{?|º',NULL,0,3),(88,'bianca@test.com',NULL,'Bianca Kristine',360,NULL,NULL,'78459a7f497ae9191335637a828aa0e6','9000236','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-20 07:57:08','À¨','2016-06-20 11:39:49','2016-06-20 11:38:47','{?|º',NULL,0,8),(89,'natasha@test.com',NULL,'natasha  Gomes',366,NULL,NULL,'7e1747c8f223c5c05e39ed1b5959382f','8436980','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,1,'2016-06-20 10:01:52','À¨','2016-06-20 11:42:08','2016-06-20 11:40:44','{?|º',NULL,0,0),(90,'sophia@test.com',NULL,'Sophia Claire',384,NULL,NULL,'b1add8299b8d890904213f82b1a50617','2678371','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-20 10:26:00','À¨','2016-06-20 11:45:59','2016-06-20 11:55:19','{?|º',NULL,0,0),(91,'angela@test.com',NULL,'Angela Cathy',340,NULL,NULL,'0855a6b044d3fd11e7d13e0588745e8b','4623580','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-20 11:07:47','{?|º','2016-06-20 11:11:03',NULL,NULL,NULL,0,1),(92,'tom@test.com',NULL,'Tom Sawyer',350,NULL,NULL,'93d0647f4b5f73fb93aa0e5019fa1025','6350576','English','English','US/Pacific',1,1,7,0,0,0,1,1,1,1,'2016-06-20 11:12:46','{?|º','2016-06-20 11:13:35','2016-06-20 11:43:17','{?|º',NULL,0,2),(93,'Jamie@test.com',NULL,'Jamie Sullivan',402,NULL,NULL,'a0abd093a614390f01cc5c634afca83e','8737593','English','English','US/Pacific',1,1,6,0,0,0,1,1,1,0,'2016-06-20 12:05:43','{?|º','2016-06-20 12:07:50','2016-06-20 12:08:56','{?|º',NULL,0,1);
/*!40000 ALTER TABLE `engine4_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_ynresponsivepurity_modules`
--

DROP TABLE IF EXISTS `engine4_ynresponsivepurity_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_ynresponsivepurity_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `icon_id` int(11) NOT NULL DEFAULT '0',
  `hover_icon_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_ynresponsivepurity_modules`
--

LOCK TABLES `engine4_ynresponsivepurity_modules` WRITE;
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_ynresponsivepurity_sliders`
--

DROP TABLE IF EXISTS `engine4_ynresponsivepurity_sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_ynresponsivepurity_sliders` (
  `slider_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_ynresponsivepurity_sliders`
--

LOCK TABLES `engine4_ynresponsivepurity_sliders` WRITE;
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_sliders` DISABLE KEYS */;
INSERT INTO `engine4_ynresponsivepurity_sliders` VALUES (1,'Find your match ','Browse for tenants and landlords that meet your requirement. ','',19,0),(2,'Rent anywhere in the world','Meet your landlord, view your apartment before you move.\r\n','',21,3),(4,'No brokers fee','connect directly with landlords. Meet interesting interesting and start talking.','',27,1);
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_sliders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_ynresponsivepurity_welcomes`
--

DROP TABLE IF EXISTS `engine4_ynresponsivepurity_welcomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_ynresponsivepurity_welcomes` (
  `welcome_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(220) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `text_link` varchar(256) DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`welcome_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_ynresponsivepurity_welcomes`
--

LOCK TABLES `engine4_ynresponsivepurity_welcomes` WRITE;
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_welcomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_ynresponsivepurity_welcomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_younetcore_apisettings`
--

DROP TABLE IF EXISTS `engine4_younetcore_apisettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_younetcore_apisettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `params` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_younetcore_apisettings`
--

LOCK TABLES `engine4_younetcore_apisettings` WRITE;
/*!40000 ALTER TABLE `engine4_younetcore_apisettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_younetcore_apisettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_younetcore_install`
--

DROP TABLE IF EXISTS `engine4_younetcore_install`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_younetcore_install` (
  `token` text NOT NULL,
  `params` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_younetcore_install`
--

LOCK TABLES `engine4_younetcore_install` WRITE;
/*!40000 ALTER TABLE `engine4_younetcore_install` DISABLE KEYS */;
INSERT INTO `engine4_younetcore_install` VALUES ('e4e4191ae43fd8d2bec15711143efeea','1461533898',1);
/*!40000 ALTER TABLE `engine4_younetcore_install` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_younetcore_license`
--

DROP TABLE IF EXISTS `engine4_younetcore_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_younetcore_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `title` text NOT NULL,
  `descriptions` text,
  `type` varchar(50) NOT NULL,
  `current_version` varchar(50) NOT NULL,
  `lasted_version` varchar(50) NOT NULL,
  `is_active` int(1) DEFAULT '0',
  `date_active` int(11) DEFAULT NULL,
  `params` text,
  `download_link` varchar(500) DEFAULT NULL,
  `demo_link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_younetcore_license`
--

LOCK TABLES `engine4_younetcore_license` WRITE;
/*!40000 ALTER TABLE `engine4_younetcore_license` DISABLE KEYS */;
INSERT INTO `engine4_younetcore_license` VALUES (1,'ynresponsivepurity','YN - Responsive Purity Template','','module','4.01','4.01',1,NULL,'a:8:{s:1:\"m\";s:18:\"ynresponsivepurity\";s:2:\"tk\";s:32:\"e4e4191ae43fd8d2bec15711143efeea\";s:1:\"d\";s:20:\"cmVudHN0YXJ6LmNvbQ==\";s:2:\"ep\";s:10:\"1461533898\";s:4:\"time\";s:10:\"1461533898\";s:2:\"ls\";s:19:\"JCPZ-MFDF-ZKLD-QEZG\";s:1:\"t\";s:7:\"license\";s:3:\"svl\";s:300:\"YTo2OntzOjU6ImVtYWlsIjtzOjI4OiJtaWNoYWVsLWJlcnRyYW5kQGhvdG1haWwuY29tIjtzOjY6ImRvbWFpbiI7TjtzOjExOiJtb2R1bGVfbmFtZSI7czoxODoieW5yZXNwb25zaXZlcHVyaXR5IjtzOjg6Imhhc2hfa2V5IjtzOjE5OiJKQ1BaLU1GREYtWktMRC1RRVpHIjtzOjg6InBsYXRmb3JtIjtzOjEyOiJzb2NpYWxlbmdpbmUiO3M6MTY6InBsYXRmb3JtX3ZlcnNpb24iO3M6MToiNCI7fQ==\";}',NULL,NULL);
/*!40000 ALTER TABLE `engine4_younetcore_license` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-20  7:54:30

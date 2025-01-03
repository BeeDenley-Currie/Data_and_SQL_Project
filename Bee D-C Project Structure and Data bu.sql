-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: berc
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `Billing_id` int NOT NULL,
  `Billing_line1` varchar(50) NOT NULL,
  `Billing_line2` varchar(50) NOT NULL,
  `Billing_town` varchar(50) NOT NULL,
  `Billing_county` varchar(50) NOT NULL,
  `Billing_postcode` varchar(8) NOT NULL,
  `Billing_method` varchar(50) NOT NULL,
  PRIMARY KEY (`Billing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` VALUES (1,'Flat A','123 Street','Ntown','Ccounty','ZY01 2BC','Card'),(2,'62 West Wallaby Street','','Wigan','','WG7 7FU','Card'),(3,'221c Baker Street','Marylebone','London','','NW1 6XE','Direct Debit'),(4,'44 Scotland Street','','Edinburgh','','EH3 6PY','Card'),(5,'Cardiff Tourist Information Centre','Mermaid Quay','Cardiff','','CF10 5BZ','Direct Debit'),(6,'Tuarach House','17 Old Broch Road','Brochburnie','Invernessshire','IV4 5JF','Card'),(7,'4 Privet Drive','','Little Whinging','Surrey','GU10 3RW','Direct Debit'),(8,'1 High Street','Thrush Green','Fordingbridge','Hampshire','SP6 3BY','Card');
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_id` int NOT NULL,
  `Cust_first_name` varchar(50) DEFAULT NULL,
  `Cust_last_name` varchar(50) DEFAULT NULL,
  `Cust_email` varchar(50) NOT NULL,
  `Bill_id` int NOT NULL,
  PRIMARY KEY (`Customer_id`),
  KEY `Bill_id` (`Bill_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Bill_id`) REFERENCES `billing` (`Billing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Ellie','O\'logie','ec-ologie@ecology.org',1),(2,'Mike','O\'logie','mk-ologie@ecology.org',1),(3,'Fox','Smith','foxsmith@vulpesenvironmental.co.uk',2),(4,'Charlotte','Darwin','darwin@beagle.com',3),(5,'Tiffany','Ma','tiffany@ma-eco.co.uk',4),(6,'Jack','Daw','info@croweco.com',5),(7,'Mark','Watney','botanybuff@potato.com',6),(8,'Eleanor','Arroway','contact@arroway.co.uk',7),(9,'Alice','Embleton','alice@foosack.uk',8),(10,'Pica','McCaw','info@croweco.com',5);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `Location_id` int NOT NULL,
  `Loc_name` varchar(50) NOT NULL,
  `Loc_area` varchar(50) NOT NULL,
  `Habitat_type` varchar(15) NOT NULL,
  PRIMARY KEY (`Location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Ben Macdui','Aberdeenshire','Mountain'),(2,'Ash Ranges','Surrey','Heath'),(3,'Donkey Town','Surrey','Urban'),(4,'Bromwich Wood','West Midlands','Urban'),(5,'Coylumbridge','Aberdeenshire','Farmland'),(6,'RSPB Sandy','Bedfordshire','Woodland'),(7,'Pulborough Brooks','Sussex','Woodland'),(8,'Buckingham Palace','London','Urban'),(9,'Bodlondeb Woods','Conwy','Woodland'),(10,'Willen Lake','Buckinghamshire','Grassland'),(11,'Langton Herring','Dorset','Farmland'),(12,'Beaulieu Heath','Hampshire','Heath'),(13,'Devil\'s Punchbowl','Surrey','Heath'),(14,'Maryculter','Aberdeenshire','Woodland'),(15,'Herrings Green','Bedfordshire','Farmland'),(16,'Fox Hill','Sussex','Farmland'),(17,'St Paul\'s Cathedral','London','Urban'),(18,'Carnedd Llewelyn','Conwy','Mountain'),(19,'Hanslope Park','Buckinghamshire','Farmland'),(20,'Wynford Eagle','Dorset','Farmland'),(21,'Allum Green','Hampshire','Woodland'),(22,'Bletchley Park','Buckinghamshire','Urban'),(23,'Duck\'s Cross','Bedfordshire','Farmland'),(24,'Wimbledon Common','London','Woodland');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `obs_overview`
--

DROP TABLE IF EXISTS `obs_overview`;
/*!50001 DROP VIEW IF EXISTS `obs_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `obs_overview` AS SELECT 
 1 AS `ID`,
 1 AS `date`,
 1 AS `Scientific_Name`,
 1 AS `Common_Name`,
 1 AS `Taxon`,
 1 AS `Number_Seen`,
 1 AS `Location`,
 1 AS `Area`,
 1 AS `Recorder_First_Name`,
 1 AS `Recorder_Last_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `observation`
--

DROP TABLE IF EXISTS `observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `observation` (
  `Observation_id` int NOT NULL,
  `Obs_date` date NOT NULL,
  `Spec_id` int NOT NULL,
  `Obs_number` int DEFAULT NULL,
  `Loc_id` int NOT NULL,
  `Rec_id` int DEFAULT NULL,
  PRIMARY KEY (`Observation_id`),
  KEY `Spec_id` (`Spec_id`),
  KEY `Loc_id` (`Loc_id`),
  KEY `Rec_id` (`Rec_id`),
  CONSTRAINT `observation_ibfk_1` FOREIGN KEY (`Spec_id`) REFERENCES `species` (`species_id`),
  CONSTRAINT `observation_ibfk_2` FOREIGN KEY (`Loc_id`) REFERENCES `location` (`Location_id`),
  CONSTRAINT `observation_ibfk_3` FOREIGN KEY (`Rec_id`) REFERENCES `recorder` (`Recorder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observation`
--

LOCK TABLES `observation` WRITE;
/*!40000 ALTER TABLE `observation` DISABLE KEYS */;
INSERT INTO `observation` VALUES (1,'2020-02-07',35,1,18,9),(2,'2020-04-08',3,1,14,4),(3,'2020-05-29',24,5,4,5),(4,'2020-06-01',20,1,3,5),(5,'2020-06-02',42,5,16,9),(6,'2020-06-02',29,5,19,3),(7,'2020-06-02',27,9,1,8),(8,'2020-07-15',8,10,1,1),(9,'2020-07-16',44,4,24,6),(10,'2020-08-25',30,4,2,4),(11,'2020-08-25',3,4,1,4),(12,'2020-11-26',44,6,22,2),(13,'2020-12-03',42,4,15,4),(14,'2021-01-13',45,5,2,2),(15,'2021-04-02',45,5,16,9),(16,'2021-04-02',40,9,11,5),(17,'2021-05-14',39,9,18,4),(18,'2021-08-03',27,9,22,1),(19,'2021-08-31',12,5,10,7),(20,'2021-09-06',5,9,13,1),(21,'2021-09-28',27,9,4,4),(22,'2021-10-04',16,10,20,7),(23,'2021-10-13',21,7,7,1),(24,'2022-02-18',25,7,21,2),(25,'2022-03-15',31,3,7,6),(26,'2022-03-21',46,9,8,9),(27,'2022-04-12',46,3,17,8),(28,'2022-05-09',46,7,24,2),(29,'2022-05-18',19,10,21,8),(30,'2022-05-27',15,3,8,4),(31,'2022-08-01',7,9,5,7),(32,'2022-11-02',47,9,8,5),(33,'2022-11-02',47,4,5,8),(34,'2023-01-02',15,8,1,5),(35,'2023-02-27',16,3,11,3),(36,'2023-04-10',50,1,16,1),(37,'2023-04-17',41,5,6,8),(38,'2023-05-11',6,3,3,3),(39,'2023-07-03',48,6,11,5),(40,'2023-07-06',10,8,9,2),(41,'2023-08-30',42,3,19,8),(42,'2023-10-20',45,2,10,8),(43,'2023-12-07',39,1,20,2);
/*!40000 ALTER TABLE `observation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ord_overview`
--

DROP TABLE IF EXISTS `ord_overview`;
/*!50001 DROP VIEW IF EXISTS `ord_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ord_overview` AS SELECT 
 1 AS `Order_id`,
 1 AS `date`,
 1 AS `Order_Area`,
 1 AS `First_Name`,
 1 AS `Last_Name`,
 1 AS `email`,
 1 AS `Billing_Method`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_id` int NOT NULL,
  `Order_date` date NOT NULL,
  `Order_Area` varchar(50) NOT NULL,
  `Cust_id` int NOT NULL,
  PRIMARY KEY (`Order_id`),
  KEY `Cust_id` (`Cust_id`),
  KEY `fk_order_location_idx` (`Order_Area`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Cust_id`) REFERENCES `customer` (`Customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2024-01-01','Surrey',10),(2,'2024-01-03','West Midlands',2),(3,'2024-01-08','Aberdeenshire',8),(4,'2024-01-10','Bedfordshire',1),(5,'2024-01-12','Sussex',6),(6,'2024-01-15','London',8),(7,'2024-01-17','Conwy',4),(8,'2024-01-19','Buckinghamshire',2),(9,'2024-01-22','Dorset',5),(10,'2024-01-24','Hampshire',8),(11,'2024-01-26','Buckinghamshire',2),(12,'2024-01-30','West Midlands',4),(13,'2024-02-01','London',9),(14,'2024-02-02','Bedfordshire',2),(15,'2024-02-08','Dorset',1),(16,'2024-02-14','Surrey',10),(17,'2024-02-21','Sussex',6),(18,'2024-02-22','West Midlands',1),(19,'2024-02-23','Buckinghamshire',2),(20,'2024-03-06','Bedfordshire',1),(21,'2024-03-07','Hampshire',7),(22,'2024-03-11','Sussex',6),(23,'2024-03-19','Dorset',9),(24,'2024-03-25','London',5),(25,'2024-03-27','Surrey',6);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recorder`
--

DROP TABLE IF EXISTS `recorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recorder` (
  `Recorder_id` int NOT NULL,
  `Rec_first_name` varchar(50) DEFAULT NULL,
  `Rec_last_name` varchar(50) DEFAULT NULL,
  `Rec_email` varchar(50) NOT NULL,
  `Rec_group` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Recorder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recorder`
--

LOCK TABLES `recorder` WRITE;
/*!40000 ALTER TABLE `recorder` DISABLE KEYS */;
INSERT INTO `recorder` VALUES (1,'Newton','Izzard','newt.l.izzard@email.com','Farnborough Amphibian Reptile Team'),(2,'Shady','Sinker','shady.s@cfg.info','Cod First Gills'),(3,'Ann','Tenna','anntenna@email.com','Birmingham Bug Charity'),(4,'Kitty','McClaw','kitty.m@cat.co.uk','Cairngorm Animal Trust'),(5,'Captain','Birdseye','something-fishy@cfg.info','Cod First Gills'),(6,'Susan','Green','s.green@email.com',''),(7,'Ada','Lovelace','computingKween@flyology.co.uk','Flyology'),(8,'Mel','Iferra','honeybee@abuzz.org','All Abuzz'),(9,'Joseph','Bloggson','everyman@bloggist.com','');
/*!40000 ALTER TABLE `recorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `species` (
  `species_id` int NOT NULL,
  `scientific_name` varchar(50) NOT NULL,
  `common_name` varchar(50) DEFAULT NULL,
  `taxon` varchar(15) NOT NULL,
  PRIMARY KEY (`species_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` VALUES (1,'Triturus cristatus','Great crested newt','Amphibian'),(2,'Adalia bipunctata','Two spot ladybird','Insect'),(3,'Felis silvestris','Wild cat','Mammal'),(4,'Saxifraga hirculus','Marsh saxifrage','Plant'),(5,'Lutra lutra','Otter','Mammal'),(6,'Pipistrellus pipistrellus','Common pipistrelle bat','Mammal'),(7,'Mustela vison','American mink','Mammal'),(8,'Tetrao urogallus','Capercaillie','Bird'),(9,'Electromus popularis','Pikachu','Pokemon'),(10,'Anguis fragilis','Slow worm','Reptile'),(11,'Zygaena viciae','New Forest burnet','Moth'),(12,'Milvus milvus','Red Kite','Bird'),(13,'Tyto alba','Barn owl','Bird'),(14,'Tyria jacobaeae','Cinnabar moth','Moth'),(15,'Gonepteryx rhamni','Brimstone','Butterfly'),(16,'Bombylius minor','Heath bee-fly','Insect'),(17,'Apium repens','Creeping marshwort','Plant'),(18,'Martes martes','Pine marten','Mammal'),(19,'Lacerta agilis','Sand lizard','Reptile'),(20,'Coronella austriaca','Smooth snake','Reptile'),(21,'Lissotriton vulgaris','Smooth newt','Amphibian'),(22,'Lissotriton helveticus','Palmate Newt','Amphibian'),(23,'Bufo bufo','Common toad','Amphibian'),(24,'Epidalea calamita','Natterjack toad','Amphibian'),(25,'Ichthyosaura alpestris','Alpine newt','Amphibian'),(26,'Castor fiber','Eurasian beaver','Mammal'),(27,'Sciurus vulgaris','Red squirrel','Mammal'),(28,'Arvicola amphibius','Water vole','Mammal'),(29,'Eptesicus serotinus','Serotine bat','Mammal'),(30,'Aeshna caerulea','Azure hawker','Insect'),(31,'Neomys fodiens','Water shrew','Mammal'),(32,'Muscardinus avellanarius','Hazel dormouse','Mammal'),(33,'Glis glis','Edible dormouse','Mammal'),(34,'Myodes glareolus ','Bank vole','Mammal'),(35,'Microtus agrestis','Field vole','Mammal'),(36,'Helix pomatia','Roman snail','Mollusc'),(37,'Deilephila elpenor','Elephant hawk-moth','Insect'),(38,'Pipistrellus pygmaeus','Soprano pipistrelle','Mammal'),(39,'Pipistrellus nathusii','Nathusius\' pipistrelle','Mammal'),(40,'Myotis daubentonii','Daubenton\'s bat','Mammal'),(41,'Myotis nattereri','Natterer\'s bat','Mammal'),(42,'Myotis mystacinus','Whiskered bat','Mammal'),(43,'Myotis brandtii','Brandt\'s bat','Mammal'),(44,'Barbastella barbastellus','Barbastelle bat','Mammal'),(45,'Plecotus auritus','Brown long-eared bat','Mammal'),(46,'Plecotus austriacus','Grey long-eared bat','Mammal'),(47,'Rhinolophus ferrumequinum','Greater horseshoe bat','Mammal'),(48,'Rhinolophus hipposideros','Lesser horseshoe bat','Mammal'),(49,'Nyctalus noctula','Noctule','Mammal'),(50,'Nyctalus leisleri','Leisler\'s bat','Mammal');
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `obs_overview`
--

/*!50001 DROP VIEW IF EXISTS `obs_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `obs_overview` AS select `obs`.`Observation_id` AS `ID`,`obs`.`Obs_date` AS `date`,`spec`.`scientific_name` AS `Scientific_Name`,`spec`.`common_name` AS `Common_Name`,`spec`.`taxon` AS `Taxon`,`obs`.`Obs_number` AS `Number_Seen`,`loc`.`Loc_name` AS `Location`,`loc`.`Loc_area` AS `Area`,`rec`.`Rec_first_name` AS `Recorder_First_Name`,`rec`.`Rec_last_name` AS `Recorder_Last_Name` from (((`observation` `obs` join `species` `spec` on((`obs`.`Spec_id` = `spec`.`species_id`))) join `location` `loc` on((`obs`.`Loc_id` = `loc`.`Location_id`))) join `recorder` `rec` on((`obs`.`Rec_id` = `rec`.`Recorder_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ord_overview`
--

/*!50001 DROP VIEW IF EXISTS `ord_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ord_overview` AS select `ord`.`Order_id` AS `Order_id`,`ord`.`Order_date` AS `date`,`ord`.`Order_Area` AS `Order_Area`,`cust`.`Cust_first_name` AS `First_Name`,`cust`.`Cust_last_name` AS `Last_Name`,`cust`.`Cust_email` AS `email`,`bill`.`Billing_method` AS `Billing_Method` from ((`orders` `ord` join `customer` `cust` on((`ord`.`Cust_id` = `cust`.`Customer_id`))) join `billing` `bill` on((`cust`.`Bill_id` = `bill`.`Billing_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20 18:10:19

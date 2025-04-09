-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `addressID` int NOT NULL AUTO_INCREMENT,
  `addressTownID` int DEFAULT NULL,
  `addressStreetID` int DEFAULT NULL,
  `addressBuilding` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `addressAppartment` varchar(100) DEFAULT NULL,
  `addressComment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`addressID`),
  KEY `Address_Streets_FK` (`addressStreetID`),
  KEY `Address_Towns_FK` (`addressTownID`),
  CONSTRAINT `address_streets_FK` FOREIGN KEY (`addressStreetID`) REFERENCES `streets` (`streetID`),
  CONSTRAINT `address_towns_FK` FOREIGN KEY (`addressTownID`) REFERENCES `towns` (`townID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonussystem`
--

DROP TABLE IF EXISTS `bonussystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonussystem` (
  `bonusID` int NOT NULL AUTO_INCREMENT,
  `bonusDate` datetime DEFAULT NULL,
  `bonusOrderID` int DEFAULT NULL,
  `bonusType` tinyint DEFAULT NULL,
  `bonusAmmount` int DEFAULT NULL,
  `bonusCustomerID` int DEFAULT NULL,
  PRIMARY KEY (`bonusID`),
  KEY `BonusSystem_ProductOrders_FK` (`bonusOrderID`),
  KEY `BonusSystem_Customers_FK` (`bonusCustomerID`),
  CONSTRAINT `bonussystem_customers_FK` FOREIGN KEY (`bonusCustomerID`) REFERENCES `customers` (`customerID`),
  CONSTRAINT `bonussystem_productorders_FK` FOREIGN KEY (`bonusOrderID`) REFERENCES `productorders` (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonussystem`
--

LOCK TABLES `bonussystem` WRITE;
/*!40000 ALTER TABLE `bonussystem` DISABLE KEYS */;
/*!40000 ALTER TABLE `bonussystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `categoryName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `categoryID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customerName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customerPhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customerEmail` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customerAddress` int DEFAULT NULL,
  `customerID` int NOT NULL AUTO_INCREMENT,
  `customerThumbnail` varchar(255) DEFAULT NULL,
  `customerPassword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`customerID`),
  KEY `Customers_Address_FK` (`customerAddress`),
  CONSTRAINT `customers_address_FK` FOREIGN KEY (`customerAddress`) REFERENCES `address` (`addressID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('ykujlfvluj','ghfjfy','ghjfgh',NULL,1,NULL,'urttr'),('thfgsdf','ghsdfgdsf','gdfsgsdfg',NULL,2,NULL,'43rtwertwe'),('asdf','1234','zxcv',NULL,3,NULL,'qwer');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbackattachments`
--

DROP TABLE IF EXISTS `feedbackattachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbackattachments` (
  `feedbackAttachmentID` int NOT NULL AUTO_INCREMENT,
  `feedbackID` int DEFAULT NULL,
  `feedbackAttachmentsSource` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feedbackAttachmentID`),
  KEY `FeedbackAttachments_Feedbacks_FK` (`feedbackID`),
  CONSTRAINT `feedbackattachments_feedbacks_FK` FOREIGN KEY (`feedbackID`) REFERENCES `feedbacks` (`feedbacksID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbackattachments`
--

LOCK TABLES `feedbackattachments` WRITE;
/*!40000 ALTER TABLE `feedbackattachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbackattachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbackcats`
--

DROP TABLE IF EXISTS `feedbackcats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbackcats` (
  `feedbackCatID` int NOT NULL AUTO_INCREMENT,
  `feedbackCatName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`feedbackCatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbackcats`
--

LOCK TABLES `feedbackcats` WRITE;
/*!40000 ALTER TABLE `feedbackcats` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbackcats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `feedbacksID` int NOT NULL AUTO_INCREMENT,
  `feedbacksDate` datetime DEFAULT NULL,
  `feedbacksNumber` varchar(20) DEFAULT NULL,
  `feedbacksCatID` int DEFAULT NULL,
  `feedbacksAuthor` varchar(50) DEFAULT NULL,
  `feedbacksContact` varchar(45) DEFAULT NULL,
  `feedbacksContent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feedbacksID`),
  KEY `Feedbacks_FeedbackCats_FK` (`feedbacksCatID`),
  CONSTRAINT `feedbacks_feedbackcats_FK` FOREIGN KEY (`feedbacksCatID`) REFERENCES `feedbackcats` (`feedbackCatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstatus` (
  `statusID` int NOT NULL AUTO_INCREMENT,
  `statusName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`statusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatus`
--

LOCK TABLES `orderstatus` WRITE;
/*!40000 ALTER TABLE `orderstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcat`
--

DROP TABLE IF EXISTS `productcat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcat` (
  `productCatID` int NOT NULL AUTO_INCREMENT,
  `productID` int NOT NULL,
  `categoryID` int NOT NULL,
  PRIMARY KEY (`productCatID`,`productID`,`categoryID`),
  KEY `ProductCat_Category_FK` (`categoryID`),
  KEY `ProductCat_Products_FK` (`productID`),
  CONSTRAINT `productcat_categories_FK` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`),
  CONSTRAINT `productcat_products_FK` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcat`
--

LOCK TABLES `productcat` WRITE;
/*!40000 ALTER TABLE `productcat` DISABLE KEYS */;
/*!40000 ALTER TABLE `productcat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productorders`
--

DROP TABLE IF EXISTS `productorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productorders` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `orderDate` datetime DEFAULT NULL,
  `orderStatusID` int DEFAULT NULL,
  `orderAddressID` int DEFAULT NULL,
  `orderDeliveryDate` datetime DEFAULT NULL,
  `orderNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customerID` int DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `ProductOrders_Customers_FK` (`customerID`),
  KEY `ProductOrders_OrderStatus_FK` (`orderStatusID`),
  KEY `ProductOrders_Address_FK` (`orderAddressID`),
  CONSTRAINT `productorders_address_FK` FOREIGN KEY (`orderAddressID`) REFERENCES `address` (`addressID`),
  CONSTRAINT `productorders_customers_FK` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`),
  CONSTRAINT `productorders_orderstatus_FK` FOREIGN KEY (`orderStatusID`) REFERENCES `orderstatus` (`statusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productorders`
--

LOCK TABLES `productorders` WRITE;
/*!40000 ALTER TABLE `productorders` DISABLE KEYS */;
/*!40000 ALTER TABLE `productorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productprices`
--

DROP TABLE IF EXISTS `productprices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productprices` (
  `productPriceID` int NOT NULL AUTO_INCREMENT,
  `productPrice` decimal(10,0) DEFAULT NULL,
  `priceDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `productID` int NOT NULL,
  PRIMARY KEY (`productPriceID`,`productID`),
  KEY `ProductPrices_Products_FK` (`productID`),
  CONSTRAINT `productprices_products_FK` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productprices`
--

LOCK TABLES `productprices` WRITE;
/*!40000 ALTER TABLE `productprices` DISABLE KEYS */;
INSERT INTO `productprices` VALUES (1,100,'2025-03-25 04:57:12',2),(2,150,'2025-03-25 04:57:54',1),(3,200,'2025-03-25 04:57:54',3),(5,50,'2025-03-26 05:58:51',2);
/*!40000 ALTER TABLE `productprices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productreviews`
--

DROP TABLE IF EXISTS `productreviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productreviews` (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `productID` int DEFAULT NULL,
  `reviewDate` datetime DEFAULT NULL,
  `reviewScore` int DEFAULT NULL,
  `customerID` int DEFAULT NULL,
  `reviewDescription` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  KEY `ProductReviews_Customers_FK` (`customerID`),
  KEY `ProductReviews_Products_FK` (`productID`),
  CONSTRAINT `productreviews_customers_FK` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`),
  CONSTRAINT `productreviews_products_FK` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productreviews`
--

LOCK TABLES `productreviews` WRITE;
/*!40000 ALTER TABLE `productreviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `productreviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productID` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) NOT NULL,
  `productDescription` varchar(255) NOT NULL,
  `productThumbnail` varchar(255) NOT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Pupa Milano','Это жизненно необходимый продукт  для каждого человека, без него невозможно представить свою жизнь! Как только вы приобретете Pupa Milano ваша жизнь  уже никогда не станет прежней!','/images/bill.png'),(2,'Лупа','Это лупа','/images/lupa.png'),(3,'Другое','Вы не понимаете - это другое','/images/pupa3.png');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewattachments`
--

DROP TABLE IF EXISTS `reviewattachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewattachments` (
  `attachmentsID` int NOT NULL AUTO_INCREMENT,
  `attachmentsSource` varchar(255) DEFAULT NULL,
  `reviewattachID` int DEFAULT NULL,
  PRIMARY KEY (`attachmentsID`),
  KEY `ReviewAttachments_ProductReviews_FK` (`reviewattachID`),
  CONSTRAINT `reviewattachments_productreviews_FK` FOREIGN KEY (`reviewattachID`) REFERENCES `productreviews` (`reviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewattachments`
--

LOCK TABLES `reviewattachments` WRITE;
/*!40000 ALTER TABLE `reviewattachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviewattachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesproducts`
--

DROP TABLE IF EXISTS `salesproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesproducts` (
  `salesID` int NOT NULL AUTO_INCREMENT,
  `salesProductID` int DEFAULT NULL,
  `salesOrderID` int DEFAULT NULL,
  `salesDate` datetime DEFAULT NULL,
  `salesPrice` decimal(10,0) DEFAULT NULL,
  `salesAmmount` int DEFAULT NULL,
  PRIMARY KEY (`salesID`),
  KEY `SalesProducts_ProductOrders_FK` (`salesOrderID`),
  KEY `SalesProducts_Products_FK` (`salesProductID`),
  CONSTRAINT `salesproducts_productorders_FK` FOREIGN KEY (`salesOrderID`) REFERENCES `productorders` (`orderID`),
  CONSTRAINT `salesproducts_products_FK` FOREIGN KEY (`salesProductID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesproducts`
--

LOCK TABLES `salesproducts` WRITE;
/*!40000 ALTER TABLE `salesproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schopingcart`
--

DROP TABLE IF EXISTS `schopingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schopingcart` (
  `cartID` int NOT NULL AUTO_INCREMENT,
  `cartCustomerID` int DEFAULT NULL,
  `cartProductID` int DEFAULT NULL,
  `cartProductAmount` int DEFAULT NULL,
  PRIMARY KEY (`cartID`),
  KEY `SchopingCart_Customers_FK` (`cartCustomerID`),
  KEY `SchopingCart_Products_FK` (`cartProductID`),
  CONSTRAINT `schopingcart_customers_FK` FOREIGN KEY (`cartCustomerID`) REFERENCES `customers` (`customerID`),
  CONSTRAINT `schopingcart_products_FK` FOREIGN KEY (`cartProductID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schopingcart`
--

LOCK TABLES `schopingcart` WRITE;
/*!40000 ALTER TABLE `schopingcart` DISABLE KEYS */;
/*!40000 ALTER TABLE `schopingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockproducts`
--

DROP TABLE IF EXISTS `stockproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockproducts` (
  `stockProductID` int NOT NULL,
  `stockDate` datetime DEFAULT NULL,
  `stockAmmount` int DEFAULT NULL,
  `stockID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`stockID`),
  KEY `StockProducts_Products_FK` (`stockProductID`),
  CONSTRAINT `stockproducts_products_FK` FOREIGN KEY (`stockProductID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockproducts`
--

LOCK TABLES `stockproducts` WRITE;
/*!40000 ALTER TABLE `stockproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streets`
--

DROP TABLE IF EXISTS `streets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streets` (
  `streetID` int NOT NULL AUTO_INCREMENT,
  `streetName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`streetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streets`
--

LOCK TABLES `streets` WRITE;
/*!40000 ALTER TABLE `streets` DISABLE KEYS */;
/*!40000 ALTER TABLE `streets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `towns`
--

DROP TABLE IF EXISTS `towns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `towns` (
  `townID` int NOT NULL AUTO_INCREMENT,
  `townName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`townID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `towns`
--

LOCK TABLES `towns` WRITE;
/*!40000 ALTER TABLE `towns` DISABLE KEYS */;
/*!40000 ALTER TABLE `towns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-09 14:52:01

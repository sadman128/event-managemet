-- --------------------------------------------------------
-- Host:                         mysql-taskmanger-d-taskmanager-discord.i.aivencloud.com
-- Server version:               8.0.35 - Source distribution
-- Server OS:                    Linux
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for events_management
DROP DATABASE IF EXISTS `events_management`;
CREATE DATABASE IF NOT EXISTS `events_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `events_management`;

-- Dumping structure for table events_management.admins
DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.admins: ~1 rows (approximately)
DELETE FROM `admins`;
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `created_at`) VALUES
	(1, 'Sajid', 'admin@gmail.com', 'admin', '2025-04-23 15:34:10');

-- Dumping structure for table events_management.events
DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `venue_id` int NOT NULL,
  `service_id` int NOT NULL,
  `date` date NOT NULL,
  `status` enum('pending','scheduled','cancelled','completed','accepted','rejected') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `venue_id` (`venue_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`) ON DELETE CASCADE,
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.events: ~9 rows (approximately)
DELETE FROM `events`;
INSERT INTO `events` (`id`, `title`, `description`, `venue_id`, `service_id`, `date`, `status`, `created_at`, `email`) VALUES
	(1, 'new1', 'new des', 2, 1, '2025-04-26', 'completed', '2025-04-23 15:17:25', 'ss@gmail.com'),
	(2, 'new 2', 'new 2', 1, 2, '2025-04-26', 'rejected', '2025-04-23 15:26:12', 'ss@gmail.com'),
	(3, 'sda', 'sda', 1, 2, '2025-04-25', 'cancelled', '2025-04-23 16:32:18', 'ss@gmail.com'),
	(4, 'new 3', 'new 3', 2, 2, '2025-04-23', 'completed', '2025-04-25 10:14:14', 'ss@gmail.com'),
	(5, 'new 3', 'new 3', 2, 2, '2025-04-23', 'rejected', '2025-04-25 10:14:14', 'ss@gmail.com'),
	(6, 'new 4', 'asd', 2, 1, '2025-04-29', 'scheduled', '2025-04-25 10:14:29', 'ss@gmail.com'),
	(7, 'assss', 'assss', 2, 2, '2025-05-10', 'pending', '2025-04-25 11:11:22', 'ss@gmail.com'),
	(8, 'Birthday', 'Birthday', 2, 2, '2025-05-10', 'cancelled', '2025-04-25 13:53:39', 'sajid@gmail.com'),
	(9, 'Tamim er bday', 'tamim gay', 2, 2, '2025-05-02', 'pending', '2025-04-25 14:52:15', 'sajid@gmail.com');

-- Dumping structure for table events_management.reviews
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `name` varchar(50) DEFAULT NULL,
  `point` int DEFAULT NULL,
  `detail` text,
  `event_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.reviews: ~1 rows (approximately)
DELETE FROM `reviews`;
INSERT INTO `reviews` (`name`, `point`, `detail`, `event_id`) VALUES
	('Sajid dude', 5, 'very good', 4);

-- Dumping structure for table events_management.services
DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.services: ~2 rows (approximately)
DELETE FROM `services`;
INSERT INTO `services` (`id`, `name`, `description`, `price`, `created_at`) VALUES
	(1, 'Silver', 'Silver Service', 50000.00, '2025-04-23 20:54:12'),
	(2, 'Gold', 'Gold Server', 80000.00, '2025-04-23 14:54:28');

-- Dumping structure for table events_management.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.users: ~0 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `address`, `created_at`) VALUES
	(1, 'Auto Restart', 'ss@gmail.com', '1122', '01834896054', 'dhaka', '2025-04-23 14:27:27'),
	(2, 'Sadman Hossain', 'sajid@gmail.com', '1122', '01834896054', 'dhaka', '2025-04-25 13:52:26');

-- Dumping structure for table events_management.venues
DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` text NOT NULL,
  `capacity` int DEFAULT NULL,
  `price_per_hour` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table events_management.venues: ~2 rows (approximately)
DELETE FROM `venues`;
INSERT INTO `venues` (`id`, `name`, `location`, `capacity`, `price_per_hour`, `created_at`) VALUES
	(1, 'Dhaka', 'Dhanmondi', 100, 50000.00, '2025-04-23 20:53:20'),
	(2, 'Dhaka2', 'Mirpur 10', 120, 45000.00, '2025-04-23 20:53:44');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

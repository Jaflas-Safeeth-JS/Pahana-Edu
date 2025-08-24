-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 22, 2025 at 04:56 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pahana_edu`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_acc_no` varchar(20) NOT NULL,
  `bill_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bills_customer` (`customer_acc_no`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `customer_acc_no`, `bill_date`, `total`) VALUES
(1, 'PEAC02', '2025-08-20 04:58:23', 1000),
(2, 'PEAC02', '2025-08-20 05:02:39', 2000),
(3, 'PEAC01', '2025-08-20 06:04:01', 1000),
(4, 'PEAC02', '2025-08-20 06:07:03', 1005),
(5, 'PEAC02', '2025-08-20 07:35:53', 1000),
(6, 'PEAC03', '2025-08-20 14:35:59', 50),
(7, 'PEAC03', '2025-08-20 14:37:49', 1000),
(8, 'PEAC01', '2025-08-20 15:02:03', 1000),
(9, 'PEAC13', '2025-08-20 17:24:54', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
CREATE TABLE IF NOT EXISTS `bill_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` double NOT NULL,
  `line_total` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bill_items_bill` (`bill_id`),
  KEY `idx_bill_items_book` (`book_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`id`, `bill_id`, `book_id`, `quantity`, `unit_price`, `line_total`) VALUES
(1, 1, 1, 1, 1000, 1000),
(2, 2, 1, 2, 1000, 2000),
(3, 3, 1, 1, 1000, 1000),
(4, 4, 1, 1, 1000, 1000),
(5, 4, 3, 1, 5, 5),
(6, 5, 1, 1, 1000, 1000),
(7, 6, 6, 2, 25, 50),
(8, 7, 1, 1, 1000, 1000),
(9, 8, 1, 1, 1000, 1000),
(10, 9, 1, 1, 1000, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `isbn`, `title`, `author`, `publisher`, `price`, `stock`, `created_at`) VALUES
(1, 'ISBN1234657', 'demo books 1', 'henry', 'demo', 1000.00, 40, '2025-08-19 11:05:18'),
(3, '7575ht', 'vdvd', 'vdvdse', 'vdv', 5.00, 24, '2025-08-19 11:48:35'),
(4, 'dfdgd', 'hghg', '5575', 'fgdvdv', 2520.00, 22, '2025-08-19 11:55:52'),
(5, 'gbfbfbvf', 'dcdc', 'cdcd', 'vdv', 28.00, 50, '2025-08-19 12:02:11'),
(6, 'cccss1', 'sdvdvd', 'vdvdv', 'vdv', 25.00, 48, '2025-08-19 12:04:06'),
(8, 'BSFVEV1', 'Political Science', 'Henry', 'EduCentre', 1500.00, 50, '2025-08-20 15:29:05'),
(9, 'ISBN55', 'Political', 'Henry1', 'demo', 1000.00, 50, '2025-08-20 16:01:43');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `units_consumed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `account_number`, `name`, `address`, `phone`, `units_consumed`) VALUES
(1, 'PEAC01', 'Demo Customer 11', '12, demo street, srilanka', '0761234567', 2),
(2, 'PEAC02', 'Demo Customer 2', '12, demo street, srilanka', '0771236589', 6),
(3, 'PEAC03', 'Demo Customer 3', '12, demo street, srilanka', '0771236589', 3),
(4, 'PEAC04', 'effffffffffff2', 'f', '+94123456788', 0),
(5, 'PEAC05', 'dedsdsd', '12, demo street, srilanka', '+94123456788', 0),
(6, 'PEAC06', 'hhh', 'hhhth', '0761234567', 0),
(7, 'PEAC07', 'test', 'ssfcscs', '0761234567', 0),
(8, 'PEAC08', 'grgrg', 'htht', '0761234567', 0),
(9, 'PEAC09', 'testin customer', '12, demo street, srilanka', '0761234567', 0),
(10, 'PEAC10', 'hth', '12, demo street, srilanka', '0761234567', 0),
(11, 'PEAC11', 'Demo Customer ', '12, demo street, srilanka', '0761234567', 0),
(12, 'PEAC12', 'trtrtrt', 'tete', '0761234567', 0),
(13, 'PEAC13', 'fdfdg', '145, demo street, srilanka', '0761234567', 1),
(14, 'PEAC14', 'John Smith', '123 Main St', '0771234567', 50),
(15, 'PEAC15', 'Jane Doe', '456 High St', '0779876543', 30),
(16, 'PEAC16', 'Bob Lee', '789 Market St', '0775556667', 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `role` enum('admin','cashier','customer') NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `uq_users_account_number` (`account_number`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `first_name`, `last_name`, `phone`, `address`, `role`, `account_number`) VALUES
(1, 'admin1', 'admin123', NULL, NULL, NULL, NULL, NULL, 'admin', NULL),
(2, 'cashier1', 'cashier123', NULL, NULL, NULL, NULL, NULL, 'cashier', NULL),
(3, 'demo1', 'demo@12345', 'demouser@gmail.com', 'Demo', 'Customer', '0761234567', '12, demo street, srilanka', 'customer', 'PEAC01'),
(4, 'test2', '12345678', 'test@gmail.com', 'testing', 'customer', '0761234567', '145, demo street, srilanka', 'customer', 'PEAC02');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

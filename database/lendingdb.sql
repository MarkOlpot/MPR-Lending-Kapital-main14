-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2025 at 02:54 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lendingdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `home_no` varchar(100) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `barangay` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `home_no`, `street`, `barangay`, `city`, `province`, `region`, `created_at`) VALUES
(9, '1213', 'ljk', 'poblacion west 4', 'asdd', 'lkj', 'a', '2025-02-14 02:50:42'),
(10, 'qwe', 'ljk', 'poblacion west 3', 'Aliaga', 'lkj', 'jlkh', '2025-02-14 02:50:42'),
(11, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-14 03:22:55'),
(12, 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'ewq', '2025-02-14 03:22:55'),
(15, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(16, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(21, '12', 'Regina', 'Pob. East 1', 'Aliaga', 'Nueva ecija', '4', '2025-02-24 00:58:23'),
(22, '1312321', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-02-24 00:58:23'),
(23, '69', 'para sa street', 'asd', 'sample', 'asda', 'asdas', '2025-02-26 07:20:00'),
(24, '1', 'sample', 'asd', 'sample', 'sample', 'test', '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `performed_by` varchar(255) NOT NULL,
  `action` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `date`, `time`, `performed_by`, `action`, `category`, `created_at`) VALUES
(144, '2025-02-26', '15:39:26', 'Michael John P. Seva', 'Michael John P. Seva logged in', 'Admin Activity Log', '2025-02-26 07:39:26'),
(145, '2025-02-26', '15:39:40', 'Michael John P. Seva', 'Michael John P. Seva searched for term: maranatha', 'Search Terms', '2025-02-26 07:39:40'),
(146, '2025-02-26', '15:39:40', 'Michael John P. Seva', 'Michael John P. Seva viewed borrower: Maranatha Gapac Barredo', 'Search Logs', '2025-02-26 07:39:40'),
(147, '2025-02-26', '15:39:53', 'Michael John P. Seva', 'Michael John P. Seva searched for term: asd', 'Search Terms', '2025-02-26 07:39:53'),
(148, '2025-02-26', '15:39:53', 'Michael John P. Seva', 'Michael John P. Seva viewed borrower: tado asd olpot', 'Search Logs', '2025-02-26 07:39:53'),
(149, '2025-02-26', '15:40:05', 'Michael John P. Seva', 'Michael John P. Seva updated borrower information for: tado taran olpot', 'Borrower Management logs', '2025-02-26 07:40:05'),
(150, '2025-02-26', '15:41:07', 'Michael John P. Seva', 'Michael John P. Seva searched for term: jayson', 'Search Terms', '2025-02-26 07:41:07'),
(151, '2025-02-26', '15:58:44', 'Michael John P. Seva', 'Michael John P. Seva searched for term: maranat', 'Search Terms', '2025-02-26 07:58:44'),
(152, '2025-02-26', '15:58:44', 'Michael John P. Seva', 'Michael John P. Seva searched for term: maranath', 'Search Terms', '2025-02-26 07:58:44'),
(153, '2025-02-26', '15:59:37', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 07:59:37'),
(154, '2025-02-26', '16:00:57', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:00:57'),
(155, '2025-02-26', '16:01:17', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-D1E306) worth ₱11.00 for borrower: Mark sample Olpot', 'Loan Managem', '2025-02-26 08:01:17'),
(156, '2025-02-26', '16:01:17', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-D1E306) worth ₱11.00 for borrower: Mark sample Olpot', 'New Loan', '2025-02-26 08:01:17'),
(157, '2025-02-26', '16:01:41', 'Michael John P. Seva', 'Michael John P. Seva searched for term: maranatha', 'Search Terms', '2025-02-26 08:01:41'),
(158, '2025-02-26', '16:02:32', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:02:32'),
(159, '2025-02-26', '16:02:48', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-86546D) worth ₱123.00 for borrower: Mark sample Olpot', 'Loan Managem', '2025-02-26 08:02:48'),
(160, '2025-02-26', '16:02:48', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-86546D) worth ₱123.00 for borrower: Mark sample Olpot', 'New Loan', '2025-02-26 08:02:48'),
(161, '2025-02-26', '16:03:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-037381) worth ₱111.00 for borrower: Mark sample Olpot', 'Loan Managem', '2025-02-26 08:03:12'),
(162, '2025-02-26', '16:03:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-037381) worth ₱111.00 for borrower: Mark sample Olpot', 'New Loan', '2025-02-26 08:03:12'),
(163, '2025-02-26', '16:04:39', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-02-26 08:04:39'),
(164, '2025-02-26', '16:04:40', 'Michael John P. Seva', 'Michael John P. Seva searched for term: mark', 'Search Terms', '2025-02-26 08:04:40'),
(165, '2025-02-26', '16:04:43', 'Michael John P. Seva', 'Michael John P. Seva searched for term: jayso', 'Search Terms', '2025-02-26 08:04:43'),
(166, '2025-02-26', '16:05:28', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-02-26 08:05:28'),
(167, '2025-02-26', '16:05:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-02-26 08:05:53'),
(168, '2025-02-26', '16:06:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F53596) worth ₱222.00 for borrower: Maranatha Gapac Barredo', 'Loan Managem', '2025-02-26 08:06:07'),
(169, '2025-02-26', '16:06:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F53596) worth ₱222.00 for borrower: Maranatha Gapac Barredo', 'New Loan', '2025-02-26 08:06:07'),
(170, '2025-02-26', '16:06:19', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-02-26 08:06:19'),
(171, '2025-02-26', '16:06:19', 'Michael John P. Seva', 'Michael John P. Seva searched for term: mjas', 'Search Terms', '2025-02-26 08:06:19'),
(172, '2025-02-26', '16:06:21', 'Michael John P. Seva', 'Michael John P. Seva searched for term: jay', 'Search Terms', '2025-02-26 08:06:21'),
(173, '2025-02-26', '16:06:22', 'Michael John P. Seva', 'Michael John P. Seva searched for term: jayson', 'Search Terms', '2025-02-26 08:06:22'),
(174, '2025-02-26', '16:06:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: bus', 'Search Terms', '2025-02-26 08:06:54'),
(175, '2025-02-26', '16:07:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F661B3) worth ₱1.00 for borrower: Jayson Fajardo Bustos', 'Loan Managem', '2025-02-26 08:07:27'),
(176, '2025-02-26', '16:07:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F661B3) worth ₱1.00 for borrower: Jayson Fajardo Bustos', 'New Loan', '2025-02-26 08:07:27'),
(177, '2025-02-26', '16:08:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-02-26 08:08:52'),
(178, '2025-02-26', '16:09:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: bus', 'Search Terms', '2025-02-26 08:09:05'),
(179, '2025-02-26', '16:09:15', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-BB44A7) worth ₱11.00 for borrower: Jayson Fajardo Bustos', 'Loan Managem', '2025-02-26 08:09:15'),
(180, '2025-02-26', '16:09:15', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-BB44A7) worth ₱11.00 for borrower: Jayson Fajardo Bustos', 'New Loan', '2025-02-26 08:09:15'),
(181, '2025-02-26', '16:10:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: b', 'Search Terms', '2025-02-26 08:10:18'),
(182, '2025-02-26', '16:10:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: bu', 'Search Terms', '2025-02-26 08:10:18'),
(183, '2025-02-26', '16:10:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:10:25'),
(184, '2025-02-26', '16:10:42', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-258C9B) worth ₱1.00 for borrower: Mark sample Olpot', 'Loan Management Logs', '2025-02-26 08:10:42'),
(185, '2025-02-26', '16:10:42', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-258C9B) worth ₱1.00 for borrower: Mark sample Olpot', 'New Loan', '2025-02-26 08:10:42'),
(186, '2025-02-26', '16:36:21', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-02-26 08:36:21'),
(187, '2025-02-26', '16:37:42', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-02-26 08:37:42'),
(188, '2025-02-26', '16:37:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-29DE80) worth ₱1.00 for borrower: Maranatha Gapac Barredo', 'Loan Management Logs', '2025-02-26 08:37:54'),
(189, '2025-02-26', '16:37:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-29DE80) worth ₱1.00 for borrower: Maranatha Gapac Barredo', 'New Loan', '2025-02-26 08:37:54'),
(190, '2025-02-26', '16:38:15', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-02-26 08:38:15'),
(191, '2025-02-26', '16:38:50', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'Admin Activity Log', '2025-02-26 08:38:50'),
(192, '2025-02-26', '16:38:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mang', 'Search Terms', '2025-02-26 08:38:56'),
(193, '2025-02-26', '16:39:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F2BB46) worth ₱11.00 for borrower: mang kepweng  returns secret', 'Loan Management Logs', '2025-02-26 08:39:27'),
(194, '2025-02-26', '16:39:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F2BB46) worth ₱11.00 for borrower: mang kepweng  returns secret', 'New Loan', '2025-02-26 08:39:27'),
(195, '2025-02-26', '16:40:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-08F993) worth ₱999.00 for borrower: mang kepweng  returns secret', 'Loan Management Logs', '2025-02-26 08:40:16'),
(196, '2025-02-26', '16:40:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-08F993) worth ₱999.00 for borrower: mang kepweng  returns secret', 'New Loan', '2025-02-26 08:40:16'),
(197, '2025-02-26', '16:42:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-02-26 08:42:31'),
(198, '2025-02-26', '16:43:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:43:12'),
(199, '2025-02-26', '16:43:44', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-02-26 08:43:44'),
(200, '2025-02-26', '16:44:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-02-26 08:44:24'),
(201, '2025-02-26', '16:44:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:44:56'),
(202, '2025-02-26', '16:44:57', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:44:57'),
(203, '2025-02-26', '16:46:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-02-26 08:46:01'),
(204, '2025-02-26', '16:46:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F03DCA) worth ₱10,000.00 for borrower: Mark sample Olpot', 'Loan Management Logs', '2025-02-26 08:46:23'),
(205, '2025-02-26', '16:46:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F03DCA) worth ₱10,000.00 for borrower: Mark sample Olpot', 'New Loan', '2025-02-26 08:46:23'),
(206, '2025-02-26', '16:48:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-02-26 08:48:43'),
(207, '2025-02-26', '16:48:47', 'Michael John P. Seva', 'Michael John P. Seva logged in', 'Admin Activity Log', '2025-02-26 08:48:47'),
(208, '2025-03-04', '08:38:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'Admin Activity Log', '2025-03-04 00:38:53'),
(209, '2025-03-04', '08:41:59', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-04 00:41:59'),
(210, '2025-03-04', '08:46:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ta', 'Search Terms', '2025-03-04 00:46:25'),
(211, '2025-03-04', '08:46:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: tado taran olpot', 'Borrower Management logs', '2025-03-04 00:46:47'),
(212, '2025-03-04', '08:47:04', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ta', 'Search Terms', '2025-03-04 00:47:04'),
(213, '2025-03-04', '08:47:20', 'Michael John P. Seva', 'Michael John P. Seva logged in', 'Admin Activity Log', '2025-03-04 00:47:20'),
(214, '2025-03-04', '08:52:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: tara', 'Search Terms', '2025-03-04 00:52:07'),
(215, '2025-03-04', '08:56:48', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: tara', 'Search Terms', '2025-03-04 00:56:48'),
(216, '2025-03-04', '08:57:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-288B95) worth ₱1,231,231.00 for borrower: tado taran olpot', 'Loan Management Logs', '2025-03-04 00:57:06'),
(217, '2025-03-04', '08:57:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-288B95) worth ₱1,231,231.00 for borrower: tado taran olpot', 'New Loan', '2025-03-04 00:57:06'),
(218, '2025-03-04', '08:57:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: a', 'Search Terms', '2025-03-04 00:57:52'),
(219, '2025-03-04', '08:57:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ta', 'Search Terms', '2025-03-04 00:57:53'),
(220, '2025-03-04', '08:58:36', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: tar', 'Search Terms', '2025-03-04 00:58:36'),
(221, '2025-03-04', '08:59:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-4A8B6B) worth ₱1,000.00 for borrower: tado taran olpot', 'Loan Management Logs', '2025-03-04 00:59:00'),
(222, '2025-03-04', '08:59:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-4A8B6B) worth ₱1,000.00 for borrower: tado taran olpot', 'New Loan', '2025-03-04 00:59:00'),
(223, '2025-03-04', '08:59:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-04 00:59:43'),
(224, '2025-03-04', '08:59:44', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ta', 'Search Terms', '2025-03-04 00:59:44'),
(225, '2025-03-04', '09:06:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: tara', 'Search Terms', '2025-03-04 01:06:34'),
(226, '2025-03-04', '09:20:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:20:14'),
(227, '2025-03-04', '09:21:10', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: taa', 'Search Terms', '2025-03-04 01:21:10'),
(228, '2025-03-04', '09:21:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:21:12'),
(229, '2025-03-04', '09:21:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-04EC40) worth ₱1.00 for borrower: Maranatha Gapac Barredo', 'Grocery Management', '2025-03-04 01:21:20'),
(230, '2025-03-04', '09:21:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-04 01:21:34'),
(231, '2025-03-04', '09:21:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-97C8D2) worth ₱12,121.00 for borrower: Maranatha Gapac Barredo', 'Loan Management Logs', '2025-03-04 01:21:45'),
(232, '2025-03-04', '09:21:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-97C8D2) worth ₱12,121.00 for borrower: Maranatha Gapac Barredo', 'New Loan', '2025-03-04 01:21:45'),
(233, '2025-03-04', '09:21:49', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:21:49'),
(234, '2025-03-04', '09:21:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-6EDF42) worth ₱12.00 for borrower: Maranatha Gapac Barredo', 'Grocery Management', '2025-03-04 01:21:58'),
(235, '2025-03-04', '09:22:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-04 01:22:52'),
(236, '2025-03-04', '09:22:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:22:53'),
(237, '2025-03-04', '09:22:59', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-3DB026) worth ₱12.00 for borrower: Maranatha Gapac Barredo', 'Grocery Management', '2025-03-04 01:22:59'),
(238, '2025-03-04', '09:23:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-6DF054) worth ₱11,111.00 for borrower: Maranatha Gapac Barredo', 'Grocery Management', '2025-03-04 01:23:18'),
(239, '2025-03-04', '09:33:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'Admin Activity Log', '2025-03-04 01:33:18'),
(240, '2025-03-04', '09:33:22', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:33:22'),
(241, '2025-03-04', '09:33:29', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: Maranatha Gapac Barredo', 'Borrower Management logs', '2025-03-04 01:33:29'),
(242, '2025-03-04', '09:38:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ta', 'Search Terms', '2025-03-04 01:38:38'),
(243, '2025-03-04', '09:44:12', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-03-04 01:44:12'),
(244, '2025-03-04', '09:45:13', 'Michael John P. Seva', 'Michael John P. Seva added new loan (Ref: LN-9D4349) worth ₱10,000.00 for borrower: Maranatha Gapac Barredo', 'Loan Management Logs', '2025-03-04 01:45:13'),
(245, '2025-03-04', '09:45:13', 'Michael John P. Seva', 'Michael John P. Seva added new loan (Ref: LN-9D4349) worth ₱10,000.00 for borrower: Maranatha Gapac Barredo', 'New Loan', '2025-03-04 01:45:13'),
(246, '2025-03-04', '09:51:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mara', 'Search Terms', '2025-03-04 01:51:14'),
(247, '2025-03-04', '09:51:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: Maranatha Gapac Barredo', 'Borrower Management logs', '2025-03-04 01:51:47'),
(248, '2025-03-04', '09:53:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-04 01:53:20'),
(249, '2025-03-04', '09:53:22', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: tara', 'Search Terms', '2025-03-04 01:53:22'),
(250, '2025-03-04', '09:53:32', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: tado taran olpot', 'Borrower Management logs', '2025-03-04 01:53:32');

-- --------------------------------------------------------

--
-- Table structure for table `borrowers`
--

CREATE TABLE `borrowers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `sex` enum('male','female') NOT NULL,
  `dob` date NOT NULL,
  `marital_status` enum('single','married','divorced','widowed') NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowers`
--

INSERT INTO `borrowers` (`id`, `first_name`, `middle_name`, `surname`, `suffix`, `sex`, `dob`, `marital_status`, `contact_number`, `address_id`, `is_deleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
(5, 'Maranatha', 'Gapac', 'Barredo', 'Jr.', 'male', '2025-02-13', 'single', '09953838730', 9, 0, '2025-02-14 02:50:42', '2025-03-04 01:33:29', '2025-02-18 05:22:36'),
(6, 'Mark', 'sample', 'Olpot', 'None', 'female', '2025-01-30', 'married', '09953838730', 11, 0, '2025-02-14 03:22:55', '2025-02-26 03:01:28', '2025-02-18 05:22:36'),
(7, 'tado', 'taran', 'olpot', 'None', 'male', '2025-02-13', 'married', '09953838730', 15, 1, '2025-02-20 00:56:31', '2025-02-26 07:40:05', '2025-02-20 00:56:31'),
(10, 'Jayson', 'Fajardo', 'Bustos', 'None', 'male', '2025-02-17', 'single', '09953838730', 21, 1, '2025-02-24 00:58:23', '2025-02-24 00:58:23', '2025-02-24 00:58:23'),
(11, 'mang kepweng ', 'returns', 'secret', 'Sr.', 'male', '2025-02-26', 'divorced', '09197657974', 23, 1, '2025-02-26 07:20:00', '2025-02-26 07:20:00', '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `collateral_files`
--

CREATE TABLE `collateral_files` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `collateral_files`
--

INSERT INTO `collateral_files` (`id`, `borrower_id`, `file_path`, `created_at`) VALUES
(10, 5, 'collateral_files/67aeaf82209e4.png', '2025-02-14 02:50:42'),
(11, 5, 'collateral_files/67aeaf8221252.png', '2025-02-14 02:50:42'),
(12, 5, 'collateral_files/67aeaf8222690.png', '2025-02-14 02:50:42'),
(13, 5, 'collateral_files/67aeaf8223f5f.png', '2025-02-14 02:50:42'),
(14, 5, 'collateral_files/67aeaf8225281.png', '2025-02-14 02:50:42'),
(15, 5, 'collateral_files/67aeaf8225bda.png', '2025-02-14 02:50:42'),
(16, 6, 'collateral_files/67aeb70fb77c1.png', '2025-02-14 03:22:55'),
(17, 6, 'collateral_files/67aeb70fb84c4.png', '2025-02-14 03:22:55'),
(18, 6, 'collateral_files/67aeb70fb8b83.png', '2025-02-14 03:22:55'),
(23, 10, 'collateral_files/67bbc42f575d9.jpg', '2025-02-24 00:58:23'),
(24, 10, 'collateral_files/67bbc42f578df.png', '2025-02-24 00:58:23'),
(25, 11, 'collateral_files/67bec0a0c9a1f.jpg', '2025-02-26 07:20:00'),
(26, 7, 'collateral_files/67c64d770367c.jpg', '2025-03-04 00:46:47'),
(27, 7, 'collateral_files/67c64d770432c.png', '2025-03-04 00:46:47'),
(28, 7, 'collateral_files/67c64d7704656.png', '2025-03-04 00:46:47');

-- --------------------------------------------------------

--
-- Table structure for table `dependents`
--

CREATE TABLE `dependents` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_number_dependents` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dependents`
--

INSERT INTO `dependents` (`id`, `borrower_id`, `name`, `contact_number_dependents`, `created_at`) VALUES
(2, 5, 'tado olpot', '09123456789', '2025-02-14 02:50:42'),
(3, 6, '', '', '2025-02-14 03:22:55'),
(4, 7, 'qwe', 'qwe', '2025-02-20 00:56:31'),
(5, 10, 'Michael Seva', '09123456789', '2025-02-24 00:58:23'),
(6, 11, 'asd', '09197657974', '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `employment_details`
--

CREATE TABLE `employment_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `employer_name` varchar(255) NOT NULL,
  `years_with_employer` int(11) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `phone_no` varchar(50) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employment_details`
--

INSERT INTO `employment_details` (`id`, `borrower_id`, `employer_name`, `years_with_employer`, `position`, `phone_no`, `salary`, `address_id`, `created_at`) VALUES
(2, 5, 'tado olpot', 8, 'manager', '09953838730', 7676.00, 10, '2025-02-14 02:50:42'),
(3, 6, 'qwe', 123, 'qwe', 'qwe', 123.00, 12, '2025-02-14 03:22:55'),
(4, 7, 'qwe', 1, 'qwe', '123', 123.00, 16, '2025-02-20 00:56:31'),
(7, 10, 'anthony francisco', 12, 'manager', '09953838730', 121.00, 22, '2025-02-24 00:58:23'),
(8, 11, 'secret', 1, 'qwe', '09197657974', 1111.00, 24, '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `grocery`
--

CREATE TABLE `grocery` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `grocery_amount` float(10,2) NOT NULL,
  `grocery_date` date NOT NULL,
  `remarks` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery`
--

INSERT INTO `grocery` (`id`, `reference_no`, `borrower_id`, `grocery_amount`, `grocery_date`, `remarks`, `created_at`, `updated_at`) VALUES
(12, 'GR-04EC40', 5, 1.00, '2025-03-04', 'Grocery added successfully', '2025-03-04 09:21:20', '2025-03-04 09:21:20'),
(13, 'GR-6EDF42', 5, 12.00, '2025-03-04', 'Grocery added successfully', '2025-03-04 09:21:58', '2025-03-04 09:21:58'),
(14, 'GR-3DB026', 5, 12.00, '2025-03-04', 'Grocery added successfully', '2025-03-04 09:22:59', '2025-03-04 09:22:59'),
(15, 'GR-6DF054', 5, 11111.00, '2025-03-04', 'Grocery added successfully', '2025-03-04 09:23:18', '2025-03-04 09:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `identification_documents`
--

CREATE TABLE `identification_documents` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `id_type` enum('SSS','TIN','PAGIBIG','PhilHealth','PAN','GSIS','National ID','Birth Certificate','Voter''s ID','Driver''s License','Passport') NOT NULL,
  `id_no` varchar(50) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `id_photo_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `identification_documents`
--

INSERT INTO `identification_documents` (`id`, `borrower_id`, `id_type`, `id_no`, `expiry_date`, `id_photo_path`, `created_at`) VALUES
(2, 5, 'National ID', '22232', '2025-02-15', 'id_photos/67aebf5b025de.png', '2025-02-14 02:50:42'),
(3, 6, 'Birth Certificate', 'qwe', '2025-02-11', 'id_photos/67aeb70fb66dc.png', '2025-02-14 03:22:55'),
(4, 7, 'PhilHealth', '123123', '2025-03-04', 'id_photos/67c64d7702a23.png', '2025-02-20 00:56:31'),
(7, 10, 'SSS', '11111111', '2025-02-09', 'id_photos/67bbc42f56056.jpg', '2025-02-24 00:58:23'),
(8, 11, 'Birth Certificate', '090909', '2025-02-26', 'id_photos/67bec0a0c8753.jfif', '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `insurance_details`
--

CREATE TABLE `insurance_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `insurance_provider` varchar(100) NOT NULL,
  `issued_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `insurance_file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `insurance_details`
--

INSERT INTO `insurance_details` (`id`, `borrower_id`, `insurance_provider`, `issued_date`, `expiry_date`, `insurance_file_path`, `created_at`, `updated_at`) VALUES
(2, 5, 'Manulife', '2025-03-04', '2025-03-05', 'insurance_files/67aeaf821e2a3.png', '2025-02-14 02:50:42', '2025-03-04 01:51:47'),
(3, 7, '', '2025-02-13', '2025-02-05', 'insurance_files/67c64d7703003.jpg', '2025-02-20 00:56:31', '2025-03-04 00:46:47'),
(4, 10, 'Manulife', '2025-02-11', '2025-02-16', 'insurance_files/67bbc42f5643c.png', '2025-02-24 00:58:23', '2025-02-24 00:58:23'),
(5, 11, 'Sun Life', '2025-02-26', '2025-02-26', 'insurance_files/67bec0a0c9028.jfif', '2025-02-26 07:20:00', '2025-02-26 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `customer_type` enum('Regular','VIP','Other','') NOT NULL,
  `loan_amount` float(10,2) NOT NULL,
  `interest_rate` int(10) NOT NULL,
  `loan_date` date NOT NULL DEFAULT curdate(),
  `term_months` int(11) NOT NULL,
  `repayment_date` date NOT NULL,
  `promissory_id` int(11) NOT NULL,
  `remarks` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`id`, `reference_no`, `borrower_id`, `customer_type`, `loan_amount`, `interest_rate`, `loan_date`, `term_months`, `repayment_date`, `promissory_id`, `remarks`, `created_at`, `updated_at`) VALUES
(97, 'LN-4A8B6B', 7, 'Regular', 1000.00, 7, '2025-03-04', 12, '2026-03-04', 96, 'das', '2025-03-04 08:59:00', '2025-03-04 08:59:00'),
(98, 'LN-97C8D2', 5, 'Regular', 12121.00, 7, '2025-03-04', 12, '2026-03-04', 97, 'd', '2025-03-04 09:21:45', '2025-03-04 09:21:45'),
(99, 'LN-9D4349', 5, 'Regular', 10000.00, 7, '2025-03-04', 6, '2025-09-04', 98, 'hehe', '2025-03-04 09:45:13', '2025-03-04 09:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `loan_balance`
--

CREATE TABLE `loan_balance` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `loan_balance` float(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_balance`
--

INSERT INTO `loan_balance` (`id`, `borrower_id`, `loan_balance`, `created_at`, `updated_at`) VALUES
(6, 7, 1000.00, '2025-03-04 00:59:00', '2025-03-04 00:59:00'),
(7, 5, 22121.00, '2025-03-04 01:21:45', '2025-03-04 01:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `loan_schedules`
--

CREATE TABLE `loan_schedules` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `principal_amount` decimal(10,2) NOT NULL,
  `interest_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','overdue') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `notif_content` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `notif_content`, `status`, `created_at`) VALUES
(1, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:51:48'),
(2, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:51:49'),
(3, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:52:27'),
(4, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:52:42'),
(5, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:52:47'),
(6, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:53:02'),
(7, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:53:15'),
(8, 'tado taran olpot\'s PhilHealth is expiring in 0 days (on Mar 04, 2025)', 0, '2025-03-04 09:53:34'),
(9, 'Maranatha Gapac Barredo\'s Manulife insurance is expiring in 1 days (on Mar 05, 2025)', 0, '2025-03-04 09:53:34');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `payment_amount` float(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `remarks` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promissory_files`
--

CREATE TABLE `promissory_files` (
  `id` int(11) NOT NULL,
  `promissory_file_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promissory_files`
--

INSERT INTO `promissory_files` (`id`, `promissory_file_path`, `created_at`) VALUES
(47, '1740367715_67bbe763b71b4.jpg', '2025-02-24 11:28:35'),
(48, '1740368070_67bbe8c695289.jpg', '2025-02-24 11:34:30'),
(49, '1740368080_67bbe8d0ed9c2.jpg', '2025-02-24 11:34:40'),
(50, '1740368193_67bbe94148ecd.pdf', '2025-02-24 11:36:33'),
(51, '1740373743_67bbfeef728f2.png', '2025-02-24 13:09:03'),
(52, '1740374044_67bc001cbb663.jpg', '2025-02-24 13:14:04'),
(53, '1740374520_67bc01f855fee.jpg', '2025-02-24 13:22:00'),
(54, '1740374573_67bc022d46f32.pdf', '2025-02-24 13:22:53'),
(55, '1740377887_67bc0f1faa4b0.png', '2025-02-24 14:18:07'),
(56, '1740378139_67bc101bee775.png', '2025-02-24 14:22:19'),
(57, '1740378569_67bc11c9c8c06.png', '2025-02-24 14:29:29'),
(58, '1740378676_67bc1234b76e9.png', '2025-02-24 14:31:16'),
(59, '1740379958_67bc17368e455.jpg', '2025-02-24 14:52:38'),
(60, '1740532988_67be6cfc983fd.jpg', '2025-02-26 09:23:08'),
(61, '1740533106_67be6d721e407.pdf', '2025-02-26 09:25:06'),
(62, '1740556757_67bec9d52b637.jpg', '2025-02-26 15:59:17'),
(63, '1740556792_67bec9f87a060.jpg', '2025-02-26 15:59:52'),
(64, '1740556812_67beca0c0c53e.jpg', '2025-02-26 16:00:12'),
(65, '1740556816_67beca104b0ca.jpg', '2025-02-26 16:00:16'),
(66, '1740556877_67beca4d1e36c.pdf', '2025-02-26 16:01:17'),
(67, '1740556883_67beca53f3145.jpg', '2025-02-26 16:01:23'),
(68, '1740556889_67beca599875c.jpg', '2025-02-26 16:01:29'),
(69, '1740556921_67beca79b1139.jpg', '2025-02-26 16:02:01'),
(70, '1740556946_67beca927053f.jpg', '2025-02-26 16:02:26'),
(71, '1740556959_67beca9fc1043.jpg', '2025-02-26 16:02:39'),
(72, '1740556965_67becaa55ecfb.jpg', '2025-02-26 16:02:45'),
(73, '1740556968_67becaa865523.jpg', '2025-02-26 16:02:48'),
(74, '1740556992_67becac0373c4.jpg', '2025-02-26 16:03:12'),
(75, '1740557106_67becb328fd0d.png', '2025-02-26 16:05:06'),
(76, '1740557143_67becb5731851.jpg', '2025-02-26 16:05:43'),
(77, '1740557167_67becb6f535d3.jpg', '2025-02-26 16:06:07'),
(78, '1740557207_67becb9751613.jpg', '2025-02-26 16:06:47'),
(79, '1740557247_67becbbf66256.jpg', '2025-02-26 16:07:27'),
(80, '1740557355_67becc2bb4539.pdf', '2025-02-26 16:09:15'),
(81, '1740557442_67becc8258d81.pdf', '2025-02-26 16:10:42'),
(82, '1740559016_67bed2a897676.png', '2025-02-26 16:36:56'),
(83, '1740559052_67bed2cc6b0cb.png', '2025-02-26 16:37:32'),
(84, '1740559074_67bed2e29df28.pdf', '2025-02-26 16:37:54'),
(85, '1740559156_67bed334ebb07.png', '2025-02-26 16:39:16'),
(86, '1740559167_67bed33f2bb7a.png', '2025-02-26 16:39:27'),
(87, '1740559196_67bed35c321e7.jpg', '2025-02-26 16:39:56'),
(88, '1740559216_67bed3708f9bf.jpg', '2025-02-26 16:40:16'),
(89, '1740559435_67bed44b2f092.pdf', '2025-02-26 16:43:55'),
(90, '1740559523_67bed4a3bee46.jpg', '2025-02-26 16:45:23'),
(91, '1740559577_67bed4d9d4f75.pdf', '2025-02-26 16:46:17'),
(92, '1740559583_67bed4df03dff.pdf', '2025-02-26 16:46:23'),
(93, '1741049242_67c64d9a87b10.pdf', '2025-03-04 08:47:22'),
(94, '1741049276_67c64dbcb2de9.pdf', '2025-03-04 08:47:56'),
(95, '1741049826_67c64fe288c3b.pdf', '2025-03-04 08:57:06'),
(96, '1741049940_67c65054a8bfd.jpg', '2025-03-04 08:59:00'),
(97, '1741051305_67c655a97c959.jpg', '2025-03-04 09:21:45'),
(98, '1741052713_67c65b29d43dc.png', '2025-03-04 09:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `transaction_type` enum('loan','payment','grocery') NOT NULL,
  `transaction_date` datetime NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `reference_no`, `transaction_type`, `transaction_date`, `amount`, `borrower_id`, `created_at`, `updated_at`) VALUES
(1, 'GR-93E944', 'grocery', '2025-02-24 00:00:00', 231312.00, 5, '2025-02-24 10:21:45', '2025-02-24 10:21:45'),
(2, 'GR-E1DF99', 'grocery', '2025-02-24 00:00:00', 123.00, 5, '2025-02-24 10:42:22', '2025-02-24 10:42:22'),
(3, 'GR-7C5A18', 'grocery', '2025-02-24 00:00:00', 121.00, 5, '2025-02-24 11:51:51', '2025-02-24 11:51:51'),
(4, 'GR-65AF99', 'grocery', '2025-02-24 00:00:00', 1.00, 5, '2025-02-24 14:15:18', '2025-02-24 14:15:18'),
(5, 'GR-C8EA9E', 'grocery', '2025-02-24 00:00:00', 123123.00, 5, '2025-02-24 14:15:56', '2025-02-24 14:15:56'),
(6, 'LN-68E3C9', 'loan', '2025-02-24 14:52:38', 31231.00, 5, '2025-02-24 14:52:38', '2025-02-24 14:52:38'),
(7, 'LN-C981D8', 'loan', '2025-02-26 09:23:08', 3.00, 6, '2025-02-26 09:23:08', '2025-02-26 09:23:08'),
(8, 'LN-21E373', 'loan', '2025-02-26 09:25:06', 1.00, 6, '2025-02-26 09:25:06', '2025-02-26 09:25:06'),
(9, 'LN-52B585', 'loan', '2025-02-26 15:59:17', 10.00, 5, '2025-02-26 15:59:17', '2025-02-26 15:59:17'),
(10, 'LN-879FB5', 'loan', '2025-02-26 15:59:52', 1.00, 6, '2025-02-26 15:59:52', '2025-02-26 15:59:52'),
(11, 'LN-C0C50C', 'loan', '2025-02-26 16:00:12', 1.00, 6, '2025-02-26 16:00:12', '2025-02-26 16:00:12'),
(12, 'LN-04B097', 'loan', '2025-02-26 16:00:16', 10.00, 5, '2025-02-26 16:00:16', '2025-02-26 16:00:16'),
(13, 'LN-D1E306', 'loan', '2025-02-26 16:01:17', 11.00, 6, '2025-02-26 16:01:17', '2025-02-26 16:01:17'),
(14, 'LN-3F3101', 'loan', '2025-02-26 16:01:24', 111.00, 5, '2025-02-26 16:01:24', '2025-02-26 16:01:24'),
(15, 'LN-99872A', 'loan', '2025-02-26 16:01:29', 111.00, 5, '2025-02-26 16:01:29', '2025-02-26 16:01:29'),
(16, 'LN-9B1068', 'loan', '2025-02-26 16:02:01', 10.00, 5, '2025-02-26 16:02:01', '2025-02-26 16:02:01'),
(17, 'LN-270512', 'loan', '2025-02-26 16:02:26', 1.00, 6, '2025-02-26 16:02:26', '2025-02-26 16:02:26'),
(18, 'LN-FC0FBA', 'loan', '2025-02-26 16:02:39', 10.00, 5, '2025-02-26 16:02:39', '2025-02-26 16:02:39'),
(19, 'LN-55ECCF', 'loan', '2025-02-26 16:02:45', 10.00, 5, '2025-02-26 16:02:45', '2025-02-26 16:02:45'),
(20, 'LN-86546D', 'loan', '2025-02-26 16:02:48', 123.00, 6, '2025-02-26 16:02:48', '2025-02-26 16:02:48'),
(21, 'LN-037381', 'loan', '2025-02-26 16:03:12', 111.00, 6, '2025-02-26 16:03:12', '2025-02-26 16:03:12'),
(22, 'LN-28FC30', 'loan', '2025-02-26 16:05:06', 10.00, 10, '2025-02-26 16:05:06', '2025-02-26 16:05:06'),
(23, 'LN-7317B8', 'loan', '2025-02-26 16:05:43', 321.00, 5, '2025-02-26 16:05:43', '2025-02-26 16:05:43'),
(24, 'LN-F53596', 'loan', '2025-02-26 16:06:07', 222.00, 5, '2025-02-26 16:06:07', '2025-02-26 16:06:07'),
(25, 'LN-751584', 'loan', '2025-02-26 16:06:47', 100.00, 10, '2025-02-26 16:06:47', '2025-02-26 16:06:47'),
(26, 'LN-F661B3', 'loan', '2025-02-26 16:07:27', 1.00, 10, '2025-02-26 16:07:27', '2025-02-26 16:07:27'),
(27, 'LN-BB44A7', 'loan', '2025-02-26 16:09:15', 11.00, 10, '2025-02-26 16:09:15', '2025-02-26 16:09:15'),
(28, 'LN-258C9B', 'loan', '2025-02-26 16:10:42', 1.00, 6, '2025-02-26 16:10:42', '2025-02-26 16:10:42'),
(29, 'LN-8975DE', 'loan', '2025-02-26 16:36:56', 100.00, 11, '2025-02-26 16:36:56', '2025-02-26 16:36:56'),
(30, 'LN-C6B07E', 'loan', '2025-02-26 16:37:32', 100.00, 11, '2025-02-26 16:37:32', '2025-02-26 16:37:32'),
(31, 'LN-29DE80', 'loan', '2025-02-26 16:37:54', 1.00, 5, '2025-02-26 16:37:54', '2025-02-26 16:37:54'),
(32, 'LN-4EBADE', 'loan', '2025-02-26 16:39:16', 10.00, 11, '2025-02-26 16:39:16', '2025-02-26 16:39:16'),
(33, 'LN-F2BB46', 'loan', '2025-02-26 16:39:27', 11.00, 11, '2025-02-26 16:39:27', '2025-02-26 16:39:27'),
(34, 'LN-C3213B', 'loan', '2025-02-26 16:39:56', 12.00, 11, '2025-02-26 16:39:56', '2025-02-26 16:39:56'),
(35, 'LN-08F993', 'loan', '2025-02-26 16:40:16', 999.00, 11, '2025-02-26 16:40:16', '2025-02-26 16:40:16'),
(36, 'LN-B2EFF6', 'loan', '2025-02-26 16:43:55', 2.00, 5, '2025-02-26 16:43:55', '2025-02-26 16:43:55'),
(37, 'LN-3BED95', 'loan', '2025-02-26 16:45:23', 2.00, 6, '2025-02-26 16:45:23', '2025-02-26 16:45:23'),
(38, 'LN-9D4EE6', 'loan', '2025-02-26 16:46:17', 10.00, 6, '2025-02-26 16:46:17', '2025-02-26 16:46:17'),
(39, 'LN-F03DCA', 'loan', '2025-02-26 16:46:23', 10000.00, 6, '2025-02-26 16:46:23', '2025-02-26 16:46:23'),
(40, 'LN-A87A4B', 'loan', '2025-03-04 08:47:22', 11.00, 7, '2025-03-04 08:47:22', '2025-03-04 08:47:22'),
(41, 'LN-CB2CD0', 'loan', '2025-03-04 08:47:56', 11.00, 7, '2025-03-04 08:47:56', '2025-03-04 08:47:56'),
(42, 'LN-288B95', 'loan', '2025-03-04 08:57:06', 1231231.00, 7, '2025-03-04 08:57:06', '2025-03-04 08:57:06'),
(43, 'LN-4A8B6B', 'loan', '2025-03-04 08:59:00', 1000.00, 7, '2025-03-04 08:59:00', '2025-03-04 08:59:00'),
(44, 'GR-8DF5CE', 'grocery', '2025-03-04 00:00:00', 10.00, 7, '2025-03-04 08:59:36', '2025-03-04 08:59:36'),
(45, 'GR-2A757E', 'grocery', '2025-03-04 00:00:00', 10.00, 7, '2025-03-04 09:00:18', '2025-03-04 09:00:18'),
(46, 'GR-1841FD', 'grocery', '2025-03-04 00:00:00', 1.00, 7, '2025-03-04 09:00:33', '2025-03-04 09:00:33'),
(47, 'GR-6EC2C7', 'grocery', '2025-03-04 00:00:00', 10.00, 7, '2025-03-04 09:00:54', '2025-03-04 09:00:54'),
(48, 'GR-313C28', 'grocery', '2025-03-04 00:00:00', 10000.00, 7, '2025-03-04 09:06:43', '2025-03-04 09:06:43'),
(49, 'GR-57BE17', 'grocery', '2025-03-04 00:00:00', 10000000.00, 7, '2025-03-04 09:07:01', '2025-03-04 09:07:01'),
(50, 'GR-04EC40', 'grocery', '2025-03-04 00:00:00', 1.00, 5, '2025-03-04 09:21:20', '2025-03-04 09:21:20'),
(51, 'LN-97C8D2', 'loan', '2025-03-04 09:21:45', 12121.00, 5, '2025-03-04 09:21:45', '2025-03-04 09:21:45'),
(52, 'GR-6EDF42', 'grocery', '2025-03-04 00:00:00', 12.00, 5, '2025-03-04 09:21:58', '2025-03-04 09:21:58'),
(53, 'GR-3DB026', 'grocery', '2025-03-04 00:00:00', 12.00, 5, '2025-03-04 09:22:59', '2025-03-04 09:22:59'),
(54, 'GR-6DF054', 'grocery', '2025-03-04 00:00:00', 11111.00, 5, '2025-03-04 09:23:18', '2025-03-04 09:23:18'),
(55, 'LN-9D4349', 'loan', '2025-03-04 09:45:13', 10000.00, 5, '2025-03-04 09:45:13', '2025-03-04 09:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `profile_picture`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Mark Nathaniel D. Olpot', 'olpottado@gmail.com', '$2y$10$fw5LsHyJOpI6WQXhH6dpl.6RYUCT4Tm3p/srUOlXD5QPl8eSmvK32', 'uploads/users/mark_nathaniel_d__olpot/profile/profile.jpg', 'admin', '2025-02-20 06:09:01', '2025-02-20 06:09:01'),
(4, 'Michael John P. Seva', 'michaeljohnseva@gmail.com', '$2y$10$pJDC0EIgVZkkygBzrzdJEuMN/tbzXDYj.r4ULhsEWu.aw3IJgPJsG', 'uploads/users/michael_john_p__seva/profile/profile.jpg', 'admin', '2025-02-24 06:54:35', '2025-02-24 06:54:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrowers`
--
ALTER TABLE `borrowers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `collateral_files`
--
ALTER TABLE `collateral_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `dependents`
--
ALTER TABLE `dependents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `employment_details`
--
ALTER TABLE `employment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `grocery`
--
ALTER TABLE `grocery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `identification_documents`
--
ALTER TABLE `identification_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `insurance_details`
--
ALTER TABLE `insurance_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `promissory_id` (`promissory_id`);

--
-- Indexes for table `loan_balance`
--
ALTER TABLE `loan_balance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_borrower` (`borrower_id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `promissory_files`
--
ALTER TABLE `promissory_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `collateral_files`
--
ALTER TABLE `collateral_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `dependents`
--
ALTER TABLE `dependents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employment_details`
--
ALTER TABLE `employment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `identification_documents`
--
ALTER TABLE `identification_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `insurance_details`
--
ALTER TABLE `insurance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `loan_balance`
--
ALTER TABLE `loan_balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promissory_files`
--
ALTER TABLE `promissory_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowers`
--
ALTER TABLE `borrowers`
  ADD CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

--
-- Constraints for table `collateral_files`
--
ALTER TABLE `collateral_files`
  ADD CONSTRAINT `collateral_files_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `dependents`
--
ALTER TABLE `dependents`
  ADD CONSTRAINT `dependents_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `employment_details`
--
ALTER TABLE `employment_details`
  ADD CONSTRAINT `employment_details_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`),
  ADD CONSTRAINT `employment_details_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

--
-- Constraints for table `grocery`
--
ALTER TABLE `grocery`
  ADD CONSTRAINT `grocery_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `identification_documents`
--
ALTER TABLE `identification_documents`
  ADD CONSTRAINT `identification_documents_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `insurance_details`
--
ALTER TABLE `insurance_details`
  ADD CONSTRAINT `insurance_details_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`promissory_id`) REFERENCES `promissory_files` (`id`),
  ADD CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan_balance`
--
ALTER TABLE `loan_balance`
  ADD CONSTRAINT `loan_balance_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD CONSTRAINT `loan_schedules_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

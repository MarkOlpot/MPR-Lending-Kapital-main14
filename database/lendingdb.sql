-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2025 at 06:07 AM
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
(9, '1213', 'ljk', '', 'asdd', 'lkj', 'a', '2025-02-14 02:50:42'),
(10, 'qwe', 'ljk', 'poblacion west 3', 'Aliaga', 'lkj', 'jlkh', '2025-02-14 02:50:42'),
(11, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-14 03:22:55'),
(12, 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'ewq', '2025-02-14 03:22:55'),
(15, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(16, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(21, '12', 'Regina', 'Pob. East 1', 'Aliaga', 'Nueva ecija', '4', '2025-02-24 00:58:23'),
(22, '1312321', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-02-24 00:58:23'),
(23, '69', 'para sa street', 'asd', 'sample', 'asda', 'asdas', '2025-02-26 07:20:00'),
(24, '1', 'sample', 'asd', 'sample', 'sample', 'test', '2025-02-26 07:20:00'),
(29, '69', 'salera st. ', 'bitalag', 'bacnotan ', 'la union', 'catholic charot haha', '2025-03-04 07:15:14'),
(30, 'paulit ulit ', 'ulit ', 'ulit', 'ulit', 'ulit', 'uli', '2025-03-04 07:15:14'),
(31, '1213', 'Purok 7', 'poblacion west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ecija', '3', '2025-03-06 07:00:57'),
(32, '22222', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-03-06 07:00:57');

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
(508, '2025-03-06', '14:43:37', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: n', 'Search Terms', '2025-03-06 06:43:37'),
(509, '2025-03-06', '14:43:37', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: na', 'Search Terms', '2025-03-06 06:43:37'),
(510, '2025-03-06', '14:48:48', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: m', 'Search Terms', '2025-03-06 06:48:48'),
(511, '2025-03-06', '14:48:48', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: ma', 'Search Terms', '2025-03-06 06:48:48'),
(512, '2025-03-06', '14:49:05', 'Mark Nathaniel D. Olpot jr', 'Added new user: Leopoldo (leo@gmail.com) with role user', 'User Management', '2025-03-06 06:49:05'),
(513, '2025-03-06', '14:59:22', 'Michael John P. Seva', 'Michael John P. Seva searched for term: a', 'Search Terms', '2025-03-06 06:59:22'),
(514, '2025-03-06', '14:59:28', 'Michael John P. Seva', 'Michael John P. Seva deleted borrower: Mark Nathaniel  Dela olpot', 'Borrower Management Logs', '2025-03-06 06:59:28'),
(515, '2025-03-06', '15:00:57', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr added new borrower: Mark Nathaniel  Dela Vega Olpot', 'Borrower Management Logs', '2025-03-06 07:00:57'),
(516, '2025-03-06', '15:04:40', 'Michael John P. Seva', 'Michael John P. Seva searched for term: a', 'Search Terms', '2025-03-06 07:04:40'),
(517, '2025-03-06', '15:04:57', 'Michael John P. Seva', 'Michael John P. Seva updated borrower information for: AHAHAHAHA Dela Vega Olpot', 'Borrower Management logs', '2025-03-06 07:04:57'),
(518, '2025-03-06', '15:05:27', 'Mark Nathaniel D. Olpot jr', 'Updated user: name from \'Michael John P. Seva\' to \'Michael Burat John P. Seva\'', 'User Management', '2025-03-06 07:05:27'),
(519, '2025-03-06', '15:14:11', 'Michael John P. Seva', 'Updated user: name from \'Leopoldo\' to \'Leopolio\'', 'User Management', '2025-03-06 07:14:11'),
(520, '2025-03-06', '15:15:22', 'Michael John P. Seva', 'Added new user: shimishimiya (sample@gmail.com) with role user', 'User Management', '2025-03-06 07:15:22'),
(521, '2025-03-06', '15:18:40', 'Mark Nathaniel D. Olpot jr', 'Updated user: name from \'\' to \'shimishimiya\' and email from \'\' to \'sample1@gmail.com\'', 'User Management', '2025-03-06 07:18:40'),
(522, '2025-03-06', '15:25:17', 'Mark Nathaniel D. Olpot jr', 'Deleted user: shimishimiya', 'User Management', '2025-03-06 07:25:17'),
(523, '2025-03-06', '15:27:57', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: haha', 'Search Terms', '2025-03-06 07:27:57'),
(524, '2025-03-06', '15:28:20', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr updated borrower information for: Burat  malake sheyt', 'Borrower Management logs', '2025-03-06 07:28:20'),
(525, '2025-03-06', '15:31:29', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: hah', 'Search Terms', '2025-03-06 07:31:29'),
(526, '2025-03-06', '15:31:31', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: b', 'Search Terms', '2025-03-06 07:31:31'),
(527, '2025-03-06', '15:31:45', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr added new loan (Ref: LN-1C87A5) worth ₱11,111.00 for borrower: Burat  malake sheyt', 'Loan Management Logs', '2025-03-06 07:31:45'),
(528, '2025-03-06', '15:31:45', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr added new loan (Ref: LN-1C87A5) worth ₱11,111.00 for borrower: Burat  malake sheyt', 'New Loan', '2025-03-06 07:31:45'),
(529, '2025-03-06', '15:34:39', 'Mark Nathaniel D. Olpot jr', 'Deleted user: Leopolio', 'User Management', '2025-03-06 07:34:39'),
(530, '2025-03-06', '15:34:55', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-03-06 07:34:55'),
(531, '2025-03-06', '15:34:59', 'Michael Burat John P. Seva', 'Michael Burat John P. Seva logged in as admin', 'User Authentication', '2025-03-06 07:34:59'),
(532, '2025-03-06', '15:52:14', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr logged out', 'Admin Activity Log', '2025-03-06 07:52:14'),
(533, '2025-03-06', '15:52:54', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged in as user', 'User Authentication', '2025-03-06 07:52:54'),
(534, '2025-03-06', '15:53:06', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: m', 'Search Terms', '2025-03-06 07:53:06'),
(535, '2025-03-06', '15:53:12', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla updated borrower information for: Athara Mariel  Mendoza Negrillo', 'Borrower Management logs', '2025-03-06 07:53:12'),
(536, '2025-03-06', '15:53:14', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged out', 'Admin Activity Log', '2025-03-06 07:53:14'),
(537, '2025-03-06', '15:53:20', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr logged in as admin', 'User Authentication', '2025-03-06 07:53:20'),
(538, '2025-03-06', '16:09:46', 'Michael Burat John P. Seva', 'Michael Burat John P. Seva searched for term: m', 'Search Terms', '2025-03-06 08:09:46'),
(540, '2025-03-06', '16:22:29', 'Michael Burat John P. Seva', 'Michael Burat John P. Seva logged out', 'Admin Activity Log', '2025-03-06 08:22:29'),
(541, '2025-03-06', '16:22:36', 'Michael Burat John P. Seva', 'Michael Burat John P. Seva logged in as admin', 'User Authentication', '2025-03-06 08:22:36'),
(542, '2025-03-06', '16:23:06', 'Michael Burat John P. Seva', 'Added new user: sample (sample@gmail.com) with role user', 'User Management', '2025-03-06 08:23:06'),
(544, '2025-03-06', '16:24:00', 'Michael Burat John P. Seva', 'Deleted user: sample', 'User Management', '2025-03-06 08:24:00'),
(546, '2025-03-06', '16:30:48', 'Mark Nathaniel D. Olpot jr', 'Updated user: name from \'Mark Nathaniel D. Olpot jr\' to \'Mark Nathaniel D. Olpot\'', 'User Management', '2025-03-06 08:30:48'),
(547, '2025-03-06', '16:36:51', 'Michael Burat John P. Seva', 'Updated user: name from \'Michael Burat John P. Seva\' to \'Michael John P. Seva\'', 'User Management', '2025-03-06 08:36:51'),
(549, '2025-03-06', '16:38:17', 'Mark Nathaniel D. Olpot jr', 'Updated user: name from \'Mark Nathaniel D. Olpot\' to \'Mark Nathaniel D. Olpot jr\'', 'User Management', '2025-03-06 08:38:17'),
(550, '2025-03-06', '09:42:31', 'Michael Burat John P. Seva', 'Updated profile picture', 'Profile Management', '2025-03-06 08:42:31'),
(551, '2025-03-06', '16:42:54', 'Michael Burat John P. Seva', 'Michael Burat John P. Seva logged out', 'Admin Activity Log', '2025-03-06 08:42:54'),
(552, '2025-03-06', '16:43:01', 'Michael John P. Seva', 'Michael John P. Seva logged in as admin', 'User Authentication', '2025-03-06 08:43:01'),
(553, '2025-03-06', '09:43:26', 'Michael John Punzalan Seva', 'Updated profile name from \'Michael John P. Seva\' to \'Michael John Punzalan Seva\'', 'Profile Management', '2025-03-06 08:43:26'),
(554, '2025-03-06', '16:44:18', 'Michael John Punzalan Seva', 'Michael John Punzalan Seva searched for term: m', 'Search Terms', '2025-03-06 08:44:18'),
(555, '2025-03-06', '16:44:34', 'Michael John Punzalan Seva', 'Michael John Punzalan Seva updated borrower information for: Athara Mariel  Mendoza Negrillo', 'Borrower Management logs', '2025-03-06 08:44:34'),
(556, '2025-03-06', '16:45:07', 'Michael John Punzalan Seva', 'Michael John Punzalan Seva logged out', 'Admin Activity Log', '2025-03-06 08:45:07'),
(557, '2025-03-06', '16:45:13', 'Michael John Punzalan Seva', 'Michael John Punzalan Seva logged in as admin', 'User Authentication', '2025-03-06 08:45:13'),
(558, '2025-03-06', '09:46:50', 'Mark Nathaniel D. Olpot', 'Updated profile name from \'Mark Nathaniel D. Olpot jr\' to \'Mark Nathaniel D. Olpot\'', 'Profile Management', '2025-03-06 08:46:50'),
(559, '2025-03-06', '16:47:44', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-06 08:47:44'),
(560, '2025-03-06', '09:48:08', 'Mark Nathaniel D. Olpot jr', 'Updated profile name from \'Mark Nathaniel D. Olpot\' to \'Mark Nathaniel D. Olpot jr\'', 'Profile Management', '2025-03-06 08:48:08'),
(561, '2025-03-06', '16:56:41', 'Mark Nathaniel D. Olpot jr', 'Deleted user: Michael John Punzalan Seva', 'User Management', '2025-03-06 08:56:41'),
(562, '2025-03-06', '16:57:17', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr logged out', 'Admin Activity Log', '2025-03-06 08:57:17'),
(563, '2025-03-06', '16:57:23', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged in as user', 'User Authentication', '2025-03-06 08:57:23');

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
(14, 'Athara Mariel ', 'Mendoza', 'Negrillo', 'Jr.', 'female', '2005-03-29', 'married', '09197657974', 29, 1, '2025-03-04 07:15:14', '2025-03-06 08:44:34', '2025-03-04 07:15:14'),
(15, 'Burat ', 'malake', 'sheyt', 'None', 'male', '2025-03-17', 'single', '09953838730', 31, 1, '2025-03-06 07:00:57', '2025-03-06 07:28:20', '2025-03-06 07:00:57');

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
(33, 14, 'collateral_files/67c6a88224799.png', '2025-03-04 07:15:14'),
(34, 14, 'collateral_files/67c6a882249f0.png', '2025-03-04 07:15:14'),
(35, 14, 'collateral_files/67c6a88224c9c.png', '2025-03-04 07:15:14'),
(36, 14, 'collateral_files/67c6a882253ef.png', '2025-03-04 07:15:14'),
(37, 14, 'collateral_files/67c6a88225664.png', '2025-03-04 07:15:14'),
(38, 15, 'collateral_files/67c94829a5ed9.png', '2025-03-06 07:00:57'),
(39, 15, 'collateral_files/67c94829a62d2.png', '2025-03-06 07:00:57'),
(40, 15, 'collateral_files/67c94829a6544.png', '2025-03-06 07:00:57');

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
(9, 14, 'bading', '09191324234', '2025-03-04 07:15:14'),
(10, 15, 'pogi', '12345678', '2025-03-06 07:00:57');

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
(11, 14, 'badong', 1, 'sixty nine', '09197657973', 20000.00, 30, '2025-03-04 07:15:14'),
(12, 15, 'maranatha barredo', 1, 'gm', '09953838730', 21212.00, 32, '2025-03-06 07:00:57');

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
(11, 14, 'TIN', '12312', '2025-03-04', 'id_photos/67c6a88223421.png', '2025-03-04 07:15:14'),
(12, 15, 'Birth Certificate', '999999', '2025-03-06', 'id_photos/67c94829a4b0f.jpg', '2025-03-06 07:00:57');

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
(8, 14, 'Sun Life', '2025-03-04', '2025-03-28', 'insurance_files/67c6a8822384c.png', '2025-03-04 07:15:14', '2025-03-04 08:04:28'),
(9, 15, 'Manulife', '2025-03-03', '2025-03-06', 'insurance_files/67c94829a5347.png', '2025-03-06 07:00:57', '2025-03-06 07:00:57');

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
(102, 'LN-1C87A5', 15, 'Regular', 11111.00, 7, '2025-03-06', 12, '2026-03-06', 101, 'wqeqw', '2025-03-06 15:31:45', '2025-03-06 15:31:45');

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
(8, 14, 60000.00, '2025-03-04 07:24:05', '2025-03-04 07:24:05'),
(9, 15, 11111.00, '2025-03-06 07:31:45', '2025-03-06 07:31:45');

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
(886, 'Mark Nathaniel  Dela Vega olpot\'s  is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:12:30'),
(887, 'Mark Nathaniel  Dela Vega olpot\'s Manulife insurance is expiring in 22 days (on Mar 26, 2025)', 0, '2025-03-04 15:12:30'),
(891, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 20 days (on Mar 24, 2025)', 0, '2025-03-04 15:13:50'),
(893, 'Jayson Fajardo bustos\'s Voter\'s ID is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:14:12'),
(895, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:14:12'),
(897, 'Athara Mariel  Mendoza Negrillo\'s TIN is expiring in 0 days (on Mar 04, 2025)', 0, '2025-03-04 15:15:35'),
(902, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 28 days (on Apr 01, 2025)', 0, '2025-03-04 15:15:35'),
(1748, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 24 days (on Mar 28, 2025)', 0, '2025-03-04 16:04:31'),
(2541, 'Jayson Fajardo bustos\'s Voter\'s ID is expiring in 13 days (on Mar 19, 2025)', 0, '2025-03-06 08:42:46'),
(2542, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 13 days (on Mar 19, 2025)', 0, '2025-03-06 08:42:46'),
(2543, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 22 days (on Mar 28, 2025)', 0, '2025-03-06 08:42:46'),
(2598, 'Mark Nathaniel  Dela Vega olpot\'s TIN is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 08:54:27'),
(4650, 'Mark Nathaniel  Dela olpot\'s TIN is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 14:27:23'),
(4895, 'Mark Nathaniel  Dela Vega Olpot\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:01:01'),
(4896, 'Mark Nathaniel  Dela Vega Olpot\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:01:01'),
(4916, 'AHAHAHAHA Dela Vega Olpot\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:05:02'),
(4917, 'AHAHAHAHA Dela Vega Olpot\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:05:02'),
(5054, 'Burat  malake sheyt\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:28:22'),
(5055, 'Burat  malake sheyt\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:28:22');

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
(100, '1741073045_67c6aa95a432a.png', '2025-03-04 15:24:05'),
(101, '1741246305_67c94f61c898c.png', '2025-03-06 15:31:45');

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
(58, 'LN-5A425C', 'loan', '2025-03-04 15:24:05', 60000.00, 14, '2025-03-04 15:24:05', '2025-03-04 15:24:05'),
(59, 'LN-1C87A5', 'loan', '2025-03-06 15:31:45', 11111.00, 15, '2025-03-06 15:31:45', '2025-03-06 15:31:45');

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
(1, 'Mark Nathaniel D. Olpot jr', 'olpottado@gmail.com', '$2y$10$fw5LsHyJOpI6WQXhH6dpl.6RYUCT4Tm3p/srUOlXD5QPl8eSmvK32', 'uploads/users/mark_nathaniel_d__olpot_jr/profile/Screenshot (116).png', 'admin', '2025-02-20 06:09:01', '2025-03-06 08:48:08'),
(39, 'Takahiro S. Inoue', 'takahiroinoue16@gmail.com', '$2y$10$MqLK3sNsxucb6dx1R4YPGuAMTF2./.OTn7EQ17E5MO6WjUavLFLfu', 'uploads/users/takahiro_s__inoue/profile/profile.jpg', 'admin', '2025-03-06 05:49:28', '2025-03-06 05:49:28'),
(40, 'Nathaniel P. Padilla', 'nathpadilla81@gmail.com', '$2y$10$LbmLfKftgjmj5pixmzp05.TV8yB2OVV4/pJcHDgho7F9bsQYdeHHK', 'uploads/users/nathaniel_p__padilla/profile/profile.jpg', 'user', '2025-03-06 05:50:27', '2025-03-06 05:50:27');

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_notif` (`notif_content`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=564;

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `collateral_files`
--
ALTER TABLE `collateral_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `dependents`
--
ALTER TABLE `dependents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employment_details`
--
ALTER TABLE `employment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `identification_documents`
--
ALTER TABLE `identification_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `insurance_details`
--
ALTER TABLE `insurance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `loan_balance`
--
ALTER TABLE `loan_balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5486;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promissory_files`
--
ALTER TABLE `promissory_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

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

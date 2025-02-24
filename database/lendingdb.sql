-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2025 at 02:07 AM
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
(22, '1312321', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-02-24 00:58:23');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `audit_content` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(5, 'Maranatha', 'Gapac', 'Barredo', 'None', 'male', '2025-02-13', 'single', '09953838730', 9, 0, '2025-02-14 02:50:42', '0000-00-00 00:00:00', '2025-02-18 05:22:36'),
(6, 'Mark', 'sample', 'Olpot', 'Sr.', 'female', '2025-01-30', 'married', '09953838730', 11, 0, '2025-02-14 03:22:55', '0000-00-00 00:00:00', '2025-02-18 05:22:36'),
(7, 'tado', 'asd', 'olpot', 'None', 'male', '2025-02-13', 'married', '09953838730', 15, 1, '2025-02-20 00:56:31', '2025-02-20 00:56:31', '2025-02-20 00:56:31'),
(10, 'Jayson', 'Fajardo', 'Bustos', 'None', 'male', '2025-02-17', 'single', '09953838730', 21, 1, '2025-02-24 00:58:23', '2025-02-24 00:58:23', '2025-02-24 00:58:23');

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
(19, 7, 'collateral_files/67b67dbff1e5a.png', '2025-02-20 00:56:31'),
(20, 7, 'collateral_files/67b67dbff2817.png', '2025-02-20 00:56:31'),
(21, 7, 'collateral_files/67b67dbff2acc.png', '2025-02-20 00:56:31'),
(22, 7, 'collateral_files/67b67dbff2ccf.png', '2025-02-20 00:56:31'),
(23, 10, 'collateral_files/67bbc42f575d9.jpg', '2025-02-24 00:58:23'),
(24, 10, 'collateral_files/67bbc42f578df.png', '2025-02-24 00:58:23');

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
(5, 10, 'Michael Seva', '09123456789', '2025-02-24 00:58:23');

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
(7, 10, 'anthony francisco', 12, 'manager', '09953838730', 121.00, 22, '2025-02-24 00:58:23');

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
(2, 5, 'National ID', '22232', '2025-02-15', 'id_photos/67aebf5b025de.png', '2025-02-14 02:50:42'),
(3, 6, 'Birth Certificate', 'qwe', '2025-02-11', 'id_photos/67aeb70fb66dc.png', '2025-02-14 03:22:55'),
(4, 7, 'PhilHealth', '123123', '2025-02-12', 'id_photos/67b67dbfef9fd.png', '2025-02-20 00:56:31'),
(7, 10, 'SSS', '11111111', '2025-02-09', 'id_photos/67bbc42f56056.jpg', '2025-02-24 00:58:23');

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
(2, 5, 'Manulife', '2025-02-26', '2025-02-17', 'insurance_files/67aeaf821e2a3.png', '2025-02-14 02:50:42', '2025-02-24 00:44:22'),
(3, 7, 'Single Premium', '2025-02-13', '2025-02-05', 'insurance_files/67b67dbff06cc.png', '2025-02-20 00:56:31', '2025-02-20 05:28:59'),
(4, 10, 'Manulife', '2025-02-11', '2025-02-16', 'insurance_files/67bbc42f5643c.png', '2025-02-24 00:58:23', '2025-02-24 00:58:23');

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
(9, 'LN-E8C185', 5, 'VIP', 1000.00, 5, '0000-00-00', 12, '2026-02-20', 0, 'Loan added successfully', '2025-02-20 16:50:54', '2025-02-20 16:50:54'),
(10, 'LN-39A507', 6, 'Regular', 111.00, 7, '0000-00-00', 12, '2026-02-24', 2, 'Loan added successfully', '2025-02-24 08:16:35', '2025-02-24 08:16:35'),
(11, 'LN-6306D7', 5, 'Other', 1000.00, 10, '0000-00-00', 12, '2026-02-02', 3, 'Loan added successfully', '2025-02-24 08:19:02', '2025-02-24 08:19:02'),
(12, 'LN-B71907', 6, 'Regular', 1000000.00, 7, '0000-00-00', 12, '2026-02-24', 4, 'Loan added successfully', '2025-02-24 08:26:19', '2025-02-24 08:26:19'),
(13, 'LN-FB81E9', 6, 'Regular', 1312321.00, 7, '0000-00-00', 12, '2026-02-24', 5, 'Loan added successfully', '2025-02-24 08:28:15', '2025-02-24 08:28:15'),
(14, 'LN-15A7E0', 6, 'Regular', 232.00, 7, '0000-00-00', 12, '2026-02-24', 11, 'Loan added successfully', '2025-02-24 08:40:49', '2025-02-24 08:40:49'),
(15, 'LN-0BA475', 5, 'VIP', 12232.00, 5, '0000-00-00', 24, '2027-02-24', 12, 'Loan added successfully', '2025-02-24 08:42:24', '2025-02-24 08:42:24'),
(16, 'LN-86E6E1', 6, 'VIP', 12121.00, 5, '0000-00-00', 12, '2026-02-24', 13, 'Loan added successfully', '2025-02-24 08:46:16', '2025-02-24 08:46:16'),
(17, 'LN-26E44E', 6, 'Regular', 1212.00, 7, '0000-00-00', 12, '2026-02-24', 14, 'Loan added successfully', '2025-02-24 08:46:58', '2025-02-24 08:46:58'),
(18, 'LN-F48E10', 6, 'Regular', 23131.00, 7, '0000-00-00', 31, '2027-09-24', 15, 'Loan added successfully', '2025-02-24 08:49:03', '2025-02-24 08:49:03'),
(19, 'LN-ACD2CA', 6, 'VIP', 123131.00, 5, '0000-00-00', 12, '2026-02-24', 16, 'Loan added successfully', '2025-02-24 08:50:02', '2025-02-24 08:50:02');

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
(1, '1740041454_67b6ecee8c413.png', '2025-02-20 16:50:54'),
(2, '1740356195_67bbba639a5ba.pdf', '2025-02-24 08:16:35'),
(3, '1740356342_67bbbaf630793.jpg', '2025-02-24 08:19:02'),
(4, '1740356779_67bbbcab71a1b.jpg', '2025-02-24 08:26:19'),
(5, '1740356895_67bbbd1fb82fb.jpg', '2025-02-24 08:28:15'),
(11, '1740357649_67bbc0115a8b7.pdf', '2025-02-24 08:40:49'),
(12, '1740357744_67bbc070ba5f9.pdf', '2025-02-24 08:42:24'),
(13, '1740357976_67bbc1586e753.pdf', '2025-02-24 08:46:16'),
(14, '1740358018_67bbc1826e4d0.pdf', '2025-02-24 08:46:58'),
(15, '1740358143_67bbc1ff48e79.pdf', '2025-02-24 08:49:03'),
(16, '1740358202_67bbc23acd2f3.pdf', '2025-02-24 08:50:02');

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
(1, 'Mark Nathaniel D. Olpot', 'olpottado@gmail.com', '$2y$10$fw5LsHyJOpI6WQXhH6dpl.6RYUCT4Tm3p/srUOlXD5QPl8eSmvK32', 'uploads/users/mark_nathaniel_d__olpot/profile/profile.jpg', 'admin', '2025-02-20 06:09:01', '2025-02-20 06:09:01');

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
  ADD KEY `user_id` (`user_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `collateral_files`
--
ALTER TABLE `collateral_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `dependents`
--
ALTER TABLE `dependents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employment_details`
--
ALTER TABLE `employment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `identification_documents`
--
ALTER TABLE `identification_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `insurance_details`
--
ALTER TABLE `insurance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `loan_balance`
--
ALTER TABLE `loan_balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promissory_files`
--
ALTER TABLE `promissory_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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

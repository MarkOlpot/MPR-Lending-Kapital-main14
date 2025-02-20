-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2025 at 03:47 AM
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
(12, 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'ewq', '2025-02-14 03:22:55');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowers`
--

INSERT INTO `borrowers` (`id`, `first_name`, `middle_name`, `surname`, `suffix`, `sex`, `dob`, `marital_status`, `contact_number`, `address_id`, `created_at`, `updated_at`) VALUES
(5, 'Maranatha', 'Gapac', 'Barredo', 'None', 'male', '2025-02-13', 'single', '09953838730', 9, '2025-02-14 02:50:42', '0000-00-00 00:00:00'),
(6, 'Mark', 'sample', 'Olpot', 'Sr.', 'female', '2025-01-30', 'married', '09953838730', 11, '2025-02-14 03:22:55', '0000-00-00 00:00:00');

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
(18, 6, 'collateral_files/67aeb70fb8b83.png', '2025-02-14 03:22:55');

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
(3, 6, '', '', '2025-02-14 03:22:55');

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
(3, 6, 'qwe', 123, 'qwe', 'qwe', 123.00, 12, '2025-02-14 03:22:55');

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
(3, 6, 'Birth Certificate', 'qwe', '2025-02-11', 'id_photos/67aeb70fb66dc.png', '2025-02-14 03:22:55');

-- --------------------------------------------------------

--
-- Table structure for table `insurance_details`
--

CREATE TABLE `insurance_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `insurance_type` varchar(100) NOT NULL,
  `issued_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `insurance_file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `insurance_details`
--

INSERT INTO `insurance_details` (`id`, `borrower_id`, `insurance_type`, `issued_date`, `expiry_date`, `insurance_file_path`, `created_at`) VALUES
(2, 5, 'Health Insurance', '2025-02-26', '2025-02-17', 'insurance_files/67aeaf821e2a3.png', '2025-02-14 02:50:42');

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
  `loan_date` date NOT NULL,
  `repayment_date` date NOT NULL,
  `promissory_id` int(11) NOT NULL,
  `remarks` text NOT NULL,
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
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `collateral_files`
--
ALTER TABLE `collateral_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `dependents`
--
ALTER TABLE `dependents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employment_details`
--
ALTER TABLE `employment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `identification_documents`
--
ALTER TABLE `identification_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `insurance_details`
--
ALTER TABLE `insurance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 26, 2021 at 04:53 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sre_hack`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Issue'),
(2, 'SR');

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `email_id` int(11) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `opened_date_time` text NOT NULL,
  `email_subject` varchar(2000) NOT NULL,
  `email_content` varchar(2000) NOT NULL,
  `email_type` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `closed_time` text DEFAULT NULL,
  `email_status` varchar(255) NOT NULL,
  `time_difference` int(11) NOT NULL DEFAULT 0,
  `ticketID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `email`
--

INSERT INTO `email` (`email_id`, `from_email`, `opened_date_time`, `email_subject`, `email_content`, `email_type`, `priority`, `closed_time`, `email_status`, `time_difference`, `ticketID`) VALUES
(123, 'hello@suvin.me', '2021-11-27 15:21:51', 'sdv', 'vsdvds', 1, 1, '2021-11-28 15:21:51', 'sdsdds', 2, 0),
(124, 'Steve Smith <test@example.com>', '2021-11-26', 'Test Email', 'Test Content', 1, 1, '22-21-12', 'sdcdsc', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

CREATE TABLE `priority` (
  `priority_id` int(11) NOT NULL,
  `priority_label` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `priority`
--

INSERT INTO `priority` (`priority_id`, `priority_label`) VALUES
(1, 'High'),
(2, 'Medium'),
(3, 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `team_contact`
--

CREATE TABLE `team_contact` (
  `contact_no` varchar(15) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team_contact`
--

INSERT INTO `team_contact` (`contact_no`, `contact_name`) VALUES
('+94728463975', 'Nandula Perera');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`email_id`),
  ADD KEY `priority` (`priority`),
  ADD KEY `email_type` (`email_type`);

--
-- Indexes for table `priority`
--
ALTER TABLE `priority`
  ADD PRIMARY KEY (`priority_id`);

--
-- Indexes for table `team_contact`
--
ALTER TABLE `team_contact`
  ADD PRIMARY KEY (`contact_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `email`
--
ALTER TABLE `email`
  ADD CONSTRAINT `email_ibfk_1` FOREIGN KEY (`priority`) REFERENCES `priority` (`priority_id`),
  ADD CONSTRAINT `email_ibfk_2` FOREIGN KEY (`email_type`) REFERENCES `category` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

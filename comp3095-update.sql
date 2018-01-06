-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2018 at 12:56 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `comp3095`
--
DROP DATABASE IF EXISTS `comp3095`;
CREATE DATABASE IF NOT EXISTS `comp3095` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `comp3095`;

grant all on COMP3095.* to 'admin'@'localhost' identified by 'admin'; 

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `atten_id` int(10) UNSIGNED NOT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`atten_id`, `department_id`, `date`) VALUES
(1, 3, '2018-01-04'),
(2, 3, '2018-01-04'),
(3, 3, '2018-01-01'),
(4, 2, ''),
(5, 2, '2018-01-02');

-- --------------------------------------------------------

--
-- Table structure for table `atten_employee`
--

DROP TABLE IF EXISTS `atten_employee`;
CREATE TABLE `atten_employee` (
  `atten_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `attended` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `atten_employee`
--

INSERT INTO `atten_employee` (`atten_id`, `employee_id`, `attended`) VALUES
(2, 18, 1),
(2, 19, 0),
(2, 20, 0),
(2, 27, 0),
(2, 28, 0),
(3, 18, 0),
(3, 19, 1),
(3, 20, 1),
(3, 27, 1),
(3, 28, 1),
(4, 16, 1),
(5, 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `criteria`
--

DROP TABLE IF EXISTS `criteria`;
CREATE TABLE `criteria` (
  `criteria_id` int(10) UNSIGNED NOT NULL,
  `criteria_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `criteria`
--

INSERT INTO `criteria` (`criteria_id`, `criteria_name`) VALUES
(153, 'Attendance'),
(154, 'Tardiness'),
(155, 'Speed'),
(156, 'Correctness'),
(157, 'Reliability');

-- --------------------------------------------------------

--
-- Table structure for table `criteria_grade`
--

DROP TABLE IF EXISTS `criteria_grade`;
CREATE TABLE `criteria_grade` (
  `report_id` int(11) UNSIGNED NOT NULL,
  `criteria_id` int(11) UNSIGNED NOT NULL,
  `grade` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `criteria_grade`
--

INSERT INTO `criteria_grade` (`report_id`, `criteria_id`, `grade`) VALUES
(29, 153, 3),
(29, 154, 4),
(29, 155, 3),
(29, 156, 4),
(29, 157, 3);

-- --------------------------------------------------------

--
-- Table structure for table `criteria_section`
--

DROP TABLE IF EXISTS `criteria_section`;
CREATE TABLE `criteria_section` (
  `criteria_id` int(10) UNSIGNED NOT NULL,
  `section_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `criteria_section`
--

INSERT INTO `criteria_section` (`criteria_id`, `section_id`) VALUES
(153, 83),
(154, 83),
(155, 84),
(156, 84),
(157, 85);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`department_id`, `name`, `location`) VALUES
(1, 'Quality Assurance', 'basement level 3'),
(2, 'Gaming', 'B99'),
(3, 'Accounting', 'F3');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `employee_id` int(11) UNSIGNED NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `employee_number` int(6) NOT NULL,
  `email` varchar(255) NOT NULL,
  `hire_date` date NOT NULL,
  `job_position` varchar(255) NOT NULL,
  `department_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `firstname`, `lastname`, `employee_number`, `email`, `hire_date`, `job_position`, `department_id`) VALUES
(1, 'Jeff', 'Boye', 123456, 'fake@email.ca', '2017-10-09', 'tester', 1),
(13, 'Andrew', 'Elliott', 435678, 'dsadsa@dsad.ca', '2005-01-01', 'Junior Programmer', 1),
(16, 'Billy Dee', 'Williams', 98723, 'ddsad@dsa.ca', '2005-01-01', 'Junior Programmer', 2),
(18, 'Jeff', 'O', 990877, 'dsadsa@dsad.ca', '2005-01-01', 'Junior Programmer', 3),
(19, 'Roman', 'Markman', 784839, 'fdsf@da.ca', '2006-01-01', 'Junior Programmer', 3),
(20, 'Kevin', 'Lei', 762364, 'fdsf@dsad.ca', '2006-01-01', 'Junior Programmer', 3),
(27, 'Jullian', 'Sy', 982736, 'dsa@dsa.ca', '2005-01-01', 'Junior Programmer', 3),
(28, 'Aron', 'Elliott', 284732, 'dsad@dsa.ca', '2005-01-01', 'It Director', 3);

-- --------------------------------------------------------

--
-- Table structure for table `employee_group`
--

DROP TABLE IF EXISTS `employee_group`;
CREATE TABLE `employee_group` (
  `employee_id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_group`
--

INSERT INTO `employee_group` (`employee_id`, `group_id`) VALUES
(27, 23),
(28, 23);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `department_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`group_id`, `name`, `department_id`) VALUES
(23, 'Accounting Group', 3);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `report_id` int(10) UNSIGNED NOT NULL,
  `template_id` int(10) UNSIGNED NOT NULL,
  `report_name` text NOT NULL,
  `target_name` text NOT NULL,
  `report_date` text NOT NULL,
  `section_1_comment` text,
  `section_2_comment` text,
  `section_3_comment` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`report_id`, `template_id`, `report_name`, `target_name`, `report_date`, `section_1_comment`, `section_2_comment`, `section_3_comment`) VALUES
(29, 25, 'Jullian Report', 'Sy, Jullian', '2018-01-03', 'Comments', 'More Comments', 'Lots of Comments');

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `section_id` int(10) UNSIGNED NOT NULL,
  `section_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`section_id`, `section_name`) VALUES
(83, 'Section 1'),
(84, 'Section 2'),
(85, 'Section 3');

-- --------------------------------------------------------

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
CREATE TABLE `template` (
  `template_id` int(10) UNSIGNED NOT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `template_name` text NOT NULL,
  `section_1` int(10) UNSIGNED NOT NULL,
  `section_2` int(10) UNSIGNED NOT NULL,
  `section_3` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `template`
--

INSERT INTO `template` (`template_id`, `department_id`, `date`, `template_name`, `section_1`, `section_2`, `section_3`) VALUES
(25, 3, '2018-01-06', 'Accounting Report 2018', 83, 84, 85);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `role`, `username`, `password`) VALUES
(1, NULL, NULL, 'admin@domain.ca', NULL, 'admin', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`atten_id`),
  ADD KEY `fk_department_id` (`department_id`);

--
-- Indexes for table `atten_employee`
--
ALTER TABLE `atten_employee`
  ADD PRIMARY KEY (`atten_id`,`employee_id`),
  ADD KEY `fk_employee_id` (`employee_id`);

--
-- Indexes for table `criteria`
--
ALTER TABLE `criteria`
  ADD PRIMARY KEY (`criteria_id`);

--
-- Indexes for table `criteria_grade`
--
ALTER TABLE `criteria_grade`
  ADD PRIMARY KEY (`report_id`,`criteria_id`),
  ADD KEY `fk_cg_criteria_id` (`criteria_id`);

--
-- Indexes for table `criteria_section`
--
ALTER TABLE `criteria_section`
  ADD PRIMARY KEY (`criteria_id`,`section_id`),
  ADD KEY `fk_cs_section_id` (`section_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `department_id_fk` (`department_id`);

--
-- Indexes for table `employee_group`
--
ALTER TABLE `employee_group`
  ADD PRIMARY KEY (`employee_id`,`group_id`),
  ADD KEY `group_id_fk` (`group_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `department_id_fk2` (`department_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_template_id` (`template_id`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`section_id`);

--
-- Indexes for table `template`
--
ALTER TABLE `template`
  ADD PRIMARY KEY (`template_id`),
  ADD KEY `fk_temp_department_id` (`department_id`),
  ADD KEY `fk_section_1_id` (`section_1`),
  ADD KEY `fk_section_2_id` (`section_2`),
  ADD KEY `fk_section_3_id` (`section_3`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `atten_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `criteria`
--
ALTER TABLE `criteria`
  MODIFY `criteria_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `department_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `section_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `template`
--
ALTER TABLE `template`
  MODIFY `template_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE;

--
-- Constraints for table `atten_employee`
--
ALTER TABLE `atten_employee`
  ADD CONSTRAINT `fk_atten_id` FOREIGN KEY (`atten_id`) REFERENCES `attendance` (`atten_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON UPDATE CASCADE;

--
-- Constraints for table `criteria_grade`
--
ALTER TABLE `criteria_grade`
  ADD CONSTRAINT `fk_cg_criteria_id` FOREIGN KEY (`criteria_id`) REFERENCES `criteria` (`criteria_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cg_report_id` FOREIGN KEY (`report_id`) REFERENCES `report` (`report_id`) ON UPDATE CASCADE;

--
-- Constraints for table `criteria_section`
--
ALTER TABLE `criteria_section`
  ADD CONSTRAINT `fk_cs_criteria_id` FOREIGN KEY (`criteria_id`) REFERENCES `criteria` (`criteria_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cs_section_id` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_group`
--
ALTER TABLE `employee_group`
  ADD CONSTRAINT `employee_id_fk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `department_id_fk2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `fk_template_id` FOREIGN KEY (`template_id`) REFERENCES `template` (`template_id`) ON UPDATE CASCADE;

--
-- Constraints for table `template`
--
ALTER TABLE `template`
  ADD CONSTRAINT `fk_temp_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

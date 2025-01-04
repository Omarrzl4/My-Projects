-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: fdb1029.awardspace.net
-- Generation Time: Jan 01, 2025 at 09:28 AM
-- Server version: 8.0.32
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `4566111_hotelreservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `ID` int NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Role` varchar(200) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`ID`, `Name`, `Role`, `Email`, `Password`) VALUES
(1, 'Ali Al Ahmad', 'housekeeping', 'ali11ahmad@gmail.com', '$2y$10$zD/h7kLMJR6lvYbSneDafeRuuvxrCZc9lvOPtH1mcUSxGcTwYYSe6'),
(2, 'Hadi Zein', 'waiter', 'hadi11zein@gmail.com', '$2y$10$GuC/4Yze/E/oGInTlk1tjuitcKnXevAST5KalNeZXgqh.RJJM88cC'),
(3, 'Mostafa Itani', 'maintenance', 'mostafa11Itani@gmail.com', '$2y$10$/WkluO3PsrPX4PN.VZfpqu3Huf2oS16BtPGLjijRQbAsDWmdJD3ju');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` varchar(10) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `first_name`, `last_name`, `email`, `phone`, `description`, `created_at`) VALUES
(1, 'Omar', 'Zoghbi', 'omar11zoghbi@gmail.com', '70123456', 'Great Hotel!!', '2024-12-14'),
(2, 'Hasan', 'Itani', 'hasan11itani@gmail.com', '70654321', 'What an Hotel to be reserved in.', '2024-12-14'),
(3, 'Ahmad', 'Omari', 'ahmad11omari@gmail.com', '70654123', 'Best Hotel I have reserved in.', '2024-12-14');

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE `guest` (
  `ID` int NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Username` varchar(200) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Password` varchar(200) NOT NULL,
  `Datecreated` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`ID`, `Name`, `Username`, `Email`, `Password`, `Datecreated`) VALUES
(1, 'Omar Zoghbi', 'Omar11', 'omar11zoghbi@gmail.com', '$2y$10$YMH05tfEFWWcIxmzTrg9mOzv5V5fBA.ai9DoIs2h6LQgahZp0stGS', '12/14/2024'),
(2, 'Hasan Itani', 'Hasan11', 'hasan11itani@gmail.com', '$2y$10$2vYHcS5Hy0OZjiRSW15Rs.WoyOcY57KCSLSq8L3Dt4lSGeCBBnLPm', '12/14/2024'),
(3, 'Ahmad Omari', 'Ahmad11', 'ahmad11omari@gmail.com', '$2y$10$0KrJd6t7dQY1VJO/O4349.J2W6gLPrZ1uYsRa3DyN6Y/39urUSYty', '12/14/2024'),
(24, 'jad', 'jadl1', 'jad11zoghbi@gmail.com', '$2a$10$3Xes/R2zPG7u69guc5uqpOrW1.1Z7JE2IX/qIgWYXYFfTX93Mrzuq', '12/24/2024'),
(25, 'hamza', 'hamza101', 'hamza@gmail.com', '$2a$10$eUiHRVXIAbYwb3mu0eSsHuhiFOvN1WiTqKIZE0l.SUdfCNYrhm7cy', '12/27/2024');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `ID` int NOT NULL,
  `Room_ID` int NOT NULL,
  `Guest_ID` int NOT NULL,
  `CheckIn` date NOT NULL,
  `CheckOut` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`ID`, `Room_ID`, `Guest_ID`, `CheckIn`, `CheckOut`) VALUES
(27, 8, 1, '2025-01-14', '2025-01-15');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `ID` int NOT NULL,
  `RoomName` varchar(255) NOT NULL,
  `RoomNumber` int NOT NULL,
  `RoomCategory` varchar(100) NOT NULL,
  `Status` tinyint(1) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `RoomPrice` int NOT NULL,
  `RoomImage` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`ID`, `RoomName`, `RoomNumber`, `RoomCategory`, `Status`, `Description`, `RoomPrice`, `RoomImage`) VALUES
(1, 'Classic King Guest Room', 101, 'Classic', 1, 'King platform bed, 5-star bedding Floor-to-ceiling windows Elegant bathroom, walk-in shower, Frette robes 42\" TV, free Wi-Fi, safe 192 sq. ft.', 400, '675da35e0d0f26.32463745.jpg'),
(2, 'Classic Queen Guest Room', 102, 'Classic', 1, 'Queen platform bed, 5-star bedding Floor-to-ceiling windows Elegant bathroom, walk-in shower, Frette robes 42\" TV, free Wi-Fi, safe 192 sq. ft.', 400, '675da3c728d471.64839641.jpg'),
(3, 'Superior Room', 103, 'Superior', 1, 'Bed with premium linens, spacious work desk, floor-to-ceiling windows, elegant bathroom with soaking tub, 40\" TV, free Wi-Fi, safe, minibar, 250 sq. ft.', 300, '675da4a3b82e53.40222242.jpeg'),
(4, 'Deluxe Double Room', 104, 'Deluxe', 1, 'Two double beds, luxurious 5-star bedding, large windows with city view, marble bathroom with walk-in shower, 50\" TV, free Wi-Fi, in-room safe, 280 sq. ft.', 350, '675da4e485ed77.61060296.jpg'),
(5, 'Luxury Suite', 105, 'Suite', 1, 'King-sized bed, separate living area, floor-to-ceiling windows with ocean view, marble bathroom with jacuzzi, 65\" TV, free Wi-Fi, minibar, safe, 600 sq. ft.', 800, '675da51b6de1b8.86785200.jpeg'),
(6, 'Presidential Suite', 106, 'Suite', 1, 'King bed, private terrace with panoramic city views, full kitchen, dining area, luxury bathroom with dual vanity and spa tub, 75\" TV, free Wi-Fi, safe, 1,200 sq. ft.', 1200, '675da57361e172.55899730.jpeg'),
(7, 'Standard Single Room', 107, 'Standard', 1, 'Single bed, compact room with minimalistic décor, shower with glass partition, 32\" TV, free Wi-Fi, safe, 150 sq. ft.', 200, '675da5c3441015.96878000.jpeg'),
(8, 'Ocean View Suite', 108, 'Suite', 1, 'King-sized bed, private balcony with ocean view, luxury bathroom with rain shower and soaking tub, 55\" TV, free Wi-Fi, minibar, safe, 700 sq. ft.', 950, '675da5fe4002c8.50390657.jpeg'),
(9, 'Garden View', 109, 'Superior', 1, 'Queen bed, views of the hotel garden, modern bathroom with shower, 40\" TV, free Wi-Fi, safe, 240 sq. ft.', 300, '675da63ee638c3.27504637.jpeg'),
(10, 'Executive', 110, 'Executive', 1, 'King bed, executive desk, lounge area, large windows with city views, bathroom with separate tub and shower, 50\" TV, free Wi-Fi, safe, 350 sq. ft.', 500, '675da6a5df5118.53633226.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `ID` int NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Guest_ID` int NOT NULL,
  `Employee_ID` int DEFAULT NULL,
  `Type` varchar(200) NOT NULL,
  `Status` enum('pending','accepted','completed') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`ID`, `Name`, `Guest_ID`, `Employee_ID`, `Type`, `Status`) VALUES
(1, 'Omar Zoghbi', 1, 2, 'food', 'accepted'),
(2, 'Hasan Itani', 2, 1, 'housekeeping', 'accepted'),
(3, 'Ahmad Omari', 3, 3, 'maintenance', 'accepted'),
(4, 'Hasan Itani', 2, NULL, 'food', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Room` (`Room_ID`),
  ADD KEY `FK_Guest` (`Guest_ID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_guest_id` (`Guest_ID`),
  ADD KEY `fk_employee_id` (`Employee_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `guest`
--
ALTER TABLE `guest`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `fk_employee_id` FOREIGN KEY (`Employee_ID`) REFERENCES `employees` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guest_id` FOREIGN KEY (`Guest_ID`) REFERENCES `guest` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2022 at 07:10 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingtime`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `phone`, `email`, `msg`, `date`) VALUES
(1, 'shubh', '9876543210', 'abc@d.com', 'helo', '2022-09-16 18:32:25'),
(2, 'shubham', '9876543210', 'abc@d.com', 'hii', '2022-09-16 18:35:18'),
(3, 'trial', '9876543210', 'abc@d.com', 'trail', '2022-09-16 18:36:29'),
(4, 'shubhamkumar', '9876543211', 'abc@d.com', 'hey ', '2022-09-16 19:43:19'),
(5, 'sss', '9876543210', 'abc@d.com', 'aaaaaaa', '2022-09-16 19:53:55'),
(6, 'shubh', '9876543210', 'abc@d.com', 'www', '2022-09-16 20:01:21');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `subheading` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `img_file` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `subheading`, `slug`, `img_file`, `content`, `date`) VALUES
(4, 'Vrindavan', 'History', 'vrindavan-history', 'Radha_Damodar_Temple.jpg', 'Vrindavan has an ancient past, associated with Hindu culture and history, and was established in the 16th and 17th centuries as a result of an explicit treaty between Muslims and Hindu Emperors,[17] and is an important Hindu pilgrimage site since long.\r\n\r\nOf the contemporary times, Vallabhacharya, aged eleven visited Vrindavan. Later on, he performed three pilgrimages of India, barefoot giving discourses on Bhagavad Gita at 84 places. These 84 places are known as Pushtimarg Baithak and since then are the places of pilgrimage. Yet, he stayed in Vrindavan for four months each year. Vrindavan thus heavily influenced his formation of Pushtimarg.\r\n\r\nBanke Bihari Temple, Vrindavan\r\nBanke Bihari Temple, Vrindavan\r\nThe essence of Vrindavan was lost over time until the 16th century, when it was rediscovered by Chaitanya Mahaprabhu. In the year 1515, Chaitanya Mahaprabhu visited Vrindavan, with the purpose of locating the lost holy places associated with Krishna\'s life.[18]\r\n\r\nIn the last 250 years, the extensive forests of Vrindavan have been subjected to urbanization, first by local Rajas and in recent decades by apartment developers. The forest cover has been whittled away to only a few remaining spots, and the local wildlife, including peacocks, cows, monkeys and a variety of bird species has been virtually eliminated.', '2022-09-20 14:35:01'),
(5, 'vridavan', 'prem mandir', 'vrindavan-prem-mandir', 'PremMandirSideViewFromCanteen.jpg', 'Prem Mandir (lit. The Temple of Love) is a Hindu temple in Vrindavan, India. It is maintained by Jagadguru Kripalu Parishat, an international non-profit, educational, spiritual, charitable trust. The complex is on a 55-acre site on the outskirts of Vrindavan. It is dedicated to Radha Krishna and Sita Ram. Radha Krishna are on the first level and Sita Ram are on the second level. The temple was established by the fifth Original Jagadguru Shri Kripalu Ji Maharaj.[1] Different Leelas of Shri Krishna and Rasik saints are depicted all over the wall of the main temple.[2]\r\n\r\nConstruction began in January 2001[3] and the inauguration ceremony took place from 15 to 17 February 2012.[4] The temple was opened to public on 17 February. The cost was 150 crore rupees ($23 million).[5] The presiding deity are Shri Radha Govind (Radha Krishna) and Shri Sita Ram. A 73,000 square feet, pillar-less, dome shaped satsang hall is being constructed next to Prem Mandir, which will accommodate 25,000 people at a time.[6] Surrounded by beautiful gardens and fountains, the temple complex has life-size depictions of four leelas of Shri Krishna – Jhulan leela, Govardhan leela, Raas leela and Kaliya Naag leela.\r\n\r\nIt is sister temple of Bhakti Mandir which was opened in 2005 and another sister temple which is known as Kirti Mandir, Barsana opened in 2019.[7]\r\n\r\n', '2022-09-21 05:57:09'),
(6, 'python', 'programming language', 'python-programming-language', 'Python.svg.png', 'Python is a widely used high-level, general-purpose, interpreted, dynamic programming language. Its design philosophy emphasizes code readability, and its syntax allows programmers to express concepts in fewer lines of code than possible in other popular programming languages.[1]\r\nPython is a multi-paradigm programming language, that is dynamically typed and garbage-collected. Many of the capabilities that the Python language supports are object-oriented programming and functional programming. This language follows a philosophy, which consists of phrases such as:\r\n\r\n\"Beautiful is better than ugly\"\r\n\"Simple is better than Complex\"\r\n\"Readability counts\"\r\n\"Explicit is better than implicit\"\r\n\"Complex is better than complicated\"\r\nSee Zen of Python for more information about this philosophy.\r\n\r\nPython aims for simplicity and a less-cluttered syntax, while allowing developers to have options for their preferred coding method. Python has many versions out for developers to use. This consists of Python 2 (now on Sunset Status) and Python 3.9 (October 2020).\r\nPython is a widely used high-level, general-purpose, interpreted, dynamic programming language. Python supports many programming paradigms, including object-oriented, functional, and procedural programming. Its design philosophy emphasizes code readability, simplicity, and its syntax allows programmers to express concepts in fewer lines of code than possible in other popular programming languages. Python is very extensible and the modularity of this language has made it popular for adding interfaces to existing applications.[1]\r\n\r\nThis course comprises 16 lessons on Python programming using Python 3. Each lesson includes a combination of Wikipedia and Internet-based readings, YouTube videos, and hands-on learning activities.\r\n\r\nThis entire Wikiversity course can be downloaded in book form by selecting Download Learning Guide in the sidebar.', '2022-09-21 07:55:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

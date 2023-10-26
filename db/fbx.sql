SET character_set_client = 'utf8';
CREATE DATABASE fbx;
USE fbx;

ALTER DATABASE fbx CHARACTER SET utf8 COLLATE utf8_unicode_ci;


CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL,
  `location_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`location_id`, `location_name`) VALUES
(1, 'Bangkok'),
(2, 'Krabi'),
(3, 'Chiang Mai'),
(4, 'Chiang Rai'),
(5, 'Phetchaburi'),
(6, 'Phetchabun'),
(7, 'Nakhon Ratchasima'),
(8, 'Nakhon Si Thammarat'),
(9, 'Nakhon Sawan'),
(10, 'Narathiwat'),
(11, 'Nan'),
(12, 'Bung Kan'),
(13, 'Buri Ram'),
(14, 'Pathum Thani'),
(15, 'Prachuap Khiri Khan'),
(16, 'Prachinburi'),
(17, 'Pattani'),
(18, 'Phra Nakhon Si Ayutthaya'),
(19, 'Phayao'),
(20, 'Phang Nga'),
(21, 'Phatthalung'),
(22, 'Phichit'),
(23, 'Phitsanulok'),
(24, 'Phuket'),
(25, 'Maha Sarakham'),
(26, 'Mukdahan'),
(27, 'Mae Hong Son'),
(28, 'Yasothon'),
(29, 'Yala'),
(30, 'Roi Et'),
(31, 'Ranong'),
(32, 'Rayong'),
(33, 'Ratchaburi'),
(34, 'Lopburi'),
(35, 'Lopburi'),
(36, 'Songkhla'),
(37, 'Loei'),
(38, 'Lampang'),
(39, 'Lamphun'),
(40, 'Wang Chik'),
(41, 'Si Sa Ket'),
(42, 'Sakon Nakhon'),
(43, 'Songkhla'),
(44, 'Satun'),
(45, 'Surat Thani'),
(46, 'Surin'),
(47, 'Sukhothai'),
(48, 'Suphan Buri'),
(49, 'Sa Kaeo'),
(50, 'Saraburi'),
(51, 'Sing Buri'),
(52, 'Nong Khai'),
(53, 'Nong Bua Lam Phu'),
(54, 'Ang Thong'),
(55, 'Udon Thani'),
(56, 'Uttaradit'),
(57, 'Ubon Ratchathani'),
(58, 'Amnat Charoen');
-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `content`, `location_id`) VALUES
(9, 3, 'Hello from JohnDoe', 1),
(10, 4, 'Today, the weather is great in Krabi', 2),
(11, 5, 'The beach here is incredibly beautiful with white sand', 2),
(12, 3, 'I want to visit Chiang Mai', 3),
(13, 4, 'Chiang Rai has a very pleasant evening', 4),
(14, 5, 'Today in Phetchaburi, it is a public holiday', 5);


-- --------------------------------------------------------

--
-- Table structure for table `posttags`
--

CREATE TABLE `posttags` (
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `posttags`
--

INSERT INTO `posttags` (`post_id`, `user_id`) VALUES
(9, 1),
(9, 2),
(10, 1),
(11, 2),
(12, 1),
(12, 3),
(13, 1),
(14, 2);


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`) VALUES
(1, 'Mon'),
(2, 'Chid'),
(3, 'Alice'),
(4, 'Bob'),
(5, 'Charlie'),
(6, 'David'),
(7, 'Eve'),
(8, 'Frank'),
(9, 'Grace');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `posttags`
--
ALTER TABLE `posttags`
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);

--
-- Constraints for table `posttags`
--
ALTER TABLE `posttags`
  ADD CONSTRAINT `posttags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  ADD CONSTRAINT `posttags_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;


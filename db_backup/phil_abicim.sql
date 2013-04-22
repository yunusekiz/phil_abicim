-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Anamakine: localhost
-- Üretim Zamanı: 22 Nis 2013, 07:50:17
-- Sunucu sürümü: 5.5.25a
-- PHP Sürümü: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Veritabanı: `phil_abicim`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_date` varchar(50) NOT NULL,
  `event_title` varchar(250) NOT NULL,
  `event_detail` text NOT NULL,
  `event_builder_ssn` bigint(12) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_builder_id` (`event_builder_ssn`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Tablo döküm verisi `event`
--

INSERT INTO `event` (`event_id`, `event_date`, `event_title`, `event_detail`, `event_builder_ssn`) VALUES
(2, '20-07-1974', 'kizim ayse tatile ciksin', 'kizim ayse annesini de alip tatile ciksin', 13368369400),
(6, '20-07-2013', 'kar tatili', 'bugun kar tatiti cocuklar okula gelmeyin', 13368369400);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message_content` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`,`receiver_id`),
  KEY `receiver_id` (`receiver_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `msg_view_by_receiver_id`
--
CREATE TABLE IF NOT EXISTS `msg_view_by_receiver_id` (
`message_id` int(11)
,`receiver_id` int(11)
,`message_content` text
);
-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `msg_view_by_sender_id`
--
CREATE TABLE IF NOT EXISTS `msg_view_by_sender_id` (
`message_id` int(11)
,`sender_id` int(11)
,`message_content` text
);
-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `ssn_view_by_teacher`
--
CREATE TABLE IF NOT EXISTS `ssn_view_by_teacher` (
`teacher_id` int(11)
,`ss_number` bigint(12)
);
-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_name` varchar(250) NOT NULL,
  `teacher_surname` varchar(250) NOT NULL,
  `ss_number` bigint(12) NOT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `ss_number` (`ss_number`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `teacher_name`, `teacher_surname`, `ss_number`) VALUES
(1, 'cem ', 'balkan', 13368369400),
(2, 'kamuran', 'akkor', 11368335700);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(200) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Tablo döküm verisi `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_email`) VALUES
(1, 'yunus ekiz', 'ynsekiz@gmail.com'),
(2, 'cagri yeni', 'cagri.yeni@gmail.com'),
(3, 'osman nuri', 'goldenpoisonfrog@gmail.com');

-- --------------------------------------------------------

--
-- Görünüm yapısı `msg_view_by_receiver_id`
--
DROP TABLE IF EXISTS `msg_view_by_receiver_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `msg_view_by_receiver_id` AS select `message`.`message_id` AS `message_id`,`message`.`receiver_id` AS `receiver_id`,`message`.`message_content` AS `message_content` from (`user` join `message`) where (`message`.`receiver_id` = `user`.`user_id`);

-- --------------------------------------------------------

--
-- Görünüm yapısı `msg_view_by_sender_id`
--
DROP TABLE IF EXISTS `msg_view_by_sender_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `msg_view_by_sender_id` AS select `message`.`message_id` AS `message_id`,`message`.`sender_id` AS `sender_id`,`message`.`message_content` AS `message_content` from (`user` join `message`) where (`message`.`sender_id` = `user`.`user_id`);

-- --------------------------------------------------------

--
-- Görünüm yapısı `ssn_view_by_teacher`
--
DROP TABLE IF EXISTS `ssn_view_by_teacher`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ssn_view_by_teacher` AS select `teacher`.`teacher_id` AS `teacher_id`,`teacher`.`ss_number` AS `ss_number` from `teacher`;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

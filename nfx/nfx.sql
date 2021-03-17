/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `nfx` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `nfx`;

CREATE TABLE IF NOT EXISTS `users` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(150) NOT NULL,
  `whitelisted` int(2) DEFAULT 0,
  `banned` int(20) DEFAULT 0,
  `first_login` varchar(50) DEFAULT NULL,
  `last_login` varchar(50) DEFAULT NULL,
  `ipv4` varchar(50) DEFAULT NULL,
  `access` varchar(50) DEFAULT 'citizen',
  PRIMARY KEY (`player_id`,`license`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `users_data` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `registration` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `money` text DEFAULT NULL,
  `position` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `groups` text DEFAULT NULL,
  `inventory` text DEFAULT NULL,
  `clothes` text DEFAULT NULL,
  `weapons` text DEFAULT NULL,
  `userdata` mediumtext DEFAULT NULL,
  PRIMARY KEY (`player_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

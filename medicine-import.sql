-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 15, 2017 at 02:56 AM
-- Server version: 5.7.19-log
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medicine`
--
CREATE DATABASE IF NOT EXISTS `medicine` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `medicine`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCart` (IN `oid` INT, IN `M_id_x` INT, IN `q` INT)  BEGIN
	START TRANSACTION;
	IF (EXISTS(SELECT * FROM `order_medicine` WHERE O_ID = oid AND M_ID = M_id_x)) THEN
		UPDATE `order_medicine` SET quantity = q WHERE O_ID = oid AND M_ID = M_id_x;
	ELSE 
		INSERT INTO `order_medicine` VALUES (oid, M_id_x, q);
	END IF;
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delCart` (IN `oid` INT, IN `M_id_x` INT, IN `q` INT)  BEGIN
	START TRANSACTION;
	DELETE FROM `order_medicine` WHERE O_ID = oid AND M_ID = M_id_x;
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_User_OrderId` (IN `User_Id` INT(11), OUT `o_id` INT)  BEGIN
	DECLARE Oid INT;
    INSERT INTO `order` (T_ID) VALUES ('0');
    SET @Oid := (SELECT `O_ID` FROM `order` ORDER BY O_ID DESC LIMIT 1);
    SET @Oid := (SELECT `O_ID` FROM `order` ORDER BY O_ID DESC LIMIT 1);
    if (!(Oid)) then
    UPDATE `order` SET T_ID = Oid WHERE T_ID = 0;
    end if;
    SET o_id = Oid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_User_OrderId` ()  BEGIN
	START TRANSACTION;
    INSERT INTO `order` (T_ID) VALUES ('0');
	UPDATE `order` SET `T_ID` = get_User_OrderId() WHERE `T_ID` = '0';
    COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_insert` (IN `oid` INT, IN `uid` INT)  BEGIN
	START TRANSACTION;
		INSERT INTO `order_user` (O_ID, U_ID, transaction_id) VALUES (oid, uid, oid);
	COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_User_OrderId` () RETURNS INT(11) BEGIN
	DECLARE oid INT;
    SET oid = (SELECT O_ID FROM `order` ORDER BY `O_ID` DESC LIMIT 1);
    RETURN oid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `C_ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `PIN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`C_ID`, `Name`, `PIN`) VALUES
(1, 'Phzfer', 700100),
(2, 'Ranbaxy', 450405),
(3, 'Mankind', 100100),
(4, 'GlaxoSmithKline', 394270),
(5, 'Novartis', 700745),
(6, 'Alkem', 700745),
(7, 'Johnson&Johnson', 100100);

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `C_ID` int(11) NOT NULL,
  `cname` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `components`
--

INSERT INTO `components` (`C_ID`, `cname`) VALUES
(1, 'Paracetamol'),
(2, 'Oxymetazoline'),
(3, 'Pantaprazole'),
(4, 'Domperidone'),
(5, 'Rantidine'),
(6, 'Fluticasone Furoate'),
(7, 'Methyl Salicylate'),
(8, 'Menthol'),
(9, 'Ketokonazole'),
(10, 'Sodium Benzoate');

-- --------------------------------------------------------

--
-- Table structure for table `composition`
--

CREATE TABLE `composition` (
  `M_ID` int(11) NOT NULL,
  `C_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `composition`
--

INSERT INTO `composition` (`M_ID`, `C_ID`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 7),
(8, 8),
(9, 8),
(10, 9),
(3, 10),
(4, 10),
(7, 10);

-- --------------------------------------------------------

--
-- Table structure for table `contraindication`
--

CREATE TABLE `contraindication` (
  `C_ID1` int(11) NOT NULL,
  `C_ID2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contraindication`
--

INSERT INTO `contraindication` (`C_ID1`, `C_ID2`) VALUES
(6, 9);

--
-- Triggers `contraindication`
--
DELIMITER $$
CREATE TRIGGER `contraindication_BEFORE_INSERT` BEFORE INSERT ON `contraindication` FOR EACH ROW BEGIN
	IF (NEW.C_ID1 = NEW.C_ID2) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medication cannot contraindicate itself';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `contraindication_BEFORE_UPDATE` BEFORE UPDATE ON `contraindication` FOR EACH ROW BEGIN
	IF (NEW.C_ID1 = NEW.C_ID2) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medication cannot contraindicate itself';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--

CREATE TABLE `manufacturer` (
  `M_ID` int(11) NOT NULL,
  `C_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `manufacturer`
--

INSERT INTO `manufacturer` (`M_ID`, `C_ID`) VALUES
(7, 1),
(8, 2),
(9, 2),
(6, 3),
(1, 4),
(2, 4),
(4, 4),
(3, 5),
(5, 6),
(10, 7);

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `M_ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Dosage` varchar(45) DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Info` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`M_ID`, `Name`, `Dosage`, `Price`, `Info`) VALUES
(1, 'Crocin', '1 Tablet per 4-6 hrs. Max 3 Times a Day', 60, 'Crocin is an Analgesic and Antipyretic Agent that causes relieves pain. It has also shown to reduce fever by blocking pathways to brain that regulates temperature.'),
(2, 'Crocin - Fast Relief', '1 Tablet per 4-6 hrs. Max 3 Times a Day', 70, 'Crocin is an Analgesic and Antipyretic Agent that causes relieves pain. It has also shown to reduce fever by blocking pathways to brain that regulates temperature.'),
(3, 'Otrivin', '1-2 Drops per Nostril', 60.5, 'Otrivin works by constricting the blood vessels and reducing the mucus lining inside the nasal pathway allowing for more airflow.'),
(4, 'Nasivion', '1-2 Drops per Nostril', 50.5, 'Nasivion works by constricting the blood vessels and reducing the mucus lining inside the nasal pathway allowing for more airflow.'),
(5, 'PAN-D', '1 Capsule per Day before Food.', 90, 'PAN-D is a proton pump inhibitor that blocks the secretion of gastric juices relieving the symptoms. Domperidone is also known for reducing vomiting fits.'),
(6, 'Rantac', '1 Tablet before Food. Max twice daily.', 75.83, 'Rantac is a anti-histamine that blocks the secretion of excess gastric juices relieving symptoms.'),
(7, 'Fluticon-FT', '2 Sprays per Nostril twice a day', 120.33, 'Fluticon-FT [LSD]  is a topical Steroid that reduces inflamation of inner lining of nasal passage. '),
(8, 'Volini', 'Spray a thin layer over affected region', 95, 'Volini causes the muscles to relax thus relieving muscle pains.'),
(9, 'Volini - Cream', 'Apply a thin layer over affected region', 100.5, 'Volini causes the muscles to relax thus relieving muscle pains.'),
(10, 'Ketosol-2%', 'Wash Affected Area with solution twice a day.', 150, 'Ketoconazole is used by treating various skin disease like dermatitis and versicolor.');

-- --------------------------------------------------------

--
-- Table structure for table `med_type`
--

CREATE TABLE `med_type` (
  `M_ID` int(11) NOT NULL,
  `type` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `med_type`
--

INSERT INTO `med_type` (`M_ID`, `type`) VALUES
(1, 'Tablet'),
(2, 'Tablet'),
(3, 'Spray'),
(4, 'Spray'),
(5, 'Capsule'),
(6, 'Tablet'),
(7, 'Spray'),
(8, 'Spray'),
(9, 'Cream/Gel'),
(10, 'Cream/Gel');

--
-- Triggers `med_type`
--
DELIMITER $$
CREATE TRIGGER `med_type_BEFORE_INSERT` BEFORE INSERT ON `med_type` FOR EACH ROW BEGIN
	IF ((NEW.type != 'Tablet')AND(NEW.type != 'Capsule')AND
		(NEW.type != 'Syrup')AND(NEW.type != 'Powder') AND
        (NEW.type != 'Spray') AND
        (NEW.type != 'Cream/Gel')) THEN
        SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine Must be of Tablet/Capsule/Syrup/Powder or Cream/Gel only';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `med_type_BEFORE_UPDATE` BEFORE UPDATE ON `med_type` FOR EACH ROW BEGIN
	IF ((NEW.type != 'Tablet')AND(NEW.type != 'Capsule')AND
		(NEW.type != 'Syrup')AND(NEW.type != 'Powder') AND
        (NEW.type != 'Spray') AND
        (NEW.type != 'Cream/Gel')) THEN
        SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine Must be of Tablet/Capsule/Syrup/Powder or Cream/Gel only';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `O_ID` int(11) NOT NULL,
  `T_ID` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(45) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`O_ID`, `T_ID`, `time`, `status`) VALUES
(30, 30, '2017-11-14 15:19:27', 'pending'),
(31, 31, '2017-11-14 15:49:00', 'pending'),
(32, 32, '2017-11-14 15:49:01', 'pending'),
(33, 33, '2017-11-14 15:49:42', 'pending'),
(34, 34, '2017-11-14 15:50:57', 'pending'),
(35, 35, '2017-11-14 15:55:10', 'pending'),
(36, 36, '2017-11-14 15:55:36', 'pending'),
(37, 37, '2017-11-14 15:55:45', 'pending'),
(38, 38, '2017-11-14 16:01:39', 'pending'),
(39, 39, '2017-11-14 18:46:39', 'pending'),
(40, 40, '2017-11-14 18:48:46', 'pending'),
(41, 41, '2017-11-14 19:21:58', 'pending'),
(42, 42, '2017-11-14 19:33:06', 'pending'),
(43, 43, '2017-11-14 19:33:38', 'pending'),
(44, 44, '2017-11-14 19:33:53', 'pending'),
(45, 45, '2017-11-14 19:35:18', 'pending'),
(46, 46, '2017-11-14 19:35:21', 'pending'),
(47, 47, '2017-11-14 19:43:01', 'pending'),
(48, 48, '2017-11-14 19:43:49', 'pending'),
(49, 49, '2017-11-14 19:45:28', 'pending'),
(50, 50, '2017-11-14 19:46:08', 'pending'),
(51, 51, '2017-11-14 19:46:52', 'pending'),
(52, 52, '2017-11-14 19:47:08', 'pending'),
(53, 53, '2017-11-14 19:59:04', 'pending'),
(54, 54, '2017-11-14 20:36:45', 'pending'),
(55, 55, '2017-11-14 20:37:01', 'pending'),
(56, 56, '2017-11-14 20:37:36', 'pending'),
(57, 57, '2017-11-14 20:38:00', 'pending'),
(58, 58, '2017-11-14 20:38:29', 'pending'),
(59, 59, '2017-11-14 20:38:39', 'pending'),
(60, 60, '2017-11-14 20:39:40', 'pending'),
(61, 61, '2017-11-14 20:39:49', 'pending'),
(62, 62, '2017-11-14 20:41:08', 'pending'),
(63, 63, '2017-11-14 20:41:52', 'pending'),
(64, 64, '2017-11-14 21:24:13', 'pending');

--
-- Triggers `order`
--
DELIMITER $$
CREATE TRIGGER `order_BEFORE_INSERT` BEFORE INSERT ON `order` FOR EACH ROW BEGIN
	IF ((NEW.status != 'Delivered')AND
	   (NEW.status != 'Pending') AND
       (NEW.status != 'Cancelled')) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status!';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `order_BEFORE_UPDATE` BEFORE UPDATE ON `order` FOR EACH ROW BEGIN
	IF ((NEW.status != 'Delivered')AND
	   (NEW.status != 'Pending') AND
       (NEW.status != 'Cancelled')) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status!';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_company`
--

CREATE TABLE `order_company` (
  `M_ID` int(11) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `order_company`
--
DELIMITER $$
CREATE TRIGGER `order_company_BEFORE_INSERT` BEFORE INSERT ON `order_company` FOR EACH ROW BEGIN
	IF (NEW.status != 'Pending')AND
	   (NEW.status != 'Delivered') THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status';
	END IF;
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity should be greater than 0';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `order_company_BEFORE_UPDATE` BEFORE UPDATE ON `order_company` FOR EACH ROW BEGIN
	IF (NEW.status != 'Pending')AND
	   (NEW.status != 'Delivered') THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_medicine`
--

CREATE TABLE `order_medicine` (
  `O_ID` int(11) NOT NULL,
  `M_ID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_medicine`
--

INSERT INTO `order_medicine` (`O_ID`, `M_ID`, `quantity`) VALUES
(30, 2, 4),
(30, 6, 1),
(30, 7, 5),
(35, 9, 1),
(36, 9, 1),
(38, 1, 1),
(38, 4, 1),
(38, 8, 1),
(38, 9, 1),
(39, 1, 1),
(39, 7, 5),
(39, 10, 1),
(40, 1, 1),
(40, 4, 4),
(40, 7, 3),
(41, 1, 1),
(41, 3, 1),
(41, 4, 1),
(43, 8, 1),
(44, 1, 1),
(44, 5, 1),
(48, 6, 1),
(48, 8, 1),
(51, 4, 1),
(51, 7, 1),
(54, 6, 1),
(54, 8, 1),
(56, 3, 4),
(56, 8, 1),
(57, 3, 4),
(57, 7, 1),
(58, 1, 1),
(58, 3, 1),
(58, 5, 1),
(58, 9, 1),
(59, 8, 5),
(61, 5, 4),
(62, 1, 1),
(62, 4, 5),
(62, 6, 4),
(62, 8, 1),
(64, 1, 1),
(64, 3, 3),
(64, 6, 1),
(64, 7, 4);

--
-- Triggers `order_medicine`
--
DELIMITER $$
CREATE TRIGGER `order_medicine_BEFORE_INSERT` BEFORE INSERT ON `order_medicine` FOR EACH ROW BEGIN
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity must be Greater than 0';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `order_medicine_BEFORE_UPDATE` BEFORE UPDATE ON `order_medicine` FOR EACH ROW BEGIN
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity must be Greater than 0';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_user`
--

CREATE TABLE `order_user` (
  `O_ID` int(11) NOT NULL,
  `U_ID` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `time_transact` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mode_pay` varchar(45) NOT NULL DEFAULT 'Online Banking'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_user`
--

INSERT INTO `order_user` (`O_ID`, `U_ID`, `transaction_id`, `time_transact`, `mode_pay`) VALUES
(47, 1, 47, '2017-11-14 19:43:01', 'Online Banking'),
(48, 1, 48, '2017-11-14 19:43:49', 'Online Banking'),
(49, 1, 49, '2017-11-14 19:45:28', 'Online Banking'),
(56, 1, 56, '2017-11-14 20:37:36', 'Online Banking'),
(57, 1, 57, '2017-11-14 20:38:00', 'Online Banking'),
(58, 1, 58, '2017-11-14 20:38:29', 'Online Banking'),
(59, 1, 59, '2017-11-14 20:38:39', 'Online Banking'),
(60, 1, 60, '2017-11-14 20:39:40', 'Online Banking'),
(61, 1, 61, '2017-11-14 20:39:49', 'Online Banking'),
(62, 1, 62, '2017-11-14 20:41:08', 'Online Banking'),
(63, 1, 63, '2017-11-14 20:41:52', 'Online Banking'),
(64, 1, 64, '2017-11-14 21:24:14', 'Online Banking'),
(51, 7, 51, '2017-11-14 19:46:52', 'Online Banking'),
(52, 7, 52, '2017-11-14 19:47:08', 'Online Banking'),
(53, 8, 53, '2017-11-14 19:59:04', 'Online Banking'),
(54, 8, 54, '2017-11-14 20:36:46', 'Online Banking'),
(55, 8, 55, '2017-11-14 20:37:01', 'Online Banking');

--
-- Triggers `order_user`
--
DELIMITER $$
CREATE TRIGGER `order_user_BEFORE_INSERT` BEFORE INSERT ON `order_user` FOR EACH ROW BEGIN
	IF ((NEW.mode_pay != 'Cash on Delivery') AND (NEW.mode_pay != 'Online Banking')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Mode of Payment!';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pin_address`
--

CREATE TABLE `pin_address` (
  `PIN` int(11) NOT NULL,
  `Area` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pin_address`
--

INSERT INTO `pin_address` (`PIN`, `Area`, `City`, `State`, `Country`) VALUES
(100100, 'New Found', 'DreamCity', 'North', 'Inda'),
(394270, 'Hazira', 'Surat', 'Gujarat', 'India'),
(450405, 'Simrol', 'Indore', 'Madhya Pradesh', 'India'),
(700100, 'Green Avenue', 'Kolkata', 'West Bengal', 'India'),
(700745, 'Patia', 'Bhubaneswar', 'Odisha', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `side_effects`
--

CREATE TABLE `side_effects` (
  `M_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `side_effects`
--

INSERT INTO `side_effects` (`M_ID`, `S_ID`) VALUES
(1, 3),
(2, 3),
(3, 5),
(4, 5),
(3, 6),
(4, 6),
(5, 12),
(7, 15),
(10, 15),
(7, 16);

--
-- Triggers `side_effects`
--
DELIMITER $$
CREATE TRIGGER `side_effects_BEFORE_INSERT` BEFORE INSERT ON `side_effects` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT * FROM treats t WHERE (t.M_ID=NEW.M_ID) AND (t.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `side_effects_BEFORE_UPDATE` BEFORE UPDATE ON `side_effects` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT * FROM treats t WHERE (t.M_ID=NEW.M_ID) AND (t.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `M_ID` int(11) NOT NULL,
  `W_ID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `expdate` date NOT NULL,
  `mandate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`M_ID`, `W_ID`, `quantity`, `expdate`, `mandate`) VALUES
(1, 1, 1000, '2020-10-10', '2017-10-10'),
(2, 1, 1000, '2020-10-10', '2017-10-10'),
(3, 1, 1000, '2020-10-10', '2017-10-10'),
(4, 2, 1000, '2020-10-10', '2017-10-10'),
(5, 2, 1000, '2020-10-10', '2017-10-10'),
(6, 1, 1000, '2020-10-10', '2017-10-10'),
(7, 1, 1000, '2020-10-10', '2017-10-10'),
(8, 2, 1000, '2020-10-10', '2017-10-10'),
(9, 1, 1000, '2020-10-10', '2017-10-10'),
(10, 1, 1000, '2020-10-10', '2017-10-10');

-- --------------------------------------------------------

--
-- Table structure for table `stockreserve`
--

CREATE TABLE `stockreserve` (
  `W_ID` int(11) NOT NULL,
  `city` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stockreserve`
--

INSERT INTO `stockreserve` (`W_ID`, `city`) VALUES
(1, 'Kolkata'),
(2, 'Indore');

-- --------------------------------------------------------

--
-- Table structure for table `symptoms`
--

CREATE TABLE `symptoms` (
  `S_ID` int(11) NOT NULL,
  `sname` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `symptoms`
--

INSERT INTO `symptoms` (`S_ID`, `sname`) VALUES
(1, 'Fever'),
(2, 'Pain Relief'),
(3, 'Liver Damage'),
(4, 'Nasal Constriction'),
(5, 'Dizziness'),
(6, 'Blurred Vision'),
(7, 'Gastroenteritis'),
(8, 'Acidity'),
(9, 'Heartburn'),
(10, 'Nausea'),
(11, 'Vomiting'),
(12, 'Dry Mouth'),
(13, 'Nasal Rhinitis'),
(14, 'Pollen Allergy'),
(15, 'Increased Ketokonazole Concentration'),
(16, 'Increased Adrenaline bioavailability'),
(17, 'BackPain'),
(18, 'Sprain'),
(19, 'Muscle Pain'),
(20, 'Dermatitis'),
(21, 'Versicolor');

-- --------------------------------------------------------

--
-- Table structure for table `treats`
--

CREATE TABLE `treats` (
  `M_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `treats`
--

INSERT INTO `treats` (`M_ID`, `S_ID`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2),
(3, 4),
(4, 4),
(5, 7),
(5, 8),
(6, 8),
(5, 9),
(6, 9),
(5, 10),
(5, 11),
(7, 13),
(7, 14),
(8, 17),
(9, 17),
(8, 18),
(9, 18),
(8, 19),
(9, 19),
(10, 20),
(10, 21);

--
-- Triggers `treats`
--
DELIMITER $$
CREATE TRIGGER `treats_BEFORE_INSERT` BEFORE INSERT ON `treats` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT * FROM side_effects s WHERE (s.M_ID=NEW.M_ID) AND (s.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `treats_BEFORE_UPDATE` BEFORE UPDATE ON `treats` FOR EACH ROW BEGIN
	IF (EXISTS(SELECT * FROM side_effects s WHERE (s.M_ID=NEW.M_ID) AND (s.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `U_ID` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `phone_no` int(15) NOT NULL,
  `DOB` date NOT NULL,
  `type` varchar(45) NOT NULL DEFAULT 'normal',
  `gender` varchar(45) DEFAULT NULL,
  `PIN` int(11) NOT NULL,
  `house_no` varchar(45) NOT NULL,
  `walletamt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`U_ID`, `email`, `password`, `first_name`, `last_name`, `phone_no`, `DOB`, `type`, `gender`, `PIN`, `house_no`, `walletamt`) VALUES
(1, 'goku@gmail.com', '7815696ecbf1c96e6894b779456d330e', 'Recoder', 'Super', 7134, '1998-10-13', 'Admin', 'M', 100100, 'C2-13', 90892),
(7, 'sghoshjr@gmail.com', '202cb962ac59075b964b07152d234b70', 'Saptarshi', 'Ghosh', 1234, '1998-10-13', 'normal', 'O', 700745, 'D616 Falcon Residency', 0),
(8, 'alex@gmail.com', '534b44a19bf18d20b71ecc4eb77c572f', 'Alex', 'John', 1002, '1997-10-10', 'reseller', 'O', 700100, '23 Baker Street', 0);

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `user_BEFORE_INSERT` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
	IF (timestampdiff(year, NEW.DOB, curdate()) < '13' ) THEN
		Signal sqlstate '45000' set message_text='You Must be Over 13 Years of Age!';
	END IF;
    IF (NEW.walletamt < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Wallet Amount cannot be less than 0';
	END IF;
    IF ((NEW.type != 'normal')AND(NEW.type != 'reseller')AND(NEW.type != 'admin')AND(NEW.type != 'dbm')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid User Type';
	END IF;
    IF ((NEW.gender != 'M')AND(NEW.gender != 'F')AND(NEW.gender != 'O')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Gender';
	END IF;
    IF (NEW.email NOT LIKE '%@%.com') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Email';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_BEFORE_UPDATE` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
    IF (NEW.walletamt < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Wallet Amount cannot be less than 0';
	END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `Name_UNIQUE` (`Name`),
  ADD UNIQUE KEY `C_ID_UNIQUE` (`C_ID`),
  ADD KEY `checkPIN_idx` (`PIN`);

--
-- Indexes for table `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `C_ID_UNIQUE` (`C_ID`);

--
-- Indexes for table `composition`
--
ALTER TABLE `composition`
  ADD PRIMARY KEY (`M_ID`,`C_ID`),
  ADD KEY `Check CID_idx` (`C_ID`);

--
-- Indexes for table `contraindication`
--
ALTER TABLE `contraindication`
  ADD PRIMARY KEY (`C_ID1`,`C_ID2`);

--
-- Indexes for table `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD PRIMARY KEY (`M_ID`,`C_ID`),
  ADD KEY `checkCID2_idx` (`C_ID`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`M_ID`),
  ADD UNIQUE KEY `M_ID_UNIQUE` (`M_ID`);

--
-- Indexes for table `med_type`
--
ALTER TABLE `med_type`
  ADD PRIMARY KEY (`M_ID`,`type`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`O_ID`),
  ADD UNIQUE KEY `O_ID_UNIQUE` (`O_ID`),
  ADD UNIQUE KEY `T_ID_UNIQUE` (`T_ID`);

--
-- Indexes for table `order_company`
--
ALTER TABLE `order_company`
  ADD PRIMARY KEY (`M_ID`);

--
-- Indexes for table `order_medicine`
--
ALTER TABLE `order_medicine`
  ADD PRIMARY KEY (`O_ID`,`M_ID`),
  ADD KEY `checkMID6_idx` (`M_ID`);

--
-- Indexes for table `order_user`
--
ALTER TABLE `order_user`
  ADD PRIMARY KEY (`U_ID`,`O_ID`),
  ADD UNIQUE KEY `O_ID_UNIQUE` (`O_ID`),
  ADD UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`);

--
-- Indexes for table `pin_address`
--
ALTER TABLE `pin_address`
  ADD PRIMARY KEY (`PIN`),
  ADD UNIQUE KEY `PIN_UNIQUE` (`PIN`);

--
-- Indexes for table `side_effects`
--
ALTER TABLE `side_effects`
  ADD PRIMARY KEY (`M_ID`,`S_ID`),
  ADD KEY `Check SID2_idx` (`S_ID`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`M_ID`,`W_ID`),
  ADD KEY `checkWID1_idx` (`W_ID`);

--
-- Indexes for table `stockreserve`
--
ALTER TABLE `stockreserve`
  ADD PRIMARY KEY (`W_ID`),
  ADD UNIQUE KEY `W_ID_UNIQUE` (`W_ID`);

--
-- Indexes for table `symptoms`
--
ALTER TABLE `symptoms`
  ADD PRIMARY KEY (`S_ID`),
  ADD UNIQUE KEY `S_ID_UNIQUE` (`S_ID`);

--
-- Indexes for table `treats`
--
ALTER TABLE `treats`
  ADD PRIMARY KEY (`M_ID`,`S_ID`),
  ADD KEY `Check SID1_idx` (`S_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`U_ID`),
  ADD UNIQUE KEY `U_ID_UNIQUE` (`U_ID`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `checkPIN2_idx` (`PIN`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `C_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `O_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `symptoms`
--
ALTER TABLE `symptoms`
  MODIFY `S_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `U_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `checkPIN` FOREIGN KEY (`PIN`) REFERENCES `pin_address` (`PIN`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `composition`
--
ALTER TABLE `composition`
  ADD CONSTRAINT `Check CID` FOREIGN KEY (`C_ID`) REFERENCES `components` (`C_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Check MID` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD CONSTRAINT `checkCID2` FOREIGN KEY (`C_ID`) REFERENCES `company` (`C_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `checkMID3` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `med_type`
--
ALTER TABLE `med_type`
  ADD CONSTRAINT `M_ID` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `order_company`
--
ALTER TABLE `order_company`
  ADD CONSTRAINT `checkMID4` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_medicine`
--
ALTER TABLE `order_medicine`
  ADD CONSTRAINT `checkMID6` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `checkOID4` FOREIGN KEY (`O_ID`) REFERENCES `order` (`O_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_user`
--
ALTER TABLE `order_user`
  ADD CONSTRAINT `checkOID` FOREIGN KEY (`O_ID`) REFERENCES `order` (`O_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `checkUID3` FOREIGN KEY (`U_ID`) REFERENCES `user` (`U_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `side_effects`
--
ALTER TABLE `side_effects`
  ADD CONSTRAINT `Check MID2` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Check SID2` FOREIGN KEY (`S_ID`) REFERENCES `symptoms` (`S_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `checkMID5` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `checkWID1` FOREIGN KEY (`W_ID`) REFERENCES `stockreserve` (`W_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `treats`
--
ALTER TABLE `treats`
  ADD CONSTRAINT `Check MID1` FOREIGN KEY (`M_ID`) REFERENCES `medicine` (`M_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Check SID1` FOREIGN KEY (`S_ID`) REFERENCES `symptoms` (`S_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `checkPIN2` FOREIGN KEY (`PIN`) REFERENCES `pin_address` (`PIN`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

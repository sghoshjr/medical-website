-- Medicine Database

CREATE SCHEMA `medicine`;

USE `medicine`;

CREATE TABLE `medicine`.`medicine` (
  `M_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Dosage` VARCHAR(45) NULL,
  `Price` FLOAT NULL,
  PRIMARY KEY (`M_ID`),
  UNIQUE INDEX `M_ID_UNIQUE` (`M_ID` ASC));

CREATE TABLE `medicine`.`med_type` (
  `M_ID` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`M_ID`, `type`),
  CONSTRAINT `M_ID`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`components` (
  `C_ID` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  PRIMARY KEY (`C_ID`),
  UNIQUE INDEX `C_ID_UNIQUE` (`C_ID` ASC));

CREATE TABLE `medicine`.`contraindication` (
	`C_ID1` INT NOT NULL REFERENCES `medicine`.`components`(`C_ID`),
    `C_ID2` INT NOT NULL REFERENCES `medicine`.`components`(`C_ID`)
);

CREATE TABLE `medicine`.`composition` (
  `M_ID` INT NOT NULL,
  `C_ID` INT NOT NULL,
  PRIMARY KEY (`M_ID`, `C_ID`),
  INDEX `Check CID_idx` (`C_ID` ASC),
  CONSTRAINT `Check MID`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Check CID`
    FOREIGN KEY (`C_ID`)
    REFERENCES `medicine`.`components` (`C_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`symptoms` (
  `S_ID` INT NOT NULL AUTO_INCREMENT,
  `sname` VARCHAR(45) NULL,
  PRIMARY KEY (`S_ID`),
  UNIQUE INDEX `S_ID_UNIQUE` (`S_ID` ASC));

CREATE TABLE `medicine`.`treats` (
  `M_ID` INT NOT NULL,
  `S_ID` INT NOT NULL,
  PRIMARY KEY (`M_ID`, `S_ID`),
  INDEX `Check SID1_idx` (`S_ID` ASC),
  CONSTRAINT `Check MID1`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Check SID1`
    FOREIGN KEY (`S_ID`)
    REFERENCES `medicine`.`symptoms` (`S_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`side_effects` (
  `M_ID` INT NOT NULL,
  `S_ID` INT NOT NULL,
  PRIMARY KEY (`M_ID`, `S_ID`),
  INDEX `Check SID2_idx` (`S_ID` ASC),
  CONSTRAINT `Check MID2`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Check SID2`
    FOREIGN KEY (`S_ID`)
    REFERENCES `medicine`.`symptoms` (`S_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`pin_address` (
  `PIN` INT NOT NULL,
  `Area` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NULL,
  PRIMARY KEY (`PIN`),
  UNIQUE INDEX `PIN_UNIQUE` (`PIN` ASC));
  

CREATE TABLE `medicine`.`company` (
  `C_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `PIN` INT NULL REFERENCES `medicine`.`pin_address`(`PIN`),
  PRIMARY KEY (`C_ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC),
  UNIQUE INDEX `C_ID_UNIQUE` (`C_ID` ASC));

CREATE TABLE `medicine`.`manufacturer` (
  `M_ID` INT NOT NULL,
  `C_ID` INT NOT NULL,
  PRIMARY KEY (`M_ID`, `C_ID`),
  INDEX `checkCID2_idx` (`C_ID` ASC),
  CONSTRAINT `checkMID3`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `checkCID2`
    FOREIGN KEY (`C_ID`)
    REFERENCES `medicine`.`company` (`C_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `medicine`.`order_company` (
  `M_ID` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `payment` INT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`M_ID`),
  CONSTRAINT `checkMID4`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `medicine`.`stockreserve` (
  `W_ID` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  PRIMARY KEY (`W_ID`),
  UNIQUE INDEX `W_ID_UNIQUE` (`W_ID` ASC));

CREATE TABLE `medicine`.`stock` (
  `M_ID` INT NOT NULL,
  `W_ID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `expdate` DATE NOT NULL,
  `mandate` DATE NOT NULL,
  PRIMARY KEY (`M_ID`, `W_ID`),
  INDEX `checkWID1_idx` (`W_ID` ASC),
  CONSTRAINT `checkMID5`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `checkWID1`
    FOREIGN KEY (`W_ID`)
    REFERENCES `medicine`.`stockreserve` (`W_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`user` (
  `U_ID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `DOB` DATE NOT NULL,
  `type` VARCHAR(45) NOT NULL DEFAULT 'normal',
  `gender` VARCHAR(45) NULL,
  `PIN` INT NOT NULL,
  `house_no` VARCHAR(45) NOT NULL,
  `walletamt` INT NOT NULL,
  PRIMARY KEY (`U_ID`),
  UNIQUE INDEX `U_ID_UNIQUE` (`U_ID` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `checkPIN2_idx` (`PIN` ASC),
  CONSTRAINT `checkPIN2`
    FOREIGN KEY (`PIN`)
    REFERENCES `medicine`.`pin_address` (`PIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `medicine`.`order` (
  `O_ID` INT NOT NULL AUTO_INCREMENT,
  `T_ID` INT NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`O_ID`),
  UNIQUE INDEX `O_ID_UNIQUE` (`O_ID` ASC),
  UNIQUE INDEX `T_ID_UNIQUE` (`T_ID` ASC));


CREATE TABLE `medicine`.`order_user` (
  `O_ID` INT NOT NULL,
  `U_ID` INT NOT NULL,
  `transaction_id` INT NOT NULL,
  `time_transact` TIMESTAMP NULL,
  `mode_pay` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`U_ID`, `O_ID`),
  UNIQUE INDEX `U_ID_UNIQUE` (`U_ID` ASC),
  UNIQUE INDEX `O_ID_UNIQUE` (`O_ID` ASC),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC),
  CONSTRAINT `checkOID`
    FOREIGN KEY (`O_ID`)
    REFERENCES `medicine`.`order` (`O_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `checkUID3`
    FOREIGN KEY (`U_ID`)
    REFERENCES `medicine`.`user` (`U_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `medicine`.`order_medicine` (
  `O_ID` INT NOT NULL,
  `M_ID` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`O_ID`, `M_ID`),
  INDEX `checkMID6_idx` (`M_ID` ASC),
  CONSTRAINT `checkMID6`
    FOREIGN KEY (`M_ID`)
    REFERENCES `medicine`.`medicine` (`M_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `checkOID4`
    FOREIGN KEY (`O_ID`)
    REFERENCES `medicine`.`order` (`O_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


ALTER TABLE `medicine`.`contraindication` 
ADD PRIMARY KEY (`C_ID1`, `C_ID2`);

-- ---------------------------------------------------------------
--
--
--  TRIGGERS
--
-- ---------------------------------------------------------------

-- Make sure that medication does not contraindicates itself;
DROP TRIGGER IF EXISTS `medicine`.`contraindication_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`contraindication_BEFORE_INSERT` 
BEFORE INSERT ON `contraindication` 
FOR EACH ROW
BEGIN
	IF (NEW.C_ID1 = NEW.C_ID2) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medication cannot contraindicate itself';
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `medicine`.`contraindication_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`contraindication_BEFORE_UPDATE` BEFORE UPDATE ON `contraindication` FOR EACH ROW
BEGIN
	IF (NEW.C_ID1 = NEW.C_ID2) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medication cannot contraindicate itself';
	END IF;
END$$
DELIMITER ;

-- Make Sure that Medicine don't cause same SideEffect as the Treatment
DROP TRIGGER IF EXISTS `medicine`.`side_effects_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`side_effects_BEFORE_INSERT` BEFORE INSERT ON `side_effects` FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM treats t WHERE (t.M_ID=NEW.M_ID) AND (t.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `medicine`.`side_effects_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`side_effects_BEFORE_UPDATE` BEFORE UPDATE ON `side_effects` FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM treats t WHERE (t.M_ID=NEW.M_ID) AND (t.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `medicine`.`treats_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`treats_BEFORE_INSERT` BEFORE INSERT ON `treats` FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM side_effects s WHERE (s.M_ID=NEW.M_ID) AND (s.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `medicine`.`treats_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`treats_BEFORE_UPDATE` BEFORE UPDATE ON `treats` FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM side_effects s WHERE (s.M_ID=NEW.M_ID) AND (s.S_ID = NEW.S_ID))) THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine cannot cause same Side Effect as the Treatment!';
	END IF;
END$$
DELIMITER ;


-- Check For Type of Medicine
DROP TRIGGER IF EXISTS `medicine`.`med_type_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `medicine`.`med_type_BEFORE_INSERT` BEFORE INSERT ON `med_type` FOR EACH ROW
BEGIN
	IF ((NEW.type != 'Tablet')AND(NEW.type != 'Capsule')AND
		(NEW.type != 'Syrup')AND(NEW.type != 'Powder') AND
        (NEW.type != 'Spray') AND
        (NEW.type != 'Cream/Gel')) THEN
        SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine Must be of Tablet/Capsule/Syrup/Powder or Cream/Gel only';
	END IF;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `medicine`.`med_type_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `medicine`.`med_type_BEFORE_UPDATE` BEFORE UPDATE ON `med_type` FOR EACH ROW
BEGIN
	IF ((NEW.type != 'Tablet')AND(NEW.type != 'Capsule')AND
		(NEW.type != 'Syrup')AND(NEW.type != 'Powder') AND
        (NEW.type != 'Spray') AND
        (NEW.type != 'Cream/Gel')) THEN
        SIGNAL sqlstate '45000' SET MESSAGE_TEXT='Medicine Must be of Tablet/Capsule/Syrup/Powder or Cream/Gel only';
	END IF;
END$$
DELIMITER ;



-- Valid Status only
DROP TRIGGER IF EXISTS `medicine`.`order_company_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_company_BEFORE_INSERT` BEFORE INSERT ON `order_company` FOR EACH ROW
BEGIN
	IF (NEW.status != 'Pending')AND
	   (NEW.status != 'Delivered') THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status';
	END IF;
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity should be greater than 0';
	END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `medicine`.`order_company_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_company_BEFORE_UPDATE` BEFORE UPDATE ON `order_company` FOR EACH ROW
BEGIN
	IF (NEW.status != 'Pending')AND
	   (NEW.status != 'Delivered') THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status';
	END IF;
END$$
DELIMITER ;

-- User Integrity

DROP TRIGGER IF EXISTS `medicine`.`user_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `medicine`.`user_BEFORE_INSERT` BEFORE INSERT ON `user` FOR EACH ROW
BEGIN
	IF (timestampdiff(year, NEW.DOB, curdate()) < '13' ) THEN
		Signal sqlstate '45000' set message_text='You Must be Over 13 Years of Age!';
	END IF;
    IF (NEW.walletamt < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Wallet Amount cannot be less than 0';
	END IF;
    IF ((NEW.type != 'normal')AND(NEW.type != 'admin')AND(NEW.type != 'dbm')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid User Type';
	END IF;
    IF ((NEW.gender != 'M')AND(NEW.gender != 'F')AND(NEW.gender != 'O')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Gender';
	END IF;
    IF (NEW.email NOT LIKE '_%@_%.com') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Email';
	END IF;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `medicine`.`user_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`user_BEFORE_UPDATE` BEFORE UPDATE ON `user` FOR EACH ROW
BEGIN
    IF (NEW.walletamt < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Wallet Amount cannot be less than 0';
	END IF;
END$$
DELIMITER ;


-- Order - User Check Mode of Payment
DROP TRIGGER IF EXISTS `medicine`.`order_user_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_user_BEFORE_INSERT` BEFORE INSERT ON `order_user` FOR EACH ROW
BEGIN
	IF ((NEW.mode_pay != 'Cash on Delivery') AND (NEW.mode_pay != 'Online Banking')) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Mode of Payment!';
	END IF;
END$$
DELIMITER ;


-- Order Check Status
DROP TRIGGER IF EXISTS `medicine`.`order_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_BEFORE_INSERT` BEFORE INSERT ON `order` FOR EACH ROW
BEGIN
	IF ((NEW.status != 'Delivered')AND
	   (NEW.status != 'Pending') AND
       (NEW.status != 'Cancelled')) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status!';
	END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `medicine`.`order_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_BEFORE_UPDATE` BEFORE UPDATE ON `order` FOR EACH ROW
BEGIN
	IF ((NEW.status != 'Delivered')AND
	   (NEW.status != 'Pending') AND
       (NEW.status != 'Cancelled')) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid Status!';
	END IF;
END$$
DELIMITER ;


-- Order Medicine : Quantity cannot be negative
DROP TRIGGER IF EXISTS `medicine`.`order_medicine_BEFORE_INSERT`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_medicine_BEFORE_INSERT` BEFORE INSERT ON `order_medicine` FOR EACH ROW
BEGIN
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity must be Greater than 0';
	END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `medicine`.`order_medicine_BEFORE_UPDATE`;

DELIMITER $$
USE `medicine`$$
CREATE DEFINER = CURRENT_USER TRIGGER `medicine`.`order_medicine_BEFORE_UPDATE` BEFORE UPDATE ON `order_medicine` FOR EACH ROW
BEGIN
	IF (NEW.quantity <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantity must be Greater than 0';
	END IF;
END$$
DELIMITER ;

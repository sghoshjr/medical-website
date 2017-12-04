-- Create Table Product
CREATE TABLE `supermarket`.`product` (
  `p_id` INT NOT NULL,
  `pname` VARCHAR(45) NULL,
  PRIMARY KEY (`p_id`),
  UNIQUE INDEX `p_id_UNIQUE` (`p_id` ASC));
ALTER TABLE `supermarket`.`product` 
ADD COLUMN `price` FLOAT NULL AFTER `pname`;


INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('1', 'Shampoo');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('2', 'Soap');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('3', 'Biscuits');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('4', 'Powder');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('5', 'Utensils');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('6', 'Hardware');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('7', 'Guitar');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('8', 'Bulbs');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('9', 'TV');
INSERT INTO `supermarket`.`product` (`p_id`, `pname`) VALUES ('10', 'PC');
UPDATE `supermarket`.`product` SET `price`='100' WHERE `p_id`='1';
UPDATE `supermarket`.`product` SET `price`='50' WHERE `p_id`='2';
UPDATE `supermarket`.`product` SET `price`='60' WHERE `p_id`='3';
UPDATE `supermarket`.`product` SET `price`='70' WHERE `p_id`='4';
UPDATE `supermarket`.`product` SET `price`='200' WHERE `p_id`='5';
UPDATE `supermarket`.`product` SET `price`='140' WHERE `p_id`='6';
UPDATE `supermarket`.`product` SET `price`='200' WHERE `p_id`='7';
UPDATE `supermarket`.`product` SET `price`='10' WHERE `p_id`='8';
UPDATE `supermarket`.`product` SET `price`='500' WHERE `p_id`='9';
UPDATE `supermarket`.`product` SET `price`='600' WHERE `p_id`='10';


CREATE TABLE `supermarket`.`customer` (
  `cid` INT NOT NULL,
  `cname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `cid_UNIQUE` (`cid` ASC));


INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('1', 'John');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('2', 'George');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('3', 'Saptarshi');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('4', 'Fenwick');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('5', 'Alex');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('6', 'Maria');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('7', 'Jeremy');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('8', 'Lelouch');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('9', 'Issei');
INSERT INTO `supermarket`.`customer` (`cid`, `cname`) VALUES ('10', 'Sakura');


CREATE TABLE `supermarket`.`sales` (
  `idsales` INT NOT NULL,
  `cid` INT NULL,
  `timestamp` DATE NULL,
  PRIMARY KEY (`idsales`));
  
  ALTER TABLE `supermarket`.`sales` 
ADD COLUMN `price` FLOAT NULL AFTER `timestamp`;


CREATE TABLE `supermarket`.`sale_product` (
  `idsale` INT NOT NULL,
  `p_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`idsale`, `p_id`));
  
INSERT INTO `supermarket`.`sale_product` (`idsale`, `p_id`, `quantity`) VALUES ('1', '1', '10');
INSERT INTO `supermarket`.`sale_product` (`idsale`, `p_id`, `quantity`) VALUES ('1', '2', '5');
INSERT INTO `supermarket`.`sale_product` (`idsale`, `p_id`, `quantity`) VALUES ('1', '3', '2');
INSERT INTO `supermarket`.`sale_product` (`idsale`, `p_id`, `quantity`) VALUES ('1', '5', '5');

DROP TRIGGER IF EXISTS `supermarket`.`sales_BEFORE_INSERT`;

DELIMITER $$
USE `supermarket`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `supermarket`.`sales_BEFORE_INSERT` BEFORE INSERT ON `sales` FOR EACH ROW
BEGIN
	DECLARE done INT default 0;
    DECLARE s1 FLOAT;
    DECLARE q2 INT;
    DECLARE sprice FLOAT;
    DECLARE cq INT;
    DECLARE cp FLOAT;

	DECLARE dcur CURSOR FOR 
    SELECT sp.quantity, p.price FROM sale_product sp, product p 
		WHERE sp.idsale = NEW.idsales AND
			  p.p_id = sp.p_id;
              
    DECLARE continue handler FOR NOT FOUND SET done = 1;
    SET sprice = 0;
    SET flag = 0;
    
    SET s1 = (SELECT sum(price) FROM sales WHERE cid=NEW.cid AND `timestamp` >= (date_sub(now(), interval 1 month)) );
    SET q2 = (SELECT MAX(quantity) FROM sale_product sp WHERE sp.idsale = NEW.idsales);
    
	open dcur;
    repeat
		fetch dcur INTO cq, cp;
        SET sprice = sprice + (cq*cp);
	until done
    end repeat;
    close dcur;
    
    SET NEW.price = sprice;
    
	SET NEW.discount = 0;
    
    IF (s1 >= 500) THEN
		SET NEW.discount = 100; #100 Rs. Discount;
    ELSEIF (q2 >= 5) THEN
		SET NEW.discount = 50; #50 Rs. Discount;
	END IF;
    
    SET sprice = sprice - NEW.discount;
    SET New.price = sprice;
END$$
DELIMITER ;




ALTER TABLE `supermarket`.`sales` 
ADD COLUMN `discount` FLOAT NULL AFTER `price`;




#
# SQL Queries
#

#1 : Identify customer having max no. of items in a month
SELECT cname FROM customer WHERE cid = (
SELECT cid FROM sales s, sale_product sp WHERE 
	s.`timestamp` >= (date_sub(now(), interval 1 month)) AND
    sp.idsale = s.idsales GROUP BY cid ORDER BY SUM(quantity) DESC LIMIT 1);
    

#2 : List All customers who bought item of type 'i' in desc order
SELECT cname FROM customer WHERE cid IN (
SELECT cid FROM sales s, sale_product sp 
	where s.idsales = sp.idsale and 
	p_id = 1 
    GROUP BY cid ORDER BY sum(quantity) DESC);
    
#3 : List Items bought together

SELECT p1.pname AS `Item1`, p2.pname AS `Item2` FROM sale_product sp1, sale_product sp2, product p1, product p2

	where sp1.idsale = sp2.idsale AND
    sp1.p_id = p1.p_id AND
    sp2.p_id = p2.p_id AND
	sp1.p_id <> sp2.p_id AND sp1.p_id < sp2.p_id 
    
    GROUP BY sp1.p_id, sp2.p_id HAVING COUNT(*) >= 1; ##Threshold to 2 counts 

#4 : List Items bought together (Threshold N)

SELECT p1.pname AS `Item1`, p2.pname AS `Item2` FROM sale_product sp1, sale_product sp2, product p1, product p2

	where sp1.idsale = sp2.idsale AND
    sp1.p_id = p1.p_id AND
    sp2.p_id = p2.p_id AND
	sp1.p_id <> sp2.p_id AND sp1.p_id < sp2.p_id 
    
    GROUP BY sp1.p_id, sp2.p_id HAVING COUNT(*) >= 2; ##Threshold to N == 2 counts 
    

#5 : List Customer Eligible for Discount
SELECT cname, SUM(discount) AS `Total Discount` FROM sales, customer c WHERE `timestamp` >= (date_sub(now(), interval 1 month))
	AND  c.cid = sales.cid
	GROUP BY sales.cid HAVING sum(price) >= 500;
    

#6 : Total Discount in Calender Month
SELECT sum(discount) FROM sales WHERE `timestamp` >= (date_sub(now(), interval 1 month));

DROP PROCEDURE IF EXISTS Insert_User_OrderId;
DROP FUNCTION IF EXISTS get_User_OrderId;

delimiter $$
CREATE FUNCTION get_User_OrderId() RETURNS INT
BEGIN
	DECLARE oid INT;
    SET oid = (SELECT O_ID FROM `order` ORDER BY `O_ID` DESC LIMIT 1);
    RETURN oid;
END $$
delimiter ;


delimiter $$
CREATE PROCEDURE Insert_User_OrderId()
BEGIN
	START TRANSACTION;
    INSERT INTO `order` (T_ID) VALUES ('0');
	UPDATE `order` SET `T_ID` = get_User_OrderId() WHERE `T_ID` = '0';
    COMMIT;
END $$
delimiter ;

CALL Insert_User_OrderId();

DROP PROCEDURE IF EXISTS order_insert;

delimiter $$
CREATE PROCEDURE order_insert(IN oid INT, IN uid INT) 
BEGIN
	START TRANSACTION;
		INSERT INTO `order_user` (O_ID, U_ID, transaction_id) VALUES (oid, uid, oid);
	COMMIT;
END $$
delimiter ;


DROP PROCEDURE IF EXISTS addCart;
DROP PROCEDURE IF EXISTS delCart;

delimiter $$
CREATE PROCEDURE addCart(IN oid INT, IN M_id_x INT, IN q INT) 
BEGIN
	START TRANSACTION;
	IF (EXISTS(SELECT * FROM `order_medicine` WHERE O_ID = oid AND M_ID = M_id_x)) THEN
		UPDATE `order_medicine` SET quantity = q WHERE O_ID = oid AND M_ID = M_id_x;
	ELSE 
		INSERT INTO `order_medicine` VALUES (oid, M_id_x, q);
	END IF;
	COMMIT;
END $$
delimiter ;

delimiter $$
CREATE PROCEDURE delCart(IN oid INT, IN M_id_x INT, IN q INT) 
BEGIN
	START TRANSACTION;
	DELETE FROM `order_medicine` WHERE O_ID = oid AND M_ID = M_id_x;
	COMMIT;
END $$
delimiter ;


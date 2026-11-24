USE canteen_db;

-- task 2
DROP PROCEDURE IF EXISTS show_item_status;
DELIMITER $$

CREATE PROCEDURE show_item_status(IN p_item_id INT)
BEGIN
    DECLARE v_stock INT;
    SELECT stock INTO v_stock FROM menu_items WHERE item_id = p_item_id;
    IF v_stock = 0 THEN
        SELECT 'Out of stock' AS status;
    ELSEIF v_stock < 20 THEN
        SELECT 'Low stock' AS status;
    ELSE
        SELECT 'In stock' AS status;
    END IF;
END $$

DELIMITER ;

UPDATE menu_items SET stock = 0 WHERE item_id = 1;
UPDATE menu_items SET stock = 10 WHERE item_id = 2;
UPDATE menu_items SET stock = 50 WHERE item_id = 3;

CALL show_item_status(1);
CALL show_item_status(2);
CALL show_item_status(3);

-- task 3
DROP PROCEDURE IF EXISTS restock_all;
DELIMITER $$

CREATE PROCEDURE restock_all(IN p_amount INT)
BEGIN
    DECLARE v_counter INT DEFAULT 1;
    WHILE v_counter <= 6 DO
        UPDATE menu_items SET stock = stock + p_amount WHERE item_id = v_counter;
        SET v_counter = v_counter + 1;
    END WHILE;
END $$

DELIMITER ;

CALL restock_all(25);
SELECT * FROM menu_items;

-- task 4
DROP PROCEDURE IF EXISTS inventory_value;
DELIMITER $$

CREATE PROCEDURE inventory_value(OUT p_total DECIMAL(10,2))
BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_price DECIMAL(6,2);
    DECLARE v_stock INT;
    DECLARE v_sum DECIMAL(10,2) DEFAULT 0;
    DECLARE item_cursor CURSOR FOR SELECT price, stock FROM menu_items;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;
    OPEN item_cursor;
    item_loop: LOOP
        FETCH item_cursor INTO v_price, v_stock;
        IF v_done = 1 THEN
            LEAVE item_loop;
        END IF;
        SET v_sum = v_sum + (v_price * v_stock);
    END LOOP item_loop;
    CLOSE item_cursor;
    SET p_total = v_sum;
END $$

DELIMITER ;

CALL inventory_value(@total);
SELECT @total AS total_value;
SELECT SUM(price * stock) AS total_value FROM menu_items;

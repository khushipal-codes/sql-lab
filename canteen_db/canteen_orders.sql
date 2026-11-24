USE canteen_db;

-- task 1
DROP PROCEDURE IF EXISTS place_order;
DELIMITER $$

CREATE PROCEDURE place_order(IN p_item_id INT, IN p_qty INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Order failed' AS result;
    END;
    START TRANSACTION;
    INSERT INTO orders (item_id, quantity, order_date) VALUES (p_item_id, p_qty, CURDATE());
    UPDATE menu_items SET stock = stock - p_qty WHERE item_id = p_item_id;
    COMMIT;
END $$

DELIMITER ;

CALL place_order(1, 2);
SELECT * FROM menu_items WHERE item_id = 1;
CALL place_order(99, 2);
SELECT * FROM menu_items WHERE item_id = 1;

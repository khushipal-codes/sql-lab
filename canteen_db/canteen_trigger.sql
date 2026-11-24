USE canteen_db;

-- task 3
DROP TRIGGER IF EXISTS trg_reduce_stock;
DELIMITER $$

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE menu_items SET stock = stock - NEW.quantity WHERE item_id = NEW.item_id;
END $$

DELIMITER ;

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
    COMMIT;
END $$

DELIMITER ;

SELECT stock FROM menu_items WHERE item_id = 1;
CALL place_order(1, 3);
SELECT stock FROM menu_items WHERE item_id = 1;

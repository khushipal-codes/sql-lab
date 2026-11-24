USE food_delivery_db;

-- fixed version
DROP PROCEDURE IF EXISTS monthly_summary;
DELIMITER $$

CREATE PROCEDURE monthly_summary(IN p_restaurant_id INT, IN p_month INT)
BEGIN
    DECLARE v_count INT;
    DECLARE v_exists INT;
    IF p_month < 1 OR p_month > 12 THEN
        SELECT 'Invalid month. Please enter a number between 1 and 12' AS message;
    ELSE
        SELECT COUNT(*) INTO v_exists FROM restaurants WHERE restaurant_id = p_restaurant_id;
        IF v_exists = 0 THEN
            SELECT 'Restaurant not found' AS message;
        ELSE
            SELECT COUNT(*) INTO v_count FROM orders WHERE restaurant_id = p_restaurant_id AND MONTH(order_date) = p_month;
            IF v_count = 0 THEN
                SELECT 'No orders found for this restaurant in this month' AS message;
            ELSE
                SELECT restaurant_id, COUNT(*) AS total_orders, SUM(total_amount) AS total_revenue, AVG(total_amount) AS average_order_value
                FROM orders
                WHERE restaurant_id = p_restaurant_id AND MONTH(order_date) = p_month
                GROUP BY restaurant_id;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

CALL monthly_summary(1, 10);
CALL monthly_summary(1, 12);
CALL monthly_summary(99, 10);
CALL monthly_summary(1, 13);

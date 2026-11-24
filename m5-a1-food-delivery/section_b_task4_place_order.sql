CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- task 4
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    wallet_balance DECIMAL(10,2) NOT NULL
);

INSERT INTO customers (name, wallet_balance) VALUES
('Aarav Sharma', 5000.00),
('Priya Nair', 800.00),
('Rohan Mehta', 2500.00);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    customer_name VARCHAR(50),
    total_amount DECIMAL(10,2),
    order_date DATE
);

DROP PROCEDURE IF EXISTS place_order;
DELIMITER $$

CREATE PROCEDURE place_order(IN p_customer_id INT, IN p_restaurant_id INT, IN p_amount DECIMAL(10,2))
BEGIN
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_name VARCHAR(50);
    START TRANSACTION;
    SELECT wallet_balance, name INTO v_balance, v_name FROM customers WHERE customer_id = p_customer_id;
    IF v_balance IS NULL THEN
        ROLLBACK;
        SELECT 'Customer not found' AS result;
    ELSEIF v_balance < p_amount THEN
        ROLLBACK;
        SELECT 'Insufficient balance, order cancelled' AS result;
    ELSE
        UPDATE customers SET wallet_balance = wallet_balance - p_amount WHERE customer_id = p_customer_id;
        INSERT INTO orders (restaurant_id, customer_name, total_amount, order_date) VALUES (p_restaurant_id, v_name, p_amount, CURDATE());
        COMMIT;
        SELECT 'Order placed successfully' AS result;
    END IF;
END $$

DELIMITER ;

CALL place_order(1, 1, 1200.00);
CALL place_order(2, 3, 1500.00);

SELECT * FROM customers;
SELECT * FROM orders ORDER BY order_id DESC LIMIT 3;

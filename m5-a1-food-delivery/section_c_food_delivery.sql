DROP DATABASE IF EXISTS food_delivery_db;
CREATE DATABASE food_delivery_db;
USE food_delivery_db;

-- task 1
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine_type VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    category VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    restaurant_id INT NOT NULL,
    item_id INT,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    restaurant_id INT,
    action VARCHAR(10),
    log_time DATETIME
);

DROP TRIGGER IF EXISTS after_order_insert;
DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_id, restaurant_id, action, log_time) VALUES (NEW.order_id, NEW.restaurant_id, 'INSERT', NOW());
END $$

DELIMITER ;

-- task 2
INSERT INTO restaurants (name, city, cuisine_type) VALUES
('Spice Garden', 'Mumbai', 'North Indian'),
('Burger Hub', 'Delhi', 'Fast Food'),
('Dragon Palace', 'Mumbai', 'Chinese'),
('Dosa Point', 'Bengaluru', 'South Indian'),
('Pizza Corner', 'Delhi', 'Italian');

INSERT INTO menu_items (restaurant_id, item_name, price, category) VALUES
(1, 'Paneer Tikka', 280.00, 'Starter'),
(1, 'Butter Chicken', 350.00, 'Main Course'),
(1, 'Gulab Jamun', 120.00, 'Dessert'),
(2, 'Cheese Burger', 180.00, 'Fast Food'),
(2, 'French Fries', 120.00, 'Fast Food'),
(3, 'Hakka Noodles', 220.00, 'Main Course'),
(3, 'Spring Rolls', 160.00, 'Starter'),
(3, 'Chocolate Brownie', 150.00, 'Dessert'),
(4, 'Masala Dosa', 150.00, 'Main Course'),
(4, 'Filter Coffee', 60.00, 'Beverages'),
(5, 'Margherita Pizza', 300.00, 'Main Course'),
(5, 'Garlic Bread', 140.00, 'Starter');

INSERT INTO orders (customer_name, restaurant_id, item_id, quantity, total_amount, order_date) VALUES
('Aarav Sharma', 1, 2, 2, 700.00, '2026-10-05'),
('Priya Nair', 3, 6, 1, 220.00, '2026-10-07'),
('Rohan Mehta', 2, 4, 3, 540.00, '2026-10-09'),
('Sneha Iyer', 1, 1, 1, 280.00, '2026-10-12'),
('Vikram Rao', 4, 9, 2, 300.00, '2026-10-15'),
('Ananya Gupta', 5, 11, 1, 300.00, '2026-10-18'),
('Karan Patel', 3, 7, 2, 320.00, '2026-10-20'),
('Divya Singh', 2, 5, 2, 240.00, '2026-10-22'),
('Arjun Desai', 1, 3, 4, 480.00, '2026-11-03'),
('Meera Joshi', 4, 10, 2, 120.00, '2026-11-05'),
('Nikhil Shah', 5, 12, 3, 420.00, '2026-11-08'),
('Tara Verma', 3, 8, 2, 300.00, '2026-11-11'),
('Kabir Shah', 1, 2, 1, 350.00, '2026-11-14'),
('Riya Kapoor', 2, 4, 2, 360.00, '2026-11-16'),
('Dev Patel', 5, 11, 2, 600.00, '2026-11-19');

-- task 3
CREATE OR REPLACE VIEW restaurant_sales_summary AS
SELECT r.name AS restaurant_name, COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.total_amount), 0) AS total_revenue
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name;

-- task 4
DROP PROCEDURE IF EXISTS add_order;
DELIMITER $$

CREATE PROCEDURE add_order(IN p_customer_name VARCHAR(50), IN p_restaurant_id INT, IN p_item_id INT, IN p_quantity INT)
BEGIN
    DECLARE v_price DECIMAL(8,2);
    DECLARE v_exists INT;
    DECLARE v_total DECIMAL(10,2);
    START TRANSACTION;
    SELECT COUNT(*) INTO v_exists FROM restaurants WHERE restaurant_id = p_restaurant_id;
    IF v_exists = 0 THEN
        ROLLBACK;
        SELECT 'Restaurant not found, order cancelled' AS result;
    ELSE
        SELECT price INTO v_price FROM menu_items WHERE item_id = p_item_id;
        IF v_price IS NULL THEN
            ROLLBACK;
            SELECT 'Menu item not found, order cancelled' AS result;
        ELSE
            SET v_total = v_price * p_quantity;
            INSERT INTO orders (customer_name, restaurant_id, item_id, quantity, total_amount, order_date) VALUES (p_customer_name, p_restaurant_id, p_item_id, p_quantity, v_total, CURDATE());
            COMMIT;
            SELECT 'Order added successfully' AS result;
        END IF;
    END IF;
END $$

DELIMITER ;

CALL add_order('Test Customer', 2, 4, 2);
CALL add_order('Test Customer', 99, 4, 1);

SELECT * FROM restaurant_sales_summary;
SELECT * FROM orders ORDER BY order_id DESC LIMIT 3;
SELECT * FROM order_audit ORDER BY audit_id DESC LIMIT 5;

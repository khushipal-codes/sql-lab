CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- task 3
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2),
    category VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

INSERT INTO restaurants (name, city) VALUES
('Spice Garden', 'Mumbai'),
('Burger Hub', 'Delhi'),
('Dragon Palace', 'Mumbai'),
('Dosa Point', 'Bengaluru'),
('Pizza Corner', 'Delhi'),
('Green Bowl', 'Pune');

INSERT INTO menu_items (restaurant_id, item_name, price, category) VALUES
(1, 'Butter Chicken', 350.00, 'Main Course'),
(1, 'Paneer Tikka', 280.00, 'Starter'),
(2, 'Cheese Burger', 180.00, 'Fast Food'),
(2, 'French Fries', 120.00, 'Fast Food'),
(3, 'Hakka Noodles', 220.00, 'Main Course'),
(3, 'Manchurian', 240.00, 'Starter'),
(4, 'Masala Dosa', 150.00, 'Main Course'),
(4, 'Idli Sambar', 90.00, 'Breakfast'),
(5, 'Margherita Pizza', 300.00, 'Main Course'),
(5, 'Garlic Bread', 140.00, 'Starter'),
(1, 'Dal Makhani', 320.00, 'Main Course'),
(3, 'Spring Rolls', 160.00, 'Starter');

SELECT r.name AS restaurant_name, m.item_name, m.price
FROM restaurants r
INNER JOIN menu_items m ON r.restaurant_id = m.restaurant_id;

SELECT r.name AS restaurant_name, m.item_name, m.price
FROM restaurants r
LEFT JOIN menu_items m ON r.restaurant_id = m.restaurant_id;

CREATE OR REPLACE VIEW restaurant_menu_summary AS
SELECT r.name AS restaurant_name, COUNT(m.item_id) AS total_items, AVG(m.price) AS average_price
FROM restaurants r
LEFT JOIN menu_items m ON r.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_id, r.name;

SELECT * FROM restaurant_menu_summary;

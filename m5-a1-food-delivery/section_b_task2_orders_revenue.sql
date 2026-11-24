CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- task 2
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    customer_name VARCHAR(50),
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders (restaurant_id, customer_name, total_amount, order_date) VALUES
(1, 'Aarav Sharma', 1800.00, '2026-11-02'),
(3, 'Priya Nair', 2500.00, '2026-11-03'),
(2, 'Rohan Mehta', 900.00, '2026-11-05'),
(1, 'Sneha Iyer', 2200.00, '2026-11-07'),
(4, 'Vikram Rao', 750.00, '2026-11-08'),
(3, 'Ananya Gupta', 1900.00, '2026-11-10'),
(5, 'Karan Patel', 1100.00, '2026-11-11'),
(2, 'Divya Singh', 1200.00, '2026-11-13'),
(1, 'Arjun Desai', 1500.00, '2026-11-15'),
(4, 'Meera Joshi', 850.00, '2026-11-16'),
(3, 'Nikhil Shah', 2100.00, '2026-11-18'),
(5, 'Tara Verma', 950.00, '2026-11-20');

SELECT restaurant_id, SUM(total_amount) AS total_revenue, AVG(total_amount) AS average_order_value, COUNT(*) AS number_of_orders
FROM orders
GROUP BY restaurant_id;

SELECT restaurant_id, SUM(total_amount) AS total_revenue
FROM orders
GROUP BY restaurant_id
HAVING SUM(total_amount) > 5000;

SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

DROP DATABASE IF EXISTS canteen_db;
CREATE DATABASE canteen_db;
USE canteen_db;

-- task 1
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    price DECIMAL(6,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

INSERT INTO menu_items (item_id, item_name, price, stock) VALUES
(1, 'Veg Sandwich', 40.00, 50),
(2, 'Samosa', 15.00, 80),
(3, 'Masala Dosa', 60.00, 30),
(4, 'Tea', 10.00, 100),
(5, 'Cold Drink', 25.00, 60),
(6, 'Burger', 80.00, 20);

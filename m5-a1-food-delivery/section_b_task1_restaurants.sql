DROP DATABASE IF EXISTS foodapp_db;
CREATE DATABASE foodapp_db;
USE foodapp_db;

-- task 1
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine_type VARCHAR(50),
    rating DECIMAL(3,1)
);

INSERT INTO restaurants (name, city, cuisine_type, rating) VALUES
('Spice Garden', 'Mumbai', 'North Indian', 4.5),
('Burger Hub', 'Delhi', 'Fast Food', 4.2),
('Dragon Palace', 'Mumbai', 'Chinese', 4.7),
('Dosa Point', 'Bengaluru', 'South Indian', 4.3),
('Pizza Corner', 'Delhi', 'Italian', 4.0),
('Biryani House', 'Pune', 'North Indian', 4.6),
('Green Bowl', 'Bengaluru', 'Healthy', 3.9);

UPDATE restaurants SET rating = 4.8 WHERE restaurant_id = 3;

DELETE FROM restaurants WHERE restaurant_id = 7;

SELECT * FROM restaurants ORDER BY rating DESC;

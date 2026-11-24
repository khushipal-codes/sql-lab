USE canteen_db;

-- task 2
START TRANSACTION;

INSERT INTO orders (item_id, quantity, order_date) VALUES (2, 3, CURDATE());
INSERT INTO orders (item_id, quantity, order_date) VALUES (3, 1, CURDATE());

SAVEPOINT before_mistake;

INSERT INTO orders (item_id, quantity, order_date) VALUES (4, 500, CURDATE());

ROLLBACK TO before_mistake;

COMMIT;

SELECT * FROM orders;

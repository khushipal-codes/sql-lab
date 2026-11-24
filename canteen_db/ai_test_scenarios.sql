USE canteen_db;

-- scenario 1
-- ChatGPT expected: stock of item 2 drops from 35 to 33
-- MySQL actual: stock of item 2 drops from 35 to 33
INSERT INTO orders (item_id, quantity, order_date) VALUES (2, 2, CURDATE());
SELECT stock FROM menu_items WHERE item_id = 2;

-- scenario 2
-- ChatGPT expected: 'Order failed', no new order row, stock of item 1 stays 20
-- MySQL actual: 'Order failed', no new order row, stock of item 1 stays 20
CALL place_order(99, 5);
SELECT COUNT(*) AS order_count FROM orders;
SELECT stock FROM menu_items WHERE item_id = 1;

-- scenario 3
-- ChatGPT expected: stock of item 3 is 65 inside the transaction, back to 75 after ROLLBACK, no new order row
-- MySQL actual: stock of item 3 is 65 inside the transaction, back to 75 after ROLLBACK, no new order row
START TRANSACTION;
INSERT INTO orders (item_id, quantity, order_date) VALUES (3, 10, CURDATE());
SELECT stock FROM menu_items WHERE item_id = 3;
ROLLBACK;
SELECT stock FROM menu_items WHERE item_id = 3;
SELECT COUNT(*) AS order_count FROM orders;

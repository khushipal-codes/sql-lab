# canteen_db

Canteen database for Sessions 8 and 9.

## Session 8 – canteen_setup.sql
Question: create canteen_db in a new folder canteen_db, with
menu_items (item_id, item_name, price, stock) and orders
(order_id, item_id, quantity, order_date). orders has a foreign
key to menu_items. Insert 6 canteen items.

## Session 8 – canteen_procedures.sql
Question: write three procedures.
- show_item_status: prints Out of stock / Low stock / In stock.
- restock_all: loops from 1 to 6 and adds 25 to each item's stock.
- inventory_value: cursor procedure, sums price x stock.

Inventory total: 13000.00, same from the cursor and from SUM.

## Session 9 – canteen_orders.sql
Question: add a procedure place_order that starts a transaction,
inserts the order, reduces stock and commits. An EXIT HANDLER for
SQLEXCEPTION rolls back and prints 'Order failed'. Test with item 1
qty 2, then unknown item 99.

## Session 9 – canteen_transactions.sql
Question: start a transaction, insert two order lines, set a
SAVEPOINT, insert a mistaken third line of 500 plates, ROLLBACK
TO the savepoint and COMMIT, so exactly two new order lines remain.

## Session 9 – canteen_trigger.sql
Question: create an AFTER INSERT trigger trg_reduce_stock on orders
that subtracts NEW.quantity from that item's stock. Remove the stock
UPDATE from place_order. Test with an order of 3: stock must drop
by exactly 3, not 6.

## Session 9 – ai_test_scenarios.sql
Question: three test scenarios for the trigger and rollback code,
each with a ChatGPT expected comment and a MySQL actual comment.

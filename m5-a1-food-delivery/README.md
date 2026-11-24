# m5-a1-food-delivery

M5-A1 Software Engineering assessment — food delivery database.
Two databases: foodapp_db (Section B) and food_delivery_db
(Section C and D). Run the files in order and take a screenshot
after each task.

## Section A – section_a_answers.md
Question: six short answers on constraints (S1), WHERE in UPDATE
and DELETE (S2), GROUP BY and HAVING (S3), INNER vs LEFT JOIN
(S4), VIEWs (S5), and transactions with COMMIT, ROLLBACK and
SAVEPOINT (S6). No SQL to run.

## Section B Task 1 – section_b_task1_restaurants.sql
Question: create database foodapp_db and a restaurants table
(restaurant_id, name, city, cuisine_type, rating). Insert 7
restaurants across 4 cities, update the rating of one, delete
one with WHERE, then SELECT all sorted by rating descending.

After the run, 6 restaurants remain. Dragon Palace is on top
with rating 4.8.
Screenshot: task1_restaurants.png

## Section B Task 2 – section_b_task2_orders_revenue.sql
Question: create an orders table (order_id, restaurant_id,
customer_name, total_amount, order_date). Insert 12 orders
across 5 restaurants. Show total revenue and average order
value per restaurant, list restaurants with total revenue
above Rs 5,000 using HAVING, and show the 5 most recent
orders with ORDER BY and LIMIT.

HAVING returns 2 restaurants: restaurant 1 (5500.00) and
restaurant 3 (6500.00). Total revenue is 17750.00.
Screenshot: task2_revenue.png

## Section B Task 3 – section_b_task3_joins_view.sql
Question: create restaurants (restaurant_id, name, city) and
menu_items (item_id, restaurant_id, item_name, price, category)
linked by a FOREIGN KEY. Insert 6 restaurants and 12 menu
items; Green Bowl has no items. INNER JOIN lists all items,
LEFT JOIN also shows Green Bowl with NULL item columns.
Create a VIEW restaurant_menu_summary with item count and
average price per restaurant.

INNER JOIN returns 12 rows, LEFT JOIN returns 13 rows.
Green Bowl shows 0 items in the view.
Screenshot: task3_joins_view.png

## Section B Task 4 – section_b_task4_place_order.sql
Question: write a stored procedure place_order that takes
customer_id, restaurant_id and amount, deducts the amount
from the customer's wallet_balance and inserts an order,
all in one transaction. ROLLBACK if the balance is too low,
otherwise COMMIT. Test a valid order and one that exceeds
the balance.

Valid order: Aarav Sharma pays 1200, balance 5000 goes to
3800, order is added. Exceeding order: Priya Nair has 800
and tries to pay 1500, so it rolls back and nothing changes.
Screenshot: task4_valid.png and task4_insufficient.png

## Section C – section_c_food_delivery.sql
Question: one integrated script. Create restaurants, menu_items
and orders with PRIMARY KEY, NOT NULL and FOREIGN KEY
constraints, plus an order_audit table. Insert 5 restaurants,
12 menu items in 5 categories, and 15 orders. Create a VIEW
restaurant_sales_summary. Write a procedure add_order that
calculates total_amount from the menu price, rolls back if
the restaurant does not exist, and inserts the order. Write
a TRIGGER after_order_insert that logs every new order into
order_audit.

After the test calls there are 16 orders and the audit table
has 16 rows. Restaurant totals: Spice Garden 1810.00,
Burger Hub 1500.00, Dragon Palace 840.00, Dosa Point 420.00,
Pizza Corner 1320.00.
Screenshot: capstone_summary.png and capstone_audit.png

## Section D – monthly summary procedure
Question: use AI to write a stored procedure monthly_summary
that takes restaurant_id and a month number and returns total
orders, total revenue and average order value, with a message
instead of an empty result when there are no orders. Then
test it without AI, find a bug, and fix it.

Files: section_d_ai_prompt_and_note.md (prompt and note),
section_d_monthly_summary_ai.sql (AI version),
section_d_monthly_summary_fixed.sql (corrected version).
The fix adds a month check (1-12) and a restaurant-exists
check, because the AI version gave the same "No orders found"
message for a missing restaurant and an invalid month.
Test: (1, 10) gives 2 orders, 980.00 total, 490.00 average.
(1, 12) gives the no-orders message.
Screenshot: section_d_ai.png and section_d_fixed.png

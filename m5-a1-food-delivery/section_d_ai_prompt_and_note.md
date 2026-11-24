# Section D — AI-Augmented Learning

## Step 1 — Prompt given to the AI tool

> Write a MySQL stored procedure named monthly_summary that takes a
> restaurant_id and a month number (1-12) as inputs. It should return
> total orders, total revenue, and average order value for that
> restaurant in that month, from an orders table with columns
> order_id, customer_name, restaurant_id, item_id, quantity,
> total_amount, order_date. If the restaurant has no orders in that
> month, return a meaningful message instead of an empty result.
> Use SELECT with GROUP BY and aggregate functions. The database
> is food_delivery_db.

## Step 2 — Files

- `section_d_monthly_summary_ai.sql` — the AI's original procedure
  and its two test calls.
- `section_d_monthly_summary_fixed.sql` — my corrected version
  and its four test calls.

## Note — what I changed and why

The AI's version gave the same "No orders found" message for three
different problems: a real restaurant with no orders that month, a
restaurant id that does not exist at all, and an invalid month like
13. That message is misleading because the user cannot tell which
one happened. My version checks the month range first (1-12) and
then checks that the restaurant exists, so each case gets its own
clear message, and only a real restaurant with zero orders in a
valid month gets the "No orders found" message.

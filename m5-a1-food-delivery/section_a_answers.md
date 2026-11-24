# Section A — Concept Application

## S1 — Constraints in a food delivery database

Three examples. First, `restaurants.restaurant_id` is the PRIMARY KEY,
so every restaurant has one unique id and no two rows can share it.
Second, `menu_items.restaurant_id` is a FOREIGN KEY pointing to
`restaurants.restaurant_id`, so a menu item can only belong to a
restaurant that really exists. Third, `restaurants.name` and
`menu_items.price` are NOT NULL, because a restaurant without a name
and an item without a price cannot be shown or sold.

Without these constraints, the data breaks quickly. Duplicate
restaurant ids would make orders attach to the wrong restaurant.
Without the foreign key, deleting a restaurant would leave orphan
menu items pointing nowhere, and the app would show items for a
restaurant that no longer exists. NULL names or prices would break
the menu page and the billing total.

## S2 — Why WHERE matters in UPDATE and DELETE

The UPDATE must only touch orders that are both older than 7 days
and still 'Pending', so its WHERE clause needs both conditions.
Without WHERE, the UPDATE would cancel every order in the table,
including orders placed today that customers are waiting for.
The DELETE must only remove 'Unavailable' items of restaurants
that have closed, so it needs a WHERE clause naming that group.
Without WHERE, it would delete every unavailable item, including
items of open restaurants that are only out of stock for a day.

Both mistakes are hard to undo because UPDATE and DELETE change
many rows at once. A safe habit is to run the same condition in
a SELECT first, check the rows it returns, and only then run the
UPDATE or DELETE.

## S3 — Revenue report with GROUP BY and HAVING

Use `SUM(total_amount)` for total revenue, `AVG(total_amount)`
for average order value, and `COUNT(*)` for number of orders,
with `GROUP BY restaurant_id` so each restaurant gets one row.
To keep only restaurants with more than 20 orders this month,
add `HAVING COUNT(*) > 20`.

HAVING must be used here because WHERE cannot filter on
aggregates. WHERE runs before grouping, when the totals do not
exist yet, so `WHERE COUNT(*) > 20` is an error. HAVING runs
after GROUP BY, when each restaurant's total is known, so it
can filter the grouped results. WHERE is still used for the
row-level condition, the current month, and HAVING for the
aggregate condition.

## S4 — INNER JOIN vs LEFT JOIN for order history

INNER JOIN returns only rows that match in both tables. An order
whose restaurant was deleted has no match in `restaurants`, so
INNER JOIN drops that order from the result and the customer
never sees it. LEFT JOIN returns every row from the left table
(`orders`) and fills in the restaurant name where a match exists,
putting NULL in the name column where there is no match.

For the order history page, LEFT JOIN is the right choice,
because the page must show every order, including ones for
restaurants no longer in the table. The missing name shows as
NULL, which the app can display as something like "Restaurant
unavailable", instead of hiding the order completely.

## S5 — Why use a VIEW for top_restaurants

A VIEW gives the front-end team one simple table-like object
with just name, total orders, and average rating, instead of
direct access to the raw tables. It hides internal columns like
ids, keeps the calculation in one place so every page shows the
same numbers, and lets the database team change the underlying
tables without rewriting the front-end queries.

Two limitations: first, a VIEW built on GROUP BY and aggregates
is read-only in practice, so the front-end cannot INSERT or
UPDATE through it and must not expect to. Second, a VIEW has
no indexes of its own and is computed from the base tables each
time it is queried, so on very large data it can be slower than
a real table, and changes to the base tables can break it.

## S6 — Transactions for wallet payment

This inconsistency should have been prevented by a transaction.
Both steps, deducting the wallet balance and inserting the
payment record, must run inside one transaction as a single
unit: either both succeed or neither takes effect.

START TRANSACTION begins the unit. If both steps succeed,
COMMIT saves them permanently. If the payment insert fails,
ROLLBACK undoes the wallet deduction too, so the balance stays
correct. SAVEPOINT marks a point inside the transaction that
you can roll back to, so you can undo only the steps after
that point instead of the whole transaction. Without this,
a failure halfway leaves the database in a state that never
should have existed.

-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================
---Rough work
SELECT *
FROM production.products
SELECT * 
FROM production.categories
-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:
SELECT product_name, list_price, category_name
FROM production.products as p
INNER JOIN production.categories as c
ON p.category_id=c.category_id
order by product_name



-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:
SELECT c.first_name + ' ' +  c.last_name as full_name, o.order_id, o.order_date
FROM sales.customers as c
INNER JOIN sales.orders as o
ON c.customer_id=o.customer_id
order by order_date desc



-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:

SELECT product_name, list_price, category_name, b.brand_id
FROM production.products as p
INNER JOIN production.categories as c
ON p.category_id=c.category_id
INNER JOIN production.brands as b
ON p.brand_id=b.brand_id
order by product_name



-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:

SELECT product_name, order_id, item_id
FROM production.products as p
LEFT JOIN sales.order_items as oi
ON p.product_id=oi.product_id


-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:

SELECT p.product_id, p.product_name
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;



-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
SELECT 
    s.store_name,
    s.store_id,
    o.order_id,
    o.order_date
FROM sales.stores AS s
LEFT JOIN sales.orders AS o
ON s.store_id = o.store_id;



-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:
SELECT e.staff_id                        as emp_staff_id,
       e.first_name + ' ' +  e.last_name as staff_fullname,
         m.staff_id                          AS manager_staff_id,
       m.first_name + ' ' +  m.last_name as manager_fullname
FROM sales.staffs as e
INNER JOIN sales.staffs as m
ON m.manager_id=e.staff_id



-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================
--27

-- Write your query below:
SELECT 
store_name,
brand_name
from sales.stores as s
Cross join production.brands as b




-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:
SELECT first_name +' ' + last_name as full_name,
order_id,
order_date,
product_name,
list_price
FROM sales.customers as c
INNER JOIN sales.orders as o
ON c.customer_id=o.customer_id
INNER JOIN sales.order_items as oi
ON o.order_id=oi.order_id
order by order_date asc,-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================
---Rough work
SELECT *
FROM production.products
SELECT * 
FROM production.categories
-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:
SELECT product_name, list_price, category_name
FROM production.products as p
INNER JOIN production.categories as c
ON p.category_id=c.category_id
order by product_name



-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:
SELECT c.first_name + ' ' +  c.last_name as full_name, o.order_id, o.order_date
FROM sales.customers as c
INNER JOIN sales.orders as o
ON c.customer_id=o.customer_id
order by order_date desc



-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:

SELECT product_name, list_price, category_name, b.brand_id
FROM production.products as p
INNER JOIN production.categories as c
ON p.category_id=c.category_id
INNER JOIN production.brands as b
ON p.brand_id=b.brand_id
order by product_name



-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:

SELECT product_name, order_id, item_id
FROM production.products as p
LEFT JOIN sales.order_items as oi
ON p.product_id=oi.product_id


-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:

SELECT p.product_id, p.product_name
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;



-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
SELECT 
    s.store_name,
    s.store_id,
    o.order_id,
    o.order_date
FROM sales.stores AS s
LEFT JOIN sales.orders AS o
ON s.store_id = o.store_id;



-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:
SELECT e.staff_id                        as emp_staff_id,
       e.first_name + ' ' +  e.last_name as staff_fullname,
         m.staff_id                          AS manager_staff_id,
       m.first_name + ' ' +  m.last_name as manager_fullname
FROM sales.staffs as e
INNER JOIN sales.staffs as m
ON m.manager_id=e.staff_id



-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================
--27

-- Write your query below:
SELECT 
store_name,
brand_name
from sales.stores as s
Cross join production.brands as b




-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:
SELECT first_name +' ' + last_name as full_name,
order_id,
order_date,
product_name,
list_price
FROM sales.customers as c
INNER JOIN sales.orders as o
ON c.customer_id=o.customer_id
INNER JOIN sales.order_items as oi
ON o.order_id=oi.order_id
order by order_date asc,
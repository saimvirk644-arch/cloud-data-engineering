-- ============================================================
-- ASSIGNMENT 04 SOLUTION
-- BikeStores Database
-- ============================================================

-- ============================================================
-- Q1. Unified Contact List (Customers + Staff)
-- ============================================================

SELECT
first_name + ' ' + last_name AS full_name,
email
FROM sales.customers

UNION

SELECT
first_name + ' ' + last_name AS full_name,
email
FROM sales.staffs;

-- ============================================================
-- Q2. States Having Both Stores and Customers
-- ============================================================

SELECT state
FROM sales.stores

INTERSECT

SELECT state
FROM sales.customers;

-- ============================================================
-- Q3. Stores With Zero Orders in 2018
-- ============================================================

SELECT store_id
FROM sales.stores

EXCEPT

SELECT DISTINCT store_id
FROM sales.orders
WHERE YEAR(order_date) = 2018;

-- ============================================================
-- SECTION B — CTEs
-- ============================================================

-- ============================================================
-- Q4. Products Above Their Category Average Price
-- ============================================================

WITH CategoryAvg AS
(
SELECT
category_id,
AVG(list_price) AS avg_price
FROM production.products
GROUP BY category_id
)
SELECT
p.category_id,
p.product_name,
p.list_price,
ca.avg_price
FROM production.products p
JOIN CategoryAvg ca
ON p.category_id = ca.category_id
WHERE p.list_price > ca.avg_price
ORDER BY p.category_id;

-- ============================================================
-- Q5. Staff Members Above Average Order Count
-- ============================================================

WITH StaffOrders AS
(
SELECT
staff_id,
COUNT(*) AS order_count
FROM sales.orders
GROUP BY staff_id
),
AverageOrders AS
(
SELECT AVG(order_count * 1.0) AS avg_order_count
FROM StaffOrders
)
SELECT
so.staff_id,
so.order_count
FROM StaffOrders so
CROSS JOIN AverageOrders ao
WHERE so.order_count > ao.avg_order_count;

-- ============================================================
-- Q6. Store Revenue Above $1,000,000 Per Year
-- ============================================================

WITH StoreRevenue AS
(
SELECT
o.store_id,
YEAR(o.order_date) AS order_year,
SUM(
oi.quantity *
oi.list_price *
(1 - oi.discount)
) AS total_revenue
FROM sales.orders o
JOIN sales.order_items oi
ON o.order_id = oi.order_id
GROUP BY
o.store_id,
YEAR(o.order_date)
)
SELECT
store_id,
order_year AS [year],
total_revenue
FROM StoreRevenue
WHERE total_revenue > 1000000
ORDER BY store_id, order_year;

-- ============================================================
-- SECTION C — CONSTRAINTS (DDL)
-- ============================================================

-- ============================================================
-- Q7. Loyalty Cards Table With Constraints
-- ============================================================

CREATE TABLE sales.loyalty_cards
(
card_number INT PRIMARY KEY,

```
customer_id INT NOT NULL,

points INT
    CHECK (points >= 0),

tier VARCHAR(10)
    CHECK (tier IN ('Bronze','Silver','Gold')),

join_date DATE NOT NULL,

CONSTRAINT FK_LoyaltyCustomer
    FOREIGN KEY (customer_id)
    REFERENCES sales.customers(customer_id)
    ON DELETE CASCADE
```

);

-- Valid Inserts

INSERT INTO sales.loyalty_cards
VALUES (1001,1,500,'Gold','2024-01-15');

INSERT INTO sales.loyalty_cards
VALUES (1002,2,150,'Silver','2024-03-22');

INSERT INTO sales.loyalty_cards
VALUES (1003,3,0,'Bronze','2024-06-01');

-- Invalid Inserts (Should Fail)

INSERT INTO sales.loyalty_cards
VALUES (1001,4,100,'Gold','2024-07-01');

INSERT INTO sales.loyalty_cards
VALUES (1004,1,-50,'Silver','2024-08-01');

INSERT INTO sales.loyalty_cards
VALUES (1005,5,200,'Diamond','2024-09-01');

-- ============================================================
-- Q8. Prevent shipped_date Earlier Than order_date
-- ============================================================

ALTER TABLE test_orders
ADD CONSTRAINT CHK_ShippingDate
CHECK
(
shipped_date IS NULL
OR shipped_date >= order_date
);

-- Test

INSERT INTO test_orders
VALUES (4,'2024-04-10','2024-04-08');

INSERT INTO test_orders
VALUES (5,'2024-04-10','2024-04-15');

-- ============================================================
-- SECTION D — CASE EXPRESSIONS
-- ============================================================

-- ============================================================
-- Q9. Shipping Speed Classification
-- ============================================================

SELECT
order_id,
order_date,
shipped_date,
CASE
WHEN shipped_date IS NULL
THEN 'Pending'

```
    WHEN DATEDIFF(DAY, order_date, shipped_date) <= 2
        THEN 'Fast'

    WHEN DATEDIFF(DAY, order_date, shipped_date)
         BETWEEN 3 AND 5
        THEN 'Normal'

    ELSE 'Delayed'
END AS shipping_speed
```

FROM sales.orders;

-- ============================================================
-- Q10. Stock Level Classification
-- ============================================================

SELECT
store_id,
product_id,
quantity,
CASE
WHEN quantity = 0
THEN 'Out of Stock'

```
    WHEN quantity BETWEEN 1 AND 10
        THEN 'Low Stock'

    WHEN quantity BETWEEN 11 AND 50
        THEN 'Sufficient'

    ELSE 'Well Stocked'
END AS stock_status
```

FROM production.stocks
ORDER BY
store_id,
quantity ASC;

-- ============================================================
-- END OF ASSIGNMENT 04
-- ============================================================

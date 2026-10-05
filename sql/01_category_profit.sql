-- Decision query: which categories drive profit vs orders?
-- Import data/superstore_sales.csv as table orders before running.
-- sqlite3 example:
--   .mode csv
--   .import data/superstore_sales.csv orders

WITH line AS (
  SELECT
    "Order ID" AS order_id,
    "Product Category" AS category,
    CAST(Sales AS REAL) AS sales,
    CAST(Profit AS REAL) AS profit,
    CAST("Order Quantity" AS REAL) AS qty
  FROM orders
),
by_cat AS (
  SELECT
    category,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(*) AS lines,
    SUM(qty) AS qty,
    SUM(sales) AS sales,
    SUM(profit) AS profit
  FROM line
  GROUP BY category
),
totals AS (
  SELECT
    SUM(orders) AS orders,
    SUM(sales) AS sales,
    SUM(profit) AS profit
  FROM by_cat
)
SELECT
  b.category,
  b.orders,
  ROUND(1.0 * b.orders / t.orders, 3) AS order_share,
  ROUND(b.sales, 0) AS sales,
  ROUND(b.sales / t.sales, 3) AS sales_share,
  ROUND(b.profit, 0) AS profit,
  ROUND(b.profit / t.profit, 3) AS profit_share,
  ROUND(b.profit / b.sales, 3) AS margin
FROM by_cat b
CROSS JOIN totals t
ORDER BY b.profit DESC;

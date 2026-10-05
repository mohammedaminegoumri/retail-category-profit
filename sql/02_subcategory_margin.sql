-- Where the Furniture loss sits, and which Office Supplies lines carry profit.

WITH line AS (
  SELECT
    "Product Category" AS category,
    "Product Sub-Category" AS sub_category,
    CAST(Sales AS REAL) AS sales,
    CAST(Profit AS REAL) AS profit
  FROM orders
)
SELECT
  category,
  sub_category,
  COUNT(*) AS lines,
  ROUND(SUM(sales), 0) AS sales,
  ROUND(SUM(profit), 0) AS profit,
  ROUND(SUM(profit) / SUM(sales), 3) AS margin
FROM line
GROUP BY category, sub_category
ORDER BY margin ASC;

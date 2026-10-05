# Which categories drive profit, and which only drive orders?

Public retail order lines, 2009–2012 (8,399 lines, 5,496 orders). Source: Superstore sales extract, [curran/data](https://github.com/curran/data/blob/gh-pages/superstoreSales/superstoreSales.csv). Not a UAE transaction file. The question and the method are what transfer to a retail or e-commerce analyst role.

## Decision

Push Technology. Do not grow Furniture on sales. Tables and Bookcases lose money.

| Category | Orders | Order share | Sales | Sales share | Profit | Profit share | Margin |
|---|---:|---:|---:|---:|---:|---:|---:|
| Technology | 1,858 | 26.4% | 5,984,248 | 40.1% | 886,314 | 58.2% | 14.8% |
| Office Supplies | 3,632 | 51.5% | 3,752,762 | 25.2% | 518,021 | 34.0% | 13.8% |
| Furniture | 1,561 | 22.1% | 5,178,591 | 34.7% | 117,433 | 7.7% | 2.3% |

Order share is distinct orders inside the category, so the three shares sum to more than 100% when an order contains more than one category. The page card uses company-level distinct orders: 5,496.

Company total: sales 14,915,601, profit 1,521,768, margin 10.20%.

Technology is 26% of category orders and 58% of profit. Furniture is 35% of sales and 8% of profit. Tables lose about 99,063 (margin −5.2%). Bookcases lose about 33,582 (margin −4.1%). Binders are the quiet winner inside Office Supplies (about 30% margin, 307k profit).

## Actions

1. Shift promo and inventory toward Technology (phones, office machines, copiers).
2. Stop discounting Tables and Bookcases, or drop the worst SKUs. They destroy the Furniture margin.
3. Keep Office Supplies as the order engine. Do not judge it on sales share. Binders, labels, and envelopes carry the profit.

## What I would ask before using this

- Is profit after product cost only, or after shipping and returns? Shipping cost is in the file but not netted here.
- Are Tables and Bookcases loss-leaders that pull Office Supplies orders? This cut cannot see the basket.
- Discount is almost flat across categories (about 5%). The Furniture problem is mix, not a discount spike.

## Tools

SQL for the decision query, Python for the same cut, Power BI for the one-page report.

## Layout

```
sql/01_category_profit.sql       decision query
sql/02_subcategory_margin.sql    where the loss sits
scripts/category_cut.py          same cut in pandas
powerbi/measures.dax             measures used on the page
powerbi/page_spec.md             one-page layout
```

Data file is not committed. Download the public extract and save it as `data/superstore_sales.csv`:

https://raw.githubusercontent.com/curran/data/gh-pages/superstoreSales/superstoreSales.csv

Dates are US month/day/year. In Power BI, set date and decimal columns with Change Type → Using Locale → English (United States).

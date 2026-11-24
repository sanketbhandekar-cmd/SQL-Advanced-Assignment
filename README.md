# SQL Advanced Assignment

## Assignment Overview
This repository contains the advanced SQL solutions developed for an online shopping platform database in MySQL. The tasks cover database design, querying, automation, and query optimization based on the advanced SQL training module.

The implementation includes joins, subqueries, set operations, window functions, common table expressions (CTEs), views, indexes, stored procedures, functions, transactions, triggers, and query performance tuning.

## Database Schema
The database manages three core tables and one audit table:

- **Customers**: Stores customer details (`customer_id`, `customer_name`, `city`, `email`).
- **Products**: Stores product catalog information (`product_id`, `product_name`, `category`, `price`, `created_date`).
- **Orders**: Tracks customer purchases (`order_id`, `customer_id`, `product_id`, `quantity`, `order_date`) with foreign key constraints.
- **Order_Audit**: Records audit entries (`audit_id`, `order_id`, `order_date`, `action_date`) triggered automatically upon new order creation.

## Steps to Execute the SQL Script

### Using MySQL Command Line:
1. Open your terminal and connect to MySQL:
   ```bash
   mysql -u <username> -p
   ```
2. Run the script:
   ```sql
   source /path/to/sql_advanced_assignment.sql;
   ```
   Or directly from shell:
   ```bash
   mysql -u <username> -p < sql_advanced_assignment.sql
   ```

### Using MySQL Workbench:
1. Open MySQL Workbench and connect to your database instance.
2. Go to **File -> Open SQL Script...** and select `sql_advanced_assignment.sql`.
3. Click the **Execute** button (lightning icon) to run the script.

## Summary of Implemented Advanced SQL Concepts

- **Advanced Joins (Section 1):** Used `INNER JOIN` with `DISTINCT` to display customers and their ordered products, `CROSS JOIN` to generate all customer-product combinations, and `LEFT JOIN` across multiple tables to include customers with zero orders.
- **Subqueries (Section 2):** Applied subqueries in `WHERE` to filter products priced above average, subqueries with `HAVING` to compare total customer spending against average customer spending, and a correlated subquery to find the highest-priced product in each category.
- **Set Operations (Section 3):** Combined products from different categories using `UNION`, and implemented MySQL alternatives for `INTERSECT` (via `INNER JOIN`) and `EXCEPT` (via `LEFT JOIN ... WHERE ... IS NULL`).
- **Window Functions (Section 4):** Ranked products within each category using `RANK() OVER (PARTITION BY ...)`, and used `LAG()` and cumulative `SUM() OVER ()` for running totals without collapsing rows.
- **Common Table Expressions (Section 5):** Structured readable multi-step queries using standard `WITH` CTEs for customer spending analysis, and used `WITH RECURSIVE` to generate numbers 1 to 10.
- **Views (Section 6):** Created the `ProductsAbove1000` view to encapsulate products priced over ₹1,000 for reusability.
- **Indexes & Performance (Section 7):** Created an index on `Products(category)` and analyzed execution behavior using `EXPLAIN`.
- **Stored Procedures & Functions (Section 8):** Created a parameterized stored procedure `GetProductsByCategory` and a deterministic custom function `CalculateOrderTotal` to compute order totals.
- **Transactions (Section 9):** Used `START TRANSACTION`, `COMMIT`, and `ROLLBACK` to demonstrate atomic price updates and rollback recovery.
- **Triggers (Section 10):** Created an `AFTER INSERT` trigger on `Orders` to log new orders into `Order_Audit`.
- **Performance Tuning (Section 11):** Optimized a sample query by selecting specific columns instead of `SELECT *`, removing redundant `DISTINCT`, avoiding `YEAR()` on the indexed column, and filtering using a `BETWEEN` date range.

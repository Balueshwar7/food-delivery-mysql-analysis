
Your Name : Badugu Balu Eshwar
Batch : PFS-ONR-006

# Food Delivery Order Analysis Using MySQL

A beginner-to-intermediate SQL project that analyzes food delivery
orders, restaurant sales, customer activity, payment preferences, and
delivery performance using a fictional dataset.

## Project Overview

Food delivery platforms generate order-level data that can be used to
understand business performance. In this project, MySQL is used to
organize sample data into relational tables and answer practical
business questions with SQL queries.

**Project goal:** Turn raw food delivery records into useful business
insights using SQL.

## Dataset

The SQL script creates a database named `food_delivery_analysis` and
five related tables:

  -----------------------------------------------------------------------
  Table                               Description
  ----------------------------------- -----------------------------------
  `customers`                         Customer names, cities, and signup
                                      dates

  `restaurants`                       Restaurant names, locations, and
                                      cuisine types

  `menu_items`                        Menu item names, categories, and
                                      prices

  `orders`                            Order dates, status, payment
                                      method, delivery time, and delivery
                                      fee

  `order_items`                       Items in each order, quantities,
                                      and unit prices
  -----------------------------------------------------------------------

The script inserts fictional sample data for customers, restaurants,
menu items, and orders from January to April 2026. This is practice
data, not real customer or business data.

## Tools and Technologies

-   **MySQL 8.0+**
-   MySQL Workbench or another MySQL client
-   SQL

## How to Run the Project

1.  Install and open MySQL 8.0 or a compatible MySQL client.
2.  Download or clone this repository.
3.  Open `food-delivery-mysql-analysis.sql` in MySQL Workbench.
4.  Execute the script from top to bottom.
5.  The script creates the database and tables, inserts the sample data,
    and runs the analysis queries.
6.  Review each query's result grid to explore the analysis.

> **Important:** The script contains `DROP TABLE IF EXISTS` statements
> for the project's tables. Running it again will drop and recreate
> those tables, replacing their data with the sample dataset. Do not run
> it in a database containing data you need to keep.

## Business Questions Answered

The SQL script includes queries to investigate:

1.  Table contents and record counts
2.  Delivered orders within a date range
3.  Order counts by status
4.  Payment method usage
5.  Food subtotal, delivery fee, and order total
6.  Revenue from delivered orders, including delivery fees
7.  Restaurant food sales, excluding delivery fees
8.  Order counts by customer city
9.  Most popular menu items by quantity sold
10. Average order value for delivered orders
11. Customers with at least two orders
12. Average delivery time by restaurant
13. Delivery speed classification using `CASE`
14. Monthly delivered food sales
15. Delivered orders above the average delivered-order total
16. Restaurant revenue summary using a CTE
17. Restaurant sales ranking using a window function
18. Running monthly food sales using a window function
19. Customers who have not placed an order
20. Data-quality check for delivered orders with missing delivery
    duration

## SQL Concepts Practiced

-   `CREATE DATABASE` and `CREATE TABLE`
-   Primary keys and foreign keys
-   `NOT NULL`, `DEFAULT`, `CHECK`, and `ENUM` constraints
-   `INSERT INTO`
-   `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`
-   Aggregate functions: `COUNT`, `SUM`, and `AVG`
-   `GROUP BY` and `HAVING`
-   `INNER JOIN` and `LEFT JOIN`
-   Date filtering and `DATE_FORMAT()`
-   `ROUND()` and `CASE`
-   Subqueries and derived tables
-   Common Table Expressions (CTEs)
-   Window functions: `RANK()` and running `SUM() OVER (...)`
-   `IS NULL` checks for data quality

## Important Metric Definitions

-   **Food subtotal:** Sum of `quantity × unit_price` for the items in
    an order.
-   **Order total:** Food subtotal plus the order's delivery fee.
-   **Delivered-order revenue:** Sum of order totals for orders whose
    status is `Delivered`.
-   **Restaurant food sales:** Food-item sales for delivered orders,
    excluding delivery fees.
-   **Average order value:** Average order total among delivered orders.
-   **Average delivery time:** Average recorded delivery duration for
    delivered orders.

These definitions are used to keep the calculations consistent.
Cancelled, preparing, and out-for-delivery orders are excluded from
analyses that specifically measure delivered sales or delivery
performance.

## Repository Structure

``` text
food-delivery-mysql-analysis/
├── food-delivery-mysql-analysis.sql
└── README.md
```

## Limitations

-   The dataset is fictional and relatively small; results are for SQL
    practice only.
-   The sample covers a limited period and a small number of customers
    and restaurants.
-   The project does not include dashboards, real-time data, or a
    production application.
-   The SQL script reports query results; business conclusions should be
    based on the results observed after running it.

## Possible Improvements

-   Add more sample records to make trends more meaningful.
-   Create a Power BI dashboard from the query outputs.
-   Add further analysis for peak ordering times, cuisine performance,
    and repeat-customer behavior.
-   Compare delivery performance across cities and order statuses.

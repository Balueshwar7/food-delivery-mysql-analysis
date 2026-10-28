-- Food Delivery Order Analysis
-- Step 1: Database and tables

CREATE DATABASE IF NOT EXISTS food_delivery_analysis;
USE food_delivery_analysis;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(120) NOT NULL,
    city VARCHAR(60) NOT NULL,
    cuisine VARCHAR(60) NOT NULL
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(120) NOT NULL,
    category VARCHAR(40) NOT NULL,
    item_price DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    CONSTRAINT chk_item_price CHECK (item_price >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_status ENUM('Delivered','Cancelled','Preparing','Out for Delivery') NOT NULL,
    payment_method ENUM('UPI','Card','Cash','Wallet') NOT NULL,
    delivery_minutes INT NULL,
    delivery_fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_order_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    CONSTRAINT chk_delivery_minutes CHECK (delivery_minutes IS NULL OR delivery_minutes >= 0),
    CONSTRAINT chk_delivery_fee CHECK (delivery_fee >= 0)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_item_menu
        FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_item_price CHECK (unit_price >= 0)
);

-- Step 2: Insert fictional sample data

INSERT INTO customers (customer_id, customer_name, city, signup_date) VALUES
(1,'Aarav Sharma','Hyderabad','2025-11-02'),
(2,'Meera Reddy','Hyderabad','2025-11-18'),
(3,'Kiran Kumar','Secunderabad','2025-12-01'),
(4,'Ananya Rao','Kukatpally','2025-12-14'),
(5,'Rahul Verma','Miyapur','2026-01-05'),
(6,'Sana Khan','Hyderabad','2026-01-11'),
(7,'Vikram Naidu','Secunderabad','2026-01-23'),
(8,'Priya Das','Miyapur','2026-02-02'),
(9,'Arjun Patel','Kukatpally','2026-02-15'),
(10,'Divya Nair','Hyderabad','2026-03-01'),
(11,'Sai Teja','Secunderabad','2026-03-11'),
(12,'Ishita Singh','Miyapur','2026-03-20');

INSERT INTO restaurants (restaurant_id, restaurant_name, city, cuisine) VALUES
(1,'Spice Route','Hyderabad','Indian'),
(2,'Urban Biryani','Hyderabad','Biryani'),
(3,'Green Bowl','Secunderabad','Healthy'),
(4,'Pizza Corner','Kukatpally','Italian'),
(5,'Dosa House','Miyapur','South Indian');

INSERT INTO menu_items (item_id, restaurant_id, item_name, category, item_price) VALUES
(1,1,'Paneer Butter Masala','Main Course',240.00),
(2,1,'Butter Naan','Bread',45.00),
(3,1,'Veg Biryani','Main Course',190.00),
(4,2,'Chicken Dum Biryani','Main Course',280.00),
(5,2,'Veg Biryani','Main Course',210.00),
(6,2,'Double Ka Meetha','Dessert',90.00),
(7,3,'Paneer Salad Bowl','Healthy Bowl',220.00),
(8,3,'Grilled Veg Wrap','Wrap',160.00),
(9,4,'Margherita Pizza','Pizza',260.00),
(10,4,'Farmhouse Pizza','Pizza',340.00),
(11,5,'Masala Dosa','Breakfast',100.00),
(12,5,'Idli Sambar','Breakfast',80.00),
(13,5,'Filter Coffee','Beverage',45.00);

INSERT INTO orders (order_id, customer_id, restaurant_id, order_date, order_status, payment_method, delivery_minutes, delivery_fee) VALUES
(1001,1,2,'2026-01-03 12:15:00','Delivered','UPI',32,30.00),
(1002,2,1,'2026-01-04 19:10:00','Delivered','Card',41,25.00),
(1003,3,5,'2026-01-06 09:05:00','Delivered','Cash',28,20.00),
(1004,4,4,'2026-01-10 20:30:00','Cancelled','UPI',NULL,25.00),
(1005,5,2,'2026-01-14 13:20:00','Delivered','Wallet',38,30.00),
(1006,6,3,'2026-01-18 12:40:00','Delivered','UPI',26,20.00),
(1007,1,1,'2026-02-02 19:05:00','Delivered','Card',44,25.00),
(1008,7,4,'2026-02-05 20:10:00','Delivered','UPI',35,30.00),
(1009,8,5,'2026-02-07 08:50:00','Delivered','Cash',24,20.00),
(1010,9,2,'2026-02-11 13:35:00','Preparing','Wallet',NULL,30.00),
(1011,2,2,'2026-02-16 20:15:00','Delivered','UPI',39,30.00),
(1012,10,3,'2026-02-21 12:25:00','Delivered','Card',29,20.00),
(1013,11,1,'2026-03-01 19:30:00','Delivered','UPI',36,25.00),
(1014,12,4,'2026-03-03 20:05:00','Delivered','Card',47,30.00),
(1015,3,5,'2026-03-06 09:25:00','Delivered','UPI',27,20.00),
(1016,4,2,'2026-03-10 13:00:00','Delivered','Wallet',33,30.00),
(1017,5,3,'2026-03-12 12:15:00','Out for Delivery','UPI',NULL,20.00),
(1018,6,1,'2026-03-15 19:45:00','Delivered','Cash',42,25.00),
(1019,7,5,'2026-03-18 09:15:00','Delivered','UPI',25,20.00),
(1020,8,4,'2026-03-22 20:20:00','Cancelled','Card',NULL,30.00),
(1021,9,2,'2026-04-02 13:15:00','Delivered','UPI',37,30.00),
(1022,10,1,'2026-04-04 19:25:00','Delivered','Wallet',40,25.00),
(1023,11,3,'2026-04-07 12:35:00','Delivered','Card',31,20.00),
(1024,12,5,'2026-04-09 08:40:00','Delivered','Cash',26,20.00),
(1025,1,2,'2026-04-12 20:00:00','Delivered','UPI',34,30.00),
(1026,2,4,'2026-04-15 19:10:00','Delivered','Card',43,30.00),
(1027,3,1,'2026-04-17 12:50:00','Delivered','UPI',35,25.00),
(1028,4,3,'2026-04-19 12:20:00','Delivered','Wallet',28,20.00),
(1029,5,5,'2026-04-21 09:10:00','Delivered','UPI',23,20.00),
(1030,6,2,'2026-04-24 13:45:00','Delivered','Cash',36,30.00);

INSERT INTO order_items (order_item_id, order_id, item_id, quantity, unit_price) VALUES
(1,1001,4,1,280.00),(2,1001,6,1,90.00),
(3,1002,1,1,240.00),(4,1002,2,3,45.00),
(5,1003,11,2,100.00),(6,1003,13,2,45.00),
(7,1004,10,1,340.00),
(8,1005,4,2,280.00),(9,1005,6,1,90.00),
(10,1006,7,1,220.00),(11,1006,8,1,160.00),
(12,1007,1,1,240.00),(13,1007,3,1,190.00),
(14,1008,9,1,260.00),(15,1008,10,1,340.00),
(16,1009,11,2,100.00),(17,1009,12,2,80.00),
(18,1010,5,1,210.00),(19,1010,6,1,90.00),
(20,1011,4,1,280.00),(21,1011,6,2,90.00),
(22,1012,7,2,220.00),
(23,1013,1,1,240.00),(24,1013,2,2,45.00),
(25,1014,10,2,340.00),
(26,1015,11,1,100.00),(27,1015,12,3,80.00),
(28,1016,4,1,280.00),(29,1016,5,1,210.00),
(30,1017,7,1,220.00),(31,1017,8,1,160.00),
(32,1018,3,2,190.00),
(33,1019,11,2,100.00),(34,1019,13,2,45.00),
(35,1020,9,1,260.00),
(36,1021,4,1,280.00),(37,1021,6,1,90.00),
(38,1022,1,1,240.00),(39,1022,3,1,190.00),
(40,1023,7,1,220.00),(41,1023,8,2,160.00),
(42,1024,11,2,100.00),(43,1024,12,1,80.00),
(44,1025,4,1,280.00),(45,1025,6,1,90.00),
(46,1026,9,1,260.00),(47,1026,10,1,340.00),
(48,1027,1,1,240.00),(49,1027,2,2,45.00),
(50,1028,7,1,220.00),(51,1028,8,1,160.00),
(52,1029,11,3,100.00),(53,1029,13,1,45.00),
(54,1030,4,1,280.00),(55,1030,5,1,210.00);

-- Step 3: Business analysis queries

-- 1. Preview tables and count records
SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM menu_items;
SELECT * FROM orders;
SELECT * FROM order_items;


-- 2. Basic filtering: delivered orders in a date range
SELECT order_id, customer_id, restaurant_id, order_date, order_status
FROM orders
WHERE order_status = 'Delivered'
  AND order_date >= '2026-01-01'
  AND order_date < '2026-04-01'
ORDER BY order_date;

-- 3. Order status summary
SELECT order_status, COUNT(*) AS number_of_orders
FROM orders
GROUP BY order_status
ORDER BY number_of_orders DESC;

-- 4. Payment method usage
SELECT payment_method, COUNT(*) AS number_of_orders
FROM orders
GROUP BY payment_method
ORDER BY number_of_orders DESC;

-- 5. Order subtotal per order; delivery fee is separate
SELECT o.order_id, o.order_status,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS food_subtotal,
       o.delivery_fee,
       ROUND(SUM(oi.quantity * oi.unit_price) + o.delivery_fee, 2) AS order_total
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_status, o.delivery_fee
ORDER BY o.order_id;

-- 6. Total delivered-order revenue including delivery fees
SELECT * FROM orders;
select * from order_items;
SELECT ROUND(SUM(order_total), 2) AS delivered_order_revenue
FROM (
    SELECT o.order_id,
           SUM(oi.quantity * oi.unit_price) + o.delivery_fee AS order_total
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id, o.delivery_fee
) AS delivered_totals;

-- 7. Restaurant food sales (excludes delivery fees)
SELECT r.restaurant_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS food_sales
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY food_sales DESC;

-- 8. Order count by customer city
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

-- 9. Most popular menu items by quantity sold
SELECT mi.item_name, SUM(oi.quantity) AS units_sold
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.item_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY mi.item_id, mi.item_name
ORDER BY units_sold DESC
LIMIT 10;

-- 10. Average order value for delivered orders
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT o.order_id,
           SUM(oi.quantity * oi.unit_price) + o.delivery_fee AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id, o.delivery_fee
) AS order_totals;

-- 11. Customers with at least two orders
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY order_count DESC, c.customer_name;

-- 12. Delivery performance by restaurant
SELECT r.restaurant_name,
       COUNT(o.order_id) AS delivered_orders,
       ROUND(AVG(o.delivery_minutes), 1) AS average_delivery_minutes
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_delivery_minutes;

-- 13. CASE: classify delivered orders by delivery time
SELECT order_id, delivery_minutes,
       CASE
           WHEN delivery_minutes <= 30 THEN 'Fast (30 min or less)'
           WHEN delivery_minutes <= 40 THEN 'Standard (31-40 min)'
           ELSE 'Slow (over 40 min)'
       END AS delivery_speed
FROM orders
WHERE order_status = 'Delivered'
ORDER BY delivery_minutes;

-- 14. Monthly delivered food sales using date functions
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_food_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;

-- 15. Orders above the average delivered-order total (subquery)
SELECT totals.order_id, ROUND(totals.order_total, 2) AS order_total
FROM (
    SELECT o.order_id,
           SUM(oi.quantity * oi.unit_price) + o.delivery_fee AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id, o.delivery_fee
) AS totals
WHERE totals.order_total > (
    SELECT AVG(order_total)
    FROM (
        SELECT o2.order_id,
               SUM(oi2.quantity * oi2.unit_price) + o2.delivery_fee AS order_total
        FROM orders o2
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        WHERE o2.order_status = 'Delivered'
        GROUP BY o2.order_id, o2.delivery_fee
    ) AS avg_totals
)
ORDER BY order_total DESC;

-- 16. CTE: create a readable restaurant revenue summary
WITH restaurant_sales AS (
    SELECT r.restaurant_id, r.restaurant_name,
           SUM(oi.quantity * oi.unit_price) AS food_sales
    FROM restaurants r
    JOIN orders o ON r.restaurant_id = o.restaurant_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT restaurant_name, ROUND(food_sales, 2) AS food_sales
FROM restaurant_sales
ORDER BY food_sales DESC;

-- 17. Window function: rank restaurants by food sales
WITH restaurant_sales AS (
    SELECT r.restaurant_id, r.restaurant_name,
           SUM(oi.quantity * oi.unit_price) AS food_sales
    FROM restaurants r
    JOIN orders o ON r.restaurant_id = o.restaurant_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT restaurant_name,
       ROUND(food_sales, 2) AS food_sales,
       RANK() OVER (ORDER BY food_sales DESC) AS sales_rank
FROM restaurant_sales;

-- 18. Window function: running monthly food sales
WITH monthly_sales AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
           SUM(oi.quantity * oi.unit_price) AS food_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT order_month,
       ROUND(food_sales, 2) AS monthly_food_sales,
       ROUND(SUM(food_sales) OVER (ORDER BY order_month), 2) AS running_food_sales
FROM monthly_sales
ORDER BY order_month;

-- 19. LEFT JOIN: customers who have not placed an order
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 20. Data quality check: missing delivery duration for delivered orders
SELECT order_id, order_status, delivery_minutes
FROM orders
WHERE order_status = 'Delivered'
  AND delivery_minutes IS NULL;



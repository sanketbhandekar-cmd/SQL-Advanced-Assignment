-- Database creation
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Drop existing tables to avoid conflict
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- 1. Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_date DATE
);

-- 3. Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Insert sample data into Customers
INSERT INTO Customers (customer_id, customer_name, city, email) VALUES
(1, 'Naruto Uzumaki', 'Tokyo', 'naruto.uzumaki@gmail.com'),
(2, 'Sasuke Uchiha', 'Kyoto', 'sasuke.uchiha@yahoo.com'),
(3, 'Monkey D Luffy', 'Osaka', 'luffy.strawhat@gmail.com'),
(4, 'Roronoa Zoro', 'Nagoya', 'zoro.swordsman@gmail.com'),
(5, 'Son Goku', 'Yokohama', 'goku.saiyan@outlook.com'),
(6, 'Eren Yeager', 'Sapporo', 'eren.yeager@gmail.com'),
(7, 'Levi Ackerman', 'Fukuoka', 'levi.ackerman@gmail.com'),
(8, 'Light Yagami', 'Kobe', 'light.yagami@gmail.com'),
(9, 'Kakashi Hatake', 'Sendai', 'kakashi.h@gmail.com'),
(10, 'Tanjiro Kamado', 'Hiroshima', 'tanjiro.k@gmail.com'),
(11, 'Saitama', 'Saitama', 'saitama.hero@gmail.com'),
(12, 'Ichigo Kurosaki', 'Kawasaki', 'ichigo.k@gmail.com');


-- Insert sample data into Products
INSERT INTO Products (product_id, product_name, category, price, created_date) VALUES
(1, 'Laptop', 'Electronics', 65000.00, '2024-01-15'),
(2, 'Smartphone', 'Electronics', 35000.00, '2024-02-10'),
(3, 'Wireless Mouse', 'Electronics', 800.00, '2024-03-05'),
(4, 'Headphones', 'Electronics', 2500.00, '2024-04-12'),
(5, 'T-Shirt', 'Clothing', 699.00, '2024-01-20'),
(6, 'Jeans', 'Clothing', 1899.00, '2024-02-18'),
(7, 'Jacket', 'Clothing', 3499.00, '2024-03-22'),
(8, 'Microwave Oven', 'Home Appliances', 8500.00, '2024-01-25'),
(9, 'Electric Kettle', 'Home Appliances', 1200.00, '2024-02-14'),
(10, 'Toaster', 'Home Appliances', 950.00, '2024-03-10'),
(11, 'SQL Handbook', 'Books', 750.00, '2024-01-10'),
(12, 'Data Science Basics', 'Books', 1450.00, '2024-02-05');


-- Insert sample data into Orders
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, 1, '2024-05-01'),
(2, 1, 3, 2, '2024-05-02'),
(3, 2, 2, 1, '2024-05-03'),
(4, 2, 4, 1, '2024-05-05'),
(5, 3, 5, 3, '2024-05-06'),
(6, 3, 6, 1, '2024-05-08'),
(7, 4, 8, 1, '2024-05-10'),
(8, 4, 9, 2, '2024-05-12'),
(9, 5, 11, 2, '2024-05-14'),
(10, 5, 12, 1, '2024-05-15'),
(11, 6, 1, 1, '2024-05-16'),
(12, 6, 7, 1, '2024-05-18'),
(13, 7, 2, 1, '2024-05-19'),
(14, 7, 10, 1, '2024-05-20'),
(15, 8, 4, 2, '2024-05-22'),
(16, 8, 5, 2, '2024-05-23'),
(17, 9, 6, 2, '2024-05-25'),
(18, 9, 8, 1, '2024-05-26'),
(19, 10, 9, 1, '2024-05-27'),
(20, 10, 11, 1, '2024-05-28'),
(21, 1, 7, 1, '2024-06-01'),
(22, 2, 1, 1, '2024-06-02'),
(23, 3, 3, 1, '2024-06-04'),
(24, 4, 12, 2, '2024-06-05'),
(25, 5, 2, 1, '2024-06-07');

-- Section 1: Advanced Joins

-- Task 1: Display each customer along with the products they ordered.
-- Used DISTINCT in case, in future customer purchased the same product.
SELECT DISTINCT
    c.customer_name,
    p.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Products p ON o.product_id = p.product_id;


-- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
SELECT customer_name, product_name from Products CROSS JOIN Customers;

-- Task 3: Display all customers and their orders, including customers who have not placed any orders.
SELECT
	customer_name,
    product_name
FROM Customers c
LEFT JOIN Orders o on c.customer_id = o.customer_id
LEFT JOIN Products p on o.product_id = p.product_id;

-- Section 2: Subqueries
-- Task 4: Find products priced above the average product price.
SELECT
	product_id,
	product_name,
	price,
    category
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

-- Task 5: Display customers whose total purchase amount is greater than the average customer purchase amount.
SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.quantity * p.price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(o2.quantity * p2.price) AS customer_total
        FROM Orders o2
        JOIN Products p2 ON o2.product_id = p2.product_id
        GROUP BY o2.customer_id
    ) t
);

-- Task 6: Find the highest-priced product in each category using a correlated subquery.
SELECT product_id, product_name, price, category
FROM Products p1
WHERE price = (
	SELECT MAX(price)
	FROM Products p2
	where p1.category = p2.category
);

-- Section 3: Set Operations
-- Task 7: Combine products from two different categories using UNION.
SELECT product_name, category, price
FROM Products
WHERE category = 'Electronics'
UNION
SELECT product_name, category, price
FROM Products
WHERE category = 'Clothing';

-- Task 8: Write MySQL alternatives for INTERSECT and EXCEPT using INNER JOIN and LEFT JOIN.

-- INTERSECT alternative using INNER JOIN (finding common products)
SELECT DISTINCT p1.product_name, p1.category, p1.price
FROM Products p1
INNER JOIN Products p2 ON p1.product_id = p2.product_id
WHERE p1.category = 'Electronics' AND p2.price > 2000;

-- EXCEPT alternative using LEFT JOIN (finding products in first set but not second)
SELECT DISTINCT p1.product_name, p1.category, p1.price
FROM Products p1
LEFT JOIN Products p2 ON p1.product_id = p2.product_id AND p2.price > 2000
WHERE p1.category = 'Electronics' AND p2.product_id IS NULL;

-- Section 4: Window Functions

-- Task 9: Rank products by price within each category.
SELECT product_name, price, category, RANK() OVER(PARTITION BY category ORDER BY price DESC )as category_rank from Products;

-- Task 10: Display the previous product price (LAG) and a running total of product prices using window functions.
SELECT
    product_name,
    category,
    price,
    LAG(price) OVER (ORDER BY price) AS previous_price,
    SUM(price) OVER (ORDER BY price) AS running_total
FROM Products;


-- Section 5: Common Table Expressions (CTEs)

-- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
WITH CustomerSpending AS (
    SELECT
        c.customer_name,
        SUM(o.quantity * p.price) AS total_spent
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Products p ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_spent
FROM CustomerSpending
WHERE total_spent > (SELECT AVG(total_spent) FROM CustomerSpending);


-- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
WITH RECURSIVE NumberSequence AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM NumberSequence
    WHERE num < 10
)
SELECT num FROM NumberSequence;


-- Section 6: Views

-- Task 13: Create a view that displays products priced above ₹1,000 and retrieve data from the view.
CREATE VIEW ProductsAbove1000 AS
SELECT product_id, product_name, category, price
FROM Products
WHERE price > 1000;

SELECT * FROM ProductsAbove1000;


-- Section 7: Indexes and Query Performance

-- Task 14: Create an index on the category column of the Products table.
CREATE INDEX idx_products_category ON Products(category);

-- Task 15: Use EXPLAIN to analyze a query that filters products by category.
EXPLAIN SELECT * FROM Products WHERE category = 'Electronics';


-- Section 8: Stored Procedures and Functions

-- Task 16: Create a stored procedure to retrieve products by category.
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN cat_name VARCHAR(50))
BEGIN
    SELECT product_id, product_name, category, price
    FROM Products
    WHERE category = cat_name;
END //

DELIMITER ;

CALL GetProductsByCategory('Electronics');


-- Task 17: Create a function to calculate the total price of an order (price × quantity).
DELIMITER //

CREATE FUNCTION CalculateOrderTotal(price DECIMAL(10, 2), qty INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN price * qty;
END //

DELIMITER ;

SELECT
    order_id,
    p.product_name,
    p.price,
    quantity,
    CalculateOrderTotal(p.price, quantity) AS total_price
FROM Orders o
JOIN Products p ON o.product_id = p.product_id;


-- Section 9: Transactions

-- Task 18: Write a transaction that updates a product's price and demonstrate the use of COMMIT and ROLLBACK.

-- Demonstrating ROLLBACK
START TRANSACTION;
UPDATE Products SET price = 99999 WHERE product_id = 1;
SELECT * FROM Products WHERE product_id = 1;
ROLLBACK;
SELECT * FROM Products WHERE product_id = 1;

-- Demonstrating COMMIT
START TRANSACTION;
UPDATE Products SET price = 68000 WHERE product_id = 1;
COMMIT;
SELECT * FROM Products WHERE product_id = 1;


-- Section 10: SQL Triggers

-- Task 19: Create a trigger that automatically records new orders in an Order_Audit table whenever a new order is inserted.
CREATE TABLE IF NOT EXISTS Order_Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    order_date DATE,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_after_insert_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Audit (order_id, order_date)
    VALUES (NEW.order_id, NEW.order_date);
END //

DELIMITER ;

-- Test trigger by inserting a new order
INSERT INTO Orders (customer_id, product_id, quantity, order_date)
VALUES (1, 3, 2, '2024-06-15');

SELECT * FROM Order_Audit;


-- Section 11: Performance Tuning

-- Task 20: Optimize the queries by applying SQL performance tuning best practices.
-- (Avoid SELECT *, remove unnecessary DISTINCT, avoid function on indexed column, use date range)
SELECT
    product_id,
    product_name,
    category,
    price,
    created_date
FROM Products
WHERE created_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND category = 'Electronics';


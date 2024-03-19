-- DAY 13 : Advanced Querying

-- Aim : Understand subqueries and nested queries and their usage in SQL queries.

-- Create sample tables for demonstration
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'John Smith', 'New York'),
(2, 'Alice Johnson', 'Los Angeles'),
(3, 'Michael Brown', 'Chicago'),
(4, 'Emily Davis', 'Houston'),
(5, 'William Wilson', 'Phoenix'),
(6, 'Sophia Martinez', 'Philadelphia'),
(7, 'James Anderson', 'San Antonio'),
(8, 'Olivia Taylor', 'San Diego'),
(9, 'David Thomas', 'Dallas'),
(10, 'Emma Hernandez', 'San Francisco');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

-- Insert sample data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 1, '2024-03-15', 150.00),
(2, 2, '2024-03-16', 200.00),
(3, 3, '2024-03-17', 120.00),
(4, 4, '2024-03-18', 180.00),
(5, 5, '2024-03-19', 250.00),
(6, 6, '2024-03-20', 170.00),
(7, 7, '2024-03-21', 300.00),
(8, 8, '2024-03-22', 220.00),
(9, 9, '2024-03-23', 190.00),
(10, 10, '2024-03-24', 280.00);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert sample data into Products table
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 800.00),
(2, 'Smartphone', 600.00),
(3, 'Tablet', 400.00),
(4, 'Headphones', 100.00),
(5, 'Camera', 1200.00),
(6, 'Printer', 300.00),
(7, 'Monitor', 250.00),
(8, 'Keyboard', 50.00),
(9, 'Mouse', 30.00),
(10, 'Speakers', 80.00);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data into Order_Items table
INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 1),
(7, 7, 2),
(8, 8, 3),
(9, 9, 4),
(10, 10, 5);

-- Practice Questions
-- 1. Retrieve all customers who have made at least one purchase.
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT DISTINCT c.customer_id, c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- 2. Find the names of customers who have not made any purchases.
SELECT customer_name
FROM Customers
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

-- 3. Get the order details for orders with a total quantity greater than the average quantity of all orders.
SELECT * FROM Order_Items
WHERE order_id IN (
    SELECT order_id
    FROM Orders
    GROUP BY order_id
    HAVING SUM(quantity) > (SELECT AVG(quantity) FROM Order_Items)
);
-- 4. Write a query to find the top 5 customers with the highest total order amount.

SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_order_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_amount DESC
LIMIT 5;

-- Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date, order_amount)

-- 5. Retrieve the names of customers who have placed orders in the past 30 days.
SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- 6. Find the products that have been ordered at least three times. 
-- Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity)

SELECT p.product_name
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING COUNT(oi.order_id) >= 3;

-- 7. Retrieve the order details for orders placed by customers from a specific city.
-- Dataset: Customers (customer_id, customer_name, city), Orders (order_id, customer_id, order_date), Order_Details (order_id, product id, quantity)
SELECT o.*
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Specific_City';

-- 8. Write a query to find the customers who have placed orders for products with a price greater than $100.
-- Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date), Products (product_id, product_name, price), Order_Details (order_id, product_id, quantity)
SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE p.price > 100;

-- 9. Get the average order amount for each customer.
-- Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date, order_amount)
SELECT customer_id, AVG(order_amount) AS avg_order_amount
FROM Orders
GROUP BY customer_id;

-- 10. Find the products that have never been ordered.
-- Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity)
SELECT product_name
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Order_Items);

-- 11. Retrieve the names of customers who have placed orders on weekends (Saturday or Sunday). 
-- Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date)
SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE DAYOFWEEK(o.order_date) IN (1, 7);

-- 12. Get the total order amount for each month.
-- Dataset: Orders (order_id, order_date, order_amount)
SELECT MONTH(order_date) AS month, SUM(order_amount) AS total_order_amount
FROM Orders
GROUP BY MONTH(order_date);

-- 13. Write a query to find the customers who have placed orders for more than two different products. 
-- Dataset: Customers (customer_id, customer_name), Orders (order id, customer_id, order_date), Order Items (order_id, product id, quantity)
SELECT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT oi.product_id) > 2;
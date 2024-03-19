-- DAY 14 :  Joins

-- Aim : Understand different types of joins and their applications in SQL queries.

-- DATASET : 
 -- Create sample tables for demonstration
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50),
    occupation VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    supplier_id INT,
    price DECIMAL(10, 2)
);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50)
);

INSERT INTO Customers (customer_id, customer_name, country, occupation) VALUES
(1, 'John Smith', 'USA', 'Engineer'),
(2, 'Alice Johnson', 'Canada', 'Teacher'),
(3, 'Michael Brown', 'UK', 'Doctor'),
(4, 'Emily Davis', 'Australia', 'Lawyer'),
(5, 'William Wilson', 'USA', 'Artist');


INSERT INTO Orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 1, '2024-03-15', 150.00),
(2, 2, '2024-03-16', 200.00),
(3, 3, '2024-03-17', 120.00),
(4, 4, '2024-03-18', 180.00),
(5, 5, '2024-03-19', 250.00);

INSERT INTO Products (product_id, product_name, supplier_id, price) VALUES
(1, 'Laptop', 1, 800.00),
(2, 'Smartphone', 2, 600.00),
(3, 'Tablet', 3, 400.00),
(4, 'Headphones', 4, 100.00),
(5, 'Camera', 5, 1200.00);

-- Insert sample data into Order_Items table
INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Insert sample data into Suppliers table
INSERT INTO Suppliers (supplier_id, supplier_name) VALUES
(1, 'Supplier 1'),
(2, 'Supplier 2'),
(3, 'Supplier 3'),
(4, 'Supplier 4'),
(5, 'Supplier 5');

-- 1. Retrieve the order details along with the customer names for all orders.
SELECT o.*, c.customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

 -- 2. Get a list of products and the total quantity ordered for each product.
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_ordered
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 3. Get a list of customers and their total order amounts.
SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_order_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 4. Retrieve the order details along with the customer name and product name for each order.
SELECT o.*, c.customer_name, p.product_name, oi.quantity
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- 5. Find the products and their corresponding suppliers' names.
SELECT p.product_name, s.supplier_name
FROM Products p
JOIN Suppliers s ON p.supplier_id = s.supplier_id;

-- 6. Get a list of customers who have never placed an order.
SELECT c.customer_id, c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 7. Retrieve the names of customers along with the total quantity of products they ordered.
SELECT c.customer_name, SUM(oi.quantity) AS total_quantity_ordered
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- 8. Find the products that have been ordered by customers from a specific country.
SELECT p.product_name
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Specific_Country';

-- 9. Get the total order amount for each customer, including those who have not placed any orders.
SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.order_amount), 0) AS total_order_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 10. Retrieve the order details for orders placed by customers with a specific occupation.
SELECT o.*, c.customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.occupation = 'Specific_Occupation';

-- 11. Find the customers who have placed orders for products with a price higher than the average price of all products.
SELECT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE p.price > (SELECT AVG(price) FROM Products);

-- 12. Retrieve the names of customers along with the total number of orders they have placed.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders_placed
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
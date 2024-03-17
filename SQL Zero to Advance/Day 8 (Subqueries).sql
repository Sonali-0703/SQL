-- Subqueries
-- Understand the concept of subqueries and their usage.
-- Learn to write subqueries in different parts of a SQL statement. Practice writing queries that include subqueries.
 
 
 CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, name, department_id, salary)
VALUES
(1, 'John Doe', 101, 60000.00),
(2, 'Jane Smith', 102, 55000.00),
(3, 'David Brown', 101, 62000.00),
(4, 'Emily Johnson', 103, 59000.00),
(5, 'Michael Davis', 102, 58000.00),
(6, 'Sarah Wilson', 101, 63000.00),
(7, 'James Miller', 103, 61000.00),
(8, 'Jessica Lee', 102, 59000.00),
(9, 'Daniel Martinez', 101, 54000.00),
(10, 'Emma Taylor', 103, 65000.00),
(11, 'William Clark', 101, 62000.00),
(12, 'Olivia Rodriguez', 102, 57000.00),
(13, 'Mason Garcia', 103, 61000.00),
(14, 'Isabella Martinez', 101, 64000.00),
(15, 'Ethan Hernandez', 102, 56000.00);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders (order_id, customer_id, order_date)
VALUES
(1, 201, '2023-10-01'),
(2, 202, '2023-10-05'),
(3, 203, '2023-10-10'),
(4, 201, '2023-10-15'),
(5, 202, '2023-10-20'),
(6, 203, '2023-10-25'),
(7, 201, '2023-10-30'),
(8, 202, '2023-11-01'),
(9, 203, '2023-11-05'),
(10, 201, '2023-11-10'),
(11, 204, '2023-11-15'),
(12, 205, '2023-11-20'),
(13, 206, '2023-11-25'),
(14, 204, '2023-11-30'),
(15, 206, '2023-12-01');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, name, category_id, price)
VALUES
(1, 'Product A', 101, 1200.00),
(2, 'Product B', 102, 800.50),
(3, 'Product C', 101, 300.75),
(4, 'Product D', 103, 1500.00),
(5, 'Product E', 102, 700.25),
(6, 'Product F', 101, 950.00),
(7, 'Product G', 103, 400.50),
(8, 'Product H', 102, 1300.75),
(9, 'Product I', 101, 1100.25),
(10, 'Product J', 103, 600.00),
(11, 'Product K', 101, 850.00),
(12, 'Product L', 102, 950.50),
(13, 'Product M', 103, 1200.75),
(14, 'Product N', 101, 1300.25),
(15, 'Product O', 102, 1000.00);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Insert records into categories table
INSERT INTO categories (category_id, category_name)
VALUES 
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Furniture');

-- 1. Write a SQL query to retrieve the names of all employees who have a salary higher than the average salary.
SELECT * FROM employees;
SELECT name 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Write a SQL query to retrieve the total number of orders placed by each customer.
SELECT customer_id, COUNT(*) AS total_orders 
FROM orders 
GROUP BY customer_id;

-- 3. Write a SQL query to retrieve the names of all products in the 'Electronics' category.
SELECT name 
FROM products 
WHERE category_id = (SELECT category_id FROM categories WHERE category_name = 'Electronics');

-- 4. Write a SQL query to retrieve all the products with a price higher than the average price of all products.
SELECT * 
FROM products 
WHERE price > (
    SELECT AVG(price) 
    FROM products
);
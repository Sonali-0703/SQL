-- Advanced Filtering and Sorting
-- Learn about advanced filtering techniques: LIKE, IN, BETWEEN, and NULL.
-- Study complex sorting options using multiple columns.
-- Practice writing queries with advanced filtering and sorting.

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, name, price)
VALUES
(1, 'Product A', 1200.00),
(2, 'Product B', 800.50),
(3, 'Product C', 300.75),
(4, 'Product D', 1500.00),
(5, 'Product E', 700.25),
(6, 'Product F', 950.00),
(7, 'Product G', 400.50),
(8, 'Product H', 1300.75),
(9, 'Product I', 1100.25),
(10, 'Product J', 600.00);
 

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    hire_date DATE
);

INSERT INTO employees (employee_id, name, hire_date)
VALUES
(1, 'John Doe', '2023-01-15'),
(2, 'Jane Smith', '2023-02-10'),
(3, 'David Brown', '2023-03-05'),
(4, 'Emily Johnson', '2023-04-20'),
(5, 'Michael Davis', '2023-05-12'),
(6, 'Sarah Wilson', '2023-06-25'),
(7, 'James Miller', '2023-07-30'),
(8, 'Jessica Lee', '2023-08-15'),
(9, 'Daniel Martinez', '2023-09-10'),
(10, 'Emma Taylor', '2023-10-05');

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    city VARCHAR(100)
);

INSERT INTO customers (customer_id, name, phone_number, city)
VALUES
(1, 'John Smith', NULL, 'New York'),
(2, 'Jane Doe', '555-1234', 'Los Angeles'),
(3, 'David Johnson', '555-5678', 'Chicago'),
(4, 'Emily Williams', NULL, 'San Francisco'),
(5, 'Michael Brown', '555-8765', 'Boston'),
(6, 'Sarah Davis', '555-4321', 'Seattle'),
(7, 'James Wilson', NULL, 'Denver'),
(8, 'Jessica Miller', '555-9876', 'Miami'),
(9, 'Daniel Lee', NULL, 'Houston'),
(10, 'Emma Martinez', '555-3456', 'Dallas');



 

-- Practice Questions:

-- 1. Write a SQL query to retrieve all the products with a price either above 1000 or below 500.
 SELECT * FROM products 
 WHERE price > 1000 OR price < 500;

-- 2. Write a SQL query to retrieve the employees who were hired between a specific date range.
SELECT * FROM employees 
WHERE hire_date BETWEEN '2023-03-01' AND '2023-06-30';

-- 3. Write a SQL query to retrieve all the customers who do not have a phone number specified in the database.
SELECT * FROM customers 
WHERE phone_number IS NULL;

-- 4. Write a SQL query to retrieve all the customers whose names start with 'J' and have a city containing 'York'.
SELECT * FROM customers 
WHERE name LIKE 'J%' AND city LIKE '%York%';
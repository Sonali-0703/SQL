-- Views and Indexes
-- Study views and their importance in database design,
-- Learn to create and use views in SQL.
-- Understand indexes and their role in optimizing query performance.
-- Practice creating views and indexes.


 CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers (customer_id, name, email)
VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'David Brown', 'david@example.com'),
(4, 'Emily Johnson', 'emily@example.com'),
(5, 'Michael Davis', 'michael@example.com'),
(6, 'Sarah Wilson', 'sarah@example.com'),
(7, 'James Miller', 'james@example.com'),
(8, 'Jessica Lee', 'jessica@example.com'),
(9, 'Daniel Martinez', 'daniel@example.com'),
(10, 'Emma Taylor', 'emma@example.com');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2023-10-01', 120.50),
(2, 2, '2023-10-05', 250.75),
(3, 3, '2023-10-10', 180.00),
(4, 4, '2023-10-15', 300.25),
(5, 5, '2023-10-20', 400.00),
(6, 6, '2023-10-25', 150.80),
(7, 7, '2023-10-30', 200.50),
(8, 8, '2023-11-01', 350.25),
(9, 9, '2023-11-05', 280.75),
(10, 10, '2023-11-10', 220.00);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, name, price)
VALUES
(1, 'Product A', 120.00),
(2, 'Product B', 80.50),
(3, 'Product C', 30.75),
(4, 'Product D', 150.00),
(5, 'Product E', 70.25),
(6, 'Product F', 95.00),
(7, 'Product G', 40.50),
(8, 'Product H', 130.75),
(9, 'Product I', 110.25),
(10, 'Product J', 60.00);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    department_id INT,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, department_id, name, salary)
VALUES
(1, 201, 'John Doe', 50000.00),
(2, 202, 'Jane Smith', 60000.00),
(3, 201, 'David Brown', 55000.00),
(4, 203, 'Emily Johnson', 62000.00),
(5, 202, 'Michael Davis', 58000.00),
(6, 201, 'Sarah Wilson', 53000.00),
(7, 203, 'James Miller', 61000.00),
(8, 202, 'Jessica Lee', 59000.00),
(9, 201, 'Daniel Martinez', 54000.00),
(10, 203, 'Emma Taylor', 63000.00);

-- Practice Questions:

-- 1. Create a view named "order summary" that retrieves the total order amount and the number of orders for each customer from the "orders" table.
CREATE VIEW order_summary AS
SELECT customer_id, COUNT(*) AS num_orders, SUM(total_amount) AS total_amount
FROM orders
GROUP BY customer_id;
SELECT * FROM order_summary;

-- 2. Create an index on the "email" column of the "customers" table for faster searching.
CREATE INDEX idx_email ON customers (email);

-- 3. Create a view named "high salary_employees" that retrieves all the employees with a salary greater than 50000 from the "employees" table.
CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 50000;

-- 4. Write a SQL query to retrieve the total number of orders and the average order amount for each customer from the "orders" table using a view named "customer_order_stats".
CREATE VIEW customer_order_stats AS
SELECT customer_id, COUNT(*) AS num_orders, AVG(total_amount) AS avg_order_amount
FROM orders
GROUP BY customer_id;

-- 5. Write a SQL query to retrieve the names and email addresses of customers who have placed at least 3 orders, using the "order_summary" view.
SELECT c.name, c.email
FROM customers c
JOIN order_summary os ON c.customer_id = os.customer_id
WHERE os.num_orders >= 3;

-- 6. Create an index on the "order_date" column of the "orders" table to optimize queries involving date-based filtering.
CREATE INDEX idx_order_date ON orders (order_date);

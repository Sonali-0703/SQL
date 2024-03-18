-- DAY 12 : Advanced Joins and Subqueries

-- Study advanced join techniques: self-joins, non-equijoins, and complex join conditions.
-- Learn to use correlated subqueries and EXISTS operator.
-- Practice writing queries with advanced joins and subqueries.

-- DATASET :
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders (order_id, customer_id, order_date)
VALUES
    (1, 1, '2024-03-15'),
    (2, 2, '2024-03-16'),
    (3, 3, '2024-03-17'),
    (4, 4, '2024-03-18'),
    (5, 5, '2024-03-19'),
    (6, 6, '2024-03-20'),
    (7, 7, '2024-03-21'),
    (8, 8, '2024-03-22'),
    (9, 9, '2024-03-23'),
    (10, 10, '2024-03-24');

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES
    (1, 1, 1, 2),
    (2, 1, 2, 1),
    (3, 2, 3, 3),
    (4, 3, 1, 1),
    (5, 3, 2, 2),
    (6, 4, 4, 1),
    (7, 4, 5, 1),
    (8, 4, 6, 3),
    (9, 5, 7, 2),
    (10, 6, 8, 1);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO products (product_id, product_name)
VALUES
    (1, 'Laptop'),
    (2, 'Smartphone'),
    (3, 'Tablet'),
    (4, 'Headphones'),
    (5, 'Keyboard'),
    (6, 'Mouse'),
    (7, 'Monitor'),
    (8, 'Printer');

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    registration_date DATE
);

INSERT INTO customers (customer_id, customer_name, registration_date)
VALUES
    (1, 'John Doe', '2024-03-01'),
    (2, 'Jane Smith', '2024-03-02'),
    (3, 'Michael Johnson', '2024-03-03'),
    (4, 'Emily Davis', '2024-03-04'),
    (5, 'Chris Wilson', '2024-03-05'),
    (6, 'Sarah Brown', '2024-03-06'),
    (7, 'David Martinez', '2024-03-07'),
    (8, 'Jennifer Taylor', '2024-03-08'),
    (9, 'Daniel Anderson', '2024-03-09'),
    (10, 'Jessica Lee', '2024-03-10');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, manager_id)
VALUES
    (1, 'John', NULL),
    (2, 'Jane', 1),
    (3, 'Michael', 1),
    (4, 'Emily', 2),
    (5, 'Chris', 2),
    (6, 'Sarah', 3);


-- Practice Questions:

-- 1. Write a SQL query to retrieve all the orders that do not have any corresponding items in the "order_items" table using a subquery.
SELECT * FROM order_items;

SELECT *
FROM orders
WHERE order_id NOT IN (SELECT order_id FROM order_items);

-- 2. Write a SQL query to retrieve all the products along with the total quantity sold for each product from the "products" and "order items" tables using a join and subquery.
SELECT * FROM products;
SELECT * FROM order_items;

SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

-- 3. Write a SQL query to retrieve all the customers who have placed an order in the same month and year as their registration date.
SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id, c.customer_name, c.registration_date, o.order_id, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(c.registration_date) = YEAR(o.order_date)
AND MONTH(c.registration_date) = MONTH(o.order_date);

-- 4. Write a SQL query to retrieve all employees and their respective managers from the "employees" table using a self-join.
SELECT * FROM employees;

SELECT e.employee_id, e.employee_name, e.manager_id, m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
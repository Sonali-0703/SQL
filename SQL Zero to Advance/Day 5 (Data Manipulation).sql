-- Data Manipulation
-- Study advanced SQL commands: UPDATE, DELETE, and INSERT INTO SELECT.
-- Understand how to modify existing data in a database.
-- Practice writing queries for data manipulation.

 CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    last_login_date DATE
);

INSERT INTO customers (customer_id, name, last_login_date)
VALUES
(1, 'John Doe', '2023-03-08'),
(2, 'Jane Smith', '2022-05-20'),
(3, 'David Brown', '2023-10-15'),
(4, 'Emily Johnson', '2022-12-01'),
(5, 'Michael Davis', '2023-08-25'),
(6, 'Sarah Wilson', '2022-09-10'),
(7, 'James Miller', '2023-02-28'),
(8, 'Jessica Lee', '2022-07-14'),
(9, 'Daniel Martinez', '2023-11-05'),
(10, 'Emma Taylor', '2022-04-30');

CREATE TABLE temp_employees (
    temp_employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO temp_employees (temp_employee_id, name, salary, department_id)
VALUES
(1, 'Mark Johnson', 55000.00, 201),
(2, 'Laura White', 60000.00, 202),
(3, 'Robert Garcia', 53000.00, 201),
(4, 'Jennifer Martinez', 62000.00, 203),
(5, 'William Clark', 58000.00, 202),
(6, 'Mary Rodriguez', 54000.00, 201),
(7, 'Thomas Anderson', 61000.00, 203),
(8, 'Lisa Harris', 59000.00, 202),
(9, 'Christopher Lopez', 56000.00, 201),
(10, 'Patricia King', 63000.00, 203);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    discount DECIMAL(5, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, discount)
VALUES
(1, 1, '2023-01-05', 0.05),
(2, 2, '2022-03-15', 0.10),
(3, 3, '2023-07-20', 0.15),
(4, 4, '2022-12-10', 0.20),
(5, 5, '2023-05-25', 0.25),
(6, 6, '2022-09-01', 0.30),
(7, 7, '2023-02-28', 0.35),
(8, 8, '2022-07-10', 0.40),
(9, 9, '2023-10-05', 0.45),
(10, 10, '2022-04-20', 0.50);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    quantity INT
);

INSERT INTO products (product_id, name, price, quantity)
VALUES
(1, 'Product A', 110.50, 5),
(2, 'Product B', 120.25, 10),
(3, 'Product C', 115.75, 15),
(4, 'Product D', 130.00, 20),
(5, 'Product E', 125.50, 25),
(6, 'Product F', 118.75, 30),
(7, 'Product G', 132.25, 35),
(8, 'Product H', 122.00, 40),
(9, 'Product I', 112.50, 45),
(10, 'Product J', 135.75, 50);




-- Practice Questions:

-- 1. Write a SQL query to delete all records from the "customers" table. where the "last_login_date" is older than 1 year.
DELETE FROM customers
WHERE last_login_date < DATE_SUB(NOW(), 
INTERVAL 1 YEAR);
SET SQL_SAFE_UPDATES = 0;


-- 2. Write a SQL query to insert new records into the "employees" table, selecting data from the "temp. employees" table.
INSERT INTO employees (employee_id, name, salary, department_id)
SELECT temp_employee_id, name, salary, department_id
FROM temp_employees;


-- 3. Write a SQL query to update the "discount" column of the "orders" table by increasing it by 5% for all orders placed before a specific date.
UPDATE orders
SET discount = discount + 0.05
WHERE order_date < '2023-01-01';


-- 4. Write a SQL query to update the "quantity" column of the "products" table to 20 for all products with a price greater than 100.
UPDATE products
SET quantity = 20
WHERE price > 100;
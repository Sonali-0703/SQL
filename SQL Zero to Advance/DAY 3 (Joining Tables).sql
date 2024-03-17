-- Joining Tables
-- Understand the concept of joining tables.
-- Learn about different types of joins: INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN.
-- Practice writing queries that involve joining multiple tables.
-- Write a SQL query to retrieve the customer name and order date from the "customers" and "orders" tables, joining them on the "customer_id" column.
-- Practice Questions:

   
-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Insert records into customers table
INSERT INTO customers (customer_id, customer_name)
VALUES 
(1, 'ABC Inc.'),
(2, 'XYZ Corp.'),
(3, 'LMN Co.');

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount INT
);

-- Insert records into orders table
INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES 
(1, 1, '2024-01-15', 1200),
(2, 2, '2024-02-20', 800),
(3, 1, '2024-03-05', 1500),
(4, 3, '2024-03-10', 900);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    supplier_id INT
);

-- Insert records into products table
INSERT INTO products (product_id, product_name, category_id, supplier_id)
VALUES 
(1, 'Laptop', 1, 1),
(2, 'Smartphone', 1, 2),
(3, 'Tablet', 1, 3);

-- Create categories table
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

-- Create suppliers table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100)
);

-- Insert records into suppliers table
INSERT INTO suppliers (supplier_id, supplier_name)
VALUES 
(1, 'Supplier A'),
(2, 'Supplier B'),
(3, 'Supplier C');

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT
);

-- Insert records into employees table
INSERT INTO employees (employee_id, employee_name, department_id)
VALUES 
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Mark Johnson', 1);

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Insert records into departments table
INSERT INTO departments (department_id, department_name)
VALUES 
(1, 'Sales'),
(2, 'Marketing'),
(3, 'HR');


-- Q1. Write a SQL query to retrieve the product name, category, and supplier name from the "products", "categories", and "suppliers" tables, joining them on the appropriate columns.
SELECT products.product_name, categories.category_name, suppliers.supplier_name
FROM products
JOIN categories 
ON products.category_id = categories.category_id
JOIN suppliers ON products.supplier_id = suppliers.supplier_id;


-- Q2. Write a SQL query to retrieve the employee name and department name from the "employees" and "departments" tables, joining them on the "department_id" column.
SELECT employees.employee_name, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;


-- Q3. Write a SQL query to retrieve the customer name and order amount from the "customers" and "orders" tables, joining them on the "customer_id" column, and only including orders with amounts greater than 1000.
SELECT customers.customer_name, orders.order_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_amount > 1000;
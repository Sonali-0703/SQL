-- Data Integrity and Constraints
-- Learn about data integrity and the role of constraints.
-- Understand different types of constraints: NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY.
-- Practice creating tables with constraints.

DROP TABLE orders;
DROP TABLE products; 
DROP TABLE employees;
DROP TABLE categories;
  

-- Practice Questions:

-- 1. Create a table named "orders" with columns for order ID, customer ID, and order date, where the order ID is the primary key and the customer ID references the "customers" table.
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
SELECT * FROM orders;
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

-- 2. Create a table named "products" with columns for product ID, name, and price, where the product ID is the primary key and the price cannot be null.
 CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL
);

-- 3. Create a table named "categories" with columns for category ID and name, where the category ID is the primary key and the name must be unique.
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

-- 4. Create a table named "employees" with columns for employee ID, name, and email, where the employee ID is the primary key and the email must be unique.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
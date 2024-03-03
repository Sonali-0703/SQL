-- Introduction to SQL and Relational  Databases
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(100)
);

-- Insert records into employees table
INSERT INTO employees (employee_id, first_name, last_name, job_title)
VALUES 
(1, 'John', 'Doe', 'Manager'),
(2, 'Jane', 'Smith', 'Sales Associate'),
(3, 'Mark', 'Johnson', 'Analyst');
SELECT * FROM employees;
-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

-- Insert records into products table
INSERT INTO products (product_id, product_name, quantity)
VALUES 
(1, 'Laptop', 5),
(2, 'Smartphone', 8),
(3, 'Tablet', 12),
(4, 'Headphones', 15),
(5, 'Mouse', 7);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    status VARCHAR(50)
);

-- Insert records into orders table
INSERT INTO orders (order_id, product_id, quantity, status)
VALUES 
(1, 1, 2, 'completed'),
(2, 3, 5, 'cancelled'),
(3, 4, 3, 'pending'),
(4, 5, 1, 'cancelled');
-- Q1. Write a SQL query to insert a new record into the "employees" table.
SELECT * FROM employees;
INSERT INTO employees VALUES
(4,"Sonali", "Sharma", "Data Scientist"),
(5,"Shivaram", "Babar", "Sr.Data Scientist");
SELECT *FROM employees;

-- Q2. Write a SQL query to update the "quantity" column of the "products" table to 10 where the "product_id" is 5.
SELECT * FROM products;
UPDATE products
SET quantity =10
WHERE product_id =5;
SELECT * FROM products;

-- Q3.Write a SQL query to delete all records from the "orders" table where the "status" is 'cancelled'.
DELETE FROM orders
WHERE status = "cancelled"; 
SELECT *FROM orders;

SET SQL_SAFE_UPDATES = 0;

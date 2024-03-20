-- DAY 16 : Aggregations and Grouping

-- Aim : Understand aggregate functions and grouping data using the GROUP BY clause.
 
-- DATASET :

-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    total_order_amount DECIMAL(10, 2)
);

-- Insert sample records into Customers table
INSERT INTO Customers (customer_id, customer_name, total_order_amount) VALUES
(1, 'John Doe', 500.00),
(2, 'Alice Smith', 750.50),
(3, 'Bob Johnson', 300.25),
(4, 'Emily Brown', 900.80);

-- Create Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert sample records into Departments table
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'Human Resources');

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_quantity INT,
    total_amount DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Insert sample records into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_quantity, total_amount, department_id) VALUES
(1, 1, '2024-03-01', 5, 100.00, 1),
(2, 1, '2024-03-03', 3, 75.50, 2),
(3, 2, '2024-03-05', 10, 200.25, 3),
(4, 3, '2024-03-08', 2, 50.30, 1),
(5, 4, '2024-03-10', 8, 150.20, 2);

-- Create Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    age INT,
    job_title VARCHAR(50)
);

-- Insert sample records into Employees table
INSERT INTO Employees (employee_id, employee_name, age, job_title) VALUES
(1, 'Michael Johnson', 35, 'Sales Manager'),
(2, 'Emma White', 28, 'Marketing Specialist'),
(3, 'David Lee', 42, 'Financial Analyst'),
(4, 'Sophia Garcia', 30, 'HR Coordinator');

-- Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    amount DECIMAL(10, 2),
    rating DECIMAL(3, 2),
    reviews INT,
    category VARCHAR(50),
    supplier_id INT
);

-- Insert sample records into Products table
INSERT INTO Products (product_id, product_name, quantity, amount, rating, reviews, category, supplier_id) VALUES
(1, 'Laptop', 50, 800.00, 4.5, 100, 'Electronics', 1),
(2, 'Smartphone', 100, 600.00, 4.2, 150, 'Electronics', 2),
(3, 'T-Shirt', 200, 20.00, 4.0, 50, 'Clothing', 3),
(4, 'Sunglasses', 50, 50.00, 4.3, 30, 'Accessories', 4);

-- Create Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100)
);

-- Insert sample records into Suppliers table
INSERT INTO Suppliers (supplier_id, supplier_name) VALUES
(1, 'Techtronics Inc.'),
(2, 'Gadget World Ltd.'),
(3, 'Fashion Trends LLC'),
(4, 'Eyewear Express');

-- Practice Questions and Answers

-- 1. Calculate the total order amount for each customer.
SELECT customer_id, SUM(total_amount) AS total_order_amount 
FROM Orders 
GROUP BY customer_id;

-- 2. Calculate the average rating and the number of reviews for each product category.
SELECT category, AVG(rating) AS average_rating, SUM(reviews) AS total_reviews 
FROM Products 
GROUP BY category;

-- 3. Get the maximum and minimum prices for each product category.
SELECT category, MAX(amount) AS max_price, MIN(amount) AS min_price 
FROM Products 
GROUP BY category;

-- 4. Calculate the total quantity and total amount for each order.
SELECT order_id, SUM(total_quantity) AS total_quantity, SUM(total_amount) AS total_amount 
FROM Orders 
GROUP BY order_id;

-- 5. Find the average age and the number of employees for each job title.
SELECT job_title, AVG(age) AS average_age, COUNT(*) AS employee_count 
FROM Employees 
GROUP BY job_title;

-- 6. Get the total number of products in each category.
SELECT category, COUNT(*) AS product_count 
FROM Products 
GROUP BY category;

-- 7. Calculate the average rating and the number of reviews for each product.
SELECT product_id, AVG(rating) AS average_rating, SUM(reviews) AS total_reviews 
FROM Products 
GROUP BY product_id;

-- 8. Find the customers with the highest and lowest total order amounts.
SELECT customer_id, total_order_amount 
FROM Customers 
ORDER BY total_order_amount DESC 
LIMIT 1;

SELECT customer_id, total_order_amount 
FROM Customers 
ORDER BY total_order_amount ASC 
LIMIT 1;

-- 9. Find the average price and the number of products for each supplier.
SELECT supplier_id, AVG(amount) AS average_price, COUNT(*) AS product_count 
FROM Products 
GROUP BY supplier_id;

-- 10. Calculate the total sales amount and the number of orders for each month.
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_sales_amount, COUNT(*) AS order_count 
FROM Orders 
GROUP BY MONTH(order_date);
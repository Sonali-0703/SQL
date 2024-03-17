-- Working with Functions
-- Study various SQL functions: String functions, Date functions, and Numeric functions.
-- Learn how to use these functions in your queries.
-- Practice writing queries that involve SQL functions.

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


-- Practice Questions:

-- 1. Write a SQL query to retrieve the current date and time.
SELECT CURRENT_TIMESTAMP;

-- 2. Write a SQL query to retrieve the uppercase names of all the employees from the "employees table.
SELECT UPPER(name) AS uppercase_name FROM employees;

-- 3. Write a SQL query to retrieve the average price of products after applying a 10% discount from the "products" table.
SELECT AVG(price * 0.9) AS avg_discounted_price FROM products;

-- 4. Write a SQL query to retrieve the length of the product names from tha "products" table.
SELECT name, LENGTH(name) AS name_length FROM products;

-- 5. Write a SQL query to retrieve the current year.
SELECT YEAR(CURRENT_DATE) AS current_year;

-- 6. Write a SQL query to retrieve the names of employees with their hire dates formatted as 'Month Day, Year'.
SELECT name, DATE_FORMAT(hire_date, '%M %e, %Y') AS formatted_hire_date FROM employees;

-- 7. Write a SQL query to retrieve the total number of products available.
SELECT COUNT(*) AS total_products FROM products;

-- 8. Write a SQL query to retrieve the total price of all products.
SELECT SUM(price) AS total_price FROM products;

-- 9. Write a SQL query to retrieve the names of products along with their prices rounded to the nearest integer.
SELECT name, ROUND(price) AS rounded_price FROM products;

-- 10. Write a SQL query to retrieve the number of employees hired each year.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS hire_count 
FROM employees 
GROUP BY YEAR(hire_date);
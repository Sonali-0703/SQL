-- Filtering and Sorting Data
-- Learn about the WHERE clause and its usage for filtering data.
-- Study the ORDER BY clause for sorting data.
-- Practice writing queries with filtering and sorting.


-- Write a SQL query to retrieve all the columns from the "employees" table where the "salary" is greater than 50000.
-- Practice Questions:
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, product_name, category, price)
VALUES
    (1, 'Laptop', 'Electronics', 1200),
    (2, 'Smartphone', 'Electronics', 800),
    (3, 'Headphones', 'Electronics', 50),
    (4, 'Tablet', 'Electronics', 700);
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orders (order_id, customer_id, product_id, quantity)
VALUES
    (1, 1, 1, 2),
    (2, 2, 2, 1),
    (3, 3, 1, 3),
    (4, 4, 3, 1),
    (5, 1, 4, 2);
    DROP TABLE CUSTOMERS;
    DROP TABLE PRODUCTS;
	DROP TABLE ORDERS;
-- Q1. Write a SQL query to retrieve all the columns from the "products" table where the "category" is "Electronics' and the "price" is less than 1000.
SELECT * FROM PRODUCTS
WHERE category ="Electronics" AND price < 1000;
-- Q2. Write a SQL query to retrieve the names of all customers from the "customers" table in alphabetical order.
	SELECT * FROM customers;
	ORDER BY customer_name ASC;
-- Q3. Write a SQL query to retrieve the total number of orders from the "orders" table.
SELECT * FROM orders;

SELECT COUNT(*) AS total_orders
FROM orders;
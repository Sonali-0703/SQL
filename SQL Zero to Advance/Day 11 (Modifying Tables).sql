-- Modifying Tables
-- Study commands for modifying existing tables: ALTER TABLE, DROP TABLE, and RENAME TABLE.
-- Learn how to add, modify, and delete columns in a table.
-- Practice modifying table structures.

-- DATASET :
CREATE TABLE customer_details (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customer_details (customer_id, customer_name, email)
VALUES
    (1, 'John Doe', 'john@example.com'),
    (2, 'Jane Smith', 'jane@example.com'),
    (3, 'Michael Johnson', 'michael@example.com'),
    (4, 'Emily Davis', 'emily@example.com'),
    (5, 'Chris Wilson', 'chris@example.com'),
    (6, 'Sarah Brown', 'sarah@example.com'),
    (7, 'David Martinez', 'david@example.com'),
    (8, 'Jennifer Taylor', 'jennifer@example.com'),
    (9, 'Daniel Anderson', 'daniel@example.com'),
    (10, 'Jessica Lee', 'jessica@example.com');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2),
    quantity INT
);

INSERT INTO products (product_id, product_name, price, quantity)
VALUES
    (1, 'Laptop', 999.99, 20),
    (2, 'Smartphone', 499.99, 30),
    (3, 'Tablet', 299.99, 15),
    (4, 'Headphones', 99.99, 50),
    (5, 'Keyboard', 49.99, 25),
    (6, 'Mouse', 29.99, 40),
    (7, 'Monitor', 199.99, 10),
    (8, 'Printer', 149.99, 5),
    (9, 'Speaker', 79.99, 20),
    (10, 'External Hard Drive', 129.99, 15);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date VARCHAR(20),
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
    (1, 1, '2024-03-15', 999.99),
    (2, 2, '2024-03-16', 299.99),
    (3, 3, '2024-03-17', 99.99),
    (4, 4, '2024-03-18', 49.99),
    (5, 5, '2024-03-19', 29.99),
    (6, 6, '2024-03-20', 199.99),
    (7, 7, '2024-03-21', 149.99),
    (8, 8, '2024-03-22', 79.99),
    (9, 9, '2024-03-23', 129.99),
    (10, 10, '2024-03-24', 999.99);
    
-- PRACTICE QUESTIONS
-- 1. Rename the table "customer_details" to "client_details".
ALTER TABLE customer_details RENAME client_details;
SELECT * FROM client_details;

-- 2. Delete the "quantity" column from the "products" table.
ALTER TABLE products
DROP COLUMN quantity;
SELECT * FROM products;

-- 3. Modify the "orders" table to change the data type of the "order_date" column to DATE.
ALTER TABLE orders 
MODIFY order_date DATE;
SELECT * FROM orders;

-- 4. Alter the "employees" table to add a new column named "address" of type VARCHAR(100). (Assuming an "employees" table exists)
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
(9, 201, 'Daniel Martinez', 54000.00);

ALTER TABLE employees
ADD address VARCHAR(100);
SELECT * FROM employees;

-- 5. Modify the "products" table to add a new column named "description" of type TEXT.
ALTER TABLE products
ADD description TEXT;
SELECT * FROM products;

-- 6. Alter the "orders" table to add a foreign key constraint named "fk_customer_id" referencing the "client_details" table on the "customer_id" column.
ALTER TABLE orders
ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES client_details(customer_id);

-- 7. Change the data type of the "price" column in the "products" table to DECIMAL(10, 2).
ALTER TABLE products
MODIFY price DECIMAL(10, 2);
SELECT * FROM products;

-- 8. Add a new column named "phone_number" of type VARCHAR(20) to the "client_details" table.
ALTER TABLE client_details
ADD phone_number VARCHAR(20);
SELECT * FROM client_details;

-- 9. Modify the "orders" table to add a new column named "order_status" of type VARCHAR(20).
ALTER TABLE orders
ADD order_status VARCHAR(20);
SELECT * FROM orders;

-- 10. Alter the "employees" table to drop the "address" column.
ALTER TABLE employees
DROP COLUMN address;
SELECT * FROM employees;
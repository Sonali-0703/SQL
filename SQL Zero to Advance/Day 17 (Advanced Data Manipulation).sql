-- DAY 17 : Advanced Data Manipulation

-- Aim : Learn to update and delete data, and handle transactions and concurrency.

-- DATASET : 
-- Create sample tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2),
    category_id INT,
    supplier_id INT,
    discount_percentage DECIMAL(5, 2),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE OrderItems (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    rating INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50)
);

-- Sample data insertion for demonstration
INSERT INTO Customers (customer_id, customer_name, email) VALUES
(1, 'John Doe', 'johndoe@example.com'),
(2, 'Jane Smith', 'janesmith@example.com');

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(101, 1, '2023-03-15'),
(102, 2, '2023-02-20');

INSERT INTO Products (product_id, product_name, price, category_id, supplier_id, discount_percentage) VALUES
(1, 'Product A', 19.99, 1, 1, 0),
(2, 'Product B', 29.99, 2, 2, 0);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Category A'),
(2, 'Category B');

INSERT INTO OrderItems (item_id, order_id, product_id, quantity) VALUES
(1001, 101, 1, 2),
(1002, 102, 2, 1);

INSERT INTO Employees (employee_id, employee_name, salary, department_id) VALUES
(1, 'Alice Johnson', 50000, 1),
(2, 'Bob Smith', 60000, 2);

INSERT INTO Reviews (review_id, product_id, rating) VALUES
(2001, 1, 4),
(2002, 2, 3);

INSERT INTO Suppliers (supplier_id, supplier_name) VALUES
(1, 'Supplier A'),
(2, 'Supplier B');

-- Practice Questions

-- 1. Update the email address of a specific customer.
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 1;

-- 2. Delete all orders placed by a certain customer.
DELETE FROM Orders
WHERE customer_id = 2;

-- 3. Increase the salary of all employees by 10%.
UPDATE Employees
SET salary = salary * 1.1;
SET SQL_SAFE_UPDATES = 0;

-- 4. Update the discount percentage for all products in a specific price range.
UPDATE Products
SET discount_percentage = 20
WHERE price BETWEEN 10 AND 20;

-- 5. Delete all reviews with a rating lower than 3.
DELETE FROM Reviews
WHERE rating < 3;

-- 6. Increase the salary of all employees in a specific department by 15%.
UPDATE Employees
SET salary = salary * 1.15
WHERE department_id = 1;

-- 7. Delete all products that have not been ordered.
DELETE FROM Products
WHERE product_id NOT IN (SELECT product_id FROM OrderItems);
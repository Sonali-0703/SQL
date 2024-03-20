-- DAY 18 : Advanced Database Concepts

-- Aim : Understand views and their usage, as well as indexing and optimization techniques.

-- DATASET : 
-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity_in_stock INT,
    category_id INT,
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, quantity_in_stock, category_id, price)
VALUES 
    (1, 'Product A', 100, 1, 50.00),
    (2, 'Product B', 150, 2, 75.00),
    (3, 'Product C', 200, 1, 100.00),
    (4, 'Product D', 75, 3, 120.00),
    (5, 'Product E', 120, 2, 90.00);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
    (1, 101, '2023-01-15', 250.00),
    (2, 102, '2023-02-20', 180.00),
    (3, 103, '2023-03-10', 350.00),
    (4, 104, '2023-04-05', 420.00),
    (5, 105, '2023-05-12', 300.00);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample data for OrderDetails table
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price)
VALUES
    (1, 1, 1, 2, 50.00),
    (2, 1, 2, 3, 75.00),
    (3, 2, 3, 1, 100.00),
    (4, 3, 4, 4, 120.00),
    (5, 4, 5, 2, 90.00);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Sample data for Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email)
VALUES
    (101, 'John', 'Doe', 'john@example.com'),
    (102, 'Jane', 'Smith', 'jane@example.com'),
    (103, 'Michael', 'Johnson', 'michael@example.com'),
    (104, 'Emily', 'Brown', 'emily@example.com'),
    (105, 'William', 'Taylor', 'william@example.com');

-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Sample data for Categories table
INSERT INTO Categories (category_id, category_name)
VALUES
    (1, 'Category 1'),
    (2, 'Category 2'),
    (3, 'Category 3');

-- Create Reviews table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    rating INT,
    review_text TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample data for Reviews table
INSERT INTO Reviews (review_id, product_id, rating, review_text)
VALUES
    (1, 1, 4, 'Great product!'),
    (2, 1, 5, 'Excellent quality.'),
    (3, 2, 3, 'Good value for money.'),
    (4, 3, 5, 'Amazing product!'),
    (5, 3, 4, 'Highly recommended.');

-- Create Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Sample data for Employees table
INSERT INTO Employees (employee_id, first_name, last_name, department_id, salary)
VALUES
    (1, 'Robert', 'Johnson', 101, 60000.00),
    (2, 'Mary', 'Williams', 102, 55000.00),
    (3, 'James', 'Jones', 101, 62000.00),
    (4, 'Sarah', 'Davis', 103, 58000.00),
    (5, 'David', 'Miller', 102, 56000.00);

-- Practice Questions
-- 1. Create a view to retrieve the list of products and their quantities in stock.
CREATE VIEW ProductQuantities AS
SELECT product_name, quantity_in_stock
FROM Products;

-- 2. Optimize a slow-performing query using proper indexing techniques.
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);

-- 3. Create a view to display the total sales amount for each product.
CREATE VIEW ProductTotalSales AS
SELECT p.product_name, SUM(od.quantity * od.price) AS total_sales_amount
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name;

-- 4. Optimize a query that retrieves the order details for a specific customer, sorting them by the order date in descending order.
CREATE INDEX idx_orders_customer_order_date ON Orders(customer_id, order_date);

-- 5. Create an index on the "last_name" column of the "Employees" table and measure the performance improvement on a specific query.
CREATE INDEX idx_employees_last_name ON Employees(last_name);

-- 6. Create a view to display the average rating and the number of reviews for each product.
CREATE VIEW ProductReviews AS
SELECT product_id, AVG(rating) AS avg_rating, COUNT(*) AS num_reviews
FROM Reviews
GROUP BY product_id;

-- 7. Optimize a query that retrieves the top 10 customers with the highest total order amounts.
CREATE INDEX idx_orders_total_amount ON Orders(total_amount);

-- 8. Create an index on the "order_date" column of the "Orders" table and analyze the query performance for a specific date range.
CREATE INDEX idx_orders_order_date ON Orders(order_date);

-- 9. Create a view to display the average salary for each department.
CREATE VIEW DepartmentAverageSalary AS
SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;

-- 10. Optimize a query that retrieves the list of products with their respective categories, filtering them by a specific category.
CREATE INDEX idx_categories_category_name ON Categories(category_name);

-- 11. Create an index on the "product_name" column of the "Products" table and analyze the query performance for a specific search term.
CREATE INDEX idx_products_product_name ON Products(product_name);

-- 12. Create a view to display the total order amount for each customer.
CREATE VIEW CustomerTotalOrderAmount AS
SELECT customer_id, SUM(total_amount) AS total_order_amount
FROM Orders
GROUP BY customer_id;
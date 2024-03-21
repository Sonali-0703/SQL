-- DAY 20 : SQL Performance Optimization

-- Aim : Learn techniques for optimizing SQL queries and improving performance.

-- Resources:
-- "Tips for Optimizing SQL Queries on dev.to (https://dev.to/ techgirl1908/tips-for-optimizing-sql-queries-28f3)
-- "SQL Query Optimization Techniques" on tutorialgateway.org (https://www.tutorialgateway.org/sql-query-optimization- techniques/

-- DATASET : 
-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10, 2)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2)
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Create Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(20)
);

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- Insert data into Products
INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, Price)
VALUES 
    (1, 'Laptop', 1, 1, 1200.00),
    (2, 'Smartphone', 1, 2, 800.00),
    (3, 'Tablet', 1, 1, 500.00),
    (4, 'Headphones', 2, 3, 100.00),
    (5, 'Keyboard', 2, 4, 50.00);

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
    (1, 1, '2024-03-10', 1500.00),
    (2, 2, '2024-03-15', 950.00),
    (3, 3, '2024-03-20', 200.00);

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES 
    (1, 1, 1, 1, 1200.00),
    (2, 1, 4, 1, 100.00),
    (3, 2, 2, 1, 800.00),
    (4, 3, 5, 2, 100.00);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone)
VALUES 
    (1, 'John Doe', 'john@example.com', '123-456-7890'),
    (2, 'Jane Smith', 'jane@example.com', '987-654-3210'),
    (3, 'Alice Johnson', 'alice@example.com', '555-123-4567');

-- Insert data into Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Phone)
VALUES 
    (1, 'Supplier A', 'John Supplier', '111-222-3333'),
    (2, 'Supplier B', 'Jane Supplier', '444-555-6666'),
    (3, 'Supplier C', 'Alice Supplier', '777-888-9999'),
    (4, 'Supplier D', 'Bob Supplier', '000-111-2222');

-- Insert data into Categories
INSERT INTO Categories (CategoryID, CategoryName)
VALUES 
    (1, 'Electronics'),
    (2, 'Accessories');

 
-- Practice Questions

-- 1. Rewrite a subquery as a join to improve query performance.
SELECT c.CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);

-- 2. Rewrite a subquery as a join in a query that retrieves the order details along with the customer names for all orders.
SELECT 
    c.CustomerName, 
    od.*
FROM 
    OrderDetails od
INNER JOIN 
    Orders o ON od.OrderID = o.OrderID
INNER JOIN 
    Customers c ON o.CustomerID = c.CustomerID;

-- 3. Use appropriate indexes to optimize query execution.
CREATE INDEX idx_ProductID ON Products(ProductID);

-- 4. Identify and eliminate unnecessary joins in a query that retrieves product details and their corresponding categories. 
 SELECT 
    p.ProductID, 
    p.ProductName, 
    p.Price, 
    p.CategoryID
FROM 
    Products p;

-- 5.Optimize a query that retrieves customer details along with their total order amounts for a specific date range.
SELECT c.CustomerID,
    c.CustomerName,
    SUM(o.TotalAmount) AS TotalOrderAmount
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderDate BETWEEN 'start_date' AND 'end_date'
GROUP BY 
    c.CustomerID, c.CustomerName;
 
-- 6. Rewrite a subquery as a join in a query that retrieves the names of customers who have placed at least two orders.
SELECT c.CustomerName
FROM Customers c
INNER JOIN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(*) >= 2
) o ON c.CustomerID = o.CustomerID;

-- 7. Optimize a query that calculates the total sales amount for each month by using appropriate indexes.
CREATE INDEX idx_OrderDate ON Orders(OrderDate);

SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);

-- 8. Identify and eliminate unnecessary joins in a query that retrieves product details and their corresponding suppliers' names. 
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- 9. Rewrite a subquery as a join in a query that retrieves the names of customers who have placed orders in the past 30 days. 
SELECT DISTINCT c.CustomerName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- 10. Optimize a query that retrieves the top 5 products with the highest sales amounts by using appropriate indexes. 
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 5;
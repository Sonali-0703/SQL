-- DAY 19 : Advanced SQL Functions

-- Aim : Explore window functions and stored procedures.

-- DATASET : 
-- Create tables for adjusted dataset
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2)
);

CREATE TABLE EmployeeSalaryLogs (
    LogID INT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10, 2),
    NewSalary DECIMAL(10, 2),
    ChangeDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    ProductID INT,
    Rating DECIMAL(3, 1),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample data insertion
INSERT INTO Products (ProductID, Name, CategoryID, Price, StockQuantity) VALUES
(1, 'Product A', 1, 10.99, 100),
(2, 'Product B', 1, 15.99, 150),
(3, 'Product C', 2, 20.49, 80);

INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES
(1, 'John Doe', 'john@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane@example.com', '987-654-3210');

INSERT INTO Employees (EmployeeID, Name, Position, Salary) VALUES
(1, 'Alice Johnson', 'Manager', 50000.00),
(2, 'Bob Smith', 'Sales Associate', 35000.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, '2024-03-20', 50.99),
(102, 2, '2024-03-21', 75.49);

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price) VALUES
(1, 101, 1, 2, 10.99),
(2, 101, 2, 3, 15.99),
(3, 102, 3, 4, 20.49);

INSERT INTO Ratings (RatingID, ProductID, Rating) VALUES
(1, 1, 4.5),
(2, 2, 3.8),
(3, 3, 4.2);

-- 1. Calculate the cumulative sales amount for each product using a window function.
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    SUM(o.TotalAmount) OVER(PARTITION BY p.ProductID ORDER BY o.OrderDate) AS CumulativeSalesAmount
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
LEFT JOIN Orders o ON oi.OrderID = o.OrderID;

-- 2. Create a stored procedure to insert a new customer into the database.
DELIMITER //

CREATE PROCEDURE InsertCustomer (
    IN Name VARCHAR(100),
    IN Email VARCHAR(100),
    IN Phone VARCHAR(20)
)
BEGIN
    INSERT INTO Customers (Name, Email, Phone)
    VALUES (Name, Email, Phone);
END //

-- 3. Retrieve the top 3 customers based on their total order amounts, and calculate the percentage of each customer's order amount compared to the total.
SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(o.TotalAmount) AS TotalOrderAmount,
    (SUM(o.TotalAmount) * 100.0 / (SELECT SUM(TotalAmount) FROM Orders)) AS OrderPercentage
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalOrderAmount DESC
LIMIT 3;

-- 4. Create a stored procedure to update the salary of an employee and log the change in a separate table. 
DELIMITER //
CREATE PROCEDURE UpdateEmployeeSalary (
    IN EmployeeID INT,
    IN NewSalary DECIMAL(10,2)
)
BEGIN
    DECLARE OldSalary DECIMAL(10,2);

    SELECT Salary INTO OldSalary FROM Employees WHERE EmployeeID = EmployeeID;

    UPDATE Employees SET Salary = NewSalary WHERE EmployeeID = EmployeeID;

    INSERT INTO EmployeeSalaryLogs (EmployeeID, OldSalary, NewSalary, ChangeDate)
    VALUES (EmployeeID, OldSalary, NewSalary, CURDATE());
END //

-- 5. Calculate the average rating for each product and assign a rank based on the rating using a window function.
SELECT 
    ProductID,
    AVG(Rating) AS AvgRating,
    RANK() OVER(ORDER BY AVG(Rating) DESC) AS RatingRank
FROM Ratings
GROUP BY ProductID;

-- 6. Implement a stored procedure to insert a new order along with its order items into the database.
DELIMITER //

CREATE PROCEDURE InsertOrderWithItems (
    IN CustomerID INT,
    IN OrderDate DATE,
    IN OrderItemsData JSON
)
BEGIN
    DECLARE NewOrderID INT;
    
    -- Insert order
    INSERT INTO Orders (CustomerID, OrderDate)
    VALUES (CustomerID, OrderDate);
    
    -- Get the ID of the newly inserted order
    SET NewOrderID = LAST_INSERT_ID();

    -- Loop through each order item in the JSON array and insert into OrderItems table
    INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price)
    SELECT NewOrderID, JSON_VALUE(OrderItem, '$.ProductID'), JSON_VALUE(OrderItem, '$.Quantity'), JSON_VALUE(OrderItem, '$.Price')
    FROM JSON_TABLE(OrderItemsData, '$[*]' COLUMNS (
        OrderItem JSON PATH '$'
    )) AS Items;

END //

-- 7. Retrieve the top 5 products based on the cumulative sales amount using a window function.
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    SUM(o.TotalAmount) AS CumulativeSalesAmount
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
JOIN Orders o ON oi.OrderID = o.OrderID
GROUP BY p.ProductID, p.Name
ORDER BY CumulativeSalesAmount DESC
LIMIT 5;

-- 8. Create a stored procedure to calculate the total order amount for a specific customer and return the result.
 DELIMITER //
CREATE PROCEDURE CalculateTotalOrderAmount (
    IN CustomerID INT,
    OUT TotalAmount DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(TotalAmount) INTO TotalAmount
    FROM Orders
    WHERE CustomerID = CustomerID;
END //

-- 9. Implement a stored procedure to delete a customer and all associated orders and order items from the database. 
 DELIMITER //
CREATE PROCEDURE DeleteCustomerAndOrders (
    IN CustomerID INT
)
BEGIN
    DECLARE order_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR 
        SELECT OrderID FROM Orders WHERE CustomerID = CustomerID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Delete order items associated with the customer's orders
    DELETE FROM OrderItems WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = CustomerID);

    -- Delete orders associated with the customer
    DELETE FROM Orders WHERE CustomerID = CustomerID;

    -- Delete the customer
    DELETE FROM Customers WHERE CustomerID = CustomerID;
END //

 -- 10. Calculate the average rating for each product category and assign a rank based on the rating using a window function. 
SELECT 
    p.CategoryID,
    AVG(r.Rating) AS AvgRating,
    RANK() OVER(ORDER BY AVG(r.Rating) DESC) AS RatingRank
FROM Products p
LEFT JOIN Ratings r ON p.ProductID = r.ProductID
GROUP BY p.CategoryID;

-- 11. Create a stored procedure to update the quantity in stock for a specific product and log the change in a separate table. 
DELIMITER //
CREATE PROCEDURE UpdateProductStockQuantity (
    IN ProductID INT,
    IN NewStockQuantity INT
)
BEGIN
    DECLARE OldStockQuantity INT;

    -- Get the current stock quantity
    SELECT StockQuantity INTO OldStockQuantity FROM Products WHERE ProductID = ProductID;

    -- Update the stock quantity
    UPDATE Products SET StockQuantity = NewStockQuantity WHERE ProductID = ProductID;

    -- Log the stock quantity change
    INSERT INTO ProductStockLogs (ProductID, OldStockQuantity, NewStockQuantity, ChangeDate)
    VALUES (ProductID, OldStockQuantity, NewStockQuantity, CURDATE());
END //
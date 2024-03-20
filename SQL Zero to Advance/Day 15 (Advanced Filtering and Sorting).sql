-- DAY 15 : Advanced Filtering and Sorting

-- Aim : Learn advanced filtering techniques and sorting options in SQL queries.

-- DATASET : 
-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, Salary)
VALUES 
(1, 'John', 'Doe', '2022-01-01', 50000.00),
(2, 'Jane', 'Smith', '2022-02-15', 60000.00),
(3, 'Alice', 'Johnson', '2022-03-20', 55000.00),
(4, 'Bob', 'Williams', '2022-04-10', 52000.00),
(5, 'Jack', 'Brown', '2022-05-05', 48000.00),
(6, 'Jill', 'Taylor', '2022-06-30', 65000.00),
(7, 'Alex', 'Moore', '2022-07-15', 70000.00),
(8, 'Anna', 'Clark', '2022-08-20', 53000.00),
(9, 'Sam', 'Adams', '2022-09-25', 58000.00),
(10, 'Eric', 'White', '2022-10-10', NULL);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT,
    Name VARCHAR(50)
);

INSERT INTO Customers (CustomerID, Name)
VALUES 
(1, 'Andrew'),
(2, 'Betty'),
(3, 'Carolyn'),
(4, 'David'),
(5, 'Evan'),
(6, 'Alan'),
(7, 'Martin'),
(8, 'Shane'),
(9, 'Grace'),
(10, 'Aaron Smith');

-- Products Table
CREATE TABLE Products (
    ProductID INT,
    Name VARCHAR(50)
);

INSERT INTO Products (ProductID, Name)
VALUES 
(1, 'Red Shoes'),
(2, 'Blue Dress'),
(3, 'Green Hat'),
(4, 'Yellow Bag'),
(5, 'Black Jacket'),
(6, 'Red Scarf'),
(7, 'White Shirt'),
(8, 'Silver Necklace'),
(9, 'Gold Ring'),
(10, 'Purple Gloves');

-- Orders Table
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE
);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate)
VALUES 
(1, 1, 2, '2022-01-05'),
(2, 2, 1, '2022-02-10'),
(3, 3, 3, '2022-03-15'),
(4, 4, 4, '2022-04-20'),
(5, 5, 5, '2022-05-25'),
(6, 6, 6, '2022-06-01'),
(7, 7, 7, '2022-07-10'),
(8, 8, 8, '2022-08-15'),
(9, 9, 9, '2022-09-20'),
(10, 10, 10, '2022-10-30');

-- Practice Questions
-- 1. Retrieve all employees whose names start with 'J'.
SELECT * FROM Employees 
WHERE FirstName LIKE 'J%';

-- 2. Find the products with names containing the word 'red'.
SELECT * FROM products 
WHERE Name LIKE '%red%';

-- 3. Get the list of employees sorted by their hire date in descending order.
SELECT * FROM Employees 
ORDER BY HireDate DESC;

-- 4. Retrieve all customers with names starting with 'A' and ending with 'n'.
SELECT * FROM Customers 
WHERE Name LIKE 'A%n';

-- 5. Find the products with names containing at least one digit. 
SELECT * FROM Products 
WHERE Name LIKE '%[0-9]%';

-- 6. Get the list of employees sorted by their salary in ascending order. NULL values should appear at the end. 
 SELECT * FROM employees
 ORDER BY Salary IS NULL, Salary ASC;
 
-- 7. Retrieve the customers whose names contain exactly five characters.
SELECT * FROM Customers 
WHERE LENGTH(Name) = 5;

-- 8. Find the products with names starting with 'S' and ending with 'e'. 
SELECT * FROM Products 
WHERE Name LIKE 'S%e';

-- 9. Get the list of employees sorted by their last name and then by their first name. 
SELECT * FROM Employees 
ORDER BY LastName, FirstName;

-- 10. Retrieve the orders placed on a specific date and sort them by the customer name in alphabetical order. 
SELECT Orders.*, Customers.Name AS CustomerName
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE OrderDate = '2022-02-10'
ORDER BY CustomerName;

-- 11. Find the products with names containing exactly three letters. 
SELECT * FROM Products 
WHERE LENGTH(Name) = 3;

-- 12. Get the list of employees sorted by their salary in descending order. NULL values should appear at the beginning. 
SELECT * FROM Employees 
ORDER BY Salary IS NULL DESC, Salary DESC;

-- 13. Retrieve the customers whose names contain a space character. 
SELECT * FROM Customers 
WHERE Name LIKE '% %';
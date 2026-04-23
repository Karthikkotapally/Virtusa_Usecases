CREATE DATABASE FreshMartDB;
USE FreshMartDB;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    ExpiryDate DATE,
    StockCount INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE SalesTransactions (
    TransactionID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    TransactionDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Categories VALUES
(1, 'Dairy'),
(2, 'Beverages'),
(3, 'Snacks');

INSERT INTO Products VALUES
(101, 'Milk', 1, CURDATE() + INTERVAL 5 DAY, 60, 2.50),
(102, 'Cheese', 1, CURDATE() + INTERVAL 10 DAY, 40, 5.00),
(103, 'Yogurt', 1, CURDATE() + INTERVAL 3 DAY, 80, 1.50),
(104, 'Cola', 2, CURDATE() + INTERVAL 30 DAY, 100, 1.20),
(105, 'Juice', 2, CURDATE() + INTERVAL 2 DAY, 70, 2.00),
(106, 'Chips', 3, CURDATE() + INTERVAL 90 DAY, 200, 1.00),
(107, 'Biscuits', 3, CURDATE() + INTERVAL 60 DAY, 150, 1.80);

INSERT INTO SalesTransactions VALUES
(1, 101, 10, CURDATE() - INTERVAL 10 DAY),
(2, 103, 20, CURDATE() - INTERVAL 5 DAY),
(3, 104, 50, CURDATE() - INTERVAL 20 DAY),
(4, 106, 30, CURDATE() - INTERVAL 70 DAY),
(5, 107, 25, CURDATE() - INTERVAL 15 DAY);

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM SalesTransactions;

SELECT ProductName, ExpiryDate, StockCount
FROM Products
WHERE ExpiryDate BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY
AND StockCount > 50;

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN SalesTransactions s
ON p.ProductID = s.ProductID
AND s.TransactionDate >= CURDATE() - INTERVAL 60 DAY
WHERE s.ProductID IS NULL;

SELECT 
    c.CategoryName,
    SUM(p.Price * s.Quantity) AS Revenue
FROM SalesTransactions s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;
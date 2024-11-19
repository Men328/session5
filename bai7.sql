CREATE DATABASE saleDB;

CREATE TABLE customers (
	customerID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE products (
	productID INT PRIMARY KEY NOT NULL,
    productName VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
	orderID INT PRIMARY KEY AUTO_INCREMENT,
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    orderDate DATE,
    TotalAmount DECIMAL(10,2) NOT NULL
);

CREATE TABLE orderItems (
	orderItemID INT PRIMARY KEY AUTO_INCREMENT,
    orderID INT NOT NULL,
    FOREIGN KEY(orderID) REFERENCES orders(orderID),
    productID INT NOT NULL,
    FOREIGN KEY(productID) REFERENCES products(productID),
    quantity INT,
    price DECIMAL(10,2)
);

CREATE TABLE sales (
	saleID INT PRIMARY KEY AUTO_INCREMENT,
    orderID INT,
    FOREIGN KEY(orderID) REFERENCES orders(orderID),
    saleDate DATE,
    saleAmount DECIMAL(10,2)
);

-- Tạo chỉ số cho cột OrderDate trong bảng Orders
CREATE INDEX idx_orderdate ON Orders (OrderDate);

-- Tạo chỉ số cho cột SaleDate trong bảng Sales
CREATE INDEX idx_saledate ON sales (saleDate);

CREATE VIEW CustomerMonthlySales AS
SELECT 
    c.customerID,
    CONCAT(c.firstName, ' ', c.lastName) AS CustomerName,
	DATE_FORMAT(o.orderDate, '%Y-%m') AS MonthYear, 
    SUM(o.totalAmount) AS TotalSales
FROM 
    customers c
JOIN 
    orders o ON c.customerID = o.customerID
GROUP BY 
    c.customerID, c.firstName, c.lastName, MonthYear;
    
SELECT * FROM CustomerMonthlySales
WHERE MonthYear = '2024-07' AND TotalSales > 2000
ORDER BY TotalSales DESC;
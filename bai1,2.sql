CREATE DATABASE saleDB;

CREATE TABLE customers (
	customerID INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    createdAt DATETIME
);

CREATE TABLE products (
	productID INT PRIMARY KEY NOT NULL,
    productName VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
	orderID INT PRIMARY KEY AUTO_INCREMENT,
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    TotalAmount DECIMAL(10,2) NOT NULL
);

ALTER TABLE customers 
ADD email VARCHAR(50);

ALTER TABLE orders
ADD orderDate DATE;

-- Bài 1:
-- Thêm chỉ số cho cột Email trong bảng Customers
CREATE INDEX idx_email ON Customers (Email);

-- Thêm chỉ số cho cột OrderDate trong bảng Orders
CREATE INDEX idx_orderdate ON Orders (OrderDate);

-- Bài 2: 
CREATE VIEW CustomerOrders AS
SELECT 
    o.orderID,
    c.customerName,
    o.orderDate,
    o.totalAmount
FROM 
    orders o
JOIN 
    customers c ON o.customerID = c.customerID;

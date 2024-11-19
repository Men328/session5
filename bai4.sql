CREATE DATABASE saleDB;

CREATE TABLE customers (
	customerID INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
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
    orderDate DATETIME,
    TotalAmount DECIMAL(10,2) NOT NULL
);

CREATE TABLE orderDetails (
	orderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    orderID INT,
    FOREIGN KEY(orderID) REFERENCES orders(orderID),
    productID INT, 
    FOREIGN KEY(productID) REFERENCES products(productID),
    quantity INT NOT NULL,
    unitPrice DECIMAL(10,2) NOT NULL
);

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
    
UPDATE CustomerOrders
SET TotalAmount = 250.00
WHERE OrderID = 1;
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

CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.customerID,
    CONCAT(c.firstName, ' ', c.lastName) AS customerName,
    COUNT(o.orderID) AS totalOrders,
    SUM(o.totalAmount) AS totalAmountSpent
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customerID = o.customerID
GROUP BY 
    c.customerID, c.firstName, c.lastName;
    
SELECT *
FROM CustomerOrderSummary
WHERE TotalAmountSpent > 5000;
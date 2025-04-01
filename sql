-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS inventory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inventory;

-- Drop tables if they exist to ensure a clean setup
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS userlogs, salesinfo, purchaseinfo, users, currentstock, products, customers, suppliers;
SET FOREIGN_KEY_CHECKS = 1;

-- Customers Table
CREATE TABLE customers (
    customercode INT AUTO_INCREMENT PRIMARY KEY,
    customername VARCHAR(100) NOT NULL,
    contactnumber VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Suppliers Table
CREATE TABLE suppliers (
    suppliercode INT AUTO_INCREMENT PRIMARY KEY,
    suppliername VARCHAR(100) NOT NULL,
    contactnumber VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Products Table
CREATE TABLE products (
    productcode INT AUTO_INCREMENT PRIMARY KEY,
    productname VARCHAR(100) NOT NULL,
    costprice DECIMAL(10,2) NOT NULL,
    sellingprice DECIMAL(10,2) NOT NULL
);

-- Current Stock Table
CREATE TABLE currentstock (
    productcode INT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (productcode) REFERENCES products(productcode) ON DELETE CASCADE
);

-- Purchase Info Table
CREATE TABLE purchaseinfo (
    purchaseid INT AUTO_INCREMENT PRIMARY KEY,
    suppliercode INT NOT NULL,
    productcode INT NOT NULL,
    quantity INT NOT NULL,
    purchaseprice DECIMAL(10,2) NOT NULL,
    purchasedate DATE NOT NULL,
    FOREIGN KEY (suppliercode) REFERENCES suppliers(suppliercode) ON DELETE CASCADE,
    FOREIGN KEY (productcode) REFERENCES products(productcode) ON DELETE CASCADE
);

-- Sales Info Table
CREATE TABLE salesinfo (
    salesid INT AUTO_INCREMENT PRIMARY KEY,
    customercode INT NOT NULL,
    productcode INT NOT NULL,
    quantity INT NOT NULL,
    totalamount DECIMAL(10,2) NOT NULL,
    salesdate DATE NOT NULL,
    FOREIGN KEY (customercode) REFERENCES customers(customercode) ON DELETE SET NULL,
    FOREIGN KEY (productcode) REFERENCES products(productcode) ON DELETE CASCADE
);

-- Users Table
CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'employee') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Logs Table
CREATE TABLE userlogs (
    logid INT AUTO_INCREMENT PRIMARY KEY,
    userid INT NOT NULL,
    logintime DATETIME NOT NULL,
    logouttime DATETIME,
    FOREIGN KEY (userid) REFERENCES users(userid) ON DELETE CASCADE
);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

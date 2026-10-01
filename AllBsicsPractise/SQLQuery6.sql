

create database [SQL Questions]

use [SQL Questions]

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'Alice', 'USA'),
(2, 'Bob', 'UK'),
(3, 'Charlie', 'Canada'),
(4, 'David', 'USA'),
(5, 'Eve', 'Australia');

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID)
VALUES 
(101, 1, '2024-08-01', 1001),
(102, 1, '2024-08-03', 1002),
(103, 2, '2024-08-04', 1001),
(104, 3, '2024-08-05', 1003),
(105, 5, '2024-08-06', 1004);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Laptop', 1000),
(1002, 'Smartphone', 700),
(1003, 'Tablet', 500),
(1004, 'Headphones', 200),
(1005, 'Smartwatch', 300);

Select * from Customers


select name from sys.tables


Select * from Customers 
Select * from Orders
Select * from Products



--1) Write an SQL query to find the names of customers who have placed an order.

Select * from Customers c inner join Orders o on o.CustomerId = c.CustomerId

---2)find the list of customers who have not placed any orders.
Select * from Customers c left  join  Orders o on c.CustomerID = o.CustomerId 
where o.OrderId is null

--3) List all orders along with the product name and price.

Select  Distinct ProductName, Price  from Orders o join Products p on o.ProductId = p.ProductId

--4) Find the names of customers and their orders, including customers who haven't placed any orders.
Select distinct CustomerName,OrderId  from Customers c left join Orders o on o.CustomerId = c.CustomerId

--5) Retrieve a list of products that have never been ordered.
select * from Products p left join Orders o on p.ProductID = o.ProductId
where o.OrderID is null

--6) Find the total number of orders placed by each customer.
Select CustomerName , Count(OrderID) From Customers c inner join Orders o on c.CustomerId = o.CustomerId
group by CustomerName

--7) Display the customers, the products they've ordered, and the order date. Include customers who haven't placed any orders.
Select distinct CustomerName, p.ProductID, ProductName , OrderDate from Customers c left join Orders o on C.CustomerId = o.CustomerID  left join Products p on o.ProductID = p.ProductID
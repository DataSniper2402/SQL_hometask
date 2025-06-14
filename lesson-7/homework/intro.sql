Easy-Level Tasks (10)

    Write a query to find the minimum (MIN) price of a product in the Products table.
	select min(products) as minprce,  from products 
    Write a query to find the maximum (MAX) Salary from the Employees table.
	select MAX(salary) as maxsalary,  from Employees
	Write a query to count the number of rows in the Customers table.
	select count(*) as totalrows, from Customers
    Write a query to count the number of unique product categories from the Products table.
    select count ( DISTINCT Ctegory ) as categorycount, from Products
    Write a query to find the total sales amount for the product with id 7 in the Sales table.
	select sum(amount)as totalamount, from Sales
	where ID = 7
    Write a query to calculate the average age of employees in the Employees table.
	select AVG(age) as avarageage, from Employees
    Write a query to count the number of employees in each department.
	select Department count(*) as totalemployees from Employees 
	group by Department
    Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
	select Category MAX(Price), MIN (Price) from Products
	group by Category
    Write a query to calculate the total sales per Customer in the Sales table.
	select Customer sum (amount) as totalsales, from sales
	group by Customer
    Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
	select DeptID COUNT (*) as EmployeeCount from Employees
	group by DeptID 
	HAVING COUNT (*) > 5

🟠 Medium-Level Tasks (9)

    Write a query to calculate the total sales and average sales for each product category from the Sales table.
	SELECT Category, SUM(Amount) AS TotalSales, AVG(Amount) AS AverageSales FROM Sales
	GROUP BY Category
    Write a query to count the number of employees from the Department HR.
	SELECT COUNT(*) AS HREmployeeCount FROM Employees
	WHERE Department = 'HR'
    Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
	SELECT DeptID, MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary FROM Employees
	GROUP BY DeptID
    Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
	SELECT DeptID, AVG(Salary) AS AverageSalary FROM Employees
	GROUP BY DeptID
    Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
	SELECT DeptID, AVG(Salary) AS AverageSalary, COUNT(*) AS EmployeeCount FROM Employees
	GROUP BY DeptID
    Write a query to filter product categories with an average price greater than 400.
	SELECT Category, AVG(Price) AS AveragePrice FROM Products
	GROUP BY Category
	HAVING AVG(Price) > 400
    Write a query that calculates the total sales for each year in the Sales table.
	SELECT YEAR(SaleDate) AS SaleYear, SUM(Amount) AS TotalSales FROM Sales
	GROUP BY YEAR(SaleDate)
	 having SaleYear
    Write a query to show the list of customers who placed at least 3 orders.
	SELECT CustomerID, COUNT(*) AS OrderCount FROM Orders
	GROUP BY CustomerID
	HAVING COUNT(*) >= 3
    Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).
	SELECT DeptID, AVG(Salary) AS AverageSalary, FROM Employees
	GROUP BY DeptID
	HAVING AVG(Salary) > 60000

🔴 Hard-Level Tasks (6)

    Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
	SELECT Category, AVG(Price) AS AveragePrice, FROM Products
	GROUP BY Category
	HAVING AVG(Price) > 150
    Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
	SELECT CustomerID, SUM(Amount) AS TotalSales, FROM Sales
	GROUP BY CustomerID
	HAVING SUM(Amount) > 1500
    Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
	SELECT DeptID, SUM(Salary) AS TotalSalary, AVG(Salary) AS AverageSalary, FROM Employees
	GROUP BY DeptID
	HAVING AVG(Salary) > 65000
    Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).
	SELECT  CustomerID, SUM(CASE WHEN Freight > 50 THEN Freight ELSE 0 END) AS TotalFreightOver50, MIN(TotalDue) AS LeastPurchase, FROM TSQL2012.Sales.Orders
	GROUP BY CustomerID
    Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
	SELECT 
    YEAR(OrderDate) AS SaleYear,
    MONTH(OrderDate) AS SaleMonth,
    SUM(Amount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM Orders
GROUP BY 
    YEAR(OrderDate), 
    MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
    Write a query to find the MIN and MAX order quantity per Year. From orders table. Necessary tables:
	SELECT 
    YEAR(OrderDate) AS OrderYear,
    MIN(Quantity) AS MinOrderQty,
    MAX(Quantity) AS MaxOrderQty
FROM Orders
GROUP BY YEAR(OrderDate)


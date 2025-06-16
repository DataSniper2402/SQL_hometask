	Easy-Level Tasks

    Using Products table, find the total number of products available in each category.
	select CategoryID count(*) from Products 
	group by CategoryID
    Using Products table, get the average price of products in the 'Electronics' category.
	select AVG(Price) as avgelectroniks, from Products
	where Category = 'Electronics'
    Using Customers table, list all customers from cities that start with 'L'.
	select * from customers
	where City LIKE 'L%'
    Using Products table, get all product names that end with 'er'.
	select * from Products 
	where productname  like '%er'
    Using Customers table, list all customers from countries ending in 'A'.
	select * from customers 
	where country like '%A'
    Using Products table, show the highest price among all products.
	select MAX(price) as highprice, from Products
    Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
	SELECT ProductName, Quantity, CASE WHEN Quantity < 30 THEN 'Low Stock' ELSE 'Sufficient' END AS StockStatus
	FROM Products
    Using Customers table, find the total number of customers in each country.
	select country COUNT(*) from customers 
	group by country
    Using Orders table, find the minimum and maximum quantity ordered.
	SELECT 
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
	FROM Orders
	Medium-Level Tasks

    Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
	SELECT DISTINCT CustomerID FROM Orders
	WHERE OrderDate >= '2023-01-01' AND OrderDate < '2023-02-01'
	EXCEPT
	SELECT DISTINCT CustomerID FROM Invoices
	WHERE InvoiceDate >= '2023-01-01' AND InvoiceDate < '2023-02-01';
    Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
	SELECT ProductName FROM Products
	UNION ALL
	SELECT ProductName FROM Products_Discounted
    Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
	SELECT ProductName FROM Products
	UNION
	SELECT ProductName FROM Products_Discounted
    Using Orders table, find the average order amount by year.
	SELECT YEAR(OrderDate) AVG (OrderAmount) AS AverageOrderAmount from Orders
	group by YEAR(OrderDate) 
    Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
	SELECT  ProductName CASE 
        WHEN Price < 100 THEN 'Low'
        WHEN Price BETWEEN 100 AND 500 THEN 'Mid' ELSE 'High' END AS PriceGroup
	FROM Products
    Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
	SELECT City,
    SUM(CASE WHEN Year = 2012 THEN Population ELSE 0 END) AS [2012],
    SUM(CASE WHEN Year = 2013 THEN Population ELSE 0 END) AS [2013]
	INTO Population_Each_Year
	FROM City_Population
	GROUP BY City
    Using Sales table, find total sales per product Id.
	SELECT ProductID, SUM(SaleAmount) AS TotalSaleS FROM Sales
	GROUP BY ProductID
    Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
	SELECT ProductName FROM Products
	WHERE ProductName LIKE '%oo%'
    Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
	SELECT Year,
    SUM(CASE WHEN City = 'Bektemir' THEN Population ELSE 0 END) AS Bektemir,
    SUM(CASE WHEN City = 'Chilonzor' THEN Population ELSE 0 END) AS Chilonzor,
    SUM(CASE WHEN City = 'Yakkasaroy' THEN Population ELSE 0 END) AS Yakkasaroy
	INTO Population_Each_City
	FROM City_Population
	GROUP BY Year
	Hard-Level Tasks
    Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
	SELECT TOP 3 CustomerID,
    SUM(InvoiceAmount) AS TotalSpent
	FROM Invoices
	GROUP BY CustomerID
	ORDER BY TotalSpent DESC
    Transform Population_Each_Year table to its original format (City_Population).
	SELECT '2012' AS Year, City, [2012] AS Population FROM Population_Each_Year
	UNION ALL
	SELECT '2013', City, [2013] FROM Population_Each_Year
	UNION ALL
	SELECT '2014', City, [2014] FROM Population_Each_Year
    Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
	SELECT P.ProductName, SUM(S.Quantity) AS TimesSold FROM Products P
	JOIN Sales S ON P.ProductID = S.ProductID
	GROUP BY P.ProductName
    Transform Population_Each_City table to its original format (City_Population).
	SELECT 'Bektemir' AS City, Year, Bektemir AS Population FROM Population_Each_City
	UNION ALL
	SELECT 'Chilonzor', Year, Chilonzor FROM Population_Each_City
	UNION ALL
	SELECT 'Yakkasaroy', Year, Yakkasaroy FROM Population_Each_City


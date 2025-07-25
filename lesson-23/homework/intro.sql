-- 1
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

-- 2
SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxTable
GROUP BY rID;

-- 3
SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

-- 4
SELECT ID, Item, Vals
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) AS rn
    FROM TestMaximum
) t
WHERE rn = 1;

-- 5
SELECT Id, SUM(MaxVal) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;

-- 6
SELECT 
    Id,
    a,
    b,
    CASE WHEN a - b = 0 THEN '' ELSE CAST(a - b AS VARCHAR) END AS OUTPUT
FROM TheZeroPuzzle;

-- 7
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

-- 8
SELECT AVG(UnitPrice) AS AvgUnitPrice FROM Sales;

-- 9
SELECT COUNT(*) AS TotalTransactions FROM Sales;

-- 10
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

-- 11
SELECT Category, SUM(QuantitySold) AS TotalUnits FROM Sales GROUP BY Category;

-- 12
SELECT Region, SUM(QuantitySold * UnitPrice) AS Revenue FROM Sales GROUP BY Region;

-- 13
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

-- 14
SELECT 
    SaleID, 
    SaleDate, 
    Product, 
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningRevenue
FROM Sales;

-- 15
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER() AS PercentageContribution
FROM Sales
GROUP BY Category;

-- 16
SELECT s.*, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- 17
SELECT *
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Sales s WHERE s.CustomerID = c.CustomerID
);

-- 18
SELECT CustomerID, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY CustomerID;

-- 19
SELECT TOP 1 CustomerID, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY CustomerID
ORDER BY Revenue DESC;

-- 20
SELECT CustomerID, COUNT(*) AS Transactions, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY CustomerID;

-- 21
SELECT DISTINCT Product
FROM Sales
WHERE Product IN (SELECT ProductName FROM Products);

-- 22
SELECT TOP 1 *
FROM Products
ORDER BY SellingPrice DESC;

-- 23
SELECT *
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products p2
    WHERE p2.Category = p.Category
);

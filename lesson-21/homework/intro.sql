

--1
SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

--2
SELECT ProductName,
       SUM(Quantity) AS TotalQuantity,
       RANK() OVER (ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM ProductSales
GROUP BY ProductName;
--3
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS Ranked
WHERE rn = 1;
--4
SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;
--5
SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;
--6
SELECT *
FROM (
    SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
) AS Sales
WHERE SaleAmount > PrevSaleAmount;

--7
SELECT *, 
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;
--8
SELECT *,
       ROUND(
         (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount, 2
       ) AS PercentChangeToNext
FROM ProductSales;
--9
SELECT *,
       ROUND(
         SaleAmount * 1.0 / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 2
       ) AS SaleAmountRatio
FROM ProductSales;
--10

SELECT *,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirstSale
FROM ProductSales;
--11
SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
) AS Incr
WHERE SaleAmount > PrevSaleAmount;
--12
SELECT *, 
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales;
--13
SELECT *,
       ROUND(
         AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2
       ) AS MovingAvg_3
FROM ProductSales;
--14
SELECT *, 
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;
--15
SELECT *,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;
--16
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
) AS Ranked
WHERE SalaryRank <= 2;
--18
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;
--17
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) AS Ranked
WHERE rn = 1;
--19
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS DepartmentTotalSalary
FROM Employees1;
--20
SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS DepartmentAvgSalary
FROM Employees1;
--21
SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;
--22
SELECT *,
       ROUND(AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS MovingAvg_3
FROM Employees1;
--23
SELECT SUM(Salary) AS Last3HireSalarySum
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    LIMIT 3
) AS Last3;

--1
select distinct s1.CustomerName from #Sales as s1  where exists ( select 1 from #Sales as s2 where s1.CustomerName=s2.CustomerName
and s2.SaleDate>= '2024-03-01'
and s2.SaleDate<'2024-04-01')




--2

select Product, SUM(Quantity * Price) as  TotalRevenue  from #Sales 
group by Product
having SUM(Quantity * Price) = (select MAX(Total) from ( select SUM(Quantity * Price) as Total from #Sales 
group by Product) as Sub)

--3
select max(quantity *price) as second_higest_salary from #sales
where (quantity*price) < (select max(Quantity * price) from #Sales )


--4

select sale_year,
   sale_month,
   sum(quantity)as total_quantity
 from
(select quantity,  year(saledate) as sale_year,
month(saledate) as sale_month from #Sales)  as monthly_sales
group by sale_year,sale_month
order by sale_year,sale_month

--5
SELECT DISTINCT s1.CustomerName, s1.Product
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
);




--6
select name, Fruit, count(*) as total_quantity from fruits
group by name, Fruit 


--7

select f2.ParentId, f1.ChildID   from Family as f1  cross  join Family as f2 
where f1.ChildID <> f2.ParentId 


--8


select CustomerID, OrderID, SUM(Amount) as total from #Orders 
where DeliveryState='CA'
group by CustomerID, OrderID

--9


UPDATE #residents
SET fullname = 
    SUBSTRING(
        address,
        CHARINDEX('name=', address) + 5,
        CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - (CHARINDEX('name=', address) + 5)
    )
WHERE (fullname IS NULL OR fullname = '')
  AND CHARINDEX('name=', address) > 0;

--10

WITH RoutePaths AS (
    SELECT 
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL
    SELECT 
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS Route,
        r.Arrival

--11

WITH Numbered AS (
    SELECT *,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS GroupNum
    FROM #RankingPuzzle
)
SELECT 
    ID,
    Vals,
    CASE 
        WHEN Vals = 'Product' THEN NULL
        ELSE GroupNum
    END AS ProductRank
FROM Numbered
ORDER BY ID;





--12
SELECT e.EmployeeName, e.Department, e.SalesAmount from #EmployeeSales e
where e.SalesAmount > (
select AVG(SalesAmount) from #EmployeeSales
where Department = e.Department)

--13
select e.EmployeeName, e.SalesMonth, e.SalesYear, e.SalesAmoun from #EmployeeSales e
where not EXISTS ( select  1  from #EmployeeSales other
where other.SalesMonth = e.SalesMonth
      and other.SalesYear = e.SalesYear
      and other.SalesAmount > e.SalesAmount)



	  
--14
select distinct e.EmployeeName from #EmployeeSales e
where not EXISTS ( select 1 from
(select distinct SalesMonth from #EmployeeSales) as all_months
 where not EXISTS ( select 1 from #EmployeeSales es
where es.EmployeeName = e.EmployeeName and es.SalesMonth = all_months.SalesMonth))


--15
select name from products where Price > ( select AVG(Price) from Products)
--16

select * from Products
where Stock <( select MAX(Stock)from Products)
--17

select Name from Products 
where Category = ( select Category from Products
where Name = 'Laptop')
--18

select * from Products
where Price > (select MIN(Price) from Products
 WHERE Category = 'Electronics')
 --19

 select Name, Category, Price from Products p
where Price > (select AVG(Price) from Products
WHERE Category = p.Category)
--20

select distinct p.ProductID, p.Name from Products p
JOIN Orders o on p.ProductID = o.ProductID
--21
select distinct p.Name from Products p
JOIN Orders o on p.ProductID = o.ProductID
where o.Quantity > (select AVG(Quantity) from Orders)
--22


select p.ProductID, p.Name from Products p
where not EXISTS ( select 1 from Orders o
where o.ProductID = p.ProductID)
--23

SELECT TOP 1 p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQuantity DESC;











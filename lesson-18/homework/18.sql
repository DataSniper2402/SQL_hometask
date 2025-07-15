1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.

Return: ProductID, TotalQuantity, TotalRevenue


with  MonthlySalesCTE as (
    select
        p.ProductID,
        SUM(s.Quantity) as  TotalQuantity,
        SUM(s.Quantity * p.Price) as  TotalRevenue
    from Sales as  s
    INNER JOIN Products as p on s.ProductID = p.ProductID
    where MONTH(s.SaleDate) = 4  
      and YEAR(s.SaleDate) = 2025
    group by p.ProductID
)
select 
    m.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    m.TotalQuantity,
    m.TotalRevenue
from  MonthlySalesCTE as m
JOIN Products as p on m.ProductID = p.ProductID

2. Create a view named that returns product info along with total sales quantity across all time.

Return: ProductID, ProductName, Category, TotalQuantitySold

	with ProductSalesCTE as (
    select 
        p.ProductID,
        p.ProductName,
        p.Category,
        p.Price,
        COALESCE(SUM(s.Quantity), 0) as TotalQuantitySold
    from Products p
    left join Sales s on p.ProductID = s.ProductID
	group by 
        p.ProductID,
        p.ProductName,
        p.Category,
        p.Price
)
select   ProductName, Category from  ProductSalesCTE as pc join Sales as s on pc.productID=s.ProductID
where TotalQuantitySold > 0
3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
   
Return: total revenue for the given product ID

with Total_revenue as (
select p.ProductID,  ProductName, sum ( s.quantity*p.price) as total_revenue from sales as s join products as p on s.ProductID=p.ProductID
group by p.ProductID,  ProductName) 
select ProductName, total_revenue  from Total_revenue as tv join Sales  as s on tv.ProductID=s.ProductID 
4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))

Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

with Total_revenue as (
select p.ProductID,  ProductName, sum ( s.quantity*p.price) as total_revenue from sales as s join products as p on s.ProductID=p.ProductID
group by p.ProductID,  ProductName) 
select ProductName, total_revenue  from Total_revenue as tv join Sales  as s on tv.ProductID=s.ProductID 


7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.

with Salary_Ranks as (
    select  distinct Salary,
        dense_rank()  (order by Salary desc) as Rank  from Employee)
select Salary as NthHighestSalary from  SalaryRanks
where Rank = 3


8. Write a SQL query to find the person who has the most friends.

Return: Their id, The total number of friends they have

with allfriends as (
select requester_id as id from Requestaccepted 
union all
select accepter_id as id from  Requestaccepted) 

friendcount as ( 
select id count(*) as num from allfriends 
group by id )
select id, num from friendcount
order by num desc 


10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.


WITH RECURSIVE FilledWorkflow AS (
  SELECT
    RowNumber,
    Workflow
  FROM WorkflowSteps
  WHERE RowNumber = 1

  UNION ALL

  SELECT
    w.RowNumber,
    CASE
      WHEN w.Workflow IS NULL OR w.Workflow = ''
           THEN f.Workflow
           ELSE w.Workflow
    END AS Workflow
  FROM WorkflowSteps w
  JOIN FilledWorkflow f ON w.RowNumber = f.RowNumber + 1
)

SELECT * FROM FilledWorkflow;


5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:


CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    -- Tub sonlar faqat 1 va o‘ziga bo‘linadigan, 1 dan katta sonlar
    IF @Number <= 1
        RETURN 'No';

    DECLARE @Result VARCHAR(3) = 'Yes';

    ;WITH NumberSeries AS (
        SELECT 2 AS Num
        UNION ALL
        SELECT Num + 1
        FROM NumberSeries
        WHERE Num + 1 <= FLOOR(SQRT(@Number))
    )
    SELECT TOP 1 @Result = 'No'
    FROM NumberSeries
    WHERE @Number % Num = 0
    OPTION (MAXRECURSION 1000);

    RETURN @Result;
END;

6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:


CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number + 1 <= @End
    )
    SELECT Number FROM NumbersCTE
    OPTION (MAX

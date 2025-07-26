-- 1. 
SELECT  
    Id,
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS FirstName,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS LastName 
FROM dbo.TestMultipleColumns;

-- 2.
SELECT * FROM TestPercent WHERE Strs LIKE '%\%%' ESCAPE '\';

-- 3. 
SELECT Id, value AS Ajratilgan_qiymat
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');

-- 4. 
SELECT Id, MyText AS OriginalText,
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    MyText, '0', 'X'), '1', 'X'), '2', 'X'), '3', 'X'), '4', 'X'),
    '5', 'X'), '6', 'X'), '7', 'X'), '8', 'X'), '9', 'X') AS ReplacedText 
FROM MyTable;

-- 5. 
SELECT * FROM testdots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

-- 6.
SELECT texts, LENGTH(texts) - LENGTH(REPLACE(texts, ' ', '')) AS kod 
FROM countspaces;

-- 7. 
SELECT e.name AS EmployeeName, e.Salary AS EmployeeSalary,
       m.Name AS ManagerName, m.Salary AS ManagerSalary 
FROM Employee e 
JOIN Employee m ON e.ManagerId = m.Id 
WHERE e.Salary > m.Salary;

-- 8.
SELECT EmployeeID, FirstName, LastName, HireDate,
TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsOfService 
FROM Employees 
WHERE TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 11 AND 14;

-- 9.
SELECT mixed_string, 
  REGEXP_REPLACE(mixed_string, '[^0-9]', '') AS digits, 
  REGEXP_REPLACE(mixed_string, '[0-9]', '') AS letters 
FROM mixed_data;

-- 10.
SELECT w1.id 
FROM weather w1 
JOIN weather w2 ON w1.id = DATEADD(DAY, 1, w2.id) 
WHERE w1.temperature > w2.temperature;

-- 11.
SELECT player_id, MIN(games_played) AS first_login_date 
FROM Activity 
GROUP BY player_id;

-- 12. 
WITH split AS (
  SELECT fruit_list, TRIM(value) AS value, 
         ROW_NUMBER() OVER (PARTITION BY fruit_list ORDER BY (SELECT NULL)) AS rn
  FROM fruits 
  CROSS APPLY STRING_SPLIT(fruit_list, ',')
)
SELECT value AS third_fruit 
FROM split 
WHERE rn = 3;

-- 13.
SELECT val,
  (SELECT '' + SUBSTRING(val, v.number, 1)
   FROM master.dbo.spt_values v
   WHERE v.number BETWEEN 1 AND LEN(val)
     AND SUBSTRING(val, v.number, 1) LIKE '[A-Za-z]'
   FOR XML PATH('')) AS characters,

  (SELECT '' + SUBSTRING(val, v.number, 1)
   FROM master.dbo.spt_values v
   WHERE v.number BETWEEN 1 AND LEN(val)
     AND SUBSTRING(val, v.number, 1) LIKE '[0-9]'
   FOR XML PATH('')) AS digits
FROM your_table;

-- 14.
SELECT p1.id, 
       CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS final_code 
FROM p1 
JOIN p2 ON p1.id = p2.id;

-- 15.
SELECT employee_id, name, hire_date,
  CASE
    WHEN DATEDIFF(YEAR, hire_date, GETDATE()) < 1 THEN 'New Hire'
    WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
    WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
    WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
    ELSE 'Veteran'
  END AS employment_stage 
FROM Employees;

-- 16. 
SELECT Vals, 
  CAST(LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS INT) AS extracted_integer 
FROM GetIntegers 
WHERE Vals LIKE '[0-9]%';

-- 17.
SELECT STRING_AGG(
  CASE  
    WHEN LENGTH(word) >= 2 THEN 
      SUBSTRING(word FROM 2 FOR 1) || SUBSTRING(word FROM 1 FOR 1) || SUBSTRING(word FROM 3)
    ELSE word
  END, ',') AS swapped_string
FROM (
  SELECT unnest(string_to_array(val_string, ',')) AS word
  FROM MultipleVals
) AS words;

-- 18. 
SELECT player_id, device_id, games_played
FROM (
  SELECT player_id, device_id, games_played,
         ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY games_played) AS rn
  FROM Activity
) sub
WHERE rn = 1;

-- 19.
SELECT area,
  EXTRACT(YEAR FROM sales_date) AS sales_year,
  EXTRACT(WEEK FROM sales_date) AS sales_week,
  sales_date,
  sales_amount,
  ROUND(100.0 * sales_amount / 
    SUM(sales_amount) OVER (PARTITION BY area, EXTRACT(YEAR FROM sales_date), EXTRACT(WEEK FROM sales_date)), 2) 
    AS percentage_of_week
FROM sales
ORDER BY area, sales_year, sales_week, sales_date;

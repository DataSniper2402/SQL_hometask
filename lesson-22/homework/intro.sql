
-- 1
SELECT *,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;

-- 2.
SELECT product_category, COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

-- 3. 
SELECT product_category, MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;

-- 4. 
SELECT product_category, MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;

-- 5. 
SELECT *,
       ROUND(AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS moving_avg
FROM sales_data;

-- 6.
SELECT region, SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

-- 7.
SELECT customer_id, customer_name,
       SUM(total_amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_by_spending
FROM sales_data
GROUP BY customer_id, customer_name
--8.
SELECT *,
       total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_prev
FROM sales_data;

-- 9. 
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS price_rank
    FROM sales_data
) ranked
WHERE price_rank <= 3;

-- 10. 
SELECT *,
       SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


-- 11.
SELECT *,
       SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;

-- 12.
WITH CTE AS (
    SELECT Value, SUM(Value) OVER (ORDER BY (SELECT NULL) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
    FROM OneColumn
)
SELECT * FROM CTE;

-- 13.
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

-- 14.
WITH RegionalAvg AS (
    SELECT region, AVG(total_amount) AS avg_region_spending
    FROM sales_data
    GROUP BY region
)
SELECT s.*
FROM sales_data s
JOIN RegionalAvg r ON s.region = r.region
WHERE s.total_amount > r.avg_region_spending;

-- 15.
SELECT customer_id, customer_name, region,
       SUM(total_amount) AS total_spent,
       RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY customer_id, customer_name, region;

-- 16.
SELECT *,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_running_total
FROM sales_data;

-- 17.
WITH MonthlySales AS (
    SELECT FORMAT(order_date, 'yyyy-MM') AS month,
           SUM(total_amount) AS monthly_total
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT month, monthly_total,
       LAG(monthly_total) OVER (ORDER BY month) AS prev_month_total,
       ROUND((monthly_total - LAG(monthly_total) OVER (ORDER BY month)) * 100.0 / LAG(monthly_total) OVER (ORDER BY month), 2) AS growth_rate
FROM MonthlySales;

-- 18.
SELECT *,
       LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);


-- 19.
SELECT *
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price) FROM sales_data
);

-- 20.
SELECT *,
       CASE 
         WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
         THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
       END AS Tot
FROM MyData;

-- 21.
SELECT Id,
       SUM(Cost) AS Cost,
       CASE WHEN COUNT(DISTINCT Quantity) = 1 THEN MAX(Quantity)
            ELSE SUM(Quantity) END AS Quantity
FROM TheSumPuzzle
GROUP BY Id;

-- 22.
WITH Numbered AS (
    SELECT SeatNumber,
           SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS grp
    FROM Seats
),
Ranges AS (
    SELECT MIN(SeatNumber) AS GapStart, MAX(SeatNumber) AS GapEnd
    FROM Numbered
    GROUP BY grp
)
SELECT GapStart + 1 AS [Gap Start], GapEnd - 1 AS [Gap End]
FROM Ranges
WHERE GapEnd - GapStart > 1;

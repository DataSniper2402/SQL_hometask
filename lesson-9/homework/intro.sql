 Easy-Level Tasks (10)

🟢 Easy (10 puzzles)

    Using Products, Suppliers table List all combinations of product names and supplier names.
	SELECT p.ProductName, s.SupplierName FROM  Products p
CROSS JOIN  Suppliers s 
    Using Departments, Employees table Get all combinations of departments and employees.
	select d.Departments, e.Employees from department cross join employees
    Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
	select p.Products,s.Supplier from   Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID
    Using Orders, Customers table List customer names and their orders ID.
	select c.customers, o.OrderID  from  Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
    Using Courses, Students table Get all combinations of students and courses.
	select s.studentsname, c.courses from Students s CROSS JOIN Courses c;
    Using Products, Orders table Get product names and orders where product IDs match.
	SELECT p.ProductName, o.OrderID from Products p JOIN  Orders o ON p.ProductID = o.ProductID
    Using Departments, Employees table List employees whose DepartmentID matches the department.
	select e.employeesname, d.departmentname from employees join  Departments ON e.DepartmentID = d.DepartmentID;
    Using Students, Enrollments table List student names and their enrolled course IDs.
	select s.studentsname, e.courseID from students join Enrollments e ON StudentID = StudentID
    Using Payments, Orders table List all orders that have matching payments.
	SELECT   o.OrderID,    p.PaymentID  from Orders o  JOIN      Payments p ON o.OrderID = p.OrderID
    Using Orders, Products table Show orders where product price is more than 100.
	SELECT o.OrderID, p.ProductName, p.Price FROM Orders o JOIN  Products p ON o.ProductID = p.ProductID
🟡 Medium (10 puzzles)

    Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
	SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.DepartmentID AS EmployeeDeptID,
    d.DepartmentID AS DepartmentDeptID,
    d.DepartmentName
	FROM 
    Employees e
CROSS JOIN 
    Departments d
WHERE 
    e.DepartmentID <> d.DepartmentID
    Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
	SELECT 
    o.OrderID,
    o.ProductID,
    o.Quantity AS OrderedQuantity,
    p.Stock AS AvailableStock,
    p.ProductName
FROM 
    Orders o
JOIN 
    Products p ON o.ProductID = p.ProductID
WHERE 
    o.Quantity > p.Stock;

    Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
   SELECT 
    c.CustomerName,
    s.ProductID,
    s.Amount
FROM 
    Customers c
JOIN 
    Sales s ON c.CustomerID = s.CustomerID
WHERE 
    s.Amount >= 500;

    Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

    Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
	SELECT 
    s.StudentName,
    c.CourseName
FROM 
    Enrollments e
JOIN 
    Students s ON e.StudentID = s.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

    Using Orders, Payments table Show orders where payment amount is less than total amount.
	SELECT 
    p.ProductName,
    s.SupplierName
FROM 
    Products p
JOIN 
    Suppliers s ON p.SupplierID = s.SupplierID
WHERE 
    s.SupplierName LIKE '%Tech%';


    Using Employees and Departments tables, get the Department Name for each employee.
	SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

    Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
	SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
WHERE 
    c.CategoryName IN ('Electronics', 'Furniture');

    Using Sales, Customers table Show all sales from customers who are from 'USA'.
	SELECT 
    s.SaleID,
    s.ProductID,
    s.Amount,
    s.SaleDate,
    c.CustomerName,
    c.Country
FROM 
    Sales s
JOIN 
    Customers c ON s.CustomerID = c.CustomerID
WHERE 
    c.Country = 'USA';

    Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
	SELECT 
    o.OrderID,
    o.CustomerID,
    c.CustomerName,
    c.Country,
    o.TotalAmount
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
WHERE 
    c.Country = 'Germany'
    AND o.TotalAmount > 100;


🔴 Hard (5 puzzles)(Do some research for the tasks below)

    Using Employees table List all pairs of employees from different departments.
	
SELECT 
    e1.EmployeeID AS Employee1_ID,
    e1.Name AS Employee1_Name,
    e1.DepartmentID AS Dept1,
    e2.EmployeeID AS Employee2_ID,
    e2.Name AS Employee2_Name,
    e2.DepartmentID AS Dept2
FROM 
    Employees e1
JOIN 
    Employees e2 ON e1.EmployeeID < e2.EmployeeID
WHERE 
    e1.DepartmentID <> e2.DepartmentID
    Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
	SELECT 
    p.PaymentID,
    o.OrderID,
    o.ProductID,
    o.Quantity,
    pr.Price,
    (o.Quantity * pr.Price) AS ExpectedAmount,
    p.AmountPaid
FROM 
    Payments p
JOIN 
    Orders o ON p.OrderID = o.OrderID
JOIN 
    Products pr ON o.ProductID = pr.ProductID
WHERE 
    p.AmountPaid <> (o.Quantity * pr.Price)
    Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
	SELECT 
    s.StudentID,
    s.StudentName
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.StudentID = e.StudentID
WHERE 
    e.CourseID IS NULL
    Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
	SELECT 
    mgr.EmployeeID AS ManagerID,
    mgr.Name AS ManagerName,
    mgr.Salary AS ManagerSalary,
    emp.EmployeeID AS EmployeeID,
    emp.Name AS EmployeeName,
    emp.Salary AS EmployeeSalary
FROM 
    Employees emp
JOIN 
    Employees mgr ON emp.ManagerID = mgr.EmployeeID
WHERE 
    mgr.Salary <= emp.Salary
    Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
	SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN 
    Payments p ON o.OrderID = p.OrderID
WHERE 
    p.PaymentID IS NULL


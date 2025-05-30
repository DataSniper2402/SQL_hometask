

Basic-Level Tasks (10)

    Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2))
    -- table
	create table Employees (EmpID INT, NAME (VARCHAR(50)), and Salary (DECIMAL(10,2))
    Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
	INSERT INTO Employees (EmpID, Name, Salary)
    VALUES (1, 'Ali Karimov', 2500.00);
    Update the Salary of an employee to 7000 where EmpID = 1.
	update employee
	set salary = 7000
	where  EmpID = 1
    Delete a record from the Employees table where EmpID = 2.
	delete from employees table 
	where EmpID = 2
    Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
	DELETE = Malumotni o'chiradi
	DROP  =  obyektni o'chiradi
	TRUNCATE = jadvaldegi barcha malumotlarni ochiradi lekin jadvalni saqlab qoladi.
    Modify the Name column in the Employees table to VARCHAR(100).
	ALTER TABLE Employees
	ALTER Name VARCHAR(100)
    Add a new column Department (VARCHAR(50)) to the Employees table.
	INSERT table Employees
	Add column Department (VARCHAR(50))
	
    Change the data type of the Salary column to FLOAT.
	UPDATE table Employees
	UPDATE column salary to FLOAT
    Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
	CREATE table Departments(DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50))
    Remove all records from the Employees table without deleting its structure.
	truncate table Employees
Intermediate-Level Tasks (6)

    Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
	INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT * FROM (
    SELECT 1 AS DepartmentID, 'Kadrlar bo‘limi' AS DepartmentName
    UNION ALL
    SELECT 2, 'Moliyaviy bo‘lim'
    UNION ALL
    SELECT 3, 'Axborot texnologiyalari'
    UNION ALL
    SELECT 4, 'Marketing'
    UNION ALL
    SELECT 5, 'Logistika')
    Update the Department of all employees where Salary > 5000 to 'Management'.
	UPDATE Employeees 
	set department = 'Management'
	where Salary > 5000
    Write a query that removes all employees but keeps the table structure intact.
	TRUNCATE table employees
    Drop the Department column from the Employees table.
	Drop table employees 
	where column Department 
    Rename the Employees table to StaffMembers using SQL commands.
	ALTER TABLE Employees
    RENAME TO StaffMembers
    Write a query to completely remove the Departments table from the database.
	drop table

Advanced-Level Tasks (9)

    Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
	create table Products (including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL))
	insert into Products values (5)
	select * from Products
    Add a CHECK constraint to ensure Price is always greater than 0.
	INSERT table Products 
	ADD INSERT chk_price_positive
	CHECK (Prise > 0)
    Modify the table to add a StockQuantity column with a DEFAULT value of 50.
	INSERT table Products 
	ADD COLUMN StockQuantity INT DEFAULT 50
    Rename Category to ProductCategory
	UPDATE table Products
	RENAME COLUMN Category TO ProductCategory
    Insert 5 records into the Products table using standard INSERT INTO queries.
	INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
	VALUES (5, 'Suv idishi', 'Aksessuarlar', 12.00, 100)
    Use SELECT INTO to create a backup table called Products_Backup containing all Products data 
	SELECT * INTO Products_Backup
	FROM * Products
    Rename the Products table to Inventory.
	ALTER table Products 
	Rename to Inventory
    Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
	LTER TABLE Inventory
	ALTER COLUMN Price FLOAT
    Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
	ALTER TABLE Inventory
    ADD ProductCode INT IDENTITY(1000, 5)


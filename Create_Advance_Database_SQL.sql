CREATE Database Module_1_DDL
USE Module_1_DDL;
GO
-- 1) Create the Employees table with predefined columns
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,       -- Primary Key on EmployeeID
    FirstName VARCHAR(50),            -- First Name column
    LastName VARCHAR(50),             -- Last Name column
    Email VARCHAR(100),               -- Email column
    HireDate DATE                     -- Hire Date column
);
-- 2) Add a new column 'PhoneNumber' to the Employees table
ALTER TABLE Employees
ADD PhoneNumber VARCHAR(15);    -- Adding PhoneNumber column
-- 3) Check the constraints on the Employees table
SELECT 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE, 
    TABLE_NAME 
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_NAME = 'Employees';
-- First, create the Departments table for the Foreign Key reference
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,    -- Primary Key on DepartmentID
    DepartmentName VARCHAR(50)       -- Department Name column
);

-- Add Primary Key and Foreign Key on Table 
-- Now, add DepartmentID column and Foreign Key constraint in Employees table
ALTER TABLE Employees
ADD DepartmentID INT;  -- Add DepartmentID column in Employees table

-- 4) Add a Foreign Key constraint to link Employees.DepartmentID to Departments.DepartmentID
ALTER TABLE Employees
ADD CONSTRAINT FK_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- Remove the Unique constraint on the FirstName column -- first adding and then removing the constraint
ALTER TABLE Employees
ADD CONSTRAINT UQ_FirstName UNIQUE (FirstName);

-- 5) Remove the Unique constraint on the FirstName column

ALTER TABLE Employees
DROP CONSTRAINT UQ_FirstName;  -- Remove the unique constraint by name

-- Remove the Unique constraint on the FirstName column
ALTER TABLE Employees
DROP CONSTRAINT UQ_FirstName;  -- Remove the unique constraint by name

ALTER TABLE Employees
ADD mgr_id INT,
    depno INT,
    salary DECIMAL(10, 2);

EXEC sp_rename 'Employees.Dep_number', 'DepartmentID', 'COLUMN'; -- changing the column name

EXEC sp_rename 'Departments.Dep_number', 'DepartmentName', 'COLUMN'; -- changing the column name in the different table

-- Module_2 Assignments

-- Question_no : 1 // Insert new record in employee table with following values
-- Emp_id = 1009, First_Name = ‘Riccky’ , Last_Name = ‘Lawrence’ , mgr_id = 1005, depno = 40
-- ,salary = 50,000
-- Note: you can add more such values to populate the table.

INSERT INTO Employees (EmployeeID, FirstName, LastName, mgr_id, depno, salary)
VALUES 
    (1009, 'Riccky', 'Lawrence',1005, 40, 50000.00),
    (1010, 'John', 'Doe', 1006, 30, 55000.00),
    (1011, 'Jane', 'Smith', 1005, 40, 60000.00),
    (1012, 'Emily', 'Davis', 1007, 50, 45000.00),
	(1013, 'Ema', 'Watson', 1008, 50, 25000.00),
	(1014, 'Dekota', 'Johnson', 1007, 20, 30000.00),
	(1015, 'Natly', 'Portman', 1009, 50, 28000.00),
	(1016, 'Los', 'fednavis', 1008, 30, 29000.00),
	(1017, 'Emily', 'Davis', 1006, 20, 17000.00);

ALTER TABLE Employees
DROP CONSTRAINT UQ_Email; -- Droping the unique contraint, because it was showing the error like "Unique key violation"
SELECT * FROM Employees; -- Calling the inserted data to see how it looks in the data base

UPDATE Employees -- updating the existing database
SET FirstName = 'Criss', LastName = 'Marteen' -- updating the first name and the last name
WHERE EmployeeID = 1017;  -- Specify the EmployeeID or another unique identifier
SELECT * FROM Employees; -- calling after updating the data

-- Question_number : 2 // Delete record from employee where salary >= 40000

DELETE FROM Employees -- Deleting as per the business requrement
WHERE salary >= 40000;
SELECT * FROM Employees; -- calling after updating the data

-- Question_number : 3 // Update First_Name and Last_Name in employee table where emp_id = 1005 and mgr_id = 1004.

UPDATE Employees -- 0 rows affected // becase it not satisfying the "AND" condition
SET FirstName = 'EG', LastName = 'EG2'
WHERE EmployeeID = 1005 AND mgr_id = 1004;

-- Question_number : 4 //Select the record from employee whose last name starts with ‘B’ or ‘F’

SELECT * FROM Employees
WHERE LastName LIKE 'B%' OR LastName LIKE 'F%';

-- Module_3_Questions_01-- Retrieve data from the Employees table using self-join
SELECT 
    E1.EmployeeID AS EmployeeID1, 
    E1.FirstName AS FirstName1, 
    E1.LastName AS LastName1, 
    E2.EmployeeID AS EmployeeID2, 
    E2.FirstName AS FirstName2, 
    E2.LastName AS LastName2
FROM Employees E1
INNER JOIN Employees E2
ON E1.mgr_id = E2.EmployeeID;  -- Joining the Employee table with itself where mgr_id refers to EmployeeID

--Question_02 -- Retrieve data from Employees and Departments tables using INNER JOIN
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName, 
    E.Email, 
    E.HireDate, 
    D.DepartmentID, 
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;  -- Join condition where Employee's DepartmentID matches Department's DepartmentID
-- above program is returning empty values because there is no data on the "Department table"

-- Question_03 -- Retrieve data from Employees and Departments tables using LEFT JOIN
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName, 
    E.Email, 
    E.HireDate, 
    D.DepartmentID, 
    D.DepartmentName
FROM Employees E
LEFT JOIN Departments D
ON E.DepartmentID = D.DepartmentID;  -- Return all employees, even if they don't belong to a department

-- Question_04 -- Retrieve data from Employees and Departments tables using RIGHT JOIN
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName, 
    E.Email, 
    E.HireDate, 
    D.DepartmentID, 
    D.DepartmentName
FROM Employees E
RIGHT JOIN Departments D
ON E.DepartmentID = D.DepartmentID;  -- Return all departments, even if no employees belong to them

-- Question_05 -- Join Employees and Departments using CROSS JOIN
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName, 
    D.DepartmentID, 
    D.DepartmentName
FROM Employees E
CROSS JOIN Departments D;  -- Cartesian product of both tables, combining every employee with every department

-- Module-4_Question_01 -- Count the number of employees whose salary is greater than or equal to 30,000
SELECT COUNT(*) AS EmployeeCount
FROM Employees
WHERE salary >= 30000;

-- Question_02 -- Calculate the average salary of all employees
SELECT AVG(salary) AS AverageSalary
FROM Employees;

-- Question_03 -- Calculate the total salary of all employees
SELECT SUM(salary) AS TotalSalary
FROM Employees;

-- Module-5 - Question_01 - Create a function to calculate the annual salary based on the monthly salary
CREATE FUNCTION CalculateAnnualSalary (@MonthlySalary DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @MonthlySalary * 12;  -- Multiply the monthly salary by 12 to get the annual salary
END;
GO

-- Example usage of the function to get the annual salary for an employee
SELECT EmployeeID, FirstName, LastName, dbo.CalculateAnnualSalary(salary) AS AnnualSalary
FROM Employees;

-- Add the LastModifiedDate column to the Employees table
ALTER TABLE Employees
ADD LastModifiedDate DATETIME;

-- Question - 02 - Create a trigger to update the last modified date when an employee record is updated
CREATE TRIGGER trg_UpdateEmployeeTimestamp
ON Employees
AFTER UPDATE
AS
BEGIN
    -- Update the LastModifiedDate column with the current timestamp whenever an employee record is updated
    UPDATE Employees
    SET LastModifiedDate = GETDATE()
    WHERE EmployeeID IN (SELECT EmployeeID FROM inserted);
END;
GO

-- Question - 03 - Check if DepartmentID 10 exists in the Departments table
SELECT * FROM Departments WHERE DepartmentID = 10; -- no, there is no such values in the department table as "DepartmentID = 10"

-- Insert a new department with DepartmentID = 10
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (10, 'Sales');  -- Assuming 'Sales' is the department name

-- Create a stored procedure to insert a new employee
CREATE PROCEDURE InsertEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @HireDate DATE,
    @PhoneNumber VARCHAR(15),
    @DepartmentID INT
AS
BEGIN
    INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, HireDate, PhoneNumber, DepartmentID)
    VALUES (@EmployeeID, @FirstName, @LastName, @Email, @HireDate, @PhoneNumber, @DepartmentID);
END;
GO

-- Execute the stored procedure to insert a new employee record
EXEC InsertEmployee 
    @EmployeeID = 1020, 
    @FirstName = 'Alice', 
    @LastName = 'Green', 
    @Email = 'alice.green@example.com', 
    @HireDate = '2025-01-05', 
    @PhoneNumber = '555-1234', 
    @DepartmentID = 10;

-- Check if the new employee with EmployeeID 1020 is inserted in the Employees table
SELECT * 
FROM Employees
WHERE EmployeeID = 1020;

-- Check if DepartmentID 10 exists in the Departments table
SELECT * 
FROM Departments
WHERE DepartmentID = 10;

-- Retrieve all records from the Employees table
SELECT * 
FROM Employees;

-- Execute the stored procedure to insert a new employee record
EXEC InsertEmployee 
    @EmployeeID = 1021, 
    @FirstName = 'Mukut', 
    @LastName = 'Kumar', 
    @Email = 'mukut.kumar@example.com', 
    @HireDate = '2025-01-05', 
    @PhoneNumber = '554-1235', 
    @DepartmentID = 10;

-- Retrieve all records from the Employees table
SELECT * 
FROM Employees; -- Checked, everything is correct.
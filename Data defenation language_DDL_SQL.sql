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

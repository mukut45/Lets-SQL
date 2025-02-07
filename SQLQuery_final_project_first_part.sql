-- First part of final poject for SQL Certification
-- AIM: Create a database to implement DDL basic commands using the "Employee"
CREATE DATABASE Employee; -- database creation
use Employee
go

-- 1. Create department table with following columns
CREATE TABLE Department ( -- creating table on the database
    Dept_id INT PRIMARY KEY,          -- Department ID (Primary Key)
    D_Name NVARCHAR(100) NOT NULL,    -- Department Name (Not Null)
    Contact_no INT UNIQUE             -- Contact Number (Unique)
);

-- 2. Create employee table with following columns
CREATE TABLE Employee ( -- creating table on the database
    Emp_id INT PRIMARY KEY,           -- Employee ID (Primary Key)
    Dept_id INT,                      -- Department ID (Foreign Key)
    Emp_name NVARCHAR(100),           -- Employee Name
    Designation NVARCHAR(100),        -- Employee Designation
    Salary MONEY,                     -- Employee Salary (Data Type: Money)
    FOREIGN KEY (Dept_id) REFERENCES Department(Dept_id)  -- Foreign Key reference to Dept_id in Department table
);

-- 3. ADD A NEW CLOUMN IN DEPARTMENT TABLE
ALTER TABLE Department -- adding the new column as "city"
ADD City NVARCHAR(50);

-- 4. CHANGE THE DATATYPE OF SALARY TO CHAR
ALTER TABLE Employee
ALTER COLUMN Salary CHAR(10);

-- 5. Rename the D_Name column to Dept_NAME in the Department table
EXEC sp_rename 'Department.D_Name', 'Dept_NAME', 'COLUMN';

-- 6. Drop the 'City' column from the Department table
ALTER TABLE Department
DROP COLUMN City;

-- Add the 'City' column to the Employee table
ALTER TABLE Employee
ADD City NVARCHAR(50);

-- Add the 'Contact_no' column to the Employee table
ALTER TABLE Employee
ADD Contact_no NVARCHAR(50);

-- DATA MANIPULATION LANGUAGE (DML)
use Employee
go
-- Insert a department with Dept_id = '01' into the Department table
INSERT INTO Department (Dept_id, Dept_NAME, Contact_no)
VALUES 
('01', 'Sales', 0110),
('02', 'Incharge', 0114),
('03', 'Account', 0113);


-- Check the columns in the Department table
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Department';

use Employee
go

INSERT INTO Employee (Emp_id, Dept_id, Emp_name, Designation, Salary, City, Contact_no)
VALUES 
(1, 1, 'S Ahmad', 'Sales Mgr', '50000', 'New Delhi', '0110');

-- Check the columns in the Employee table
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee';

-- INSERT INTO Employee (Emp_id, Dept_id, Emp_name, Designation, Salary, City, Contact_no) -- trying and testing
-- VALUES 
-- (1, 01, 'S Ahmad', 'Sales Mgr', '50000', 'New Delhi', '0110'),
-- (2, 01, 'Anand', 'Sales Mgr', '40000', 'New Delhi', '0111'),
-- (3, 03, 'Aruna', 'Account Mgr', '45000', 'New Delhi', '0112'),
-- (4, 03, 'Alpesh', 'Account', '35000', 'Bangalore', '0113'),
-- (5, 02, 'Monica', 'Incharge', '25000', 'Noida', '0114'),
-- (6, 01, 'Harish', 'Sales Manager', '15000', 'Bangalore', '0115');

-- Check the existing Emp_id values in the Employee table
SELECT Emp_id FROM Employee;
use Employee
go
-- Delete all existing rows in the Employee table
DELETE FROM Employee;

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee';

use Employee
go
INSERT INTO Employee (Emp_id, Dept_id, Emp_name, Designation, Salary, City, Contact_no)
VALUES 
(001, 01, 'S Ahmad', 'Sales Mgr', '50000', 'New Delhi', '0110'),
(002, 01, 'Anand', 'Sales Mgr', '40000', 'New Delhi', '0111'),
(003, 03, 'Aruna', 'Account Mgr', '45000', 'New Delhi', '0112'),
(004, 03, 'Alpesh', 'Account', '35000', 'Bangalore', '0113'),
(005, 02, 'Monica', 'Incharge', '25000', 'Noida', '0114'),
(006, 01, 'Harish', 'Sales Manager', '15000', 'Bangalore', '0115');

SELECT * FROM Department;

-- Insert the missing departments into the Department table
-- INSERT INTO Department (Dept_id, Dept_NAME, Contact_no)
-- VALUES 
-- ('02', 'Accounting', '1234567890');
-- INSERT INTO Department (Dept_id, Dept_NAME, Contact_no)
-- VALUES 
-- ('03', '', '1234567890');

-- Delete the row from the Department table where Dept_id = '02'
DELETE FROM Department
WHERE Dept_id = '02';
SELECT * FROM Department;

INSERT INTO Department (Dept_id, Dept_NAME, Contact_no)
VALUES 
('02', 'HR', '0114');

INSERT INTO Department (Dept_id, Dept_NAME, Contact_no)
VALUES 
('03', 'Acounting', '0113');


INSERT INTO Employee (Emp_id, Dept_id, Emp_name, Designation, Salary, City, Contact_no)
VALUES 
(001, 01, 'S Ahmad', 'Sales Mgr', '50000', 'New Delhi', '0110'),
(002, 01, 'Anand', 'Sales Mgr', '40000', 'New Delhi', '0111'),
(003, 03, 'Aruna', 'Account Mgr', '45000', 'New Delhi', '0112'),
(004, 03, 'Alpesh', 'Account', '35000', 'Bangalore', '0113'),
(005, 02, 'Monica', 'Incharge', '25000', 'Noida', '0114'),
(006, 01, 'Harish', 'Sales Manager', '15000', 'Bangalore', '0115');

SELECT * FROM Employee;

-- 7. Update the Contact_no for the employee in Bangalore with Emp_id = 6 (If anyone wanna exicute the code below, please try to un-comment it before exicution)

--UPDATE Employee
--SET Contact_no = '0115'  -- Replace with the new contact number
-- WHERE Emp_id = 6 AND City = 'Bangalore';

-- 8. Select EMP_ID, EMP_NAME, and Designation from the Employee table
SELECT Emp_id, Emp_name, Designation
FROM Employee;

-- 9. Select all details of employees whose salary is greater than 30,000
SELECT *
FROM Employee
WHERE Salary > 30000;

-- 10. Select all details of employees whose salary is between 15,000 and 30,000
SELECT *
FROM Employee
WHERE Salary BETWEEN 15000 AND 30000;

-- 11. Select all details of employees who live in 'Bangalore' or 'New Delhi'
SELECT *
FROM Employee
WHERE City IN ('Bangalore', 'New Delhi');

-- 12. Select all details of employees who do not stay in 'Bangalore' or 'New Delhi'
SELECT *
FROM Employee
WHERE City NOT IN ('Bangalore', 'New Delhi');

-- 13. Select all details of employees whose name starts with 'A'
SELECT *
FROM Employee
WHERE Emp_name LIKE 'A%';

-- 14. Select all details of employees and order them by Salary in descending order
SELECT *
FROM Employee
ORDER BY Salary DESC;

-- 15. Retrieve the average salary of employees per department with casting
-- I can use the CAST() function to convert the Salary to a numerical type in my SELECT query

SELECT Dept_id, AVG(CAST(Salary AS DECIMAL(10, 2))) AS Average_Salary
FROM Employee
GROUP BY Dept_id;

-- 16. Retrieve dept_id, Salary and average salary for departments with average salary > 30,000
SELECT Dept_id, AVG(CAST(Salary AS DECIMAL(10, 2))) AS Average_Salary
FROM Employee
GROUP BY Dept_id
HAVING AVG(CAST(Salary AS DECIMAL(10, 2))) > 30000;


-- Second part of Final Project for SQL Certification

use Company -- using the company database
go

DROP TABLE company; -- dropig table because the values i have inserted was wrong
DROP TABLE Dept; -- same like above
USE Company -- using the company data base again after removing tables
go

CREATE TABLE company ( -- creating the new table with column names below
    Emp_id INT PRIMARY KEY,     -- Primary key for the Company table
    Name NVARCHAR(50),
    Age INT,
    Address NVARCHAR(100),
    Salary INT,
    Join_date DATE
);

CREATE TABLE Dept ( -- created the department table with column names
    Id INT PRIMARY KEY,        -- Primary key for the Dept table
    Dept NVARCHAR(20),
    emp_id INT                  -- emp_id will refer to the Company table
);

ALTER TABLE company
ADD CONSTRAINT fk_company_dept -- adding the foreign key constraint
FOREIGN KEY (emp_id) -- from company table
REFERENCES Dept(Id); -- referance from department table

INSERT INTO company (Emp_id, Name, Age, Address, Salary, Join_date) -- inserting thr values to company table, column wise
VALUES (1, 'Paul', 32, 'California', 20000, '2001-07-13');


INSERT INTO Dept (Id, Dept, emp_id) -- inserting the values to department table before, to avoid conflicts with foreign key
VALUES
    (1, 'IT Billing', 1),
    (2, 'Engineering', 2),
    (3, 'Finance', 4);

INSERT INTO company (Emp_id, Name, Age, Address, Salary, Join_date)
VALUES (1, 'Paul', 32, 'California', 20000, '2001-07-13');

INSERT INTO company (Emp_id, Name, Age, Address, Salary)
VALUES (3, 'Allen', 23, 'Norway', 20000);

SELECT * FROM Dept; -- to see all the values in dept table
SELECT * FROM company; -- to see all the values in company table

--INSERT INTO company (Emp_id, Name, Age, Address, Salary, Join_date) -- trying and testing
--VALUES (4, 'David', 25, 'Richmond', 65000, '2010-10-25') -- trying and testing

INSERT INTO Dept (Id, Dept, emp_id) -- inserting more values to dept table because to avoid conflicts with the forign key
VALUES
	(4, 'Account', 3),
	(5, 'HR', 5);

INSERT INTO company (Emp_id, Name, Age, Address, Salary, Join_date) -- inserting more values to company table
VALUES (4, 'David', 25, 'Richmond', 65000, '2010-10-25')

INSERT INTO company (Emp_id, Name, Age, Address, Salary, Join_date)
VALUES (5, 'Mark', 27, 'Texas', 35000, '2015-11-02')

INSERT INTO company (Emp_id, Name, Age, Address, Join_date)
VALUES (2, 'Teddy', 25, 'Los Veges', '2013-09-01')

SELECT -- Fetch following details for employee with id = 2 
    c.Emp_id,
    c.Name,
    d.Dept,
    d.Id AS Dept_Id,
    c.Age,
    c.Salary
FROM
    company c
JOIN
    Dept d ON c.Emp_id = d.emp_id
WHERE
    c.Emp_id = 2;

--DELIMITER $$ -- trying and testing

--CREATE PROCEDURE GetEmployeeDetails(IN emp_id_input INT)
--BEGIN
 --   SELECT
     --   c.Emp_id,
     --   c.Name,
     --   d.Dept,
       -- d.Id AS Dept_Id,
        --c.Age,
       -- c.Salary
   -- FROM
     --   company c
    -- JOIN
       -- Dept d ON c.Emp_id = d.emp_id
    -- WHERE
       -- c.Emp_id = 2;
-- END $$

-- DELIMITER ;

CREATE PROCEDURE GetEmployeeDetails -- Create a stored procedure to fetch following columns from Company and Dept2 table based on a given emp id.
    @emp_id_input INT
AS
BEGIN
    SELECT
        c.Emp_id,
        c.Name,
        d.Dept,
        d.Id AS Dept_Id,
        c.Age,
        c.Salary
    FROM
        company c
    JOIN
        Dept d ON c.Emp_id = d.emp_id
    WHERE
        c.Emp_id = @emp_id_input;
END;
EXEC GetEmployeeDetails @emp_id_input = 2;  -- Example: Fetch details for employee with emp_id = 2 (input)
EXEC GetEmployeeDetails @emp_id_input = 3;  -- Example: Fetch details for employee with emp_id = 3 (input)

CREATE VIEW EmployeeDetails AS -- Create a view to fetch the details of employee with following columns
SELECT
    c.Emp_id,
    c.Name,
    d.Dept,
    d.Id AS Dept_Id,
    c.Age,
    c.Salary
FROM
    company c
JOIN
    Dept d ON c.Emp_id = d.emp_id;

SELECT * FROM EmployeeDetails WHERE Emp_id = 2; -- Execution Result (with the input)


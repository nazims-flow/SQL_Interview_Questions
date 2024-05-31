-- Leetcode problem LeetCode SQL Premium Problem 2853: 'Highest Salary Difference'


-- DDL for Salaries table
CREATE TABLE Salaries (
emp_name VARCHAR(50),
department VARCHAR(50),
salary INT,
PRIMARY KEY (emp_name, department)
);

-- DML for Salaries table
INSERT INTO Salaries (emp_name, 
					  department, salary) VALUES
('Kathy', 'Engineering', 50000),
('Roy', 'Marketing', 30000),
('Charles', 'Engineering', 45000),
('Jack', 'Engineering', 85000),
('Benjamin', 'Marketing', 34000),
('Anthony', 'Marketing', 42000),
('Edward', 'Engineering', 102000),
('Terry', 'Engineering', 44000),
('Evelyn', 'Marketing', 53000),
('Arthur', 'Engineering', 32000);



/*
Write an SQL query to calculate the difference 
between the highest salaries 
in the marketing and engineering department. 
Output the absolute difference in salaries.
*/


-- Solution using Window Function and CTE
SELECT * FROM salaries

WITH marketing As(
   SELECT salary
   FROM (
     SELECT department,
       salary,
       ROW_NUMBER() OVER(Partition BY Department ORDER BY Salary DESC) as rn
	   FROM Salaries
   ) as partitioned_salary
	WHERE department ='Marketing' AND rn=1
) ,
engineering AS (
   SELECT salary
   FROM (
     SELECT department,
       salary,
       ROW_NUMBER() OVER(Partition BY Department ORDER BY Salary DESC) as rn
	   FROM Salaries
   ) as partitioned_salary
	WHERE department ='Engineering' AND rn=1
)
SELECT 
    ABS(marketing.salary - engineering.salary) AS absolute_diff 
	FROM marketing , engineering
	   
-- Solution using CASE and Aggregate Functions

SELECT
      ABS(
	  MAX(CASE WHEN department='Marketing' THEN Salary END) -
	  MAX(CASE WHEN department='Engineering' THEN Salary END)
	  ) as salary_diff
	  FROM Salaries
	  
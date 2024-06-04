-- Day 09 SQL 


-- Create Department table
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert values into Department table
INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Create Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

-- Insert additional records into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES
(8, 'Alice', 75000, 2),
(9, 'Bob', 82000, 2),
(10, 'Carol', 78000, 1),
(11, 'David', 70000, 1),
(12, 'Eva', 85000, 2),
(13, 'Frank', 72000, 1),
(14, 'Gina', 83000, 1),
(15, 'Hank', 68000, 1),
(16, 'Irene', 76000, 2),
(17, 'Jack', 74000, 2),
(18, 'Kelly', 79000, 1),
(19, 'Liam', 71000, 1),
(20, 'Molly', 77000, 2),
(21, 'Nathan', 81000, 1),
(22, 'Olivia', 73000, 2),
(23, 'Peter', 78000, 1),
(24, 'Quinn', 72000, 1),
(25, 'Rachel', 80000, 2),
(26, 'Steve', 75000, 2),
(27, 'Tina', 79000, 1);






/*
-- Question Day-09/30 Find Department's Top three 
salaries in each department.

Table: department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |  id is primary key
| name        | varchar |	department_name
+-------------+---------+

Table: employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |		id is the primary key
| name         | varchar |
| salary       | int     |
| departmentId | int     |		departmentId is the foreign key	
+--------------+---------+

 A company's executives are interested in seeing who earns the most 
 money in each of the company's departments. 
 A high earner in a department is an employee 
 who has a salary in the top three unique salaries 
 for that department.
 Write a solution to find the employees 
who are high earners in each of the departments.
*/

SELECT * FROM department
SELECT * FROM employee


SELECT 
      dept_name,
      id ,
	  name ,
	  salary
FROM(     
SELECT 
      e.id ,
	  e.name ,
	  e.salary,
	  e.departmentid,
	  d.name as dept_name,
	  DENSE_RANK() OVER(Partition By d.name ORDER BY e.salary DESC) as dn
	  FROM employee as e
	  JOIN department as d
	  ON d.id = e.departmentid) as ranked_sal
	  WHERE dn<4
	  
	  
	  


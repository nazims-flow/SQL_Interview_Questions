
-- Google Interview Question for DA

CREATE TABLE student_names(
    student_id INT,
    name VARCHAR(50)
);

-- Insert the records
INSERT INTO student_names (student_id, name) VALUES
(1, 'RAM'),
(2, 'ROBERT'),
(3, 'ROHIM'),
(4, 'RAM'),
(5, 'ROBERT');


-- Question 


-- Get the count of distint student that are not unique 

SELECT * FROM student_names

SELECT COUNT(non_unique_name) 
FROM(
SELECT DISTINCT(name) as non_unique_name,
       COUNT(name)
	   FROM student_names
	   GROUP BY 1 
	   HAVING COUNT(name)>1) as x
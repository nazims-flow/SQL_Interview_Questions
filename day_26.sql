-- 26/30 Days SQL Challenge

-- SCHEMA

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_items_ordered INT
);

INSERT INTO orders VALUES
(1, 101, '2022-01-01', 5),
(2, 102, '2022-01-02', 10),
(3, 103, '2022-01-03', 8),
(4, 104, '2022-01-04', 12),
(5, 105, '2022-01-05', 15),
(6, 106, '2022-01-06', 20),
(7, 107, '2022-01-07', 25),
(8, 108, '2022-01-08', 30),
(9, 109, '2022-01-09', 35),
(10, 110, '2022-01-10', 40),
(11, 111, '2022-01-11', 45),
(12, 112, '2022-01-12', 50),
(13, 113, '2022-01-13', 55),
(14, 114, '2022-01-14', 60),
(15, 115, '2022-01-15', 65);


DROP TABLE IF EXISTS returns;

CREATE TABLE returns (
    return_id INT,
    order_id INT,
    return_date DATE,
    returned_items INT
);

INSERT INTO returns VALUES
(1, 1, '2022-01-03', 2),
(2, 2, '2022-01-05', 3),
(3, 3, '2022-01-07', 1),
(4, 5, '2022-01-08', 4),
(5, 6, '2022-01-08', 6),
(6, 7, '2022-01-09', 7),
(7, 8, '2022-01-10', 8),
(8, 9, '2022-01-11', 9),
(9, 10, '2022-01-12', 10),
(10, 11, '2022-01-13', 11),
(11, 12, '2022-01-14', 12),
(12, 13, '2022-01-15', 13),
(13, 14, '2022-01-16', 14),
(14, 15, '2022-01-17', 15);




/*
-- Amazon Data Analyst Interview 
Hard Category Questions Time 15min

Question:

Suppose you are given two tables - Orders and Returns. 
The Orders table contains information about orders placed by customers, 
and the Returns table contains information about returned items. 

Design a SQL query to 
find the top 5 ustomer with the highest percentage 
of returned items out of their total orders. 
	
Return the customer ID 
and the percentage of returned items rounded to two decimal places.

*/

-- customer_id,
-- total_items_ordered by each cx
-- total_items_returned by each cx
-- 2/4*100 50% total_items_returned/total_items_ordered*100



SELECT * FROM orders;
SELECT * FROM returns;


SELECT
    o.customer_id,
    SUM(o.total_items_ordered) AS total_items_ordered,
    SUM(r.returned_items) AS total_items_returned,
    ROUND((SUM(r.returned_items) * 100.0 / SUM(o.total_items_ordered))::NUMERIC, 2) AS return_per,
    DENSE_RANK() OVER (ORDER BY ROUND((SUM(r.returned_items) * 100.0 / SUM(o.total_items_ordered))::NUMERIC, 2) DESC) AS rank
FROM orders AS o
LEFT JOIN returns AS r ON o.order_id = r.order_id
GROUP BY o.customer_id
HAVING SUM(r.returned_items) > 0
ORDER BY rank
LIMIT 5;

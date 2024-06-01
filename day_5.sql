-- Create transactions table
CREATE TABLE transactions (
    user_id INTEGER,
    spend DECIMAL(10, 2),
    transaction_date TIMESTAMP
);

-- Insert data into transactions table
INSERT INTO transactions (user_id, spend, transaction_date) VALUES
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00');

/*
-- UBER DATA ANALYST INTERVIEW QUESTION
Question:
Write a SQL query to obtain the third transaction of every user. 
Output the user id, spend, and transaction date.
*/

SELECT * FROM transactions

SELECT user_id ,
       spend , 
	   transaction_date
FROM
(SELECT user_id,
        spend,
	   transaction_date ,
       ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) as rn
       FROM transactions) WHERE rn=3
	   
/*
Question:
Find the top 5 products whose revenue has decreased in comparison to the 
previous year (both 2022 and 2023). Return the product name, 
revenue for the previous year, revenue for the current year, 
revenue decreased, and the decreased ratio (percentage).
*/	   

SELECT * FROM product_revenue

WITH prev_year as
(   SELECT 
         product_name ,
         revenue 
         FROM product_revenue
         WHERE Year=2022
),
cur_year as
(  SELECT 
         product_name ,
         revenue 
         FROM product_revenue
         WHERE Year=2023
)

SELECT p.product_name as prod_name ,
       p.revenue as prev_revenue,
	   c.revenue as cur_revenue,
	   (p.revenue - c.revenue) as revenue_decreased,
	   ROUND((p.revenue - c.revenue)*100.0/p.revenue::NUMERIC,2) as decreased_ratio
	   FROM prev_year as p
	   JOIN cur_year as c
	   ON p.product_name=c.product_name
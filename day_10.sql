CREATE TABLE Transactions (
    id INT PRIMARY KEY,
    country VARCHAR(255),
    state VARCHAR,
    amount INT,
    trans_date DATE
);

INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');


/*
Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.

Return the result table in in below order.RANGE


Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/


SELECT * FROM Transactions

SELECT EXTRACT(MONTH FROM trans_date) as month,
       Country ,
	   COUNT(state) as trans_count,
	   SUM(CASE 
			  WHEN state= 'approved' THEN 1 ELSE 0 END ) as approved_count,
	   SUM(amount) as trans_total_amount,
	   SUM(CASE 
		      WHEN state= 'approved' THEN amount ELSE 0 END) as approved_amount
	   FROM transactions
	   GROUP BY 1 ,2
	   ORDER BY 3 DESC

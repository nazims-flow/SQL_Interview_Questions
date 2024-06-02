-- Create product_spend table
CREATE TABLE product_spend (
    category VARCHAR(255),
    product VARCHAR(255),
    user_id INTEGER,
    spend DECIMAL(10, 2),
    transaction_date TIMESTAMP
);

-- Insert sample records
INSERT INTO product_spend (category, product, user_id, spend, transaction_date) VALUES
('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
('appliance', 'refrigerator', 123, 299.99, '2022-03-02 12:00:00'),
('appliance', 'washing machine', 123, 219.80, '2022-03-02 12:00:00'),
('electronics', 'vacuum', 178, 152.00, '2022-04-05 12:00:00'),
('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');

/*
-- Amazon Interview question

Question:
Write a query to identify the top two highest-grossing products 
within each category in the year 2022. Output should include the category,
product, and total spend.

*/

SELECT * FROM product_spend

SELECT
	category,
	product,
	total_spend
FROM
(SELECT category ,
       product ,
	   SUM(spend) as total_spend,
	   DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as dn
	   FROM product_spend
       WHERE EXTRACT(YEAR FROM transaction_date)=2022
       GROUP BY 1 , 2) as ranked_category
       WHERE dn<3
	   
	   
	   
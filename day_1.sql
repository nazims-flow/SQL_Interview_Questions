/* 1. You have two tables: Product and Supplier.
- Product Table Columns: Product_id, Product_Name, Supplier_id, Price
- Supplier Table Columns: Supplier_id, Supplier_Name, Country
*/

-- Write an SQL query to find the name of the product with the highest 
-- price in each country.

SELECT * FROM products
SELECT * FROM suppliers

SELECT *
FROM
(
SELECT p.product_id ,
       p.product_name,
	   p.supplier_id,
	   p.price,
	   s.country,
	   DENSE_RANK() OVER(PARTITION BY s.country ORDER BY p.price DESC) as dn
	   FROM products as p
	   JOIN suppliers as s
	   ON s.supplier_id = p.supplier_id
) WHERE dn = 1


---- Q.2 

/* 
You have two tables: Customer and Transaction.
- Customer Table Columns: Customer_id, Customer_Name, Registration_Date
- Transaction Table Columns: Transaction_id, Customer_id, Transaction_Date, Amount

-- Write an SQL query to calculate the total transaction amount for each customer for the current year. 
The output should contain Customer_Name and the total amount.
*/

-- 1. find total transaction amt group by each customer filter with current year 
-- put where condition to check if the transaction are current year year 1  

SELECT * FROM Customers
SELECT * FROM Transaction

SELECT c.customer_name,
       SUM(t.amount)
	   FROM Customers as c
	   JOIN Transaction as t
	   ON c.customer_id = t.customer_id
	   WHERE EXTRACT(Year FROM t.transaction_date)= (SELECT EXTRACT(Year FROM CURRENT_DATE)) 
       GROUP BY 1;

       
       






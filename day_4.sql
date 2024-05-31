CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Insert values into the customers table
INSERT INTO customers (customer_id, customer_name, age, gender)
VALUES
    (1, 'John Doe', 30, 'Male'),
    (2, 'Jane Smith', 25, 'Female'),
    (3, 'Alice Johnson', 35, 'Female'),
    (4, 'Bob Brown', 40, 'Male');

-- Insert values into the orders table
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
    (101, 1, '2023-01-15', 150.50),
    (102, 2, '2022-02-20', 200.25),
    (103, 3, '2023-03-10', 180.75),
    (104, 4, '2023-04-05', 300.00),
    (105, 1, '2022-05-12', 175.80),
    (106, 2, '2021-06-18', 220.40),
    (107, 3, '2023-07-22', 190.30),
    (108, 4, '2023-08-30', 250.60),
	(109, 4, '2021-08-30', 250.60),
	(110, 4, '2024-01-30', 250.60),
	(111, 4, '2023-08-30', 250.60);;


/* IBM Data Analyst SQL Question
Q.1
Customer Segmentation Problem:
You have two tables: customers and orders.

customers table has columns: 
  customer_id, customer_name, age, gender.
orders table has columns: 
order_id, customer_id, order_date, total_amount.


Write an SQL query to find the average order amount 
for male and female customers separately
return the results with 2 DECIMAL.
*/

SELECT * FROM customers

SELECT * FROM orders
-- using case
SELECT 
       ROUND(AVG(CASE 
	    WHEN c.gender='Male' THEN o.total_amount
		ELSE 0
	    END)::NUMERIC , 2)
       as avg_male_order_amount,
	   ROUND(AVG(CASE 
	    WHEN c.gender='Female' THEN o.total_amount 
		ELSE 0
	    END )::NUMERIC, 2)
	   as avg_female_order_amount
	  FROM 
      customers as c
	  JOIN orders as o
	  ON c.customer_id = o.customer_id
	  
-- using group by
SELECT 
	c.gender as gender_name,
	ROUND(avg(o.total_amount), 2) as avg_spent
FROM customers as c
JOIN orders as o
ON c.customer_id = o.customer_id
GROUP BY gender_name


CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price_per_unit DECIMAL(10, 2)
);
INSERT INTO sales (order_id, order_date, product_id, quantity, price_per_unit)
VALUES
    (1, '2022-03-10', 101, 2, 15.00),
    (2, '2022-04-05', 102, 1, 25.50),
    (3, '2023-01-15', 103, 3, 10.75),
    (4, '2023-02-20', 104, 2, 30.20),
    (5, '2022-05-12', 105, 4, 12.80),
    (6, '2023-06-18', 106, 2, 22.40),
    (7, '2023-07-22', 107, 1, 45.30),
    (8, '2021-08-30', 108, 3, 20.60);

SELECT * FROM Sales

--Write an SQL query to find out the total sales revenue generated for each month in the year 2023.

SELECT 
      EXTRACT (Month FROM order_date) as month,
      SUM((quantity * price_per_unit)) as total_sales_month
	  FROM sales
	  WHERE EXTRACT(Year FROM order_date)=2023
	  GROUP BY 1
	  ORDER BY 1
CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    Region VARCHAR(50),
    Amount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales (Region, Amount, SaleDate) VALUES
('North', 5000.00, '2024-05-01'),
('South', 6000.00, '2024-05-02'),
('East', 4500.00, '2024-05-03'),
('West', 7000.00, '2024-05-04'),
('North', 5500.00, '2024-05-05'),
('South', 6500.00, '2024-05-06'),
('East', 4800.00, '2024-05-07'),
('West', 7200.00, '2024-05-08'),
('North', 5200.00, '2024-05-09'),
('South', 6200.00, '2024-05-10'),
('East', 4700.00, '2024-05-11'),
('West', 7100.00, '2024-05-12'),
('North', 5300.00, '2024-05-13'),
('South', 6300.00, '2024-05-14'),
('East', 4600.00, '2024-05-15'),
('West', 7300.00, '2024-05-16'),
('North', 5400.00, '2024-05-17'),
('South', 6400.00, '2024-05-18'),
('East', 4900.00, '2024-05-19'),
('West', 7400.00, '2024-05-20'),
('North', 5600.00, '2024-05-21'),
('South', 6600.00, '2024-05-22'),
('East', 5000.00, '2024-05-23'),
('West', 7500.00, '2024-05-24'),
('North', 5700.00, '2024-05-25'),
('South', 6700.00, '2024-05-26'),
('East', 5100.00, '2024-05-27'),
('West', 7600.00, '2024-05-28');


-- Flipkart Business Analyst entry level SQL question

/*

Identify the region with the lowest sales amount for the previous month. 
return region name and total_sale amount.

*/
-- region and sum sale
-- filter last month
-- lowest sale region


SELECT * FROM Sales

SELECT Region
FROM
(
SELECT Region,
       SUM(amount),
	   ROW_NUMBER() OVER(ORDER BY SUM(amount)) as rn
	   FROM Sales
	   WHERE EXTRACT(Month FROM saledate)=EXTRACT(MONTH FROM current_date)-1
	   GROUP BY 1) WHERE rn=1
	   
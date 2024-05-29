-- SCHEMA


-- Create pages table
CREATE TABLE pages (
    page_id INTEGER PRIMARY KEY,
    page_name VARCHAR(255)
);

-- Insert data into pages table
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Create page_likes table
CREATE TABLE page_likes (
    user_id INTEGER,
    page_id INTEGER,s
    liked_date TIMESTAMP,
    FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- Insert data into page_likes table
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');

SELECT * FROM Pages
SELECT * FROM page_likes

--Write a SQL query to retrieve the IDs of the Facebook pages that have zero likes. 
--The output should be sorted in ascending order based on the page IDs.

--Solution 1
WITH CTE as 
       (SELECT p.page_id,
	   COUNT(pl.page_id) as count_of_likes
	   FROM pages as p
	   LEFT JOIN page_likes as pl
	   ON p.page_id = pl.page_id
	   GROUP BY 1
	   )
	   SELECT page_id
	   FROM CTE 
	   WHERE count_of_likes = 0
	   ORDER BY 1
	   
--SOlution 2   
SELECT p.page_id,
	   COUNT(pl.page_id) as count_of_likes
	   FROM pages as p
	   LEFT JOIN page_likes as pl
	   ON p.page_id = pl.page_id
	   GROUP BY 1
	   HAVING COUNT(pl.page_id)=0
	   ORDER BY 1 ASC
	   
	   
--Solution 3
SELECT 
page_id,
page_name
FROM pages
WHERE page_id NOT IN
(SELECT  page_id
		FROM page_likes
)
ORDER BY 1
	  



-- Create the events table
CREATE TABLE events (
    app_id INTEGER,
    event_type VARCHAR(10),
    timestamp TIMESTAMP
);

-- Insert records into the events table
INSERT INTO events (app_id, event_type, timestamp) VALUES
(123, 'impression', '2022-07-18 11:36:12'),
(123, 'impression', '2022-07-18 11:37:12'),
(123, 'click', '2022-07-18 11:37:42'),
(234, 'impression', '2022-07-18 14:15:12'),
(234, 'click', '2022-07-18 14:16:12');

/*

Question 2: 
Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.
Definition and note:
Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.
Expected Output Columns: app_id, ctr

Question 2 Link :: https://datalemur.com/questions/click-through-rate

*/
SELECT * FROM events

WITH Click as 
(SELECT app_id,
       COUNT(event_type) as no_of_clicks
	   FROM events
       WHERE EXTRACT(Year FROM timestamp)=2022 AND event_type='click'
       GROUP BY 1
),
Impression AS
(   
	SELECT app_id,
	COUNT(event_type) AS no_of_impression
	FROM events
    WHERE EXTRACT(Year FROM timestamp)=2022 AND event_type='impression'
	GROUP BY 1
)
SELECT
     cl.app_id,
     100.0*cl.no_of_clicks/im.no_of_impression AS CTR
	 FROM click as cl 
	 JOIN
	 impression as im
	 ON cl.app_id = im.app_id
	 
	 
--Solution 2 	 
	 
SELECT 
    app_id,
    ROUND((100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) / SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END)), 2) AS ctr
FROM 
    events
WHERE 
    EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY 
    app_id;
	   











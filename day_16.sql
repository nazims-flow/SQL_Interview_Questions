CREATE TABLE tiktok (
					views INT
);


-- Insert records
-- Insert records into the tiktok table
INSERT INTO tiktok (views) 
VALUES 
	(100), (800), (350), 
	(150), (600), 
	(700), (700), (950);


--- Find the median of the views

WITH CTE
AS (
	SELECT 
		views,
		ROW_NUMBER() OVER( ORDER BY views ASC) rn_asc,
		ROW_NUMBER() OVER( ORDER BY views DESC) rn_desc
	FROM tiktok
	WHERE views < 900
)
SELECT 
	AVG(views) as median
FROM CTE 
WHERE ABS(rn_asc - rn_desc) <= 1
LOAD DATA LOCAL INFILE 'C:/Users/steph/Desktop/DA Learning/Practice Datasets/Divvy/Formatted/202409-divvy-tripdata_formatted.csv' INTO TABLE ride_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Confirm import ran smoothly
SELECT *
FROM ride_data
LIMIT 10;

-- Get accurate percentage numbers for sampling, number of total rides by member type per month
SELECT DATE_FORMAT(started_at, '%Y-%m') AS month, member_casual, COUNT(ride_id) AS total_rides
FROM ride_data
GROUP BY DATE_FORMAT(started_at, '%Y-%m'), member_casual
ORDER BY month, member_casual;

SELECT *
FROM ride_data
WHERE started_at LIKE '2024-09%' AND member_casual = 'member'
LIMIT 949;

-- Average Ride Length by date and member type
SELECT DATE(started_at) AS startdate, SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(TIMEDIFF(ended_at,started_at))))) AS timediff, member_casual
FROM ride_data
GROUP BY startdate, member_casual
ORDER BY startdate;

-- Average ride length by day of the week and member type
SELECT  day_of_the_week, SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(TIMEDIFF(ended_at,started_at))))) AS timediff, member_casual
FROM ride_data
GROUP BY day_of_the_week, member_casual
ORDER BY day_of_the_week;

-- Average ride length by member type
SELECT  member_casual, SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(TIMEDIFF(ended_at,started_at))))) AS timediff
FROM ride_data
GROUP BY member_casual;

-- Total rides by day of the week and member type
SELECT  COUNT(ride_id) AS total_rides, member_casual, day_of_the_week
FROM ride_data
GROUP BY member_casual, day_of_the_week;

-- Total rides by date and member type
SELECT  DATE(started_at) AS startdate, member_casual, COUNT(ride_id) AS total_rides
FROM ride_data
GROUP BY member_casual, startdate;


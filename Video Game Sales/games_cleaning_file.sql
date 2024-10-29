LOAD DATA LOCAL INFILE 'C:/Users/steph/Desktop/DA Learning/Practice Datasets/Game Sales/Video_Games_Sales_as_at_22_Dec_2016.csv' INTO TABLE games_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT *
FROM games_data;

CREATE TABLE games_staging
LIKE games_data;

INSERT games_staging
SELECT *
FROM games_data;

-- Deleting Where Year was N/A
DELETE
FROM games_staging
WHERE Year_of_Release = '0';

-- Searching for Duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Name`, Platform, Year_of_Release, Genre, Publisher, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales, Critic_Score, Critic_Count, User_Score, User_Count, Developer, Rating) AS row_num
FROM games_staging;

WITH duplicate_finder AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Name`, Platform, Year_of_Release, Genre, Publisher, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales, Critic_Score, Critic_Count, User_Score, User_Count, Developer, Rating) AS row_num
FROM games_staging
)
SELECT *
FROM duplicate_finder
WHERE row_num > 1;

SELECT COUNT(*)
FROM games_staging
WHERE `Name` = '' OR Platform = '' OR Year_of_Release = '' OR Genre = '' OR Publisher = '';

SELECT *
FROM games_staging;

UPDATE games_staging
SET Platform = 'PSVita'
WHERE Platform = 'PSV';

UPDATE games_staging
SET Platform = 'Atari 2600'
WHERE Platform = '2600';

UPDATE games_staging
SET Platform = 'PS1'
WHERE Platform = 'PS';







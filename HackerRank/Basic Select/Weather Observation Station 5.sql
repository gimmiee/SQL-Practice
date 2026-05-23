/*
Working platform: MySQL

Purpose:
Find:
1) The city with the shortest name and its length
2) The city with the longest name and its length

Rules:
- If multiple cities have the same shortest/longest length,
  choose the one that comes first alphabetically.
*/

-- Shortest city name
SELECT 
    CITY,
    LENGTH(CITY) AS city_length
FROM STATION
ORDER BY 
    LENGTH(CITY) ASC,
    CITY ASC
LIMIT 1;


-- Longest city name
SELECT 
    CITY,
    LENGTH(CITY) AS city_length
FROM STATION
ORDER BY 
    LENGTH(CITY) DESC,
    CITY ASC
LIMIT 1;

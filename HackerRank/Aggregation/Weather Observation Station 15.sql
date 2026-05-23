/*
Working platform: MySQL

Purpose:
From the STATION table, find the longitude (LONG_W) of the station
that has LAT_N less than 137.2345 and the highest LAT_N among them.

Output:
- LONG_W rounded to 4 decimal places

Approach:
- Filter rows where LAT_N < 137.2345
- Sort by LAT_N in descending order
- Pick the top record
- Round LONG_W to 4 decimal places
*/

SELECT 
    ROUND(LONG_W, 4) AS longitude
FROM 
    STATION
WHERE 
    LAT_N < 137.2345
ORDER BY 
    LAT_N DESC
LIMIT 1;

/*
Working platform: MySQL

Purpose:
Calculate the Euclidean distance between two points:
- (MAX LAT_N, MAX LONG_W)
- (MIN LAT_N, MIN LONG_W)

Return the result rounded to 4 decimal places.

Approach:
- Find maximum and minimum latitude values
- Find maximum and minimum longitude values
- Apply Euclidean distance formula:
  sqrt((x2 - x1)^2 + (y2 - y1)^2)
- Round result to 4 decimal places
*/

SELECT 
    ROUND(
        SQRT(
            POWER(MAX(LAT_N) - MIN(LAT_N), 2) + 
            POWER(MAX(LONG_W) - MIN(LONG_W), 2)
        ),
        4
    ) AS euclidean_distance
FROM STATION;

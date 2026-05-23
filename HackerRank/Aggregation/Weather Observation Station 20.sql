 /*
Working platform: MySQL

Purpose:
Find the median value of LAT_N from the STATION table.
Return the value rounded to 4 decimal places.

Approach:
- For each LAT_N, compare how many values are smaller and larger than it
- The median is the value where:
  COUNT(values < LAT_N) = COUNT(values > LAT_N)
- This works because the median splits the dataset into two equal halves
*/

SELECT 
    ROUND(st.lat_n, 4) AS median_lat_n
FROM station AS st
WHERE 
    (SELECT COUNT(lat_n) 
     FROM station 
     WHERE lat_n < st.lat_n)
    =
    (SELECT COUNT(lat_n) 
     FROM station 
     WHERE lat_n > st.lat_n);

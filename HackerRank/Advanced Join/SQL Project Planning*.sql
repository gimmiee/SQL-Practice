/*
Working platform: MySQL

Purpose:
Identify project groups by detecting continuous date ranges.
Return:
- project start date
- corresponding end date

Approach:
- Step 1: Identify valid project start dates
  (Start_Date not appearing as End_Date)
- Step 2: Identify valid project end dates
  (End_Date not appearing as Start_Date)
- Step 3: Generate all possible start-end pairs using CROSS JOIN
- Step 4: Filter valid ranges (start < end)
- Step 5: For each start date, choose the earliest valid end date
- Step 6: Sort by project duration, then start date
*/

SELECT 
    A.START_DATE,
    MIN(B.END_DATE) AS END_DATE
FROM 
(
    SELECT Start_Date 
    FROM Projects 
    WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)
) A
CROSS JOIN 
(
    SELECT End_Date 
    FROM Projects 
    WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)
) B
WHERE A.START_DATE < B.END_DATE
GROUP BY A.START_DATE
ORDER BY 
    DATEDIFF(MIN(B.END_DATE), A.START_DATE),
    A.START_DATE;

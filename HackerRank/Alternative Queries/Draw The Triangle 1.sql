/*
Working platform: MySQL

Purpose:
Generate a decreasing star pattern P(20), where each row prints
a number of '*' equal to the current row number.

Approach:
- Use a recursive CTE to generate numbers from 20 down to 1
- For each number n, repeat '* ' n times
- Output each row as a string pattern
*/

WITH RECURSIVE numbers AS (
    -- Anchor: starting value
    SELECT 20 AS n

    UNION ALL

    -- Recursive step: decrease value by 1 until reaching 1
    SELECT n - 1
    FROM numbers
    WHERE n > 1
)

SELECT REPEAT('* ', n)
FROM numbers;

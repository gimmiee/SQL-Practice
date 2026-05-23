/*
Working platform: MySQL

Purpose:
Generate and print a simple increasing star pattern P(20),
where each row i contains i repetitions of '* '.

Approach:
- Use a recursive CTE to generate numbers from 1 to 20
- For each number n, repeat '* ' n times
- Output each row as a string pattern
*/

WITH RECURSIVE numbers AS (
    -- Anchor: starting value
    SELECT 1 AS n

    UNION ALL

    -- Recursive step: increment value until 20
    SELECT n + 1
    FROM numbers
    WHERE n < 20
)

SELECT REPEAT('* ', n)
FROM numbers;

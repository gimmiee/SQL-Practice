/*
Working platform: MySQL

Purpose:
Print all prime numbers less than or equal to 1000
on a single line separated by '&'.

Approach:
- Use a recursive CTE to generate numbers from 1 to 1000
- Identify prime numbers by checking whether any number
  greater than 1 and smaller than itself divides evenly
- Keep only numbers with no valid divisors
- Concatenate results into a single string using '&' as separator
*/

WITH RECURSIVE numbers AS (
    -- Anchor: starting value
    SELECT 1 AS n
    UNION ALL
    -- Recursive step: increment number until 1000
    SELECT n + 1
    FROM numbers
    WHERE n < 1000
),

primes AS (
    SELECT n
    FROM numbers
    WHERE n > 1
      AND NOT EXISTS (
          -- Check if the current number has any divisor
          SELECT 1
          FROM numbers d
          WHERE d.n < numbers.n
            AND d.n > 1
            AND numbers.n % d.n = 0
      )
)
  
SELECT GROUP_CONCAT(n SEPARATOR '&')
FROM primes;

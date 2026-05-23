/*
Working platform: MySQL
Purpose: Retrieve hacker details with their total challenge counts,
         keeping only those with either the maximum count or a unique count.

Approach:
- Compute total challenges per hacker
- Calculate frequency of each challenge count
- Identify the maximum challenge count
- Filter:
  * Keep hackers with the maximum count
  * OR keep hackers whose count appears only once
- Sort by total challenges (DESC), then hacker_id (ASC)
*/

WITH hacker_counts AS (
    SELECT 
        h.hacker_id,
        h.name,
        COUNT(c.challenge_id) AS total_count
    FROM hackers h
    JOIN challenges c 
        ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
),
count_frequency AS (
    SELECT 
        total_count,
        COUNT(*) AS freq
    FROM hacker_counts
    GROUP BY total_count
),
max_count AS (
    SELECT MAX(total_count) AS max_cnt
    FROM hacker_counts
)

SELECT 
    hc.hacker_id,
    hc.name,
    hc.total_count
FROM hacker_counts hc
JOIN count_frequency cf
    ON hc.total_count = cf.total_count
CROSS JOIN max_count mc
WHERE 
    hc.total_count = mc.max_cnt
    OR cf.freq = 1
ORDER BY 
    hc.total_count DESC,
    hc.hacker_id;

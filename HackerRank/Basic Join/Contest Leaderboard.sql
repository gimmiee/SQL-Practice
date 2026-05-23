/*
Working platform: MySQL

Purpose:
Retrieve each hacker's total score across all challenges,
where total score is defined as the sum of each challenge's maximum score.

Approach:
- Compute the maximum score per hacker per challenge
- Aggregate these maximum scores per hacker
- Exclude hackers with a total score of 0
- Sort by total score (DESC), then hacker_id (ASC)
*/

WITH maxscore AS (
    SELECT 
        hacker_id,
        challenge_id,
        MAX(score) AS max_score
    FROM submissions
    GROUP BY hacker_id, challenge_id
)

SELECT 
    h.hacker_id,
    h.name,
    SUM(ms.max_score) AS total_score
FROM maxscore ms
JOIN hackers h 
    ON ms.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(ms.max_score) > 0
ORDER BY total_score DESC, h.hacker_id;

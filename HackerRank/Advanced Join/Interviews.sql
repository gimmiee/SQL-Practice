/*
Working platform: MySQL

Purpose:
For each contest, calculate:
- total submissions
- total accepted submissions
- total views
- total unique views

Then exclude contests where all values are 0.

Approach:
- Join all related tables from Contests → Colleges → Challenges
  → Submission_Stats → View_Stats
- Aggregate metrics per contest
- Filter out empty contests using HAVING
*/

SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    SUM(ss.total_submissions) AS total_submissions,
    SUM(ss.total_accepted_submissions) AS total_accepted_submissions,
    SUM(vs.total_views) AS total_views,
    SUM(vs.total_unique_views) AS total_unique_views
FROM Contests c
JOIN Colleges col 
    ON c.contest_id = col.contest_id
JOIN Challenges ch 
    ON col.college_id = ch.college_id
LEFT JOIN Submission_Stats ss 
    ON ch.challenge_id = ss.challenge_id
LEFT JOIN View_Stats vs 
    ON ch.challenge_id = vs.challenge_id
GROUP BY 
    c.contest_id, 
    c.hacker_id, 
    c.name
HAVING 
    SUM(ss.total_submissions)
    + SUM(ss.total_accepted_submissions)
    + SUM(vs.total_views)
    + SUM(vs.total_unique_views) > 0
ORDER BY 
    c.contest_id;

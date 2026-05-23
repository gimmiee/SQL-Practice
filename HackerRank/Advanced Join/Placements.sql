/*
Working platform: MySQL

Purpose:
Find students whose best friends have a higher salary than themselves.
Return student names ordered by their friend's salary in descending order.

Approach:
- Join Students with Friends to map each student to their best friend
- Join Packages twice:
  * one for student's salary
  * one for friend's salary
- Filter where friend's salary > student's salary
- Sort by friend's salary DESC
*/

SELECT 
    S.Name
FROM Students S
JOIN Friends F 
    ON S.ID = F.ID
JOIN Packages P 
    ON S.ID = P.ID
JOIN Packages FP 
    ON F.Friend_ID = FP.ID
WHERE FP.Salary > P.Salary
ORDER BY FP.Salary DESC;

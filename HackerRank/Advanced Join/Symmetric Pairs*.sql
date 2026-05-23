/*
Working platform: MySQL

Purpose:
Find all symmetric pairs (X, Y) in the Functions table such that:
- There exists a matching pair (Y, X)
- Avoid duplicates
- Include (X, X) only if it appears more than once

Approach:
- Self join the table to match X with Y and Y with X
- Use GROUP BY to remove duplicate outputs
- Use HAVING condition to:
  * keep pairs where X < Y (to avoid duplicate reverse pairs)
  * OR keep (X, X) only if it appears more than once
- Sort by X ascending
*/

SELECT 
    F1.X,
    F1.Y
FROM Functions F1
JOIN Functions F2 
    ON F1.X = F2.Y 
   AND F1.Y = F2.X
GROUP BY 
    F1.X, F1.Y
HAVING 
    F1.X < F1.Y 
    OR COUNT(*) > 1
ORDER BY 
    F1.X;

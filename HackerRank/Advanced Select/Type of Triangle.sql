/*
Working platform: MySQL

Purpose:
Classify each row in TRIANGLES table as a type of triangle based on side lengths.

Approach:
- Use triangle inequality rule to check validity first
- If not valid, return 'Not A Triangle'
- If valid, classify based on equality of sides:
  * All sides equal → Equilateral
  * Two sides equal → Isosceles
  * All sides different → Scalene
*/

SELECT 
    CASE
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        ELSE 'Scalene'
    END AS triangle_type
FROM TRIANGLES;

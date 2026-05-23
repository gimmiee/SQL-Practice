/*
Working platform: MySQL

Purpose:
1) Display each person's name with their occupation initial in parentheses.
2) Generate a summary count of each occupation in formatted sentences.

Approach:
- Query 1:
  * Concatenate Name with first letter of Occupation
  * Sort by Name (alphabetical order)

- Query 2:
  * Group records by Occupation
  * Count number of people per occupation
  * Format output string
  * Sort by frequency (ASC), then occupation (ASC)
*/

-- 1. Name with occupation initial
SELECT 
    CONCAT(Name, '(', SUBSTRING(Occupation, 1, 1), ')') AS formatted_name
FROM OCCUPATIONS
ORDER BY Name;

-- 2. Occupation frequency summary
SELECT 
    CONCAT(
        'There are a total of ',
        COUNT(*),
        ' ',
        LOWER(Occupation),
        's.'
    ) AS occupation_summary
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY 
    COUNT(*) ASC,
    Occupation ASC;

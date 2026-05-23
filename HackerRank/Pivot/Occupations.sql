/*
Working platform: MySQL

Purpose:
Pivot the Occupation column so that each occupation becomes
its own column with names listed alphabetically underneath.

Approach:
- Assign a row number to each name within its occupation group
  using alphabetical order
- Use CASE WHEN to place names into their corresponding occupation column
- Use MAX() to extract the non-NULL value within each grouped row
- Group by row number to align names horizontally across occupations

[Original Table]
+------------+-----------+
| Occupation | Name      |
+------------+-----------+
| Doctor     | Jenny     |
| Professor  | Ashley    |
| Singer     | Emily     |
| Actor      | Samantha  |
| Doctor     | Julia     |
+------------+-----------+

[Pivot]
+----------+-----------+--------+----------+
| Doctor   | Professor | Singer | Actor    |
+----------+-----------+--------+----------+
| Jenny    | Ashley    | Emily  | Samantha |
| Julia    | NULL      | NULL   | NULL     |
+----------+-----------+--------+----------+
*/

WITH numbered AS (
    SELECT
        name,
        occupation,
        ROW_NUMBER() OVER (
            PARTITION BY occupation
            ORDER BY name
        ) AS rn
    FROM occupations
)

SELECT
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM numbered
GROUP BY rn;

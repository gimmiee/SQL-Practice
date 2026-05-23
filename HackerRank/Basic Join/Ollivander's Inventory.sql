/*
Working platform: MySQL

Purpose:
Find the cheapest (minimum coins_needed) wand for each combination of:
- age (from wand property)
- power (from wands table)

Only include non-evil wands.

Return:
- id
- age
- coins_needed
- power

Order:
- power DESC
- age DESC

Approach:
- Join Wands with Wands_Property
- Filter out evil wands
- For each (age, power), keep only the wand with minimum coins_needed
*/

SELECT 
    w.id,
    wp.age,
    w.coins_needed,
    w.power
FROM wands w
JOIN wands_property wp 
    ON w.code = wp.code
WHERE wp.is_evil = 0
AND (wp.age, w.power, w.coins_needed) IN (
    SELECT 
        wp_sub.age,
        w_sub.power,
        MIN(w_sub.coins_needed)
    FROM wands w_sub
    JOIN wands_property wp_sub 
        ON w_sub.code = wp_sub.code
    WHERE wp_sub.is_evil = 0
    GROUP BY 
        wp_sub.age,
        w_sub.power
)
ORDER BY 
    w.power DESC,
    wp.age DESC;

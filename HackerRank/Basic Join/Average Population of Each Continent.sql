/*
Working platform: MySQL

Purpose:
Calculate the average population of cities per continent.

Approach:
- Join CITY and COUNTRY using country code
- Group by continent
- Compute average city population
- Round down result using FLOOR
*/

SELECT 
    ctry.Continent,
    FLOOR(AVG(city.Population)) AS avg_city_population
FROM CITY city
JOIN COUNTRY ctry
    ON city.CountryCode = ctry.Code
GROUP BY 
    ctry.Continent;

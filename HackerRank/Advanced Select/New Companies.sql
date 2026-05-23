/*
Working platform: MySQL

Purpose:
For each company, return:
- company_code
- founder name
- number of unique lead managers
- number of unique senior managers
- number of unique managers
- number of unique employees

Note:
- Tables may contain duplicate records, so DISTINCT counts are required.
- company_code is alphanumeric (e.g., C_1, C_10), so ordering must be lexical.
*/

SELECT 
    c.company_code,
    c.founder,
    COUNT(DISTINCT e.lead_manager_code) AS lead_manager_count,
    COUNT(DISTINCT e.senior_manager_code) AS senior_manager_count,
    COUNT(DISTINCT e.manager_code) AS manager_count,
    COUNT(DISTINCT e.employee_code) AS employee_count
FROM Company c
JOIN Employee e 
    ON c.company_code = e.company_code
GROUP BY 
    c.company_code, 
    c.founder
ORDER BY 
    c.company_code ASC;

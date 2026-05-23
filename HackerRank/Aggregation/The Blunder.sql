/*
Working platform: MySQL

Purpose:
Calculate the error between:
- The average of actual salaries
- The average of salaries after removing all '0' digits

Then return the ceiling of the difference.

Approach:
- Compute AVG(Salary)
- Compute AVG(Salary with all '0' removed using REPLACE)
- Subtract both averages
- Apply CEIL to round up the final result
*/

SELECT 
    CEIL(
        AVG(Salary) - AVG(REPLACE(Salary, '0', ''))
    ) AS Salary_Error
FROM EMPLOYEES;

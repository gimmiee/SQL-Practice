/*
Working platform: MySQL

Purpose:
Find:
1) Maximum total earnings (Salary * Months)
2) Number of employees who have that maximum earnings

Output format:
max_earnings count_of_employees

Approach:
- Compute total earnings per employee
- Identify maximum earnings
- Count employees matching that value
*/

SELECT 
    (Salary * Months) AS total_earnings,
    COUNT(*) AS employee_count
FROM Employee
WHERE (Salary * Months) = (
    SELECT MAX(Salary * Months)
    FROM Employee
);

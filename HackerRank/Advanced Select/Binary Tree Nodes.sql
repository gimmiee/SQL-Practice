/*
Working platform: MySQL

Purpose:
Classify each node in a binary search tree (BST) as:
- Root: node with no parent (P is NULL)
- Inner: node that is a parent of at least one other node
- Leaf: node that is not a parent and has a parent

Approach:
- Step 1: Identify root nodes (P IS NULL)
- Step 2: Identify inner nodes by checking if N appears as a parent (P)
- Step 3: Remaining nodes are leaves
- Step 4: Sort output by node value (N)
*/

SELECT 
    N,
    CASE 
        WHEN P IS NULL THEN 'Root'
        WHEN N IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS NodeType
FROM BST
ORDER BY N;

-- =====================================================================
--  Company Database — Example Queries
--  Dialect: MySQL 8.0
--
--  Run schema.sql first to build the database, then run these queries
--  one at a time to see the results. Organized by topic.
-- =====================================================================

USE company;

-- =====================================================================
--  1. READING DATA  (SELECT)
-- =====================================================================

-- Show every column of every row.
SELECT * FROM departments;
SELECT * FROM employees;

-- Inspect a table's structure (its "blueprint").
DESCRIBE employees;


-- =====================================================================
--  2. FILTERING ROWS  (WHERE, ORDER BY, ...)
-- =====================================================================

-- Departments located in Stockholm.
SELECT * FROM departments
WHERE location = 'Stockholm';

-- Employees earning more than 50,000.
SELECT * FROM employees
WHERE salary > 50000;

-- Employees in department 1 who earn more than 60,000 (two conditions).
SELECT * FROM employees
WHERE salary > 60000 AND dept_id = 1;

-- All employees, highest salary first.
SELECT * FROM employees
ORDER BY salary DESC;

-- Salary within a range.
SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 50000;

-- Employees in department 1 or 3.
SELECT * FROM employees
WHERE dept_id IN (1, 3);

-- Names starting with the letter M (LIKE + % wildcard).
SELECT * FROM employees
WHERE emp_name LIKE 'M%';

-- The two highest-paid employees.
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 2;


-- =====================================================================
--  3. AGGREGATION & GROUPING  (COUNT, SUM, AVG, GROUP BY, HAVING)
-- =====================================================================

-- Whole-table summaries.
SELECT COUNT(*) AS total_employees FROM employees;
SELECT SUM(salary) AS total_payroll FROM employees;
SELECT MAX(salary) AS highest_salary FROM employees;

-- Average salary of department 1 only.
SELECT AVG(salary) AS avg_dept1 FROM employees
WHERE dept_id = 1;

-- Per-department summaries (GROUP BY = one result row per group).
SELECT dept_id, COUNT(*)    AS headcount   FROM employees GROUP BY dept_id;
SELECT dept_id, MAX(salary) AS top_salary  FROM employees GROUP BY dept_id;
SELECT dept_id, SUM(salary) AS dept_payroll FROM employees GROUP BY dept_id;

-- Filter the GROUPS themselves with HAVING:
-- only departments with more than one employee.
SELECT dept_id, COUNT(*) AS headcount
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 1;

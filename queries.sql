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

-- Only departments whose average salary is above 45,000.
SELECT dept_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 45000;


-- =====================================================================
--  4. CHANGING DATA  (UPDATE, DELETE)
--
--  GOLDEN RULE: always include a WHERE clause. Without it, UPDATE/DELETE
--  affects EVERY row in the table.
-- =====================================================================

-- Update a single column for one employee.
UPDATE employees
SET salary = 45000
WHERE emp_id = 2;

-- Update several columns at once.
UPDATE employees
SET salary = 45000, dept_id = 1
WHERE emp_id = 2;

-- Delete a specific row (here, a temporary test record).
DELETE FROM employees
WHERE emp_id = 99;

-- Note: MySQL Workbench's "safe update mode" blocks UPDATE/DELETE whose
-- WHERE does not use a key column. To override for the session:
--   SET SQL_SAFE_UPDATES = 0;   -- turn off
--   SET SQL_SAFE_UPDATES = 1;   -- turn back on


-- =====================================================================
--  5. CONSTRAINTS & KEYS  (data integrity)
--
--  Constraints are rules MySQL enforces. See schema.sql for the full
--  table definitions (AUTO_INCREMENT, NOT NULL, UNIQUE, DEFAULT,
--  FOREIGN KEY). The statements below show how to ADD a constraint to
--  an existing table and how the database then rejects invalid data.
-- =====================================================================

-- Add a FOREIGN KEY to an existing table with ALTER TABLE.
-- (Guarantees every employee's dept_id matches a real department.)
ALTER TABLE employees
ADD FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- The following statements are SUPPOSED to fail -- they prove the rules work:

-- UNIQUE: duplicate project_name is rejected (Error 1062).
-- INSERT INTO projects (project_name, dept_id) VALUES ('Website Redesign', 3);

-- NOT NULL: missing project_name is rejected.
-- INSERT INTO projects (budget, dept_id) VALUES (5000, 1);

-- FOREIGN KEY (child): department 999 doesn't exist -> rejected (Error 1452).
-- INSERT INTO employees (emp_id, emp_name, salary, dept_id) VALUES (50, 'Ghost', 40000, 999);

-- FOREIGN KEY (parent): can't delete a department that still has employees (Error 1451).
-- DELETE FROM departments WHERE dept_id = 1;


-- =====================================================================
--  6. JOINS  (combining tables)
--
--  Tables are linked by dept_id. JOINs let us show related data from
--  both tables in one result. (e and d are table aliases.)
-- =====================================================================

-- INNER JOIN: each employee shown WITH their department name.
-- Returns only rows that match in BOTH tables.
SELECT e.emp_name, e.salary, d.dept_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.dept_id;

-- LEFT JOIN: ALL departments, even those with no employees.
-- A department with no employees shows emp_name = NULL (e.g. Marketing).
SELECT d.dept_name, e.emp_name
FROM departments AS d
LEFT JOIN employees AS e ON d.dept_id = e.dept_id;

-- JOIN + WHERE + ORDER BY: high earners, with department name, sorted.
SELECT e.emp_name, e.salary, d.dept_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.dept_id
WHERE e.salary > 50000
ORDER BY e.salary DESC;

-- JOIN + GROUP BY: average salary per department NAME (a readable report).
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

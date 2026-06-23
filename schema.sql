-- =====================================================================
--  Company Database — Schema & Sample Data
--  Dialect: MySQL 8.0
--
--  Run this whole file once to build the database from scratch.
--  In MySQL Workbench: open this file, then click the lightning-bolt
--  (or press Ctrl+Shift+Enter) to execute the entire script.
-- =====================================================================

-- Create the database (the "folder" that holds our tables) and switch to it.
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Start clean if the tables already exist (drop child tables first).
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ---------------------------------------------------------------------
--  Table: departments
--  One row per department. dept_id uniquely identifies each department.
-- ---------------------------------------------------------------------
CREATE TABLE departments (
    dept_id    INT PRIMARY KEY,   -- unique id (PRIMARY KEY => automatically NOT NULL)
    dept_name  VARCHAR(50),       -- e.g. 'Engineering'
    location   VARCHAR(50)        -- e.g. 'Stockholm'
);

-- ---------------------------------------------------------------------
--  Table: employees
--  One row per employee. dept_id links each employee to a department.
-- ---------------------------------------------------------------------
CREATE TABLE employees (
    emp_id    INT PRIMARY KEY,    -- unique id for the employee
    emp_name  VARCHAR(50),        -- employee name
    salary    INT,                -- annual salary
    dept_id   INT,                -- which department they belong to
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)  -- must be a real department
);

-- ---------------------------------------------------------------------
--  Table: projects
--  Demonstrates AUTO_INCREMENT, NOT NULL, UNIQUE, DEFAULT, and a
--  FOREIGN KEY linking each project to a department.
-- ---------------------------------------------------------------------
CREATE TABLE projects (
    project_id    INT AUTO_INCREMENT PRIMARY KEY,  -- MySQL generates the id
    project_name  VARCHAR(100) NOT NULL UNIQUE,    -- required, no duplicates
    budget        INT DEFAULT 0,                   -- defaults to 0 if omitted
    dept_id       INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- ---------------------------------------------------------------------
--  Sample data
-- ---------------------------------------------------------------------
INSERT INTO departments (dept_id, dept_name, location) VALUES
    (1, 'Engineering', 'Stockholm'),
    (2, 'Sales',       'Gothenburg'),
    (3, 'HR',          'Malmö');

INSERT INTO employees (emp_id, emp_name, salary, dept_id) VALUES
    (1, 'Anna',   52000, 1),
    (2, 'Erik',   41000, 2),
    (3, 'Sofia',  68000, 1),
    (4, 'Johan',  39000, 3),
    (5, 'Maria',  75000, 1),
    (6, 'Lars',   48000, 2);

-- project_id and budget are left out on purpose to show AUTO_INCREMENT + DEFAULT.
INSERT INTO projects (project_name, dept_id) VALUES
    ('Website Redesign', 1),
    ('Sales Dashboard',  2);

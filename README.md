# Company Database — SQL Project

A small relational database (MySQL 8.0) modelling a company's **departments** and
**employees**, with a documented set of example queries. Built while learning SQL
from the ground up, focused on the fundamentals used in real backend work.

## 🛠️ Tech
- **MySQL 8.0** (developed in MySQL Workbench)
- Plain SQL — no extensions

## 🗂️ Database design

Two tables, linked by `dept_id`:

```
departments                         employees
-----------                         ---------
dept_id   (PK) ◄───────────────┐    emp_id    (PK)
dept_name                      └──  dept_id        (links to departments.dept_id)
location                            emp_name
                                    salary
```

| Table | Column | Type | Notes |
|---|---|---|---|
| **departments** | `dept_id` | INT | Primary key |
| | `dept_name` | VARCHAR(50) | e.g. Engineering |
| | `location` | VARCHAR(50) | e.g. Stockholm |
| **employees** | `emp_id` | INT | Primary key |
| | `emp_name` | VARCHAR(50) | |
| | `salary` | INT | |
| | `dept_id` | INT | **Foreign key** → departments |
| **projects** | `project_id` | INT | Primary key, `AUTO_INCREMENT` |
| | `project_name` | VARCHAR(100) | `NOT NULL`, `UNIQUE` |
| | `budget` | INT | `DEFAULT 0` |
| | `dept_id` | INT | **Foreign key** → departments |

## 🚀 How to run

1. Open **MySQL Workbench** and connect to your local server.
2. Open and run [`schema.sql`](schema.sql) — this creates the `company` database,
   both tables, and sample data.
3. Open [`queries.sql`](queries.sql) and run the queries one at a time to explore.

## 📋 What this project demonstrates

- **Schema design** — creating a database and tables, choosing data types, primary keys
- **Inserting data** — single-row, multi-row, and named-column `INSERT`
- **Reading & filtering** — `SELECT`, `WHERE`, `AND`/`OR`, `BETWEEN`, `IN`, `LIKE`, `ORDER BY`, `LIMIT`
- **Aggregation** — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- **Grouping** — `GROUP BY` and filtering groups with `HAVING`
- **Modifying data** — `UPDATE`, `DELETE` (and why the `WHERE` clause is critical)
- **Constraints & integrity** — `AUTO_INCREMENT`, `NOT NULL`, `UNIQUE`, `DEFAULT`, `FOREIGN KEY`, `ALTER TABLE`

## 🧭 Example questions answered

- Which employees earn more than 50,000?
- Who are the two highest-paid employees?
- How many employees are in each department?
- What is the average salary per department?
- Which departments have more than one employee?

## 📈 Roadmap (as I keep learning)

- [x] `UPDATE` / `DELETE` — modifying data
- [x] Constraints & `FOREIGN KEY` — enforce that every employee belongs to a real department
- [ ] **JOINs** — show each employee *with their department name*
- [ ] Subqueries
- [ ] Connect to the database from Python / FastAPI

---
*Built as part of my hands-on journey learning SQL for backend development.*

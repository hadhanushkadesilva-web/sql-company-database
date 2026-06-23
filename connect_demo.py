"""
connect_demo.py — Talk to the MySQL 'company' database from Python.

This is the same idea a FastAPI backend uses: connect, run SQL, get results.
Run it with:  py connect_demo.py
"""

import getpass
import mysql.connector

# --- 1. Connect to the local MySQL server and the 'company' database ---------
# getpass asks for the password at runtime, so it is never stored in this file.
password = getpass.getpass("MySQL root password: ")

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="company",
)
cursor = conn.cursor()

# --- 2. Run a query (the SAME SQL you wrote in Workbench) --------------------
cursor.execute("""
    SELECT e.emp_name, e.salary, d.dept_name
    FROM employees AS e
    INNER JOIN departments AS d ON e.dept_id = d.dept_id
    ORDER BY e.salary DESC
""")

# --- 3. Fetch the rows and print them ---------------------------------------
rows = cursor.fetchall()           # fetchall() returns a list of rows
print(f"\n{'Name':<10}{'Salary':>9}   Department")
print("-" * 32)
for emp_name, salary, dept_name in rows:
    print(f"{emp_name:<10}{salary:>9}   {dept_name}")

# --- 4. Always close the connection -----------------------------------------
cursor.close()
conn.close()

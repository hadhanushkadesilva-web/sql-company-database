"""
safe_query.py — Parameterized queries (the safe way to use user input).

In a real app, values like `min_salary` come from a user or an API request.
NEVER build SQL by concatenating strings -- that allows SQL injection attacks.
Instead, use %s placeholders and pass the values separately.

Run it with:  py safe_query.py
"""

import getpass
import mysql.connector

password = getpass.getpass("MySQL root password: ")

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="company",
)
cursor = conn.cursor()

# Pretend this value came from a user / an API request.
min_salary = 50000

# ✅ SAFE: %s is a placeholder; the value is passed separately as a tuple.
# The connector escapes it, so it can never be treated as SQL commands.
cursor.execute(
    "SELECT emp_name, salary FROM employees WHERE salary > %s ORDER BY salary DESC",
    (min_salary,),
)

print(f"\nEmployees earning more than {min_salary}:")
for emp_name, salary in cursor.fetchall():
    print(f"  {emp_name:<10}{salary}")

# ❌ The DANGEROUS version (shown for contrast -- never write this):
#    cursor.execute("SELECT * FROM employees WHERE salary > " + str(min_salary))
#    A malicious value like "0; DROP TABLE employees;" could destroy your data.

cursor.close()
conn.close()

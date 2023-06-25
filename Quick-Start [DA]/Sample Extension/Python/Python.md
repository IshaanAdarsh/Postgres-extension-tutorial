To illustrate the concepts covered in the tutorial, a sample Postgres extension should be developed using Python.

## Installing Extesntion plpython3u:
- Starting with PostgreSQL 13, Postgres.app includes the plpython3u extension. This extension allows you to create functions and stored procedures in Python 3. However, Postgres.app does not include the Python programming language itself. You need to download the official Python installer separately.

- Download and install Python 3.8.x (for PostgreSQL 13) and/or Python 3.9.x (universal2) (for PostgreSQL 14) from python.org. Other Python installations or versions are not supported.

- Activate the plpython3u extension with the command CREATE EXTENSION plpython3u;

- You can now create functions and procedures that use the language plpython3u.

Links: <br>
https://www.psycopg.org -> Psycopg is the most popular PostgreSQL adapter for the Python programming language.

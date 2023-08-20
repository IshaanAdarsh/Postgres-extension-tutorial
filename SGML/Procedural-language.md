# [Procedural Languages](https://www.postgresql.org/docs/current/xplang.html):
- Procedural languages in PostgreSQL provide a powerful way to extend the database's functionality by writing functions and procedures in languages other than SQL. PostgreSQL natively supports these and can be used directly within the database environment. These languages, also known as PLs, offer developers the flexibility to implement complex business logic and computations directly within the database.

Key points about procedural languages in PostgreSQL:

1. **Extended Functionality:** Procedural languages enable developers to write custom functions and procedures in languages like PL/pgSQL, PL/Python, PL/Tcl, PL/Perl, PL/R, and more. This allows for the creation of complex computations and data processing within the database.

2. **Control Flow and Logic:** Procedural languages offer control flow constructs like loops, conditionals, and exception handling, making it easier to implement business logic that goes beyond the capabilities of SQL.

3. **Custom Aggregates, Window Functions, and Triggers:** Procedural languages allow developers to define [custom aggregates](https://www.postgresql.org/docs/current/xaggr.html), [window functions](https://www.postgresql.org/docs/current/functions-window.html), and [triggers](https://www.postgresql.org/docs/current/triggers.html), enabling advanced data analysis, processing, and event-driven actions directly within the database.

4. **Performance Optimization:** By choosing the right procedural language for specific tasks, developers can achieve performance improvements over SQL, especially for complex data operations.

To use procedural languages in PostgreSQL:

1. **Enable the Language:** Before using a procedural language in a database, it needs to be enabled using the `CREATE LANGUAGE` command or by installing the relevant extensions.

2. **Write Functions and Procedures:** After enabling the language, developers can write functions and stored procedures using the chosen procedural language. This allows them to implement complex business logic, data transformations, and data analysis directly within the database.

For more detailed information on Procedural Language, you can refer to the [PostgreSQL documentation on Procedural Language](https://www.postgresql.org/docs/current/xplang.html).
 

## Quick Start: Creating a Postgres Extension using PL/pgSQL

In this quick start guide, we will create a simple PostgreSQL extension using [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html). 

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) installed and running on your system.
- Basic knowledge of SQL and [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html) programming.
- `make` utility for building and compiling software. 
- Knowledge about the Postgres Development Libraries

### Step 1: Create the Extension Directory
- Create a new directory for your extension project. 

```bash
mkdir ~/pg_plpgsql_ext
cd ~/pg_plpgsql_ext
```

### Step 2: Create the SQL Script File:
- Create a file named `pg_plpgsql_ext--1.0.0.sql` in the `pg_plpgsql_ext` directory with the following content:

```sql
-- pg_plpgsql_ext--1.0.0.sql
-- Create the function that uses PL/pgSQL
CREATE OR REPLACE FUNCTION subtract_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a - b;
END;
$$;
```

#### Explanation of the SQL Script:
- `CREATE OR REPLACE FUNCTION subtract_numbers(a integer, b integer) RETURNS integer LANGUAGE plpgsql AS $$`: This statement creates the function `subtract_numbers` with two integer arguments (`a` and `b`). The function will return an integer. The `LANGUAGE plpgsql` specifies that the function is written in PL/pgSQL.
- `BEGIN`: This is the beginning of the PL/pgSQL code block.
- `RETURN a - b;`: This line calculates the subtraction of `b` from `a` and returns the result.

### Step 3: Create the Control File:
- Create a file named "pg_plpgsql_ext.control" in the "pg_plpgsql_ext" directory with the following content:

```control
# pg_plpgsql_ext.control

# Extension name
comment = 'A simple PostgreSQL extension using PL/pgSQL.'

# Default version of the extension
default_version = '1.0.0'

# Extension is relocatable
relocatable = true
```

- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

### Step 4: Create the Makefile:
- Create a Makefile in the "pg_plpgsql_ext" directory with the following content:

```makefile
# Makefile for pg_plpgsql_ext
EXTENSION = pg_plpgsql_ext
DATA = pg_plpgsql_ext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
- For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

### Step 5: Build and Install the Extension
- Let's build and install the "pg_plpgsql_ext" extension:

```bash
# Build the extension
make

# Install the extension
make install
```

- For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 6: Enable the Extension in PostgreSQL
- Connect to your PostgreSQL database using `psql`:

```bash
psql -U your_username -d your_database
```

- Inside the PostgreSQL interactive terminal, enable the extension:
```sql
CREATE EXTENSION pg_plpgsql_ext;
```

- For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

### Step 7: Test the Extension
```sql
-- Example usage of the function
SELECT subtract_numbers(10, 5);

-- Output:
 subtract_numbers
-----------------
               5
(1 row)
```

## Quick Start: Creating a Postgres Extension using PL/Python:

In this quick start guide, we will create a simple PostgreSQL extension using [PL/Python](https://www.postgresql.org/docs/current/plpython.html).

### Prerequisites

- [PostgreSQL](https://www.postgresql.org/download/) installed and running on your system.
- [plpython3u](https://www.postgresql.org/docs/current/plpython.html) procedural language available in your PostgreSQL installation.
> In the context of PostgreSQL's procedural languages, the "u" in "plpython3u" stands for "untrusted". This signifies that the language implementation allows for executing arbitrary code and potentially accessing external resources.

- Basic knowledge of [Python](https://www.python.org) programming.
- `make` utility for building and compiling software. 
- Knowledge about the Postgres Development Libraries

### Step 1: Create the Extension Directory
- Create a new directory for your extension project. 
```bash
mkdir ~/pg_py_ext
cd ~/pg_py_ext
```

### Step 2: Create the SQL Script File (pg_py_ext--1.0.sql)
- Create a file named `pg_py_ext--1.0.0.sql` in the `pg_py_ext` directory with the following content:

```sql
-- pg_py_ext--1.0.0.sql
-- Create the function that uses the Python script
CREATE OR REPLACE FUNCTION add_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpython3u
AS $$
def add_numbers(a, b):
    return a + b
return add_numbers(int(a), int(b))
$$;
```

#### Explanation of the SQL Script:
- `CREATE OR REPLACE FUNCTION add_numbers(a integer, b integer) RETURNS integer LANGUAGE plpython3u AS $$`: This statement creates the function `add_numbers` with two integer arguments (`a` and `b`). The function will return an integer. The `LANGUAGE plpython3u` specifies that the function is written in PL/Python3U.
- `def add_numbers(a, b):`: This is the Python code block that defines the `add_numbers` function. The function takes two arguments (`a` and `b`) and returns their sum.

### Step 3: Create the Control File:
- Create a file named "pg_py_ext.control" with the following content:

```control
# pg_py_ext.control

# Extension name
comment = 'A simple PostgreSQL extension using PL/Python3U.'

# Default version of the extension
default_version = '1.0.0'

# Extension is relocatable
relocatable = true
```
- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

### Step 4: Create the Makefile (Makefile)
- Create a file named "Makefile" in the "pg_py_ext" directory with the following content:

```makefile
# Makefile for pg_py_ext
EXTENSION = pg_py_ext
DATA = pg_py_ext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
- For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

### Step 5: Build and Install the Extension
- Let's build and install the "pg_py_ext" extension:

```bash
# Build the extension
make

# Install the extension
make install
```

- For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 6: Enable the Extension in PostgreSQL
- Connect to your PostgreSQL database using `psql`:

```bash
psql -U your_username -d your_database
```

- Inside the PostgreSQL interactive terminal, enable the extension:
```sql
CREATE EXTENSION pg_py_ext;
```

- For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).
 
### Step 7: Test the Extension
```sql
-- Example usage of the function
SELECT add_numbers(3, 5);

-- Output:
 add_numbers
-------------
           8
(1 row)
```

## Quick Start: Creating a Postgres Extension using PL/Python:

In this quick start guide, we will create a simple PostgreSQL extension using [PL/Python](https://www.postgresql.org/docs/current/plpython.html). The extension will include a Python function to add two numbers.

## Prerequisites

- [PostgreSQL](https://www.postgresql.org/download/) installed and running on your system.
- [plpython3u]((https://www.postgresql.org/docs/current/plpython.html)) procedural language available in your PostgreSQL installation.
- Basic knowledge of [Python](https://www.python.org) programming.

### Step 1: Create the Extension Directory

Create a new directory for your extension project. You can choose any location on your system. Let's assume you create the directory in your home folder:

```bash
mkdir ~/pg_py_ext
cd ~/pg_py_ext
```

### Step 2: Create the SQL Script File (pg_py_ext--1.0.sql)

Next, we'll create the SQL script file that defines the extension's functions and features. Create a file named `pg_py_ext--1.0.sql` in the `pg_py_ext` directory with the following content:

```sql
-- pg_py_ext--1.0.sql
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
```control
# pg_py_ext.control

# Extension name
comment = 'A simple PostgreSQL extension using PL/Python3U.'

# Default version of the extension
default_version = '1.0'

# Extension is relocatable
relocatable = true
```
- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

#### Explanation of the Control File:
- `comment = 'A simple PostgreSQL extension using PL/Python3U.'`: This line provides a brief description or comment about the extension.
- `default_version = '1.0'`: This line specifies the default version of the extension.
- `relocatable = true`: This line indicates that the extension is relocatable, allowing it to be moved to a different location.

### Step 4: Create the Makefile (Makefile)

Create a file named "Makefile" in the "pg_py_ext" directory with the following content:

```makefile
# Makefile for pg_py_ext
EXTENSION = pg_py_ext
DATA = pg_py_ext--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

- For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

#### Explanation of the Makefile:
- `EXTENSION = pg_py_ext`: This variable specifies the name of the extension.
- `DATA = pg_py_ext--1.0.sql`: This variable includes the SQL script file ("pg_py_ext--1.0.sql") in the extension.
- `PG_CONFIG = pg_config`: This variable points to the `pg_config` executable, which is used to get PostgreSQL build information.
- `include $(PGXS)`: This includes the PostgreSQL Extension Makefile infrastructure.

### Step 5: Build and Install the Extension

Now, let's build and install the "pg_py_ext" extension:

```bash
# Build the extension
make

# Install the extension
make install
```

- For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 6: Enable the Extension in PostgreSQL

Connect to your PostgreSQL database using `psql`:

```bash
psql -U your_username -d your_database
```

Inside the PostgreSQL interactive terminal, enable the extension:

```sql
CREATE EXTENSION pg_py_ext;
```
- For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).
 
### Step 7: Test the Extension

Now that the extension is enabled, you can use the `add_numbers` function in SQL queries:

```sql
-- Example usage of the function
SELECT add_numbers(3, 5);

-- Output:
 add_numbers
-------------
           8
(1 row)
```

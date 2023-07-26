## Quick Start: Creating a Postgres Extension using PL/pgSQL

In this quick start guide, we will create a simple PostgreSQL extension using [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html). The extension will include a PL/pgSQL function to subtract two numbers.

### Prerequisites

- [PostgreSQL](https://www.postgresql.org/download/) installed and running on your system.
- Basic knowledge of SQL and PL/pgSQL programming.

### Step 1: Create the Extension Directory

Create a new directory for your extension project. You can choose any location on your system. Let's assume you create the directory in your home folder:

```bash
mkdir ~/pg_plpgsql_ext
cd ~/pg_plpgsql_ext
```

### Step 2: Create the SQL Script File:

Next, we'll create the SQL script file that defines the extension's functions and features. Create a file named `pg_plpgsql_ext--1.0.sql` in the `pg_plpgsql_ext` directory with the following content:

```sql
-- pg_plpgsql_ext--1.0.sql
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

Create a file named "pg_plpgsql_ext.control" in the "pg_plpgsql_ext" directory with the following content:

```control
# pg_plpgsql_ext.control

# Extension name
comment = 'A simple PostgreSQL extension using PL/pgSQL.'

# Default version of the extension
default_version = '1.0'

# Extension is relocatable
relocatable = true
```
- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

#### Explanation of the Control File:
- `default_version = '1.0'`: This line specifies the default version of the extension.
- `relocatable = true`: This line indicates that the extension is relocatable, allowing it to be moved to a different location.

### Step 4: Create the Makefile:

Create a file named "Makefile" in the "pg_plpgsql_ext" directory with the following content:

```makefile
# Makefile for pg_plpgsql_ext
EXTENSION = pg_plpgsql_ext
DATA = pg_plpgsql_ext--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
- For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

#### Explanation of the Makefile:
- `EXTENSION = pg_plpgsql_ext`: This variable specifies the name of the extension.
- `DATA = pg_plpgsql_ext--1.0.sql`: This variable includes the SQL script file ("pg_plpgsql_ext--1.0.sql") in the extension.
- `PG_CONFIG = pg_config`: This variable points to the `pg_config` executable, which is used to get PostgreSQL build information.
- `include $(PGXS)`: This includes the PostgreSQL Extension Makefile infrastructure.

### Step 5: Build and Install the Extension

Now, let's build and install the "pg_plpgsql_ext" extension:

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
CREATE EXTENSION pg_plpgsql_ext;
```
- For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

### Step 7: Test the Extension

Now that the extension is enabled, you can use the `subtract_numbers` function in SQL queries:

```sql
-- Example usage of the function
SELECT subtract_numbers(10, 5);

-- Output:
 subtract_numbers
-----------------
               5
(1 row)
```

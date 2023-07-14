## A sample PostgreSQL extension using Python as the external language:
We'll create an extension called `pg_py_ext` that provides a function to calculate the factorial of a number.

### Step 1: Install the necessary tools:
- Install PostgreSQL: Follow the instructions specific to your operating system to install PostgreSQL.
- Install Python: Install Python on your system. You can use a package manager like `pip` to install Python.

### Step 2: Create the extension structure:
`pg_py_ext` directory Structure:
```
pg_py_ext/
├── Makefile
├── pg_py_ext.control
├── pg_py_ext.py
├── pg_py_ext--1.0.0.sql
└── README.md
```

- Inside the "pg_py_ext" directory, create the following files:
  - `Makefile`:
    ```
    EXTENSION = pg_py_ext
    DATA = pg_py_ext--0.1.sql

    PG_CONFIG = pg_config
    PGXS := $(shell $(PG_CONFIG) --pgxs)
    include $(PGXS)
    ```

  - `pg_py_ext--0.1.sql`:
    ```
    CREATE EXTENSION IF NOT EXISTS pg_py_ext;
    COMMENT ON EXTENSION pg_py_ext IS 'A sample PostgreSQL extension.';
    ```

   - `pg_py_ext.control`:
    ```
    # pg_py_ext
    comment = 'A sample PostgreSQL extension'
    default_version = '0.1'
    relocatable = true
    module_pathname = '$libdir/pg_py_ext'
    ```

### Step 3: Implement the extension logic:
- Inside the "pg_py_ext" directory, create a file named `pg_py_ext.py` and write the following code:
  ```python
  def factorial(n):
      if n == 0:
          return 1
      else:
          return n * factorial(n - 1)
  ```
  
### Step 4: Build and install the extension:
- Make sure you have the necessary build tools installed on your system (e.g., gcc).
- Run the following commands to build and install the extension:
```
$ make
$ make install
```

### Step 5: Test the extension:
- Open a PostgreSQL client (e.g., `psql`) and connect to your database.
- Run the following command to install the extension:
```
CREATE EXTENSION pg_py_ext;
```
- Now you can use the `factorial` function provided by the extension in your queries. For example:
```
SELECT factorial(5);

-- Output
 factorial
-----------
       120
(1 row)
```

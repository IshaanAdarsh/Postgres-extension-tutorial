# Minimum Viable Product:
A basic tutorial on creating a PostgreSQL extension using the bare minimum files:

- A **control file**, which tells PostgreSQL some basic information about the extension, such as its name, version, and schema.
- A **SQL script file**, which contains the SQL commands to create the extension's objects.
- A **Makefile** is a file that helps automate the build process of the extension. It defines the compilation and installation steps, making it easier to build and install the extension on different systems.

## A Postgres extension using only a control file, an SQL file and a Makefile:

### Step 1: Create the Extension Directory
- Create a directory for your extension. Let's call it "my_extension".

```bash
$ mkdir my_extension
$ cd my_extension
```

#### Directory Hierarchy:
```
my_extension/
├── README.md
├── my_extension--1.0.0.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
└── Makefile

```

### Step 2: Create the Extension Control File
- Inside the "my_extension" directory, create a file named "my_extension.control". 
  - This file defines the metadata and dependencies of your extension. It helps manage and configure the extension's behavior during installation, upgrade, or removal.

```bash
$ touch my_extension.control
```

- Open the "my_extension.control" file and add the following content:

```control
# my_extension.control
# Comment line to provide additional information about the extension
comment = 'Minimal Viable Product'

# Specifies the default version of the extension
default_version = '1.0.0'

# Indicates whether the extension is relocatable, allowing it to be moved to a different location
relocatable = true
```

### Step 3: Create the Extension SQL File
- Create a file named "my_extension--1.0.0.sql".
  - This file contains the SQL statements required to install or uninstall your extension.
  - The format for a PostgreSQL extension file name is `extension_name--version.sql`, where `extension_name` is the name of the extension, and `version` is the version number. The double-dash serves as a delimiter to indicate the separation between the extension name and the version number.

```bash
$ touch my_extension--1.0.0.sql
```
- Open the "my_extension--1.0.0.sql" file and add the following content:

```sql
-- Create necessary objects for version 1.0.0
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Add 2 numbers using add function
CREATE FUNCTION add(a integer, b integer) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    RETURN a + b;
```

### Step 4: Create the Makefile
- Create a Makefile in the "extension" directory. 
  - The Makefile is used to define the build process. It specifies the module name, extension name, and SQL files. The PG_CONFIG variable retrieves the path to the pg_config utility, which is used to get the necessary configuration for building the extension.

```bash
$ touch Makefile
```
- Open the Makefile and add the following content:

```makefile
EXTENSION = my_extension                 # Name of the extension
DATA = my_extension--1.0.0.sql           # SQL file containing extension objects and functions

PG_CONFIG  ?= pg_config                  # Path to the pg_config executable
PGXS := $(shell $(PG_CONFIG) --pgxs)     # Get the PostgreSQL Extension Makefile from pg_config
include $(PGXS)                          # Include the PostgreSQL Extension Makefile
```

### Step 5: Build and Install the Extension
- To build and install the extension, run the following commands:

```bash
$ make
$ make install
```

> NOTE: make: Nothing to be done for 'all'

> Makefile doesn't have any MODULE or other binary to build. You can go directly to the make install step

- The "make" command compiles the extension code using the Makefile
- The "make install" command copies the necessary files to the appropriate PostgreSQL directories.

### Step 6: Create the Extension in PostgreSQL:
- Connect to your PostgreSQL database and execute the following SQL statement to create the extension:

```sql
CREATE EXTENSION IF NOT EXISTS my_extension;
-- Output: CREATE EXTENSION
```
- The CREATE EXTENSION statement is executed in PostgreSQL to create the extension.

## Implementation of the Extension:
Once you have successfully implemented the `my_extension` in your PostgreSQL database, you can use it as follows:

### 1. Query the `my_table` table:
   - You can query the `my_table` table like any other table in your database. For example, you can retrieve all rows from the table using the following SQL query:
   ```sql
   SELECT * FROM my_table;
   ```
#### Output:
```
id | name
----+------
(0 rows)
```
### 2. Use the add function to perform addition:
  - The `add` function takes two integer arguments and returns their sum
  ```sql
  SELECT add(2, 3);
  ```
#### Output:
```
 add
-----
   5
(1 row)
```

## Regression Testing:

### Step 1: Create the Extension SubDirectory for Regression SQL File:
- Create a subdirectory for your regression file. Name it `sql`

```bash
$ mkdir sql
$ cd sql
```
-   Create a new file called `my_extension--regress.sql`.

```bash
$ touch my_extension--regress.sql
```

- Open the `my_extension--regress.sql` file and add the following content keeping in mind these instructions:

  -   Write SQL statements that test the functionality of your `my_extension`.

  -   Include a combination of `CREATE`, `INSERT`, `UPDATE`, `DELETE`, and `SELECT` statements to cover various scenarios.

  -   Make sure to test both positive and negative scenarios to validate the behaviour of your extension.

```sql
-- regression test script for my_extension
CREATE EXTENSION my_extension;

-- Verify the data in the my_table table
SELECT * FROM my_table;

-- Test the add function
SELECT add(1, 2);
```

### Step 2: Update the Makefile:

- In the given code, the changes made to the `Makefile` are related to the addition of a new variable called `REGRESS` and the inclusion of a new SQL file `my_extension--regress`.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.0.sql
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

- The `REGRESS` variable is used to specify the name of the regression test script file for the extension. In this case, the name is `my_extension--regress`. This file will contain the SQL commands for the regression tests to be executed.

- These changes in the `Makefile` enable the `my_extension--regress.sql` file to be recognized during the installation process, allowing the regression tests to be executed using `make installcheck` 

### Step 3: Create the Extension SubDirectory for Expected Result:
- Create a subdirectory for your regression file. Name it `expected`

```bash
$ mkdir expected
$ cd expected
```
-   Create a new file called `my_extension--regress.out`.

```bash
$ touch my_extension--regress.out
```

- Add your assumption of what will be the result of the regression test:

```out
-- regression test script for my_extension
CREATE EXTENSION my_extension;
-- Verify the data in the my_table table
SELECT * FROM my_table;
 id | name 
----+------
(0 rows)

-- Test the add function
SELECT add(1, 2);
 add 
-----
   3
(1 row)
```

- If the expected file matched the results exactly then the regression test is passed.

### Step 4: Run `make installcheck`:

- Navigate to the directory containing your extension's code and Makefile.
- Run the following command to execute the `make installcheck` target:
   ```
   make installcheck
   ```

   This command will initiate the installation and regression testing process for your extension.

#### Working of the command `make installcheck`:
- The `make installcheck` command will internally execute the `pg_regress` utility with the appropriate parameters. It will connect to a PostgreSQL server and run the regression tests specified in the `my_extension--regress.sql` file.

- Review the output of the `make installcheck` command to see the results of the regression tests. The command will display the progress and status of each test case.

  - If all the tests pass successfully, you will see a summary indicating that the regression tests have passed.

  - If any tests fail, the output will provide information about the specific test case that failed and any relevant error messages.

  - Analyze the output and any error messages to identify and address any issues encountered during the regression testing.

It is important to note that the success or failure of the `make installcheck` command depends on the correctness of your extension's implementation and the accuracy of the regression test script (`my_extension--regress.sql`). Ensure that the regression test script covers the necessary test cases and verifies the expected behaviour of your extension.

#### `make installcheck` test fails:
If the `make installcheck` command doesn't work, it usually means that there are issues with the installation or configuration of the extension. This command is used to run the regression tests for the extension to ensure that it functions correctly.

The `.diff` file and `.out` file are generated during the regression tests. Here's an explanation of each:

1. `.diff` file: This file contains the differences between the expected output and the actual output of the regression tests. It shows the changes, additions, or deletions made to the expected output to match the actual output. Each difference is indicated with a line starting with a "-" or "+" sign, representing removed or added lines, respectively.

2. `.out` file: This file contains the actual output of the regression tests. It shows the results, error messages, or any other output generated by the test scripts. The `.out` file is compared with the expected output to generate the `.diff` file.

The purpose of comparing the expected output with the actual output is to validate that the extension behaves as intended and produces the correct results. Any differences between the expected and actual output are highlighted in the `.diff` file, allowing developers to identify and resolve any issues in the extension code.

- **regression.diffs**
```
diff -U3 /Users/spartacus/Desktop/GSoC/CODE/my_extension/expected/my_extension--regress.out /Users/spartacus/Desktop/GSoC/CODE/my_extension/results/my_extension--regress.out
--- /Users/spartacus/Desktop/GSoC/CODE/my_extension/expected/my_extension--regress.out	2023-06-28 19:50:09.086462000 +0530
+++ /Users/spartacus/Desktop/GSoC/CODE/my_extension/results/my_extension--regress.out	2023-06-28 19:54:53.312678363 +0530
@@ -7,7 +7,7 @@
 (0 rows)
 
 -- Test the add function
-SELECT add(1, 2)
+SELECT add(1, 2);
  add 
 -----
    3
```

- **regression.out**
```
test my_extension--regress        ... FAILED       18 ms
```

### Step 4: Analysing the output:
The successful output of the `make installcheck` command for the `my_extension` extension:

```bash
echo "+++ regress install-check in  +++" && /Users/spartacus/.pgenv/pgsql-15.0/lib/pgxs/src/makefiles/../../src/test/regress/pg_regress --inputdir=./ --bindir='/Users/spartacus/.pgenv/pgsql-15.0/bin'    --dbname=contrib_regression my_extension--regress
+++ regress install-check in  +++
(using postmaster on Unix socket, default port)
============== dropping database "contrib_regression" ==============
SET
DROP DATABASE
============== creating database "contrib_regression" ==============
CREATE DATABASE
ALTER DATABASE
ALTER DATABASE
ALTER DATABASE
ALTER DATABASE
ALTER DATABASE
ALTER DATABASE
============== running regression test queries        ==============
test my_extension--regress        ... ok           10 ms

=====================
 All 1 tests passed.
=====================
```
- The output includes information about creating the test database, installing the extension, executing the test queries, and finally cleaning up the database.

## Updating the Extension:



# MVP (SQL+Control+Makefile):
A basic tutorial on creating a PostgreSQL extension using the bare minimum files and a Makefile:

- A **control file**, which tells PostgreSQL some basic information about the extension, such as its name, version, and schema.
- A **SQL script file**, which contains the SQL commands to create the extension's objects.
- A **Makefile** is an optional but highly recommended file that helps automate the build process of the extension. It defines the compilation and installation steps, making it easier to build and install the extension on different systems.

## A Postgres extension using only a control file, an SQL file and a Makefile:

### Step 1: Create the Extension Directory
- Create a directory for your extension. Let's call it "my_extension".

```bash
$ mkdir my_extension
$ cd my_extension
```

### Step 2: Create the Extension Control File
- Inside the "my_extension" directory, create a file named "my_extension.control". 
  - This file defines the metadata and dependencies of your extension.

```bash
$ touch my_extension.control
```

- Open the "my_extension.control" file and add the following content:

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0'
relocatable = true

# Installation script for version 1.0
# 1.0
# my_extension--1.0.sql
```

### Step 3: Create the Extension SQL File
- Create a file named "my_extension--1.0.sql".
  - This file contains the SQL statements required to install or uninstall your extension.

```bash
$ touch my_extension--1.0.sql
```

- Open the "my_extension--1.0.sql" file and add the following content:

```sql
-- extension--1.0.sql
-- my_extension--1.0.sql

-- Create necessary objects for version 1.0
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE FUNCTION my_function() RETURNS void AS $$
INSERT INTO my_table (name) VALUES ('Example');
$$ LANGUAGE sql;
```

### Step 4: Create the Makefile
- Create a Makefile in the "extension" directory. 
  - The Makefile is used to define the build process. It specifies the module name, object files, extension name, and SQL files. The PG_CONFIG variable retrieves the path to the pg_config utility, which is used to get the necessary configuration for building the extension.

```bash
$ touch Makefile
```
- Open the Makefile and add the following content:
<!--Problem: https://dba.stackexchange.com/questions/328624/makefile-issue-in-creating-postgres-extension
Had an issue with the make install command:
```makefile
DATA = my_extension--1.0.sql

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
Solution: Makefile is lacking the entry `EXTENSION = my_extension`
Reason: That's why `make install` doesn't copy the `*.control` file, and that's why `CREATE EXTENSION` fails.

NOTE: make: Nothing to be done for 'all' 
Makefile doesn't have any MODULE or other binary to build. You can go directly to the make install step
-->

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.sql

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Step 5: Build and Install the Extension
- To build and install the extension, run the following commands:

```bash
$ make
$ make install
```
- The "make" command compiles the extension code using the Makefile
- The "make install" command copies the necessary files to the appropriate PostgreSQL directories.

### Step 6: Create the Extension in PostgreSQL
- Connect to your PostgreSQL database and execute the following SQL statement to create the extension:

```sql
CREATE EXTENSION IF NOT EXITS "my_extension";
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
```sql
id | name
----+------
(0 rows)
```


### 2. Call the `my_function` function:
   - To execute the `my_function` function, you can use the `SELECT` statement with the function call. For example:
   ```sql
   SELECT my_function();
   ```
#### Output:
```sql
my_function
-------------

(1 row)
```

   The function will be executed, and any side effects, such as inserting a row into the `my_table` table, will take place.

#### Output:
```sql
 id |  name
----+---------
  1 | Example
(1 row)
```
Remember to replace `my_table` with the actual table name you have chosen, and adjust the function call as needed based on your specific implementation.

## Regression Testing:

### Step 1: Create a Regression Test Script:

-   Create a new file called `my_extension_regression.sql`.

```bash
$ touch my_extension_regression.sql
```

- Open the `my_extension_regression.sql` file and add the following content keeping in mind these instructions:

  -   Write SQL statements that test the functionality of your `my_extension`.

  -   Include a combination of `CREATE`, `INSERT`, `UPDATE`, `DELETE`, and `SELECT` statements to cover various scenarios.

  -   Make sure to test both positive and negative scenarios to validate the behaviour of your extension.

```sql
-- regression test script for my_extension

-- Create the my_table table
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Test the my_function function
SELECT my_function();

-- Verify the data in the my_table table
SELECT * FROM my_table;
```

### Step 2: Update the Makefile:

- In the given code, the changes made to the `Makefile` are related to the addition of a new variable called `REGRESS` and the inclusion of a new SQL file `my_extension--regress.sql`.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.sql
REGRESS = my_extension--regress.sql

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

- The `REGRESS` variable is used to specify the name of the regression test script file for the extension. In this case, the name is `my_extension--regress.sql`. This file will contain the SQL commands for the regression tests to be executed.

- These changes in the `Makefile` enable the `my_extension--regress.sql` file to be recognized during the installation process, allowing the regression tests to be executed using `make installcheck` 

### Step 3: Run `make installcheck`:

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

### Step 4: Analysing the output:
The successful output of the `make installcheck` command for the `my_extension` extension:
```sql
+++ regress install-check in  +++
(using postmaster on Unix socket, default port)
============== dropping database "contrib_regression" ==============
DROP DATABASE
============== creating database "contrib_regression" ==============
CREATE DATABASE
ALTER DATABASE
============== installing extension "my_extension" ==============
CREATE EXTENSION
SET
CREATE TABLE
CREATE FUNCTION
============== running regression test queries ==============
SELECT
--------
(1 row)

 my_function
--------------

(1 row)

 id |  name  
----+--------
  1 | Example
(1 row)
============== dropping database "contrib_regression" ==============
DROP DATABASE
============== cleaning up ==============
CLEANUP

```
- The output includes information about creating the test database, installing the extension, executing the test queries, and finally cleaning up the database.



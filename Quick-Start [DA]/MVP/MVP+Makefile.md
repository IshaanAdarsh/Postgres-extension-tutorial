# Minimum Viable Product:
A basic tutorial on creating a PostgreSQL extension using the bare minimum files:

- A **control file**, which tells PostgreSQL some basic information about the extension, such as its name, version, and schema.
- A **SQL script file**, which contains the SQL commands to create the extension's objects.
- A **Makefile** is a file that helps automate the build process of the extension. It defines the compilation and installation steps, making it easier to build and install the extension on different systems.

# [CODE](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/tree/main/Code/my_extension)

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
├── META.json
├── README.md
├── my_extension--1.0.0.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
├── results/
│   └── my_extension--regress.out
└── Makefile

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
default_version = '1.0.0'
relocatable = true

# Installation script for version 1.0.0
# 1.0.0
# my_extension--1.0.0.sql
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
<!--Problem: https://dba.stackexchange.com/questions/328624/makefile-issue-in-creating-postgres-extension
Had an issue with the make install command:
```makefile
DATA = my_extension--1.0.0sql

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
DATA = my_extension--1.0.0.sql

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
> NOTE: make: Nothing to be done for 'all'

> Makefile doesn't have any MODULE or other binary to build. You can go directly to the make install step

- The "make" command compiles the extension code using the Makefile
- The "make install" command copies the necessary files to the appropriate PostgreSQL directories.

### Step 6: Create the Extension in PostgreSQL
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
<!--
# Ran into a Shitload of problems in the make installcheck. The main takeaways:
- Change the REGRESS Variable value from REGRESS = my_extension--regress.sql to REGRESS = my_extension--regress
- Make sure all your code is working (my_function was acting weird, will figure out the issue)
- Shit from 13 years ago can help you -> for reference https://github.com/IshaanAdarsh/Postgres-extension-tutorial/issues/15
- Keep a track of the problems you face using GitHub issues, so you can track the problem thoroughly.
-->

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

## PGXN (PostgreSQL Extension Network):  
### Uploading the Extension on PGXN:
- It is a collaborative platform and centralized repository for PostgreSQL extensions. It provides a platform for developers to share, distribute, and collaborate on PostgreSQL extensions, enhancing the overall ecosystem and community support for PostgreSQL. 

To set up and use PGXN to publish and distribute your extension to other users, you can follow these steps: 

1.  **Set up a PGXN Account:** Visit the PGXN website (<https://pgxn.org/>) and create an account. This will allow you to manage your extensions and publish them on the PGXN repository. 

2.  **Prepare Your Extension:** Ensure that your extension is properly developed, tested, and ready for distribution. Make sure you have a well-documented README file, SQL scripts, and any necessary code files or dependencies. 

3.  **Create a PGXN Metadata File:** PGXN requires a metadata file that provides information about your extension. Create a file named `META.json` that includes details such as the extension name, version, author, description, dependencies, and other relevant information. Refer to the PGXN documentation for the required format and fields. 

#### Code for META.json file for my_extension:
```json
{
  "name": "my_extension",
  "abstract": "A basic PostgreSQL extension.",
  "version": "1.0.0",
  "maintainer": "Ishaan Adarsh <ishaanad9@gmail.com>",
  "license": "postgresql",
  "provides": {
    "my_extension": {
      "file": "my_extension--1.0.sql",
      "version": "1.0.0"
    }
  },
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}

```

#### README.md:
- Include a README file in your extension's repository that provides an overview of the extension, installation instructions, and basic usage examples. The README file serves as the starting point for users to understand your extension and its features. Here's an example structure for a README file:

```markdown
   # My Extension

   A brief description of your extension.

   ## Installation

   Steps to install the extension.

   ## Configuration

   Configuration options and their explanations.

   ## Usage

   Instructions on how to use the extension with code examples.

   ## Upgrading

   Notes on upgrading to a new version and any migration steps required.
```

4.  **Build a Distribution Package:** Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

5.  **Publish Your Extension:** Use the PGXN command-line tool or web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

### Updating an Extension on PGXN:
#### New Directory Hierarchy:
```
my_extension/
├── changes
├── META.json
├── README.md
├── my_extension--1.0.0.sql
├── my_extension--1.0.1.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
├── results/
│   └── my_extension--regress.out
└── Makefile
```

#### Step 1: Update the Extension Control File:
- Open the "my_extension.control" file and update the following content:

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0.1'
relocatable = true
```

#### Step 2: Create the new Extension SQL File:

- Create a file named `my_extension--1.0.1.sql`.

  - This file contains the new SQL statements for the extension.
  - The format for a PostgreSQL extension file name is `extension_name--version.sql`, where `extension_name` is the name of the extension, and `version` is the version number. The double-dash serves as a delimiter to indicate the separation between the extension name and the version number.

```bash
$ touch my_extension--1.0.1.sql
```

- Open the `my_extension--1.0.1.sql` file and add the following content:
  - The `complex_add` is a new function named complex_add that takes an array of integers as input. Inside the function, we use the unnest function to expand the array into individual elements and then calculate the sum using the SUM function. The result is returned as an integer.

```sql
-- Update path script for version 1.0.1
-- Create necessary objects for version 1.0.1
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

CREATE FUNCTION complex_add(integer[]) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    AS $$
        SELECT COALESCE(SUM(val), 0)
        FROM unnest($1) AS t(val)
    $$
;
```
### Step 3: Update the Makefile:

- In the given code, the changes made to the `Makefile` are related to the updated value of the `DATA` variable.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.1.sql
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

## Implementation of the Extension:
Once you have successfully implemented the `my_extension` in your PostgreSQL database, you can use the new funtion as follows:

### 1. Use the complex_add function to perform complex addition:
  ```sql
  SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);
  ```
#### Output:
```
 complex_add
-------------
          15
(1 row)
```

### Step 4: Update the Regression File:
-  Update the `my_extension--regress.sql` file to include the test for the new `complex_add function`
```sql
-- regression test script for my_extension

-- Create the extension
CREATE EXTENSION my_extension;

-- Verify the data in the my_table table
SELECT * FROM my_table;

-- Test the add function
SELECT add(1, 2) AS result;

-- Test the complex_add function
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]) AS result;
```

### Step 5: Run the `make installcheck`:
- After running a successful `make installcheck` command the output of the test will be:

```out
-- regression test script for my_extension
-- Create the extension
CREATE EXTENSION my_extension;
-- Verify the data in the my_table table
SELECT * FROM my_table;
 id | name 
----+------
(0 rows)

-- Test the add function
SELECT add(1, 2) AS result;
 result 
--------
      3
(1 row)

-- Test the complex_add function
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]) AS result;
 result 
--------
     15
(1 row)
```

### Step 6: Create a change file:
- A changelog is a file that provides a comprehensive and organized list of changes, enhancements, and bug fixes for each release of your PostgreSQL extension. It serves as a communication tool between you and the users, helping them understand the modifications made and the impact they may have on their existing installations. 

- Contents for the my_extension changelog:
```change
# Changelog for my_extension

## Version 1.0.1
- New Function: complex_add
  - Description: Added a new function called complex_add.
  - Usage: complex_add takes an array of integers as input and returns their sum.
  - Example: SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);

## Version 1.0.0
- Initial release of my_extension.
- Implemented basic functionality for data management and operations.
```

### Step 7: Update the `META.json`:
- Update the version number in the META.json file to "1.0.1" and ensure that all other information, such as the abstract, description, and maintainer, is accurate and up to date.

```json 
{
  "name": "my_extension",
  "abstract": "A Basic PostgreSQL extension",
  "description": "my_extension is a PostgreSQL extension that provides additional functionality for data management and operations.",
  "version": "1.0.1",
  "maintainer": [
    "Ishaan Adarsh <ishaanad9@gmail.com>"
  ],
  "license": "postgresql",
  "provides": {
    "my_extension": {
      "file": "my_extension--1.0.1.sql",
      "version": "1.0.1"
    }
  },
  "generated_by": "Ishaan Adarsh",
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}
```
> The `meta-spec` must be version `1.0.0`.  That's referring to the version of the JSON specification, NOT your module version.  `1.0.0` is the only spec that exists.

### Step 8: Build a Distribution Package for the updated version:
- Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

### Step 9: Publish Your Upgraded Extension:
- Use the PGXN command-line tool or web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

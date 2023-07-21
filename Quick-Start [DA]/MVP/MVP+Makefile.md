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

For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).


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

<!--
We could explain PGXS inshort to give the user more idea about the last 3 lines in the makefile.
#### PGXS (PostgreSQL Extension Build Infrastructure) 
It is a framework that helps simplify the process of building and installing extensions for PostgreSQL. It provides a standard way to compile and install extensions, making it easier to distribute and use them.

To use PGXS:
1. Create your extension's files, including source code and control files.
2. Create a Makefile in your extension's directory.
3. Inside the Makefile, include PGXS by adding a few lines of code.
4. Define any extension-specific instructions in the Makefile.
5. Use the `make` command to build and install your extension.
6. Enable the extension in PostgreSQL using the `CREATE EXTENSION` SQL command.

PGXS takes care of locating your PostgreSQL installation, determining compilation options, and ensuring the extension files are in the right place. It simplifies the process, making it easier for you to build and install your extension in different PostgreSQL environments.
-->

For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

#### Tip: 
```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.0.sql my_extension--1.1.0.sql
```

- By including multiple SQL script files in the `DATA` variable of the `Makefile`, the user can ensure that different versions of the extension can have different sets of objects or functionality. 
- Each SQL script file represents a specific version of the extension and can contain the necessary SQL commands for the desired changes.
- This allows the user to easily manage and control the installation of specific features or modifications in different versions of your extension.

### Step 5: Build and Install the Extension
- To build and install the extension, run the following commands:

```bash
$ make
$ make install
```

For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

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

For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).


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
For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/15/extend-pgxs.html).

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

For more information on the `make installcheck` command, you can refer to the [PostgreSQL documentation on `make installcheck`](https://www.postgresql.org/docs/current/regress-run.html#id-1.6.20.5.4).

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

# Updating the Extension:
There are multiple ways to upgrade extensions in PostgreSQL:

1. `ALTER EXTENSION`: The `ALTER EXTENSION` command allows you to upgrade an extension to a newer version. This command is specifically designed for managing extensions and provides a convenient way to apply updates without the need to drop and recreate the extension.

2. `DROP EXTENSION` and then `CREATE EXTENSION`: Another approach is to drop the existing extension and then recreate it using the newer version. This involves removing the extension from the database and then installing the updated version as a fresh installation.

Both methods have their advantages and may be suitable depending on the specific situation:

- `ALTER EXTENSION` is typically the preferred method as it allows for seamless upgrades without the need to drop and recreate the extension. It preserves the existing configuration, dependencies, and privileges associated with the extension.

- `DROP EXTENSION` and `CREATE EXTENSION` can be useful when significant changes or migrations are involved, or when there are conflicts or incompatibilities between versions that require a clean installation.

It's important to consider the specific requirements, compatibility, and impact on dependencies when choosing the appropriate method for upgrading extensions in PostgreSQL.

## Updating the Extension using the `ALTER EXTENSION` command:

- The ALTER EXTENSION command in PostgreSQL enables users to efficiently modify extensions by upgrading to newer versions, adjusting configuration and behaviour, introducing additional functionality or objects, and modifying existing components within the extension. 

- This command streamlines extension management, eliminating the need for manual interventions or complex administrative procedures. It simplifies the task of applying updates, incorporating new features, and ensuring compatibility with evolving requirements.

- For more information on the Extension Updates, you can refer to the [PostgreSQL documentation on Extension Updates](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.14)

### Directory Hierarchy:
```
my_extension/
├── README.md
├── my_extension--1.0.0.sql
├── my_extension--1.0.0--1.0.1.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
└── Makefile

```

### Step 1: Create an Update Script:
- If the user wants to upgrade the extension from the old_version to a new target_version.
- These scripts encapsulate the necessary changes required to upgrade an extension from one version to another, ensuring smooth transitions and preserving data integrity.
- Update scripts have names following the pattern `extension--old_version--target_version.sql` 

```bash
$ touch my_extension--1.0.0--1.0.1.sql
:' We are upgrading from version 1.0.0 to 1.0.1 '
```

- Open the my_extension--1.0.0--1.0.1 file and make the changes you want to add to the current version of the extension:

> Good Practice:

> Commenting out unchanged code in upgrade scripts enhances readability, facilitates comprehension of modifications, and serves as a valuable reference for future updates or troubleshooting scenarios, ensuring effective management and clarity in extension upgrades.

```sql
-- Update path script for version 1.0.1

-- Comment out the unchanged code 
-- Create necessary objects for version 1.0.1
-- CREATE TABLE my_table (
--  id SERIAL PRIMARY KEY,
--  name VARCHAR(100) NOT NULL
-- );

-- Add 2 numbers using add function
-- CREATE FUNCTION add(a integer, b integer) RETURNS integer
--    LANGUAGE SQL
--    IMMUTABLE
--    RETURNS NULL ON NULL INPUT
--    RETURN a + b;

-- Add complex_add function in version 1.0.1
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

### Step 2: Update the Control File:
- Updating the default_version for an extension is necessary to indicate the latest version available

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0.1'                # Reflect the newer version of the extension
relocatable = true
```

### Step 3: Update the Makefile:
- Update the `DATA` variable to include the update script to ensure that it is executed during the upgrade process of the extension, enabling the changes to be applied consistently across all installations.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.0--1.0.1.sql   # Update the DATA variable with the Upgrade Script file
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Step 4: Build and Install the Extension
- To build and install the updated extension, run the following commands:

```bash
$ make
$ make install
```

### Step 5: Upgrade the Extension:
- Finally, use the `ALTER EXTENSION` command to update the extension to the latest version.
- Execute the following SQL statement:

```sql
ALTER EXTENSION my_extension UPDATE TO '1.0.1';
-- Output: ALTER EXTENSION
```
The new objects introduced in the `my_extension--1.0.0--1.0.1.sql` file are included when updating an existing extension. This approach allows you to add new functionality without affecting the existing objects and ensures proper versioning and upgrade procedures.

- For more information on the `ALTER EXTENSION` command, you can refer to the [PostgreSQL documentation on `ALTER EXTENSION`](https://www.postgresql.org/docs/current/sql-alterextension.html)

- To check for **unexpected update paths**, use this command:

```sql
SELECT * FROM pg_extension_update_paths('*`extension_name`*');
```
- This shows each pair of distinct known version names for the specified extension, together with the update path sequence that would be taken to get from the source version to the target version, or `NULL` if there is no available update path.

**Output**:
```
 source | target |     path
--------+--------+--------------
 1.0.1  | 1.0.0  |
 1.0.0  | 1.0.1  | 1.0.0--1.0.1
(2 rows)
```
## `DROP EXTENSION` and `CREATE EXTENSION` method of upgrading extensions:

### Step 1:  Check the existing version: 
- Before performing the upgrade, check the current version of the extension using the following query:
```sql
SELECT * FROM pg_extension WHERE extname = 'my_extension';
```

#### Output:
```
  oid  |   extname    | extowner | extnamespace | extrelocatable | extversion | extconfig | extcondition
-------+--------------+----------+--------------+----------------+------------+-----------+--------------
 17254 | my_extension |       10 |         2200 | t              | 1.0.0      |           |
(1 row)
```

### Step 2: Backup the database: 
- It is always recommended to take a backup of your database before performing any upgrade operation to ensure data safety.
```
pg_dump -U <username> -d <database_name> -f <backup_file_path>
```

Replace `<username>` with your PostgreSQL username, `<database_name>` with the name of the database you want to back up, and `<backup_file_path>` with the path where you want to save the backup file.

### Step 3: Drop the existing extension: 
- Execute the `DROP EXTENSION` command to remove the current version of the extension from the database:
```sql
DROP EXTENSION IF EXISTS your_extension_name;
-- Output: DROP EXTENSION
```

- For more information on the `DROP EXTENSION` command, you can refer to the [PostgreSQL documentation on `DROP EXTENSION`](https://www.postgresql.org/docs/current/sql-dropextension.html)

### Step 4: Update the current extension documents to the new_version:

### Directory Hierarchy:
```
my_extension/
├── README.md
├── my_extension--1.0.0.sql
├── my_extension--1.0.1.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
└── Makefile

```

#### 1) Update the Extension Control File:
- Open the "my_extension.control" file and update the following content:

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0.1'
relocatable = true
```

#### 2) Create the new Extension SQL File:

- Create a file named `my_extension--1.0.1.sql`.
  - This file contains the new SQL statements for the extension.

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
#### 3) Update the Makefile:

- In the given code, the changes made to the `Makefile` are related to the updated value of the `DATA` variable.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.1.sql
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Step 4: Install the new version: 
- Run the `CREATE EXTENSION` command to install the updated version of the extension:
```sql
CREATE EXTENSION your_extension_name;
-- Output: CREATE EXTENSION
```

For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).


### Step 5: Verify the upgrade: 
- Confirm that the upgrade was successful by checking the new version of the extension:
```sql
SELECT * FROM pg_extension WHERE extname = 'your_extension_name';
```

#### Output:
```
  oid  |   extname    | extowner | extnamespace | extrelocatable | extversion | extconfig | extcondition
-------+--------------+----------+--------------+----------------+------------+-----------+--------------
 17254 | my_extension |       10 |         2200 | t              | 1.0.1      |           |
(1 row)
```

### Step 6: Validate functionality: 
- Test the functionality of the extension in your application or database to ensure that it is working as expected with the upgraded version.

- The new functionality added is complex_add:
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
## Extension Management:
Effective release management involves a systematic approach to versioning, testing, documentation, and distribution. Here are the key steps and best practices for managing releases of a Postgres extension:

### Versioning:
- Follow a consistent versioning scheme for your extension to indicate changes and updates. A common approach is to use Semantic Versioning (SemVer), which consists of three parts: `MAJOR.MINOR.PATCH`.

- Increment the MAJOR version for backward-incompatible changes, the MINOR version for backward-compatible new features, and the PATCH version for backward-compatible bug fixes.

### README.md: 
- The README.md file plays a pivotal role in extension management and packaging. It serves as the primary source of information for users and developers who interact with your Postgres extension. It should contain the following information about the extension:
  - Introduction
  - Installation Instructions
  - Configuration Options
  - Usage Examples
  - Troubleshooting and FAQ
  - License and Copyright Information.

```md
## Introduction
my_extension is a minimal viable product that provides a set of functions and a table to store data in PostgreSQL.

## Installation Instructions
To install my_extension, follow these steps:

1. Ensure you have PostgreSQL installed on your system.

2. Download the my_extension files.

3. Navigate to the directory containing the my_extension files.

4. Build and install the extension using the following command:

  `make install`
  

5. Enable my_extension in your PostgreSQL database:

  `CREATE EXTENSION my_extension;`


## Configuration Options

my_extension does not require any specific configuration options.

## Usage Examples

### Creating and Using the Table

To create the necessary objects for version 1.0.0 and the my_table table:

  `CREATE TABLE my_table (`
  `  id SERIAL PRIMARY KEY,`
  `  name VARCHAR(100) NOT NULL`
  `);`


To verify the data in the my_table table:

  `SELECT * FROM my_table;`

### Using the add Function

To add two numbers using the add function:

  `SELECT add(1, 2);`

## Troubleshooting and FAQ

**Q: I encountered an error during installation. What should I do?**
A: Double-check that you have followed the installation instructions correctly. Make sure PostgreSQL is installed and running.

**Q: Can I use my_extension with PostgreSQL version X?**
A: my_extension is designed for PostgreSQL version Y (replace Y with the specific version it was developed for). It may work with other versions, but it's recommended to use the compatible version.

## License and Copyright Information

my_extension is released under the [MIT License](LICENSE). Copyright &copy; [Your Name].
```
### docfile:
- A docfile is an essential component of extension management and packaging. It is a documentation file that contains detailed information about the extension, its design, architecture, and usage. The docfile provides an outline for additional sections that can be expanded upon with more detailed information about the extension. It should contain the following information about the extension:
  - Architecture and Design
  - Functionality Explanation
  - Code Structure
  - Performance Considerations
  - Testing and Regression
  - Contribution Guidelines

```md
## Architecture and Design

my_extension provides a simple set of functions and a table in PostgreSQL to demonstrate a minimal viable product. It consists of a single table, "my_table," with two columns: "id" (a serial primary key) and "name" (a varchar).

## Functionality Explanation

### Table: my_table
The "my_table" table is used to store data with an auto-incrementing "id" and a "name" field to hold a string value.

### Function: add
The "add" function is a simple SQL function that takes two integer inputs and returns their sum.

### Function: complex_add
The "complex_add" function is an additional function introduced in version 1.0.1. It takes an integer array as input and returns the sum of its elements.

## Code Structure:
my_extension/
├── README.md
├── my_extension--1.0.0.sql
├── my_extension--1.0.1.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
└── Makefile

The my_extension code is organized into the following files:

1. **Control file**: Defines metadata about the extension, such as the default version, comments, and relocatable status.

2. **SQL files**: Contains SQL commands to create the necessary objects for the extension, including the "my_table" table and the "add" and "complex_add" functions.

3. **Makefile**: A build configuration file that specifies how to build and install the extension in PostgreSQL.

4. **Regression SQL file**: Contains regression tests to verify the functionality of the extension.

## Performance Considerations

As my_extension is a minimal viable product, it is designed to demonstrate basic functionality rather than optimized performance. Depending on your specific use case, you may need to optimize certain parts of the extension for better performance.

## Testing and Regression

my_extension includes regression tests to ensure that it functions correctly. These tests can be executed using the following command:

  `make installcheck`

The regression SQL file (`my_extension--regress.sql`) contains the test cases to validate the extension's behaviour.

## Contribution Guidelines

Contributions to my_extension are welcome! If you wish to contribute, please follow these guidelines:

1. Fork the repository.

2. Make your changes in a feature branch.

3. Test your changes thoroughly and ensure they do not break existing functionality.

4. Create a pull request to submit your changes for review.

5. Ensure that your code follows the project's coding standards and best practices.

Please note that all contributions are subject to review and acceptance by the project maintainers. For major changes or significant new features, it's recommended to discuss your ideas first in an issue before submitting a pull request.
```
### Changelog:
Maintain a comprehensive changelog that documents all changes made in each release. Include details about new features, bug fixes, improvements, and backward-incompatible changes.

```md
# Changelog

## Version 1.0.0 (Initial Release)

### Added
- Created the my_extension extension with the `my_table` table and the `add` function.
- The `my_table` table consists of columns: `id` (serial primary key) and `name` (varchar).
- The `add` function allows adding two integer values and returns their sum.

## Version 1.0.1

### Added
- Introduced the `complex_add` function to perform sum calculations on an integer array input.
- Extended the my_extension functionality to include more advanced arithmetic operations.
- Updated the SQL file to include the definition of the `complex_add` function.

```

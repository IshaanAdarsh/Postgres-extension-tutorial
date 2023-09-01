# Minimum Viable Product:
A basic tutorial on creating a PostgreSQL extension using the bare minimum files:

- **[Control file](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11)**
- **SQL script file** 
- **[Makefile](https://www.postgresql.org/docs/current/extend-pgxs.html)**

## A Postgres extension using only a control file, an SQL file and a Makefile:

### Step 1: Create the Extension Directory
- Create a directory for your extension. Let's call it "my_extension".

```bash
$ mkdir my_extension
$ cd my_extension
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

# Indicates whether the extension is relocatable, allowing it to be moved to a different location (true by default)
relocatable = true
```

For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).


### Step 3: Create the Extension SQL File
- Create a file named "my_extension--1.0.0.sql".
  - This file contains the SQL statements required to install or uninstall your extension.
> The format for a PostgreSQL extension file name is `extension_name--version.sql`, where `extension_name` is the name of the extension, and `version` is the version number. The double-dash serves as a delimiter to indicate the separation between the extension name and the version number.

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
  - The Makefile is used to define the build process. It specifies extension name, and SQL files.
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

For more information on the Makefiles, you can refer to the [PostgreSQL documentation on Makefile](https://www.postgresql.org/docs/current/extend-pgxs.html).

#### Tip: 
```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.0.sql my_extension--1.1.0.sql
```

- The `DATA` variable in the `Makefile` allows you to specify multiple SQL script files for different extension versions. Each file represents a specific version with distinct objects or functionality. 

### Step 5: Build and Install the Extension
- To build and install the extension, run the following commands:

```bash
$ make
$ make install
```

For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 6: Create the Extension in PostgreSQL:
- Connect to your PostgreSQL database and execute the following SQL statement to create the extension:

```sql
CREATE EXTENSION IF NOT EXISTS my_extension;
```
For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

## Implementation of the Extension:
Once you have successfully implemented the `my_extension` in your PostgreSQL database, you can use it as follows:

### 1. Query the `my_table` table:
   - You can query the `my_table` table like any other table in your database. For example, you can retrieve all rows from the table using the following SQL query:
```sql
SELECT * FROM my_table;

-- Output
id | name
----+------
(0 rows)
```
### 2. Use the add function to perform addition:
  - The `add` function takes two integer arguments and returns their sum
```sql
SELECT add(2, 3);

-- Output
 add
-----
   5
(1 row)
```

## Regression Testing:
- The regression tests are a comprehensive set of tests for the SQL implementation in PostgreSQL. They test standard SQL operations as well as the extended capabilities of PostgreSQL.

### Step 1: Create the Extension subdirectory for test SQL files:
- Create a subdirectory for your regression file. Name it `sql`

```bash
$ mkdir sql
$ cd sql
```
-   Create a new file called `my_extension-regress.sql`.

```bash
$ touch my_extension-regress.sql
```

- Open the `my_extension-regress.sql` file and add the following content.

```sql
-- regression test script for my_extension
CREATE EXTENSION my_extension;

-- Verify the data in the my_table table
SELECT * FROM my_table;

-- Test the add function
SELECT add(1, 2);
```
For more information on regression files, you can refer to the [PostgreSQL documentation on Regression Tests](https://www.postgresql.org/docs/current/regress.html).

### Step 2: Update the Makefile:
- In the given code, the changes made to the `Makefile` are related to the addition of a new variable called `REGRESS` and the inclusion of a new SQL file `my_extension-regress`.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.0.sql
REGRESS = my_extension-regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
For more information on the Makefiles, you can refer to the [PostgreSQL documentation on makefile](https://www.postgresql.org/docs/current/extend-pgxs.html).

### Step 3: Create the `expected` subdirectory for expected result:
- Create a subdirectory for your regression file. Name it `expected`

```bash
$ mkdir expected
$ cd expected
```
-   Create a new file called `my_extension-regress.out`.

```bash
$ touch my_extension-regress.out
```
- Add the following content, which is the expected output of the extension after running the regression test:

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
- If the expected file matched the results exactly then the regression test passes.

### Step 4: Run `make installcheck`:

- Navigate to the directory containing your extension's code and Makefile.
- Run the following command to execute the `make installcheck` target and start regression testing process:

```
make installcheck
```

For more information on the `make installcheck` command, you can refer to the [PostgreSQL documentation on `make installcheck`](https://www.postgresql.org/docs/current/regress-run.html#id-1.6.20.5.4).


#### Tip:
- Another way of running the regression script is by running this command:

```
psql -f sql/my_extension--regress.sql > expected/my_extension--regress.out
```

The command `psql -f sql/my_extension--regress.sql > expected/my_extensions--regress.out` runs the regression test script `my_extension--regress.sql` and redirects the output to a file named `my_extensions--regress.out` in the `expected` directory.

#### How `make installcheck` works:
- The `make installcheck` command will internally execute the `pg_regress` utility with the appropriate parameters. It will connect to a PostgreSQL server and run the regression tests specified in the `my_extension--regress.sql` file.

#### When `make installcheck` test fails:
- If the `make installcheck` command doesn't work, it usually means that there are issues with the installation or configuration of the extension. The `regression.diffs` file and `regression.out` files are generated when the tests fail. Here's an explanation of each:

  - `regression.diffs`: This file contains the differences between the expected output and the actual output of the regression tests.
    
  - `regression.out`: This file contains the actual output of the regression tests. It shows the results, error messages, or any other output generated by the test scripts.

For more information on the Test Evaluation, you can refer to the [PostgreSQL documentation on Test Evaluation](https://www.postgresql.org/docs/current/regress-evaluation.html)

#### Sample Error Message:
- **regression.diffs**
```diff
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

# Extension Upgradability:
There are multiple ways to upgrade extensions in PostgreSQL:

1. `ALTER EXTENSION`

2. `DROP EXTENSION` and `CREATE EXTENSION`

## Updating the Extension using the `ALTER EXTENSION` command:

- The `ALTER EXTENSION` command in PostgreSQL enables users to efficiently modify extensions by upgrading to newer versions, adjusting configuration and behaviour, introducing additional functionality or objects, and modifying existing components within the extension. 

- For more information on the Extension Updates, you can refer to the [PostgreSQL documentation on Extension Updates](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.14)

### Step 1: Create an Update Script:
- Update scripts encapsulate the necessary changes required to upgrade an extension from one version to another, ensuring smooth transitions and preserving data integrity.
- Update scripts have names following the pattern `extension--old_version--target_version.sql` 

```bash
$ touch my_extension--1.0.0--1.0.1.sql
```

- Open the my_extension--1.0.0--1.0.1 file and make the necessary code changes.

```sql
-- Update path script for version 1.0.1
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
DATA = my_extension--1.0.0.sql my_extension--1.0.0--1.0.1.sql   # Update the DATA variable with the Upgrade Script file
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

```sql
ALTER EXTENSION my_extension UPDATE TO '1.0.1';
```

- For more information on the `ALTER EXTENSION` command, you can refer to the [PostgreSQL documentation on `ALTER EXTENSION`](https://www.postgresql.org/docs/current/sql-alterextension.html)

## `DROP EXTENSION` and `CREATE EXTENSION` method of upgrading extensions:

### Step 1: Drop the existing extension: 
- Execute the `DROP EXTENSION` command to remove the current version of the extension from the database:
```sql
DROP EXTENSION IF EXISTS my_extension;
```

- For more information on the `DROP EXTENSION` command, you can refer to the [PostgreSQL documentation on `DROP EXTENSION`](https://www.postgresql.org/docs/current/sql-dropextension.html)

### Step 2: Update the current extension files to the new_version:

#### 1) Update the Extension Control File:
- Open the "my_extension.control" file and update the default_version to the new verison of the extension:

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0.1'
relocatable = true
```

#### 2) Create the new Extension SQL File:
- Create a file named `my_extension--1.0.1.sql`.

```bash
$ touch my_extension--1.0.1.sql
```

- Open the `my_extension--1.0.1.sql` file and add the following content:
```sql
-- Update path script for version 1.0.1
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

-- Version 1.0.1: Adding the complex_add function to the extension. 
-- complex_add allows users to perform complex addition operations using an array of integers as input, returning the sum of all array elements. 
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
DATA = my_extension--1.0.0.sql my_extension--1.0.1.sql
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

For more information on the Makefiles, you can refer to the [PostgreSQL documentation on Makefile](https://www.postgresql.org/docs/current/extend-pgxs.html).

### Step 4: Install the new version: 
- Run the `CREATE EXTENSION` command to install the updated version of the extension:
```sql
CREATE EXTENSION my_extension;
```

For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

### Step 5: Validate functionality: 
- Test the functionality of the extension in your application or database to ensure that it is working as expected with the upgraded version.

```sql
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);

-- Output
 complex_add
-------------
          15
(1 row)
```

## Extension Management:
Effective release management involves a systematic approach to versioning, testing, documentation, and distribution. Here are the key steps and best practices for managing releases of a Postgres extension:

### Versioning:
- Follow a consistent versioning scheme for your extension to indicate changes and updates. A common approach is to use [Semantic Versioning (SemVer)](https://semver.org), which consists of three parts: `MAJOR.MINOR.PATCH`.

- Increment the MAJOR version for backwards-incompatible changes, the MINOR version for backwards-compatible new features, and the PATCH version for backwards-compatible bug fixes.

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

my_extension is released under the [PostgreSQL License](LICENSE).
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
## Description

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
https://github.com/IshaanAdarsh/my_extension

2. Make your changes in a feature branch.

3. Test your changes thoroughly and ensure they do not break existing functionality.

4. Create a pull request to submit your changes for review.

5. Ensure that your code follows the project's coding standards and best practices.

Please note that all contributions are subject to review and acceptance by the project maintainers. For major changes or significant new features, it's recommended to discuss your ideas first in an issue before submitting a pull request.
```
### Changelog:
Maintain a comprehensive changelog that documents all changes made in each release. Include details about new features, bug fixes, improvements, and backwards-incompatible changes.

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

## Extension Distribution:
Once you have developed and tested your Postgres extension, it's time to distribute it to other users and developers. Distributing your extension ensures that others can benefit from your work and integrate it into their PostgreSQL databases. To achieve this, you can use various platforms and distribution methods to make your extension accessible to a diverse audience.

### 1. PGXN (PostgreSQL Extension Network)

- PGXN is a centralized repository for PostgreSQL extensions, providing a convenient platform for extension distribution. By submitting your extension to PGXN, you can make it readily available to users and developers in the PostgreSQL community.

#### For more information on the PGXN, you can refer to the [PostgreSQL documentation on PGXN](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/PGXN.md).

### 2. Package Managers

Utilizing package managers allows users to install your extension easily with a simple command. You can package your extension in formats compatible with various package managers like `apt`, `yum`, `brew`, or `pip`.

#### Steps to Distribute Your Extension via Package Managers:

1. Create a distribution package in the format required by the respective package manager. For example, `.deb` for `apt` on Debian-based systems, `.rpm` for `yum` on Red Hat-based systems, or a formula for `brew` on macOS.

2. Host the distribution package on a repository or server accessible to users. You can use platforms like GitHub Releases, PackageCloud, or a custom repository.

3. Users can then install your extension using the package manager's install command:

```bash
# For apt (Debian/Ubuntu):
sudo apt-get install my_extension

# For yum (CentOS/RHEL):
sudo yum install my_extension

# For brew (macOS):
brew install my_extension
```

> Note:
> Ensure that your extension adheres to licensing and copyright requirements when distributing it across various platforms. It's essential to provide clear information about the license under which your extension is distributed and any dependencies it relies upon.

# Advanced Topics:

## [Procedural Languages for the Extension Creation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Procedural-language.md):
- Procedural languages in PostgreSQL provide a powerful way to extend the database's functionality by writing functions and procedures in languages other than SQL. 

- #### For more information on the Procedural Languages in Extension Creation, you can refer to the [PostgreSQL documentation on Procedural Languages in Extension Creation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Procedural-language.md). 

## [External Languages for the Extension Creation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/External-language.md):
- External languages in PostgreSQL provide a powerful way to integrate additional programming languages, extending the database's capabilities beyond its native support.

- #### For more information on the External Languages in Extension Creation, you can refer to the [PostgreSQL documentation on External Languages in Extension Creation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/External-language.md). 

## [Extending PostgreSQL with `pg_sample_ext`](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md): A Quick Start Guide
- This guide offers step-by-step instructions on creating extensions, while introducing features like functions, custom data types, and operators. From foundational concepts to advanced techniques, this guide equips you with the skills to extend PostgreSQL effectively.

- #### See [Extending PostgreSQL with `pg_sample_ext`](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md) for details.

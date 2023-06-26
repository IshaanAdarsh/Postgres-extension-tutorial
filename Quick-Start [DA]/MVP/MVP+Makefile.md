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
Reason: That's why `make install` doesn't copy the `*.control` file, and that's why `CREATE EXTENSION` fails.-->

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

<!--
## Regression Testing:
-->

To illustrate the concepts covered in the tutorial, a sample Postgres extension should be developed using SQL.

## SQL Postgres extension called "string_utils" which performs the function of reversing strings.

**Prerequisites for writing an extension:** 

Before starting to write an extension, you need to have the following prerequisites:
- Basic knowledge of SQL language and Postgres database management system.
- Postgres server installed on your system.
- A text editor for writing code.

**How to start writing an extension:** 

To start writing a Postgres extension, you need to follow these steps:
1. Open your text editor and create a new file with the name "string_utils.sql".
2. Add the following code to create a new schema for the extension:

```sql
CREATE SCHEMA string_utils;
```


1. Define the functions and types that you want to include in your extension. For example, we can define a function to reverse a string: 

```sql
CREATE OR REPLACE FUNCTION string_utils.reverse(text) RETURNS text AS $
BEGIN
    RETURN REVERSE($1);
END;
$ LANGUAGE plpgsql;
```


1. Save the file as "string_utils.sql".

**How to write a Makefile and what it should do:**  

The Makefile is used to automate the building and installation of the extension. It should include the following targets: 
- `all`: builds the extension 
- `install`: installs the extension 
- `uninstall`: uninstalls the extension 
- `clean`: cleans up any temporary files created during the build process

Here's an example Makefile for our "string_utils" extension: 

```makefile
MODULES = string_utils
DATA = string_utils--1.0.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```



**Role of PGXN and PGXS in this:**  

PGXN and PGXS are two tools that can be used to package and distribute Postgres extensions.
- PGXN: a network of PostgreSQL-related projects for extension distribution.
- PGXS: a makefile framework for building C extensions for PostgreSQL. 

If you want to publish your extension on PGXN, you need to create a package that includes the extension files and a meta file with information about the extension.

If you use PGXS to build your extension, it will generate a "control" file that can be used to create a package for distribution.

**Any procedural or external language used and its use in this sample extension:** 

In this example, we used PL/pgSQL procedural language to define the "reverse" function. However, we did not use any external languages. 

**How to write regression tests for the extension:**  

Regression tests are used to ensure that the extension functions correctly after any changes are made. The test should be included in a separate file with the extension ".sql".

Here's an example of a regression test for the "string_utils" extension: 

```sql
-- Test the reverse function
SELECT string_utils.reverse('hello') = 'olleh';
```



**Extension release management and upgradability:**   

When releasing a new version of the extension, you need to increase the version number in the filename and update the `ALTER EXTENSION` statement to reflect the changes. You should also provide instructions for upgrading the extension from the previous version.

For example, if we're releasing version 2.0 of the "string_utils" extension, the new SQL file should be named "string_utils--2.0.sql". We can then update the `ALTER EXTENSION` statement to: 

```sql
ALTER EXTENSION string_utils UPDATE TO '2.0';
```

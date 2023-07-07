# Extending Postgres with `pg_sample_ext`

In this quick start guide, we will explore the process of extending PostgreSQL using the `pg_sample_ext` extension. `pg_sample_ext` is a sample extension that gradually introduces various extension features which include
- Functions
- Data Types
  - Domains
- Operators
- Indexam
- Tableam.

By following this guide, you will learn how to create, install, and upgrade the `pg_sample_ext` extension while understanding the different ways in which Postgres can be extended. Each section will introduce a specific feature, providing hands-on examples and explanations to help you grasp the concepts and apply them to your own extensions.

Throughout this quick start, we will start with the basics, such as creating a function then we will progress to more advanced topics like defining custom data types and domains, implementing operators for custom types, and exploring advanced indexing and table access methods.

By the end of this guide, you will have a solid understanding of how to extend PostgreSQL using the `pg_sample_ext` extension and be equipped with the knowledge to create your own powerful extensions, tailored to meet your specific needs.

## Function: 

### Step 1: Create the Extension Directory
Create a directory for your extension, preferably in the PostgreSQL extension directory. For example:
```
$ mkdir pg_sample_ext
```

### Step 2: Create the Control File
Inside the extension directory, create a control file with the `.control` extension. This file will provide information about the extension.

```
# pg_sample_ext extension
comment = 'Sample extension to demonstrate Postgres Extensibilty'
default_version = '1.0.0'
relocatable = true
```

### Step 3: Create the SQL Script File
Create an SQL script file with the `.sql` extension inside the extension directory. This file will contain the SQL code to create the custom function. For example, create a file named `pg_sample_ext--1.0.sql` with the following contents:

```sql
-- Create a function to calculate the square of a number
CREATE OR REPLACE FUNCTION square(num integer)
RETURNS integer AS $$
BEGIN
  RETURN num * num;
END;
$$ LANGUAGE plpgsql;
```

### Step 4: Create the Makefile
Create a Makefile inside the extension directory. This file will define the build and installation instructions for the extension. For example, create a file named `Makefile` with the following contents:

```
EXTENSION = pg_sample_ext
DATA = pg_sample_ext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Step 5: Build and Install the Extension
Build and install the extension using the following commands:

```
$ make
$ make install
```

### Step 6: Enable the Extension in PostgreSQL
Connect to your PostgreSQL database and run the following command to enable the extension:
```sql
CREATE EXTENSION pg_sample_ext;
```

### Implementation:
Now, you can use the `pg_sample_ext` extension in your PostgreSQL database, specifically the `square` function to calculate the square of a number.
```sql
SELECT square(5); -- Returns 25
```

By following these steps, you can create a PostgreSQL extension that includes a custom function to extend the functionality of the database.

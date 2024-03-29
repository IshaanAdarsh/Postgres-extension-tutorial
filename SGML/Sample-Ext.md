# Extending Postgres with `pg_sample_ext`

In this quick start guide, we will explore the process of extending PostgreSQL using the `pg_sample_ext` extension. `pg_sample_ext` is a sample extension that gradually introduces various extension features which include:
- [Functions](https://www.postgresql.org/docs/current/sql-createfunction.html)
- [Data Types](https://www.postgresql.org/docs/current/datatype.html)
  - [`CREATE TYPE`](https://www.postgresql.org/docs/current/sql-createtype.html)
  - [`CREATE DOMAIN`](https://www.postgresql.org/docs/current/sql-createdomain.html)
- [Operators](https://www.postgresql.org/docs/current/sql-createoperator.html)

By following this guide, you will learn how to create, install, and upgrade the `pg_sample_ext` extension while understanding the different ways in which Postgres can be extended. Throughout this quick start, we will start with the basics, such as creating a function then we will progress to more advanced topics like defining custom data types and domains, and implementing operators for custom types.

For a detailed tutorial on getting started with extension creation, refer to the [Simple Postgres Extension](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md).

## Function:
### Step 1: Create the Extension Directory
- Create a directory for your extension
```
$ mkdir pg_sample_ext
```

### Step 2: Create the Control File
- Create a control file with the `.control` extension. This file will provide information about the extension.

```
# pg_sample_ext extension
comment = 'Sample extension to demonstrate Postgres Extensibilty'
default_version = '1.0.0'
relocatable = true
```
- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

### Step 3: Create the SQL Script File
- This file will contain the SQL code to create the custom function. 

```sql
-- Create a function to calculate the square of a number
CREATE OR REPLACE FUNCTION square(num integer)
RETURNS integer AS $$
BEGIN
  RETURN num * num;
END;
$$ LANGUAGE plpgsql;
```
- For more detailed information on `CREATE FUNCTION`, you can refer to the [PostgreSQL documentation on `CREATE FUNCTION`](https://www.postgresql.org/docs/current/sql-createfunction.html).

### Step 4: Create the Makefile
- Create a Makefile inside the extension directory.

```
EXTENSION = pg_sample_ext
DATA = pg_sample_ext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
For more information on the Makefiles, you can refer to the [PostgreSQL documentation on Makefile](https://www.postgresql.org/docs/current/extend-pgxs.html).

### Step 5: Build and Install the Extension
- Build and install the extension using the following commands:

```
$ make
$ make install
```
For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 6: Enable the Extension in PostgreSQL
- Connect to your PostgreSQL database and run the following command to enable the extension:
```sql
CREATE EXTENSION pg_sample_ext;
```
For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

### Usage:
- Now, you can use the `pg_sample_ext` extension in your PostgreSQL database, specifically the `square` function to calculate the square of a number.
```sql
SELECT square(5); -- Returns 25
```

## Custom Data Type: 
The `CREATE TYPE` statement and the `CREATE DOMAIN` statement in PostgreSQL are used to create custom data types. While they both allow you to define custom data types, there are differences in how they are created and their intended purposes. Here's a differentiation between the two:

### 1. `CREATE TYPE` statement:
Creates a composite type or an enumerated type. For more detailed information on `CREATE TYPE`, you can refer to the [PostgreSQL documentation on `CREATE TYPE`](https://www.postgresql.org/docs/current/sql-createtype.html).

#### 1. A composite type using `CREATE TYPE`:
   - The `person_type` is defined as a composite type consisting of two attributes: `name` of type `text` and `age` of type `integer`.
```sql
CREATE TYPE person_type AS (
  name text,
  age integer
);
```

#### 2. An enumerated type using `CREATE TYPE`:
   - The `status_type` is defined as an enumerated type that represents a set of predefined values: 'active', 'inactive', and 'pending'.
```sql
CREATE TYPE status_type AS ENUM ('active', 'inactive', 'pending');
```

Using the Data Types:
```sql
-- Use the composite type in a table column
CREATE TABLE my_table (
   id serial PRIMARY KEY,
   person person_type
);

-- Use the enumerated type in a table column
CREATE TABLE status_table (
  id serial PRIMARY KEY,
  status status_type
);

-- Implementing Operations using Data Types
-- 1) Insert a row with a value from the composite type
INSERT INTO my_table (person) VALUES (('John Doe', 30));

-- Output:
 id |     person
----+-----------------
  1 | ("John Doe",30)
(1 row)

-- 2) Insert a row with a value from the enumerated type
INSERT INTO status_table (status) VALUES ('active');

-- Output:
 id | status
----+--------
  1 | active
(1 row)

```

In the example above, we demonstrate how to use the `person_type` composite type to declare a variable and perform operations using its attributes. We also showcase the usage of the `status_type` enumerated type in a table column, ensuring that only the predefined values ('active', 'inactive', 'pending') can be inserted.

### 2. `CREATE DOMAIN` statement:
- A domain type is a custom data type that is based on an existing base type but with additional constraints applied. For more detailed information on `CREATE DOMAIN`, you can refer to the [PostgreSQL documentation on `CREATE DOMAIN`](https://www.postgresql.org/docs/current/sql-createdomain.html).

A domain type using `CREATE DOMAIN`:
```sql
-- Create a domain type for representing positive integers
CREATE DOMAIN positive_integer AS integer
   CHECK (VALUE > 0);
```

In the example above, we create a domain type called `positive_integer` based on the existing base type `integer`. The `CHECK` constraint ensures that any value assigned to this domain type must be greater than 0, effectively enforcing the concept of positive integers.

Usage example:
```sql
-- Create a table using the domain type
CREATE TABLE quant_table (
   id serial PRIMARY KEY,
   quantity positive_integer
);

-- Insert a row, ensuring the quantity is a positive integer
INSERT INTO quant_table (quantity) VALUES (10);

-- Output:
 id | quantity
----+----------
  1 |       10
(1 row)

-- This insert will fail due to the CHECK constraint
INSERT INTO my_table (quantity) VALUES (-5);

-- Output:
ERROR:  value for domain positive_integer violates check constraint "positive_integer_check"
```

## Custom Postgres Operators:
In PostgreSQL, custom operators can be created to extend the functionality of the database by defining new operations or modifying the behaviour of existing operations. For more detailed information on `CREATE OPERATOR`, you can refer to the [PostgreSQL documentation on `CREATE OPERATOR`](https://www.postgresql.org/docs/current/sql-createoperator.html).

```sql
-- Custom Operator: @*
-- Description: Custom operator that multiplies two values of type my_type

-- Create a new type to use in our operator.
CREATE TYPE my_type AS (value int);

-- Create a SQL function that defines the behaviour of the custom operator.
-- This function multiplies the values of two my_type operands.
CREATE FUNCTION multiply_values(input1 my_type, input2 my_type) RETURNS my_type AS $$
    SELECT ROW(input1.value * input2.value)::my_type;
$$ LANGUAGE SQL IMMUTABLE;

-- Create a custom operator that multiplies two values of type my_type.
-- The operator symbol is @*.
-- It takes two operands of type my_type and returns a value of the same type.
-- The behaviour is defined by the SQL function multiply_values.
CREATE OPERATOR @* (
    PROCEDURE = multiply_values,
    LEFTARG = my_type,
    RIGHTARG = my_type
);
```

### Implementation:
- Here, we first show the input values `input_left` and `input_right`, which are `my_type` values created using the `ROW` constructor.

```sql

-- Input

SELECT ROW(2)::my_type AS input_left, ROW(3)::my_type AS input_right;

-- Output

 input_left | input_right
------------+-------------
 (2)        | (3)
(1 row)
```

- Then, we execute the query using the custom operator `@*` to multiply the `input_left` and `input_right` values. The result is `(6)`, which is the product of 2 and 3.

```sql
-- Input

SELECT ROW(2)::my_type @* ROW(3)::my_type AS result;

-- Output

 result
--------
 (6)
(1 row)
```

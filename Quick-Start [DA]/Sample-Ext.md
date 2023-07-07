# Extending Postgres with `pg_sample_ext`

In this quick start guide, we will explore the process of extending PostgreSQL using the `pg_sample_ext` extension. `pg_sample_ext` is a sample extension that gradually introduces various extension features which include
- Functions
- Data Types
  - `CREATE TYPE`
  - `CREATE DOMAIN`
- Operators
  - Unary Operators
  - Binary Operators
  - Comparison Operators
  - Arithmetic Operators
  - Logical Operators
  - Text Operators
  - Postfix Operators
- Indexam
- Tableam

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

## Custom Data Type: 
The `CREATE TYPE` statement and the `CREATE DOMAIN` statement in PostgreSQL are used to create custom data types. While they both allow you to define custom data types, there are differences in how they are created and their intended purposes. Here's a differentiation between the two:

[3rd Party Tutorial Content](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-user-defined-data-types/)

### 1. `CREATE TYPE` statement:
Creates a composite type or an enumerated type.
- Composite types (also known as row types) allow you to define a new data type that consists of multiple attributes or fields. They are similar to creating a table with named columns but without the storage aspect.
- Enumerated types allow you to define a new data type with a predefined list of allowed values.

A composite type using `CREATE TYPE`:
```sql
CREATE TYPE person_type AS (
  name text,
  age integer
);
```

An enumerated type using `CREATE TYPE`:
```sql
CREATE TYPE status_type AS ENUM ('active', 'inactive', 'pending');
```

### 2. `CREATE DOMAIN` statement:
- A domain type is a custom data type that is based on an existing base type but with additional constraints or rules applied. It provides a way to create a specialized version of an existing data type.
- Domains are useful for adding constraints or business rules to a base type without duplicating those constraints across multiple columns.

A domain type using `CREATE DOMAIN`:
```sql
CREATE DOMAIN email_address AS text
  CHECK (value ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
```

## Custom Postgres Operators:
[3rd Party Site](https://www.linuxtopia.org/online_books/database_guides/Practical_PostgreSQL_database/PostgreSQL_x15284_002.htm)

In PostgreSQL, custom operators can be created to extend the functionality of the database by defining new operations or modifying the behaviour of existing operations. There are different types of custom operators that can be created in PostgreSQL:

1. **Unary Operators:**
   Unary operators are operators that perform an operation on a single operand. They can be prefix operators or postfix operators.

2. **Binary Operators:**
   Binary operators are operators that perform an operation on two operands. They can be infix operators or prefix operators.

3. **Comparison Operators:**
   Comparison operators are used to compare two values and return a boolean result. Custom comparison operators can be defined to handle specific data types or implement custom comparison logic.

4. **Arithmetic Operators:**
   Arithmetic operators are used for mathematical operations such as addition, subtraction, multiplication, and division. Custom arithmetic operators can be defined to handle specialized numeric types or implement custom arithmetic logic.

5. **Logical Operators:**
   Logical operators are used for logical operations such as conjunction (AND), disjunction (OR), and negation (NOT). Custom logical operators can be defined to handle specialized conditions or implement custom logical operations.

6. **Text Operators:**
   Text operators are used for string concatenation, pattern matching, and other text-related operations. Custom text operators can be defined to handle specific string patterns or implement custom text manipulation logic.

7. **Postfix Operators:**
   Postfix operators are operators that are applied after their operand. They are useful for creating custom functions that can be called using a postfix syntax.

## What are Procedural Languages?

PostgreSQL supports several procedural languages, including PL/SQL, PL/Python, PL/Perl, and PL/Tcl. These languages allow you to write stored procedures, triggers, and other database objects using a familiar programming language.
## How to Use Procedural Languages for a PostgreSQL Extension

To use a procedural language in a PostgreSQL extension, you need to do the following: 
1. Install the language: Use the `CREATE LANGUAGE` command to install the desired procedural language in your PostgreSQL database. For example, to install PL/Python:

```sql

CREATE LANGUAGE plpythonu;
```


1. Create the function: Write a function in your procedural language that performs the desired operation. For example, here's a simple function written in PL/Python that returns the sum of two integers:

```sql

CREATE FUNCTION my_sum(a INTEGER, b INTEGER) RETURNS INTEGER
AS $
    return a + b
$ LANGUAGE plpythonu;
```


1. Build the extension: In your extension's Makefile, include the procedural language as a dependency. For example, to include PL/Python:

```makefile

MODULES = myextension
DATA = myextension--1.0.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
REGRESS = myextension_test
DOCS = README.md
PLPYTHONU = $(shell $(PG_CONFIG) --pkglibdir)/plpythonu
include $(PGXS)

myextension.so: myextension.o
        $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PLPYTHONU)
```

 
1. Test the function: After building and installing the extension, you can test your function using the `SELECT` command. For example:

```scss

SELECT my_sum(1, 2);
```



This should return the value `3`.

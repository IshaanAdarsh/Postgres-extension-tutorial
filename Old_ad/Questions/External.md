# What are External Languages?

In addition to the procedural languages supported by PostgreSQL, you can also use external languages to write stored procedures, triggers, and other database objects. These languages are not built into PostgreSQL, but instead run in a separate process and communicate with the database using a communication protocol.

## How to Use External Languages for a PostgreSQL Extension

To use an external language in a PostgreSQL extension, you need to do the following:

1. Choose an external language. Select an external language that you want to use in your extension. There are several options available, such as Java, C#, and Node.js. Each language has its own set of tools and libraries, so choose the one that best fits your needs.
2. Write the function. Write a function in your external language that performs the desired operation. This function should communicate with the database using the appropriate communication protocol.

For example, here's a simple function written in Python that returns the sum of two integers:

```python
import psycopg2

def my_sum(a, b):
    conn = psycopg2.connect("dbname=mydb user=myuser")
    cur = conn.cursor()
    cur.execute("SELECT %s + %s", (a, b))
    result = cur.fetchone()[0]
    cur.close()
    conn.close()
    return result
```
## Build the extension

In your extension's Makefile, include the necessary files and libraries for your external language. For example, to include Python:

```python
MODULES = myextension
DATA = myextension--1.0.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
REGRESS = myextension_test
DOCS = README.md
PYTHON_INCLUDE = /usr/include/python3.9
PYTHON_LIB = /usr/lib/x86_64-linux-gnu/libpython3.9.so
SHLIB_LINK += -lpython3.9
include $(PGXS)
myextension.so: myextension.o
    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PYTHON_LIB)
```

## Test the function

After building and installing the extension, you can test your function using the `SELECT` command. For example:

```sql
SELECT my_sum(1, 2);
```


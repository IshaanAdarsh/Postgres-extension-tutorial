# Quick Start: Creating a PostgreSQL Extension using C as an External Language

In this quick start guide, we will create a simple PostgreSQL extension using C as an external language. The extension will include a function to add two numbers.

## Prerequisites

- PostgreSQL installed and running on your system.
- Basic knowledge of C programming.
- Familiarity with the PostgreSQL extension development process.

### Step 1: Create the Extension Directory

Create a new directory for your extension project.

```bash
mkdir pg_cext
cd pg_cext
```

### Step 2: Create the Makefile

Create a Makefile that uses PGXS macros to build the extension:

```makefile
MODULES = pg_cext
EXTENSION = pg_cext
DATA = pg_cext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Step 3: Create the Control File

Create a control file named `pg_cext.control` with the following content:

```control
comment = 'Postgres extension using C to add two numbers'
default_version = '1.0.0'
relocatable = true
module_pathname = '$libdir/pg_cext'
```

### Step 4: Write the C Function

Write the C function in a file named `pg_cext.c`:

```c
#include "postgres.h"
#include "fmgr.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(add_nums);

Datum add_nums(PG_FUNCTION_ARGS)
{
    int32 arg1 = PG_GETARG_INT32(0);
    int32 arg2 = PG_GETARG_INT32(1);

    PG_RETURN_INT32(arg1 + arg2);
}
```

### Step 5: Create the SQL Script file:

Create a control file named `pg_cext--1.0.0.sql` with the following content:

```sql
CREATE OR REPLACE FUNCTION
addme(int,int) RETURNS int AS 'MODULE_PATHNAME','addme'
LANGUAGE C STRICT;
```

### Step 5: Build and Install the Extension

Build the extension using the following command:

```bash
make
```

Install the extension:

```bash
make install
```

### Step 6: Create and Test the Extension

Create the extension in your PostgreSQL database:

```sql
CREATE EXTENSION pg_cext;
```

Test the function:

```sql
SELECT add_nums(2, 3);
```

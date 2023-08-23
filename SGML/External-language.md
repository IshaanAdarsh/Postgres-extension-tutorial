# External Languages in PostgreSQL:
External languages in PostgreSQL provide a powerful way to integrate additional programming languages, extending the database's capabilities beyond its native support. Developers can use these languages to implement custom functionality, access external libraries, and leverage their expertise in preferred programming languages.

Using external languages offers several advantages:

1. **Language Flexibility:** Integrate a wide range of languages like [Python](https://www.python.org), [Ruby](https://www.ruby-lang.org/en/), or [Java](https://www.java.com/en/) to perform tasks that may not be as straightforward in SQL.

2. **Code Reusability:** Reuse existing code written in preferred languages, reducing development time and effort.

3. **Performance Optimization:** Choose languages with performance advantages for specific tasks, improving the overall extension efficiency.

4. **Ecosystem Integration:** Tap into well-established language ecosystems, leveraging community-contributed libraries and best practices.

To utilize external languages in a PostgreSQL extension, follow these steps:

1. **Implement the Language:** Develop the code and functionality to support the external language within the extension.

2. **Define the Language in Control File:** Specify the external language requirement and provide integration details in the extension's control file.

3. **Register the Language:** Use [`CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html) in PostgreSQL to install and enable the extension, recognizing the external language.

4. **Write Functions and Stored Procedures:** Utilize the external language to implement the desired functionality in functions and stored procedures.

# Quick Start: Creating a PostgreSQL Extension using C as an External Language
In this quick start guide, we will create a simple PostgreSQL extension using C as an external language.

## Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) installed and running on your system.
- Basic knowledge of C programming.
- Familiarity with the PostgreSQL extension development process.
- `make` utility for building and compiling software. 
- Compiler to convert your source code into executable machine code.
- Knowledge about the Postgres Development Libraries

### Step 1: Create the Extension Directory
- Create a new directory for your extension project.

```bash
mkdir pg_cext
cd pg_cext
```

### Step 2: Create the Makefile
- Create a Makefile that uses PGXS macros to build the extension:

```makefile
MODULES = pg_cext
EXTENSION = pg_cext
DATA = pg_cext--1.0.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
- For more information on the Makefiles, you can refer to the [PostgreSQL documentation on Makefile](https://www.postgresql.org/docs/current/extend-pgxs.html).

### Step 3: Create the Control File
- Create a control file named `pg_cext.control` with the following content:

```control
comment = 'Postgres extension using C to add two numbers'
default_version = '1.0.0'
relocatable = true
module_pathname = '$libdir/pg_cext'
```
- For more detailed information on Control Files, you can refer to the [PostgreSQL documentation on Control Files](https://www.postgresql.org/docs/current/extend-extensions.html#id-1.8.3.20.11).

### Step 4: Write the C Function
- Write the C function in a file named `pg_cext.c`:

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
- Create a control file named `pg_cext--1.0.0.sql` with the following content:

```sql
CREATE OR REPLACE FUNCTION
add_nums(int,int) RETURNS int AS 'MODULE_PATHNAME','add_nums'
LANGUAGE C STRICT;
```

### Step 6: Build and Install the Extension

#### Build the extension using the following command:

```bash
make
```

When we run the command `make` in the terminal, it triggers the build process of the PostgreSQL extension. This process involves compiling the extension's source code and generating the necessary object files (.o) and shared object files (.so).

1. **.o Files (Object Files):** During the build process, the source code of the extension (e.g., `my_extension.c`) is translated into machine-readable code represented by object files. These files contain the compiled code for individual functions or components of the extension. However, they are not yet directly executable on their own.

2. **.so Files (Shared Object Files):** The next step in the build process is linking the object files together to create a shared object file (`.so`). This file is a dynamically linked library that contains all the compiled code from the object files. It is also referred to as a shared library or DLL (Dynamic Link Library) on some systems. The `.so` file is the final form of the extension that PostgreSQL can use.

**PGXS (PostgreSQL Extension Build Infrastructure):** 
The PostgreSQL Extension Build Infrastructure (PGXS) is a set of Makefile macros and rules that simplify the build process for PostgreSQL extensions. It automates common build tasks and allows developers to use predefined variables and targets in their `Makefile`. By including PGXS in the `Makefile`, developers can leverage its functionality and ensure a standardized build process.

When using `PGXS` in the `Makefile`, it gets the necessary paths and configurations from `pg_config --pgxs`, ensuring correct building with dependencies. The build process generates `.o` and `.so` files in the build directory. The `.so` file is the extension, ready for installation in PostgreSQL, containing compiled code for all defined functions.

#### Install the extension:

```bash
make install
```

- For more information on the installation procedures, you can refer to the [PostgreSQL documentation on Installing the Files](https://www.postgresql.org/docs/current/install-procedure.html#INSTALL).

### Step 7: Create and Test the Extension
- Create the extension in your PostgreSQL database:

```sql
CREATE EXTENSION pg_cext;
```
- For more information on the `CREATE EXTENSION` command, you can refer to the [PostgreSQL documentation on `CREATE EXTENSION`](https://www.postgresql.org/docs/current/sql-createextension.html).

- Test the function:

```sql
SELECT add_nums(2, 3);

-- Output:
 add_nums
-------
     5
(1 row)

```

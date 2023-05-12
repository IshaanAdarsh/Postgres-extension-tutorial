## Control file:

The control file is a text file that tells PostgreSQL about your extension. The control file must have the extension name, the extension version, and the extension author. The control file must also have a list of the functions and data types that are provided by your extension.
The following is an example of a control file:

``` sql
MODULE = myextension
VERSION = 1.0
AUTHOR = Ishaan
CREATE_FUNCTION = myextension_add
CREATE_FUNCTION = myextension_sub
CREATE_FUNCTION = myextension_mul
CREATE_FUNCTION = myextension_div
CREATE_TYPE = myextension_int
```

The MODULE line specifies the name of the extension. The VERSION line specifies the version of the extension. The AUTHOR line specifies the author of the extension. The CREATE_FUNCTION lines specify the names of the functions that are provided by the extension. The CREATE_TYPE line specifies the name of the data type that is provided by the extension.

## SQL data file:

The SQL data file is a text file that contains the SQL statements that are needed to create the objects that are used by your extension. This may include tables, functions, procedures, and views.
The following is an example of a SQL data file:

```sql

CREATE TABLE myextension_int (
  id serial PRIMARY KEY,
  value integer NOT NULL
);

CREATE FUNCTION myextension_add(integer, integer) RETURNS integer AS $$
BEGIN
  RETURN $1 + $2;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION myextension_sub(integer, integer) RETURNS integer AS $$
BEGIN
  RETURN $1 - $2;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION myextension_mul(integer, integer) RETURNS integer AS $$
BEGIN
  RETURN $1 * $2;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION myextension_div(integer, integer) RETURNS integer AS $$
BEGIN
  RETURN $1 / $2;
END;
$$ LANGUAGE plpgsql;
```

The CREATE TABLE statement creates a table called myextension_int. The CREATE FUNCTION statements create functions called myextension_add, myextension_sub, myextension_mul, and myextension_div.

## C or C++ code for your extension:

The C or C++ code is the actual code that implements the functions and data types that are provided by your extension. The code must be compiled and linked into a shared object file.
The following is an example of C code that implements the myextension_add function:

```C
#include <stdlib.h>
#include <pgsql/libpq-fe.h>

PG_FUNCTION_INFO_V1(myextension_add);

Datum
myextension_add(PG_FUNCTION_ARGS)
{
  int32_t arg1 = PG_GETARG_INT32(0);
  int32_t arg2 = PG_GETARG_INT32(1);
  int32_t result = arg1 + arg2;
  PG_RETURN_INT32(result);
}
```

The PG_FUNCTION_INFO_V1() macro declares the function to PostgreSQL. The Datum type is the generic type for function results. The PG_GETARG_INT32() macro gets the argument at the specified position and casts it to an int32_t type. The PG_RETURN_INT32() macro returns the specified value as an int32_t type.
Once you have written the C or C++ code, you need to compile it into a shared object file. 

You can use the make command to compile your code.The following is an example of a Makefile that compiles the C code:

```sql

EXTENSION = myextension

OBJS = myextension.o

all: $(EXTENSION).so

$(EXTENSION).so: $(OBJS)
  $(CC) -shared -o $@ $(OBJS) -L/usr/lib/postgresql/13/lib -lpq
  
myextension.o: myextension.c
  $(CC) -c -o $@ $<
  
clean:
  rm -f $(OBJS) $(EXTENSION).so

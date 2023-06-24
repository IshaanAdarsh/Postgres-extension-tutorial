A quick start guide for creating a sample Postgres pgSQL extension:

Step 1: Setting up the development environment
- Make sure you have Postgres installed on your system.
- Create a new directory for your extension project.

Step 2: Creating the extension files
- Inside your project directory, create a new file called "extension.sql".
- In "extension.sql", define the functions, types, or other objects you want to include in your extension. For example:
```
-- extension.sql
-- pgSQL extension control information
-- comment = 'My PostgreSQL pgSQL Extension'
-- default_version = '1.0'
-- module_pathname = '$libdir/extension_name'

-- Function definition
CREATE FUNCTION my_function() RETURNS text AS $$
BEGIN
    RETURN 'Hello, world!';
END;
$$ LANGUAGE plpgsql;
```
- a pgSQL extension in PostgreSQL, you don't need a separate control file. 


Step 3: Building the extension
- Create a new file called "Makefile" in your project directory.
- In the "Makefile", define the necessary build commands. For a pgSQL extension, you can use the following template:
```
MODULE_big = extension_name
OBJS = extension_name.o

EXTENSION = extension_name
DATA = extension_name--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

Step 4: Compiling and installing the extension
- Open a terminal and navigate to your project directory.
- Run the following command to compile the extension:
```
make
```
- After successful compilation, install the extension by running:
```
sudo make install
```

Step 5: Creating the extension in Postgres
- Open a Postgres client, such as psql, to connect to your database.
- Run the following command to create the extension:
```
CREATE EXTENSION extension_name;
```
- You can now use the functions or types defined in your extension in your database queries.

You've created and installed a basic pgSQL extension in Postgres. You can expand on this tutorial by adding more functions, types, or other objects to your "extension.sql" file and recompiling the extension using the provided Makefile.

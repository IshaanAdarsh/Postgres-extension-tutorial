# MVP (SQL+Control+Makefile):
A basic tutorial on creating a PostgreSQL extension using the bare minimum files and a Makefile:

- A **control file**, which tells PostgreSQL some basic information about the extension, such as its name, version, and schema.
- A **SQL script file**, which contains the SQL commands to create the extension's objects.
- A **Makefile** it is an optional but highly recommended file that helps automate the build process of the extension. It defines the compilation and installation steps, making it easier to build and install the extension on different systems.

## A Postgres extension using only a control file, an SQL file and a Makrfile:

### Step 1: Create the Extension Directory
- Create a directory for your extension. Let's call it "extension".
```
$ mkdir extension
$ cd extension
```

### Step 2: Create the Extension Control File
- Inside the "extension" directory, create a file named "extension.control". 
  - This file defines the metadata and dependencies of your extension.

```
$ touch extension.control
```

- Open the "extension.control" file and add the following content:

```
# myextension.control
comment = 'My PostgreSQL Extension'
default_version = '1.0'
module_pathname = '$libdir/extension
```

### Step 3: Create the Extension SQL File
- Create a file named "extension--1.0.sql".
  - This file contains the SQL statements required to install or uninstall your extension.

```
$ touch myextension--1.0.sql
```

- Open the "extension--1.0.sql" file and add the following content:

```sql
-- extension--1.0.sql
CREATE EXTENSION IF NOT EXISTS extension;
```

### Step 4: Create the Makefile
- Create a Makefile in the "extension" directory. 
  - The Makefile is used to define the build process. It specifies the module name, object files, extension name, and SQL files. The PG_CONFIG variable retrieves the path to the pg_config utility, which is used to get the necessary configuration for building the extension.

```
$ touch Makefile
```
- Open the Makefile and add the following content:

```makefile
MODULE_big = myextension
OBJS = extension.o

EXTENSION = myextension
DATA = myextension--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```
- In the Makefile, replace "extension" with the name of your extension. If you have multiple source files, update the "OBJS" variable accordingly.

### Step 5: Build and Install the Extension
- To build and install the extension, run the following commands:

```
$ make
$ make install
```
- The "make" command compiles the extension code using the Makefile
- The "make install" command copies the necessary files to the appropriate PostgreSQL directories.

### Step 6: Create the Extension in PostgreSQL
- Connect to your PostgreSQL database and execute the following SQL statement to create the extension:

```sql
CREATE EXTENSION extension;
```

- The CREATE EXTENSION statement is executed in PostgreSQL to create the extension.

Congratulations! You have created and installed a basic PostgreSQL extension.

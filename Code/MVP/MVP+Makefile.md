A basic tutorial on creating a PostgreSQL extension using the bare minimum files and a Makefile:

Step 1: Create the Extension Directory
Create a directory for your extension. Let's call it "myextension".

```
$ mkdir myextension
$ cd myextension
```

Step 2: Create the Extension Control File
Inside the "myextension" directory, create a file named "myextension.control". This file defines the metadata and dependencies of your extension.

```
$ touch myextension.control
```

Open the "myextension.control" file and add the following content:

```
# myextension.control
comment = 'My PostgreSQL Extension'
default_version = '1.0'
module_pathname = '$libdir/myextension'
```

You can customize the content as per your extension's details.

Step 3: Create the Extension SQL File
Create a file named "myextension--1.0.sql". This file contains the SQL statements required to install or uninstall your extension.

```
$ touch myextension--1.0.sql
```

Open the "myextension--1.0.sql" file and add the following content:

```sql
-- myextension--1.0.sql
CREATE EXTENSION IF NOT EXISTS myextension;
```

You can add additional SQL statements as needed for your extension.

Step 4: Create the Makefile
Create a Makefile in the "myextension" directory. The Makefile defines the build process and provides targets for compilation and installation.

```
$ touch Makefile
```

Open the Makefile and add the following content:

```makefile
MODULE_big = myextension
OBJS = myextension.o

EXTENSION = myextension
DATA = myextension--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

In the Makefile, replace "myextension" with the name of your extension. If you have multiple source files, update the "OBJS" variable accordingly.

Step 5: Build and Install the Extension
To build and install the extension, run the following commands:

```
$ make
$ make install
```

This will compile the extension code and copy the necessary files to the appropriate PostgreSQL directories.

Step 6: Create the Extension in PostgreSQL
Connect to your PostgreSQL database and execute the following SQL statement to create the extension:

```sql
CREATE EXTENSION myextension;
```

Congratulations! You have created and installed a basic PostgreSQL extension.

Explanation:

- In Step 2, the "myextension.control" file defines the metadata of the extension. It includes the comment, default version, and the path to the shared library of the extension.

- In Step 3, the "myextension--1.0.sql" file contains the SQL statements required to install the extension. The CREATE EXTENSION statement creates the extension if it doesn't exist.

- In Step 4, the Makefile is used to define the build process. It specifies the module name, object files, extension name, and SQL files. The PG_CONFIG variable retrieves the path to the pg_config utility, which is used to get the necessary configuration for building the extension.

- In Step 5, the "make" command compiles the extension code using the Makefile, and the "make install" command copies the necessary files to the appropriate PostgreSQL directories.

- Finally, in Step 6, the CREATE EXTENSION statement is executed in PostgreSQL to create the extension.

## What is PGXS?

PGXS stands for "PostgreSQL Extension Building Infrastructure". It is a set of Makefiles and scripts that simplify the process of building and installing PostgreSQL extensions.

PGXS is designed to work with the `pg_config` command, which is used to determine the configuration options and file locations for your PostgreSQL installation. By using PGXS, you can avoid the need to manually specify these options in your Makefile.
## Do I Need PGXS?

If you're building a simple PostgreSQL extension that consists of just one or a few source files, you may be able to build it without using PGXS. However, for more complex extensions that include multiple files and dependencies, PGXS can make the process much easier.

In general, if you're building a PostgreSQL extension in C, you should consider using PGXS.
## How Does PGXS Work?

To use PGXS, you'll need to create a Makefile for your extension that includes the appropriate PGXS rules. Here's an example Makefile:

```make

MODULES = myext
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```



This Makefile defines a variable `MODULES` that lists the source file(s) for your extension (in this case, just `myext.c`), and uses the `pg_config` command to determine the location of the PostgreSQL installation and include the appropriate build rules.

The `include $(PGXS)` line is what actually includes the PGXS rules. This will define a number of Makefile variables and targets that you can use to build and install your extension.

Once you've created your Makefile, you can use the following commands to build and install your extension:

```shell

$ make
$ sudo make install
```



The `make` command will build your extension and create a shared library file (e.g. `myext.so`). The `sudo make install` command will install the shared library file in the appropriate location (e.g. `/usr/lib/postgresql/<version>/lib/myext.so`) and register your extension with PostgreSQL.

Once your extension is installed, you can use the `CREATE EXTENSION` command to load it into a database:

```sql

CREATE EXTENSION myext;
```

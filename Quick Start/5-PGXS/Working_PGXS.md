# Working of PGXS
PGXS (PostgreSQL Extension Building Infrastructure) provides a set of rules and macros that automate the compilation and installation of PostgreSQL extensions. To use PGXS to build your extension, follow these steps:

1.  Set up the Extension Directory Structure: Create a directory for your extension and organize the necessary files within it. The directory should typically include source code files, SQL script files, a control file, a Makefile, and any additional files required for the extension.
    
2.  Include PGXS Makefile: In your extension's Makefile, include the PGXS Makefile using the `include` directive. This will import the necessary rules and macros for building extensions.
    

```makefile
MODULES = my_extension
EXTENSION = my_extension
DATA = my_extension--1.0.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

3.  Define Extension-Specific Variables: Set the necessary variables in your Makefile to configure the build process for your extension. For example, `MODULES` should list the names of the C files containing the extension's code, `EXTENSION` should specify the name of the extension, and `DATA` should specify the SQL script file(s) that define the extension's objects and behaviors.
    
4.  Build the Extension: Run the `make` command to build the extension. PGXS will automatically compile the source code files, link against the required libraries, and generate the necessary object files and shared library for your extension.
    
5.  Install the Extension: Once the extension is built, run the `make install` command to install it into your PostgreSQL installation. This will copy the necessary files to the appropriate directories, ensuring that the extension is available for use within the database.

6.  Clean Up: To remove the build artifacts, you can run the `make clean` command. This will delete the generated object files, shared library, and other temporary files.

By following these steps and utilizing PGXS, you can automate the compilation and installation of your extension. PGXS handles the complexities of building extensions, such as managing dependencies, generating required files, and integrating with PostgreSQL's build system. This allows you to focus on developing the functionality of your extension while benefiting from the streamlined build process provided by PGXS.

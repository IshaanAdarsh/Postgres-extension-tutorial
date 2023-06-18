# Postgres Documentation:
The official PostgreSQL documentation does not specify a specific directory hierarchy for extension development. However, it provides recommendations and guidelines on organizing the files and directories within an extension.
 
According to the PostgreSQL documentation, the extension's files should be organized in a logical manner, making it easy to understand and maintain the codebase. 
- It suggests placing the SQL script files in a separate directory and using a consistent naming convention for those files. 
- It also recommends using a control file to provide metadata and configuration information about the extension.
- The documentation also mentions that the C source files for the extension should be organized in a way that aligns with the standard PostgreSQL extension building process, typically using the src/ directory and subdirectories for different modules or components.

It emphasizes the importance of clarity, maintainability, and adherence to PostgreSQL extension development practices. Therefore, you have the flexibility to choose a directory structure that best suits your extension's requirements while following the guidelines and recommendations outlined in the documentation.

# Proposed Changes:
When creating a directory structure for a PostgreSQL extension, there are various approaches you can take depending on the complexity and requirements of your extension. Here are three commonly used directory structures for PostgreSQL extensions:


## Basic Directory Structure: 
This structure is suitable for small, simple extensions that consist of a single file or a few related files.

```
my_extension/
├── my_extension.sql
└── my_extension.control

```

-   `my_extension.sql`: SQL script containing the extension's functionality.
-   `my_extension.control`: Control file specifying metadata and configuration for the extension.

This basic structure is language-agnostic and can be used with any programming language that supports PostgreSQL extensions. The SQL script can be written in the respective language's syntax.

## Standard Directory Structure: 
This structure follows a standard approach for organizing PostgreSQL extensions with separate directories for source code, SQL scripts, and additional resources.

```
cssmy_extension/
├── sql/
│   └── my_extension.sql
├── src/
│   ├── my_extension.c
│   └── my_extension.h
├── my_extension.control
└── README.md

```

-   `sql/`: Directory for SQL scripts.
-   `src/`: Directory for source code files.
-   `my_extension.c`: Extension's main source code file (C language).
-   `my_extension.h`: Header file for the extension (C language).
-   `my_extension.control`: Control file.
-   `README.md`: Readme file providing instructions and information about the extension.

This structure allows separation of code and SQL scripts, making it easier to maintain and organize the extension. The `src/` directory can contain language-specific files for different programming languages.

## Advanced Directory Structure: 
This structure is suitable for larger extensions with complex functionality and multiple language implementations.

```
cssmy_extension/
├── sql/
│   └── my_extension.sql
├── python/
│   ├── my_extension.py
│   └── setup.py
├── java/
│   ├── src/
│   │   └── com/
│   │       └── example/
│   │           └── MyExtension.java
│   ├── build.xml
│   └── README.md
├── c/
│   ├── src/
│   │   ├── my_extension.c
│   │   └── my_extension.h
│   ├── Makefile
│   └── README.md
├── my_extension.control
└── README.md

```

-   `sql/`: Directory for SQL scripts.
-   Language-specific directories (`python/`, `java/`, `c/`): Each contains source code files and necessary build or configuration files specific to that language.
-   `my_extension.control`: Control file.
-   `README.md`: Readme file providing instructions and information about the extension.

This advanced structure demonstrates the inclusion of multiple language implementations within the same extension. Each language directory contains its own set of source files and build/config files specific to that language.

   In this structure, additional directories are added to separate data files, configuration files, documentation, and other resources related to the extension. This helps keep the codebase organized and makes it easier to distribute and install the extension.
    
Remember that the choice of directory structure depends on the specific needs of your extension. It's important to keep the structure logical, maintainable, and consistent with PostgreSQL extension development practices.

Here are the existing extensions (pg\_stat\_statements, PostGIS, pgcrypto) categorized into three categories based on their directory hierarchy, ranging from basic to advanced:

1.  Basic:
    
    -   `pg_stat_statements`:
        
        ```lua
        pg_stat_statements/
        ├── pg_stat_statements--1.0.sql
        ├── pg_stat_statements.control
        └── README
        
        ```
        
        This extension follows a basic directory structure with the SQL script, control file, and a README file.
        
2.  Standard:
    
    -   `pgcrypto`:
        
        ```sql
        pgcrypto/
        ├── sql/
        │   └── pgcrypto--1.3.sql
        ├── src/
        │   ├── aes.c
        │   ├── md5.c
        │   └── ...
        ├── pgcrypto.control
        └── README.md
        
        ```
        
        The `pgcrypto` extension organizes its SQL scripts and source code files in separate directories, with the control file and a README file.
        
3.  Advanced:
    
    -   `PostGIS`:
        
        ```lua
        postgis/
        ├── doc/
        ├── postgis.control
        ├── postgis--3.1.0.sql
        ├── postgis--3.1.0--3.1.1.sql
        ├── postgis--3.1.1.sql
        ├── postgis--3.1.1--3.1.2.sql
        ├── postgis--3.1.2.sql
        ├── postgis--3.1.2--3.1.3.sql
        ├── postgis--3.1.3.sql
        ├── postgis--3.1.3--3.1.4.sql
        ├── postgis--3.1.4.sql
        ├── ...
        └── README.postgis
        
        ```
        
        The `PostGIS` extension has a more advanced directory structure with additional version-specific SQL scripts and a separate directory for documentation.
        

Please note that the above directory structures are simplified for demonstration purposes and may not include all the files and directories present in the actual extensions. The categorization is based on the relative complexity of the directory hierarchy compared to the other extensions.


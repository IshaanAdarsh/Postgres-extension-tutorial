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

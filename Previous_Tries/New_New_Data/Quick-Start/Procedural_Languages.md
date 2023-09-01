# Procedural Language:
Procedural Languages in PostgreSQL are programming languages that can be used to write stored procedures, user-defined functions, and triggers within the database. These languages extend the functionality of PostgreSQL by allowing developers to write custom code in languages other than SQL.

Procedural Languages offer several benefits:

1.  **Expanded Functionality**: By using procedural languages, developers can write complex logic and algorithms that go beyond the capabilities of SQL. Procedural languages provide features like loops, conditionals, exception handling, and advanced data manipulation, allowing for more powerful and flexible database programming.
    
2.  **Code Reusability**: Procedural languages allow developers to reuse existing code and libraries written in those languages. This enables integration with external systems, leveraging the vast ecosystem of libraries and frameworks available in popular programming languages.
    
3.  **Performance Optimization**: Procedural languages can provide performance optimizations by allowing developers to write highly optimized code in low-level languages like C or C++. This can be crucial for computationally intensive operations where performance is critical.
    
4.  **Domain-Specific Extensions**: Procedural languages enable the development of domain-specific extensions tailored to specific application needs. These extensions can encapsulate complex business logic, algorithms, or data processing routines, providing a higher level of abstraction and ease of use.
    
## Role of Procedural Language:
Procedural languages play a significant role in packaging and distributing PostgreSQL extensions. Here are some key aspects:

1.  **Language-specific Dependencies:** When packaging an extension, the procedural language used in the extension is an essential consideration. Different procedural languages may have their own dependencies, libraries, or runtime environments that need to be bundled with the extension. Including these language-specific dependencies ensures that the extension can be installed and executed correctly on different PostgreSQL installations.
    
2.  **Language Extension Modules:** Procedural languages are typically packaged as extension modules. These modules contain the necessary code and resources to support the language within PostgreSQL. When distributing an extension, the language extension module needs to be included and properly installed alongside the extension itself. This ensures that the procedural language is available and can be utilized by the extension's functions and stored procedures.
    
3.  **Language Registration:** During the distribution process, the procedural language needs to be registered with the PostgreSQL server. This registration step informs PostgreSQL that the language is available for use. The registration may involve executing specific SQL statements or utilizing PostgreSQL's extension infrastructure to register the language. By properly registering the procedural language, users can easily enable and utilize it within their PostgreSQL databases.
    
4.  **Compatibility and Portability:** Procedural languages can vary in terms of compatibility and portability across different PostgreSQL versions and platforms. When packaging and distributing an extension, it is crucial to ensure that the extension's procedural language is compatible with the targeted PostgreSQL versions and platforms. This may involve adapting the language code or providing alternative implementations to ensure broad compatibility and portability.
    
5.  **Documentation and Examples:** Packaging and distributing an extension involves providing comprehensive documentation and examples for the procedural language. This documentation should cover language-specific syntax, usage guidelines, best practices, and any extensions or libraries supported by the language. Including clear and concise examples helps users understand how to utilize the procedural language effectively within the context of the extension.
 
## Quick Start for Procedural Languages: 
The procedural language plays an important role in the packaging and distribution of PostgreSQL extensions. It allows you to encapsulate the logic and functionality of your extension within custom functions and stored procedures written in a specific procedural language. Here's a quick start on how procedural languages contribute to packaging and distributing PostgreSQL extensions:

1.  **Define Functionality:** Identify the specific functionality and operations that your extension provides. This could include data manipulation, complex calculations, specialized algorithms, or any other custom behavior.
    
2.  **Choose a Procedural Language:** Select a procedural language that best suits your extension's requirements and the programming skills of your team. PostgreSQL supports multiple procedural languages, such as PL/pgSQL, PL/Python, PL/Perl, PL/Java, and more.
    
3.  **Write Functions and Stored Procedures:** Use the chosen procedural language to write functions and stored procedures that implement the desired functionality. These functions will serve as the building blocks of your extension.
    
4.  **Package Functions and Stored Procedures:** Organize the functions and stored procedures into logical units or modules. This could be based on functionality, domain, or any other relevant criteria. Group related functions together to create a cohesive and modular extension structure.
    
5.  **Document Functions and Usage:** Provide comprehensive documentation for each function, including details about input parameters, return types, expected behavior, and usage examples. Clear documentation is essential for users to understand how to utilize your extension effectively.
    
6.  **Handle Dependencies:** If your extension relies on external libraries or modules, ensure that these dependencies are properly managed and documented. Provide instructions for installing and configuring any required dependencies to ensure smooth integration with your extension.
    
7.  **Include Procedural Language Installation:** In your extension's installation process, include the necessary steps to enable and install the required procedural language(s) if they are not already present in the target PostgreSQL instance. This ensures that the procedural language is available for executing your extension's functions and stored procedures.
    
8.  **Test and Validate:** Thoroughly test your extension to ensure that the functions and stored procedures work as intended and provide the expected results. Validate the behavior and performance of your extension across different scenarios and database configurations.
    
9.  **Create Distribution Package:** Package your extension along with any supporting files, documentation, and installation instructions into a distribution package. This package should be self-contained and easy to install in a PostgreSQL environment.
    
10.  **Publish and Distribute:** Make your extension available for distribution through various channels, such as PostgreSQL extension repositories, package managers, or your own website. Provide clear instructions for users to install, configure, and use your extension.

To use procedural language in a PostgreSQL extension, you need to define and implement the language handler functions and register the language with PostgreSQL. Here's an example using the popular procedural language PL/Python:

1.  **Define the Language Handler Functions**: Create a code file, let's say `plpythonu.c`, containing the implementation of the PL/Python language handler functions. These functions define how PostgreSQL interacts with the Python interpreter. Here's a simplified example:
    
    ```c
    #include "postgres.h"
    #include "fmgr.h"
    #include "plpython.h"
    
    PG_MODULE_MAGIC;
    
    /* Entry point when the language is trusted */
    void _PG_init(void);
    
    /* Entry point when the language is untrusted */
    void _PG_init(void) {
        /* Register the PL/Python language */
        if (!PLy_init())
            elog(ERROR, "could not initialize PL/Python");
    }
    ```
    
    This code sets up the initialization function `_PG_init`, which registers the PL/Python language with PostgreSQL.
    
2.  **Build and Install the Extension**: In the Makefile, add the necessary rules to build and install the extension. Ensure that the procedural language files (`plpythonu.c` in this case) are compiled and linked properly. Here's an example snippet:
    
    ```makefile
    MODULES = my_extension
    DATA = my_extension--1.0.sql
    DOCS = README.md
    
    PG_CONFIG = pg_config
    PGXS := $(shell $(PG_CONFIG) --pgxs)
    include $(PGXS)
    ```
    
    This Makefile snippet ensures that the procedural language files are included in the build process and installed correctly with the extension.
    
3.  **Register the Language in SQL Script**: In the SQL script file (`my_extension--1.0.sql`), include the necessary SQL statements to register the procedural language. Here's an example:
    
    ```sql
    CREATE OR REPLACE PROCEDURAL LANGUAGE 'plpythonu' HANDLER plpython_call_handler;
    ```
    
    This statement registers the PL/Python procedural language with the `plpython_call_handler` function as the handler.
    
4.  **Build and Install the Extension**: Use the Makefile to build and install the extension:
    
    ```bash
    $ make
    $ make install
    ```
    
    This compiles the code, builds the extension, and installs it in the appropriate PostgreSQL directories.
    
5.  **Create and Use Functions in the Procedural Language**: After the extension is installed, you can create functions using the procedural language in your database. For example, to create a PL/Python function:
    
    ```sql
    CREATE FUNCTION my_python_function() RETURNS text AS $$
    def my_python_function():
        return 'Hello, PL/Python!'
    $$ LANGUAGE plpythonu;
    ```
    
    This creates a function named `my_python_function` that returns a text value. The function is written in PL/Python.
    

Procedural Languages provide a powerful way to extend PostgreSQL and leverage the capabilities of other programming languages within the database. They enable developers to write custom code, reuse existing libraries, optimize performance, and build domain-specific extensions tailored to their application requirements.

## Enabling Procedural Language:
There are a few different ways to enable procedural languages in PostgreSQL. Here are the common methods:

1.  Using the `CREATE LANGUAGE` Command: The `CREATE LANGUAGE` command is the simplest way to enable a procedural language. You can execute this command in a PostgreSQL database to enable the desired language.

Example:

```sql
CREATE LANGUAGE plpythonu;
```

2.  Using the `psql` Command-Line Tool: You can also use the `psql` command-line tool to enable procedural languages. Start the `psql` tool and connect to the target database. Then, use the `\c` command to connect to the desired database and the `\q` command to exit the `psql` tool. The language will be enabled automatically.

Example:

```bash
psql -U <username> -d <database_name>
\c <database_name>
\q
```

3.  Modifying the `postgresql.conf` File: Another method is to modify the `postgresql.conf` configuration file. Locate the `shared_preload_libraries` parameter in the file and add the name of the procedural language you want to enable. Save the changes and restart the PostgreSQL service for the language to take effect.

Example:

```arduino
shared_preload_libraries = 'plpythonu'
```

4.  Using the `ALTER DATABASE` Command: If you want to enable a procedural language for a specific database, you can use the `ALTER DATABASE` command.

Example:

```sql
ALTER DATABASE <database_name> SET plpythonu;
```

These are the common ways to enable procedural languages in PostgreSQL. Choose the method that suits your requirements and access level to enable the desired language in your PostgreSQL database.

## Writing Functions and Stored Procedures: 
Functions and stored procedures are essential components of a PostgreSQL extension. They allow you to define custom behaviour and perform operations on the database data. Here's a quick start on how to write functions and stored procedures in PostgreSQL extensions:

1.  **Select a Procedural Language:** Choose a procedural language supported by PostgreSQL that best suits your needs, such as PL/pgSQL, PL/Python, PL/Perl, PL/Java, or others.
    
2.  **Define a Function:** Use the chosen procedural language to define a function. Functions in PostgreSQL are created using the `CREATE FUNCTION` statement. Specify the function name, input parameters, return type, and the function's body, which contains the logic to be executed.
    

Example (using PL/pgSQL):
```sql
CREATE FUNCTION get_employee_name(emp_id integer) RETURNS text AS $$
DECLARE
    employee_name text;
BEGIN
    SELECT name INTO employee_name FROM employees WHERE id = emp_id;
    RETURN employee_name;
END;
$$ LANGUAGE plpgsql;
```

3.  **Use Stored Procedures:** Stored procedures are similar to functions but don't have a return value. They are commonly used to perform actions or modify data in the database.

Example (using PL/pgSQL):
```sql
CREATE PROCEDURE update_employee_salary(emp_id integer, new_salary numeric) AS $$
BEGIN
    UPDATE employees SET salary = new_salary WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;
```

4.  **Interact with PostgreSQL Data:** Inside the function or stored procedure, you can interact with the PostgreSQL data using SQL statements. Use `SELECT`, `INSERT`, `UPDATE`, and `DELETE` statements to read or modify data as needed. You can also use variables, control structures (e.g., loops, conditionals), and exception handling to enhance the functionality of your functions and stored procedures.

Example:
```sql
CREATE FUNCTION get_employee_count() RETURNS integer AS $$
DECLARE
    count_emp integer;
BEGIN
    SELECT COUNT(*) INTO count_emp FROM employees;
    RETURN count_emp;
END;
$$ LANGUAGE plpgsql;
```

In this function, the `SELECT` statement retrieves the name of an employee with a specified ID and stores it in the `employee_name` variable. The variable is then returned as the result of the function.

# Supported Procedural Languages: 
PostgreSQL supports several procedural languages that can be used in extension creation. Here are some of the commonly used procedural languages:

1.  **PL/pgSQL**: PL/pgSQL is the default procedural language in PostgreSQL. It is similar to SQL and provides additional control structures, variables, and exception handling. PL/pgSQL is widely used for writing stored procedures, triggers, and functions.

2.  **PL/Python**: PL/Python allows you to write PostgreSQL functions and procedures in the Python programming language. It provides full access to Python's extensive libraries and ecosystem, making it a popular choice for complex data processing and analytics tasks.

3.  **PL/Perl**: PL/Perl enables writing PostgreSQL functions and triggers in the Perl programming language. It allows you to leverage Perl's powerful text manipulation, regular expressions, and database connectivity capabilities.

4.  **PL/Java**: PL/Java allows you to write functions and procedures in the Java programming language. It provides seamless integration with Java code and enables the use of Java libraries and frameworks within PostgreSQL.

5.  **PL/PHP**: PL/PHP enables writing PostgreSQL functions and triggers in the PHP programming language. It provides a convenient way to incorporate PHP code into the database and interact with external web services or perform complex data manipulations.

6.  **PL/Lua**: PL/Lua allows you to write PostgreSQL functions and triggers using the Lua scripting language. Lua is known for its lightweight and embeddable nature, making it suitable for scripting and extension development.

7.  **PL/R**: PL/R enables writing PostgreSQL functions and procedures using the R programming language. It provides access to R's powerful statistical and data analysis capabilities, making it a preferred choice for advanced analytics within the database.

8.  **PL/sh**: PL/sh allows you to write PostgreSQL functions and triggers using shell scripting languages like Bash or Perl. It provides flexibility in integrating with external systems, executing system commands, and performing system-level operations.

9.  **PL/JavaScript**: PL/JavaScript allows you to write PostgreSQL functions and procedures using JavaScript. It leverages the V8 JavaScript engine for efficient execution and enables the use of JavaScript libraries and frameworks within PostgreSQL.

10. **PL/Python3** (Python 3 version of PL/Python)

11. **PL/Proxy**

12. **PL/v8** (JavaScript with V8 engine)

14. **PL/Perl6**

15. **PL/nodes**

16. **PL/SQL** (Oracle-compatible PL/SQL dialect)

17. **PL/TSQL** (Transact-SQL dialect)

18. **PL/LSM** (Log-Structured Merge Trees)

19. **PL/Tcl**


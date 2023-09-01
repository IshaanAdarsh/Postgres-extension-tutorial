# External languages
It refers to languages that are not natively supported by the database but can be integrated and used within PostgreSQL through custom extensions. These languages are typically implemented as dynamically loadable libraries or interpreters and provide an interface for executing code within the PostgreSQL environment.

The use of external languages in PostgreSQL extensions offers the following benefits:

1.  **Language Flexibility:** External languages allow developers to extend PostgreSQL's capabilities by integrating additional programming languages that are not natively supported. This enables developers to leverage the features and libraries of their preferred programming language within PostgreSQL, opening up a wide range of possibilities for extending database functionality.
    
2.  **Code Reusability:** By integrating external languages, developers can reuse existing code written in their preferred programming language. They can leverage libraries, frameworks, and existing codebases to build complex functionality within their PostgreSQL extensions. This promotes code reuse, reduces development time, and allows developers to leverage their expertise in a familiar programming language.
    
3.  **Performance Optimization:** Certain programming languages may provide performance advantages for specific tasks or algorithms. By utilizing external languages, developers can write performance-critical code in a language that offers better execution speed or optimized libraries for specific computations. This can significantly improve the overall performance of the extension.
    
4.  **Ecosystem Integration:** External languages often have well-established ecosystems, including package managers, testing frameworks, and community support. By integrating these languages into PostgreSQL, developers can leverage the existing ecosystem and take advantage of community-contributed libraries, tools, and best practices. This promotes collaboration and accelerates development.
    

To use an external language in a PostgreSQL extension, the following steps are typically involved:

1.  **Implement the Language:** Develop the necessary code and functionality to support the external language within the extension. This may involve writing a custom interpreter, integrating a language runtime, or creating a bridge to an existing language implementation.
    
2.  **Define the Language in the Extension Control File:** In the extension's control file, specify the external language as a requirement and provide any additional information needed for integration, such as the library path or command to execute the language runtime.
    
3.  **Register the Language:** Use the `CREATE EXTENSION` command in PostgreSQL to install and register the extension that includes the external language. This ensures that PostgreSQL recognizes and enables the language for use.
    
4.  **Write Functions and Stored Procedures:** Utilize the external language within the extension to implement functions and stored procedures. Write the necessary code in the chosen external language to interact with PostgreSQL data, execute queries, or perform any desired operations.
    

Here's an example of using an external language, specifically Python, in a PostgreSQL extension:

1.  Implementing the Python Language:

```c
#include "postgres.h"
#include "fmgr.h"
#include "utils/elog.h"

PG_FUNCTION_INFO_V1(py_hello);

Datum py_hello(PG_FUNCTION_ARGS) {
    elog(INFO, "Hello from Python!");
    PG_RETURN_NULL();
}
```

2.  Extension Control File (example.control):

```bash
comment = 'Example extension with Python integration'
default_version = '1.0'
module_pathname = '$libdir/example'
relocatable = true

# Specify the requirement for the Python language
requires = 'plpython3u'
```

3.  SQL Script to Create the Function (example.sql):

```sql
CREATE OR REPLACE FUNCTION hello_from_python()
RETURNS void AS $$
    LANGUAGE plpython3u
    CODE 'py_hello()';
$$;
```

4.  Registration and Usage:

```sql
-- Install and enable the extension
CREATE EXTENSION example;

-- Call the Python function
SELECT hello_from_python();
```

In this example, the extension integrates the Python language (specified in the control file) and implements a simple function (`py_hello`) written in C that logs a message. The Python function (`hello_from_python`) is then defined using the `LANGUAGE plpython3u` clause, which executes the `py_hello` function.

By using external languages in PostgreSQL extensions, developers can extend the database's capabilities, leverage existing code, and integrate with different programming ecosystems, enhancing the flexibility and functionality of their extensions.

## Language Compatibility with Postgres:

PostgreSQL supports multiple programming languages for writing extensions, including SQL, PL/pgSQL, C, C++, Python, Perl, Ruby, and more. These languages are either built-in or can be added as extensions. Each language has its syntax and features, and developers can choose the language that best suits their requirements and familiarity.

### Using External Languages in Extensions:

To use external languages in PostgreSQL extensions, developers need to follow these general steps:

1.  **Install the Required Language Extension:** If the desired language is not built-in to PostgreSQL, it needs to be installed as an extension. For example, to use Python, the `plpython` extension needs to be installed.
    
2.  **Define the Language in the Extension Control File:** In the extension's control file (`example.control`), specify the required language as a dependency. This ensures that the language is available and enabled when the extension is installed.
    
3.  **Implement Functions or Stored Procedures in the Language:** Write the extension's functions or stored procedures in the chosen external language. Each language has its syntax and specific way of interacting with PostgreSQL. For example, in Python, you can use the `plpython` language to define Python functions that can be called from SQL statements.
    
4.  **Register and Install the Extension:** Use the `CREATE EXTENSION` command in PostgreSQL to register and install the extension, including the external language. This command will make the language available for use within the database.
    
## How to Call External Programs or Libraries from the Extension Code:

To call external programs or libraries from the extension code, you can use the following methods:

1.  **EXECUTE Command:** PostgreSQL's `EXECUTE` command allows executing dynamic SQL statements or arbitrary commands. You can use it to execute external programs or commands using the operating system shell. For example:
    
    ```sql
    EXECUTE '/path/to/external_program argument1 argument2';
    ```
    
    Note that using the `EXECUTE` command to execute external programs can introduce security risks and should be used with caution.
    
2.  **Language-Specific Libraries or Functions:** Some languages, like C or C++, provide interfaces or libraries that allow direct interaction with external programs or libraries. You can use these language-specific features to call external programs or invoke functionality from external libraries.
    
3.  **User-Defined Functions:** In some cases, you may need to write custom user-defined functions in the chosen language to interface with external programs or libraries. These functions can encapsulate the logic required to interact with the external components and can be called from within the extension code.
    
4.  **Language Extensions or Modules:** Many languages provide extensions or modules that facilitate calling external programs or libraries. For example, in Python, you can use libraries like `subprocess` or `os` to execute external commands or interact with the operating system.

It's important to note that calling external programs or libraries from within PostgreSQL extensions should be done carefully, considering security, performance, and maintainability aspects. Proper error handling, input validation, and security measures should be implemented to ensure the safety and reliability of the extension.

<!-- As many extension don't document this (its a real pain in the ass)
Only Specific to External Languages, a full section will be devoted to Packaging and Dependencies-->
## Packaging and Dependencies
When developing a PostgreSQL extension that uses external languages, packaging and handling dependencies become important considerations. Here are some key aspects to consider:

1.  **Packaging the Extension:**
    -   Include clear instructions in the extension documentation on any external language dependencies required by the extension.
    -   Specify the minimum supported version of the external language, if applicable.
    -   Provide guidelines on how to install and configure the required external language(s) before installing the extension.

2.  **Dependency Management:**
    -   Clearly document any additional dependencies beyond the external language(s) used, such as libraries, modules, or tools required by the extension.
    -   Specify the minimum required versions of these dependencies to ensure compatibility.
    -   Consider using a package manager or dependency management system to handle the installation and resolution of dependencies automatically.

3.  **Version Compatibility:**
    -   Test the extension with different versions of the external language(s) to ensure compatibility and provide guidelines for users regarding the supported versions.
    -   Document any known issues or limitations when using specific versions of the external language(s) with the extension.

4.  **Packaging Tools:**
    -   Utilize packaging tools such as PGXN (PostgreSQL Extension Network) or PGXS (PostgreSQL Extension Build Infrastructure) to package the extension along with its dependencies and external language components.
    -   These tools help streamline the packaging process, handle versioning, and provide a standardized structure for distributing the extension.

5.  **Installation and Configuration:**
    -   Clearly document the installation steps, including any specific configurations needed for the external language(s).
    -   Provide guidelines on how to enable and configure the external language(s) within PostgreSQL, such as setting up environment variables or enabling extensions.

By addressing packaging and dependency considerations, you can ensure that users can easily install and use your extension, even if it relies on external languages. Clear documentation, careful version management, and appropriate packaging tools will facilitate a smooth installation and usage experience for users of your PostgreSQL extension.

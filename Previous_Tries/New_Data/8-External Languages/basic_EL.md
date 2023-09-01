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

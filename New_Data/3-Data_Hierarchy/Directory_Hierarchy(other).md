# Directory structure for a PostgreSQL extension:
## Need of Code Directory and Code Hierarchy:

The need of a code director in extension building is to have a single point of control for the code. This allows for easier management and maintenance of the code, as well as improved collaboration between developers.
A code director can also help to improve the quality of the code by enforcing coding standards and best practices. Additionally, a code director can help to identify and fix bugs more quickly.
Overall, a code director can be a valuable asset to any team that is building a PostgreSQL extension.
Here are some of the benefits of using a code director for extension building:

-   Improved code quality: A code director can help to improve the quality of the code by enforcing coding standards and best practices. This can help to reduce the number of bugs and make the code more maintainable.
-   Improved collaboration: A code director can help to improve collaboration between developers by providing a central place to store and manage the code. This can help to ensure that everyone is working on the same version of the code and that changes are tracked and documented.
-   Easier management and maintenance: A code director can help to make it easier to manage and maintain the code. This can be done by providing features such as version control, bug tracking, and code reviews.
-   Improved security: A code director can help to improve the security of the code by providing features such as code scanning and vulnerability management.

## Type 1:
```
├── debian
│   ├── changelog
│   ├── control
│   ├── install
│   ├── rules
│   └── source
└── src
    ├── Makefile
    ├── myextension.h
    └── myextension.c
```

The `debian` directory contains the files that are needed to package the extension for Debian-based distributions. The `src` directory contains the C or C++ code for the extension. The `Makefile` is used to compile and build the extension.
The following is a brief description of the files in the `debian` directory:

-   `changelog`: This file contains the change log for the extension.
-   `control`: This file contains the control information for the extension, such as the name, version, and author.
-   `install`: This file contains the commands that are used to install the extension.
-   `rules`: This file contains the rules that are used to build the Debian package for the extension.
-   `source`: This directory contains the source code for the Debian package.

The following is a brief description of the file in the `src` directory:

-   `Makefile`: This is used to compile and link the code.
-   `myextension.c`: This file contains the C or C++ code for the extension.
-   `myextension.h`: This file contains the header file for the extension.

## Type 2:
```
├── control
│   └── myextension.control
├── data
│   └── myextension--1.0.sql
├── include
│   └── myextension.h
└── src
    └── myextension.c
```

- The `control` directory contains the control file for the extension. The control file is a text file that tells PostgreSQL about the extension. The control file must have the extension name, the extension version, and the extension author. The control file must also have a list of the functions and data types that are provided by the extension.
- The `data` directory contains the SQL data file for the extension. The SQL data file is a text file that contains the SQL statements that are needed to create the objects that are used by the extension. This may include tables, functions, procedures, and views.
- The `include` directory contains the header file for the extension. The header file is a C or C++ header file that contains the declarations for the functions and data types that are provided by the extension.
- The `src` directory contains the source code for the extension. The source code is the actual code that implements the functions and data types that are provided by the extension.

## Type 3:
```
* /
    * debian
        * changelog
        * control
        * rules
    * doc
        * README.md
        * INSTALL
        * TODO
    * src
        * myextension.c
        * myextension.h
        * Makefile
```

The `debian` directory contains the files that are needed to package the extension for Debian-based distributions. The `doc` directory contains the documentation for the extension. The `src` directory contains the C or C++ code for the extension. The `Makefile` is used to compile and install the extension.
The `myextension.c` file contains the main code for the extension. The `myextension.h` file contains the header file for the extension. The `Makefile` contains the build instructions for the extension.

The following is a brief description of each file:

-   `debian/changelog`: This file contains the changelog for the extension.
-   `debian/control`: This file contains the control information for the extension, such as the name, version, and description.
-   `debian/rules`: This file contains the build rules for the extension.
-   `README.md`: This file contains the README for the extension.
-   `INSTALL`: This file contains the installation instructions for the extension.
-   `TODO`: This file contains the TODO list for the extension.
-   `myextension.c`: This file contains the main code for the extension.
-   `myextension.h`: This file contains the header file for the extension.
-   `Makefile`: This file contains the build instructions for the extension.


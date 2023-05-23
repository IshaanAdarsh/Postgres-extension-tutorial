# Tutorial Contents: 

### Prerequisites for writing an extension:
- Understanding the Postgres extension architecture and how it works
- Explain what a Postgres extension is and its purpose.
- Highlight the benefits of creating extensions for Postgres
- Provide a list of software and tools required for developing a Postgres extension.
  - Sql Script File, Makefile, Control File, etc.
- Ensure that Postgres and the necessary development libraries are installed and properly set up.
- Specify the supported target languages and their corresponding development environments.
  - C,C++,Python,Java,Ruby,JavaScript (PLV8),Perl,PHP,.NET,etc.

### How to start writing an extension:
- Defining a Directory structure for a PostgreSQL extension
  - Type 1, 2, 3
- Highlight the important files and directories involved in the extension development process.
- Providing the MVP (Minimum Viable Product) tutorial
  - MVP = SQL Script File + Control File
  - Loading extension into the database using the CREATE EXTENSION command
- Explain the typical workflow for creating, compiling, installing, and using an extension.

### How to write a Makefile and what it should do:
- Define Variables
  - `PG_CONFIG`
  - `EXTENSION`
  - `DATA`
  - `MODULES
- Specify Build Targets
  - `all`
  - `install`
  - `clean`
  - `uninstall`
- Define Compilation Rules and Specify Installation Rules
- Handle Dependencies and Provide Additional Functionality

### PGXS:
- Define PGXS and Benefits of PGXS (How it simplifies Extension Building)
- How PGXS Works (How to use PGXS to automate the compilation and installation of the extension)
- Makefile Configuration with PGXS
- Build Commands with PGXS
  - `make`
  - `make install`
  - `make clean`

### PGXN:
- Define PGXN and Benefits of PGXN (Collaboration and Community Support)
  - Centralized Repository
  - Helps in Versioning and Distribution
  - Quality Control
- How PGXN Works (How to set up and use PGXN to publish and distribute the extension to other users)
- Using PGXN for Extension Installation

### Procedural Languages:
- List Supported Procedural Languages like PL/pgSQL, PL/Python, PL/Perl, PL/Tcl, PL/Java, PL/PHP
- Enabling Procedural Languages (using `CREATE LANGUAGE` command)
- Writing Functions and Stored Procedures
- Using Procedural Language Functions in Extensions
- Interaction with PostgreSQL Data
- Role of Procedural Language in Packaging and Distribution

### External Languages:
- Language Compatibility with Postgres
- Language-Specific Libraries and APIs
- Language Bindings or Extensions
- Using External Languages in Extensions
  - How to call external programs or libraries from the extension code using the EXECUTE command or other methods
- Security Considerations
- Packaging and Dependencies

### How to write regression tests for the extension:

-   Extension release management and upgradability

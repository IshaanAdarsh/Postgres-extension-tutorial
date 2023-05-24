# Tutorial Contents: 

## Definitions and Basic Code:
### Prerequisites for writing an extension:
- Understanding the Postgres extension architecture and how it works
- Explain what a Postgres extension is and its purpose.
- Highlight the benefits of creating extensions for Postgres

- Ensure that Postgres and the necessary development libraries are installed and properly set up.
- Specify the supported target languages and their corresponding development environments.
  - C,C++,Python,Java,Ruby,JavaScript (PLV8),Perl,PHP,.NET,etc.

### Anatomy of a PostgreSQL Extension:
- Provide a list of software and tools required for developing a functioning Postgres extension and define thier use in the extension ecosystem.
  - Sql Script File
  - Makefile
  - Control File
  - Code File

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
- Test Case Selection
  - Identify the key functionalities and use cases
- Test Environment Setup
- Test Fixture and Data Preparation
  - Consider using a fixture management tool or scripting language to automate the setup and teardown process for test data.
- Test Framework Selection: Test case management, assertions, and result reporting
  - pgTAP
  - pg_regress
  - custom frameworks built using languages like Python or Perl
- Test Case Definition
  - Use the testing framework's provided APIs
- Test Execution and Reporting
- Test Coverage and Maintenance
- Handling errors and debugging

### Extension release management and upgradability:
- Versioning Scheme 
  -  Semantic Versioning (SemVer)
- Release Documentation
- Release Testing
- Compatibility Consideration
- Backward Compatibility
- Upgradability Testing
- Continuous Integration and Deployment
  - Utilize a continuous integration (CI) system to automate the build, testing, and deployment of your extension.
- Release Channels and Notifications
- User Feedback and Issue Tracking

### Best Practices and Advanced Topics
- Optimizing extension performance
- Integration with other PostgreSQL features (e.g., foreign data wrappers, event triggers)
- Documentation, support, and community engagement for the extension

## Sample Extensions:
- Make sample extension with basic code as examples, as a part of the introduction to Extensions:
  - SQL
  - Python
  - Java
  - Javascript

## Links and further edu:
- Provide a curated list of external resources, such as official documentation, relevant blog posts, tutorials, and community forums, for further learning and support.

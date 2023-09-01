# Postgres Extension Tutorial

Welcome to the Postgres Extension Tutorial. This comprehensive tutorial is designed to provide a step-by-step guide to PostgreSQL extension development. Whether you're new to PostgreSQL or extension development, this tutorial assumes only a basic knowledge of Postgres and the target programming language. It covers various aspects of creating, managing, and distributing extensions for PostgreSQL.

After completing this tutorial, you'll have a strong foundation in PostgreSQL extension development, and you can explore advanced topics in PostgreSQL or contribute to the extension ecosystem.

## Table of Contents

### Part I: Getting Started

1.1) **Basic Extension Components**
   - Understanding the core files required for an extension:
     - Control file
     - SQL script file
     - Makefile

### Part II: Building Your First Extension / Quick Start

2.1) **Creating the Extension Directory**
   - Setting up the directory structure for your extension.

2.2) **Writing the Control File**
   - Defining metadata and dependencies for your extension.

2.3) **Creating the Extension SQL File**
   - Designing and writing SQL scripts for your extension.

2.4) **Crafting the Makefile**
   - Configuring the build process for your extension.

2.5) **Building and Installing the Extension**
   - Compiling and installing your extension into PostgreSQL.

### Part III: Using Your Extension

3.1) **Creating the Extension in PostgreSQL**
   - Enabling your extension in a PostgreSQL database.

3.2) **Implementing the Extension**
    - Utilizing the functionality provided by your extension.

### Part IV: Regression Testing

4.1) **Introduction to Regression Testing**
    - Understanding the importance of testing.

4.2) **Creating Regression Test Scripts**
    - Writing tests to ensure your extension functions correctly.

4.3) **Running Regression Tests**
    - Executing tests to validate your extension's behavior.

### Part V: Extension Upgradability

5.1) **Updating Your Extension**
    - Modifying and upgrading your extension.
    - Using `ALTER EXTENSION` and `DROP EXTENSION` methods.
  
### Part VI: Extension Management and Distribution

6.1) **Documentation and README.md**
    - Crafting informative documentation for your extension.
    - Creating a README.md file.

6.2) **Changelog and Versioning**
    - Managing changes and versions of your extension.

6.3) **Extension Distribution**
    - Making your extension accessible to others.
    - Using PGXN and package managers.

### Part VII: Advanced Topics

7.1) **Procedural Languages for Extension Creation**
    - Incorporating procedural languages into your extension.
      - Using PL/pgSQL
      - Using PL/Python

7.2) **External Languages for Extension Creation**
    - Extending PostgreSQL with external programming language C.

7.3) **Extending PostgreSQL with `pg_sample_ext`**
    - A practical guide to creating extensions with examples.
      - Creating a Custom Function
      - Creating and using Custom Data Types
         - Using `CREATE TYPE`
         - Using `CREATE DOMAIN`
      - Creating and using Custom Postgres Operators

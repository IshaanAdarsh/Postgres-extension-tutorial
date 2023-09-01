# Postgres Extension Tutorial

Welcome to the Postgres Extension Tutorial. This comprehensive tutorial is designed to provide a step-by-step guide to PostgreSQL extension development. Whether you're new to PostgreSQL or extension development, this tutorial assumes only a basic knowledge of Postgres and the target programming language. It covers various aspects of creating, managing, and distributing extensions for PostgreSQL.

After completing this tutorial, you'll have a strong foundation in PostgreSQL extension development, and you can explore advanced topics in PostgreSQL or contribute to the extension ecosystem.

## Table of Contents

### Part I: Getting Started

1.1. **Basic Extension Components**
   - Understanding the core files required for an extension:
     - Control file
     - SQL script file
     - Makefile

### Part II: Building Your First Extension / Quick Start

2.1. **Creating the Extension Directory**

2.2. **Writing the Control File**

2.3. **Creating the Extension SQL File**

2.4. **Writing the Makefile**

2.5. **Building and Installing the Extension**

2.6. **Creating and Implementing the Extension in PostgreSQL**

### Part III: Regression Testing

3.1. **Introduction to Regression Testing**

3.2. **Creating Regression Test Scripts**

3.3. **Running Regression Tests**

### Part IV: Extension Upgradability

5.1. **Updating Your Extension**
    - 5.1.1. **`ALTER EXTENSION` method**
    - 5.1.2. **`DROP EXTENSION` method**
  
### Part VI: Extension Management and Distribution

6.1. **Documentation and README.md**

6.2. **Changelog and Versioning**

6.3. **Extension Distribution**
    - 6.3.1. **Using PGXN** 
    - 6.3.2. **Using package managers**

### Part VII: Advanced Topics

7.1. **Procedural Languages for Extension Creation**
      - 7.1.1. **Using PL/pgSQL**
      - 7.1.2. **Using PL/Python**

7.2. **External Languages for Extension Creation**
    - 7.2.1. **Using C(External Language) to extend Postgres**

7.3. **Extending PostgreSQL with `pg_sample_ext`**
    - 7.3.1. **Creating a Custom Function**
      - 7.3.2. **Creating and using Custom Data Types**
         - 7.3.2.1. **Using `CREATE TYPE`**
         - 7.3.2.2. **Using `CREATE DOMAIN`**
      - 7.3.3. **Creating and using Custom Postgres Operators**

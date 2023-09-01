# Postgres Extension Tutorial

Welcome to the Postgres Extension Tutorial. This comprehensive tutorial is designed to provide a step-by-step guide to PostgreSQL extension development. Whether you're new to PostgreSQL or extension development, this tutorial assumes only a basic knowledge of Postgres and the target programming language. It covers various aspects of creating, managing, and distributing extensions for PostgreSQL.

After completing this tutorial, you'll have a strong foundation in PostgreSQL extension development, and you can explore advanced topics in PostgreSQL or contribute to the extension ecosystem.

## Table of Contents

### Part I: Getting Started
- [1.1. **Introduction to PostgreSQL Extensions**](https://www.postgresql.org/docs/current/extend.html)
- [1.2. **Setting Up Your Environment**](https://www.postgresql.org/docs/current/tutorial-install.html)
- [1.3. **Basic Extension Components**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#minimum-viable-product)

### [Part II: Building Your First Extension / Quick Start](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#a-postgres-extension-using-only-a-control-file-an-sql-file-and-a-makefile)
- [2.1. **Creating the Extension Directory**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-1-create-the-extension-directory)
- [2.2. **Writing the Control File**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-2-create-the-extension-control-file)
- [2.3. **Creating the Extension SQL File**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-3-create-the-extension-sql-file)
- [2.4. **Writing the Makefile**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-4-create-the-makefile)
- [2.5. **Building and Installing the Extension**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-5-build-and-install-the-extension)
- [2.6. **Creating and Implementing the Extension in PostgreSQL**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-6-create-the-extension-in-postgresql)

### [Part III: Regression Testing](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#regression-testing)
- [3.1. **Introduction to Regression Testing**](https://www.postgresql.org/docs/current/regress.html)
- [3.2. **Creating Regression Test Scripts**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-1-create-the-extension-subdirectory-for-test-sql-files)
- [3.3. **Running Regression Tests**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#step-4-run-make-installcheck)

### [Part IV: Extension Upgradability](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#extension-upgradability)
- [5.1. **Updating Your Extension**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#extension-upgradability)
  - [5.1.1. **`ALTER EXTENSION` method**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#updating-the-extension-using-the-alter-extension-command)
  - [5.1.2. **`DROP EXTENSION` method**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#drop-extension-and-create-extension-method-of-upgrading-extensions)
  
### [Part VI: Extension Management](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#extension-management) 
- [6.1. **README.md**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#readmemd)
- [6.2. **docfile**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#docfile)
- [6.3. **Changelog and Versioning**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#changelog)

### [Part VII: Extension Distribution](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#extension-distribution)
- [7.1. **Using PGXN**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#1-pgxn-postgresql-extension-network)
- [7.2. **Using package managers**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#2-package-managers)

### [Part VIII: Advanced Topics](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Main.md#advanced-topics)

- [8.1. **Procedural Languages for Extension Creation**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Procedural-language.md#procedural-languages)
  - [8.1.1. **Using PL/pgSQL**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Procedural-language.md#quick-start-creating-a-postgres-extension-using-plpgsql)
  - [8.1.2. **Using PL/Python**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Procedural-language.md#quick-start-creating-a-postgres-extension-using-plpython)

- [8.2. **External Languages for Extension Creation**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/External-language.md#external-languages-in-postgresql)
  - [8.2.1. **Using C(External Language) to extend Postgres**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/External-language.md#quick-start-creating-a-postgresql-extension-using-c-as-an-external-language)

- [8.3. **Extending PostgreSQL with `pg_sample_ext`**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#extending-postgres-with-pg_sample_ext)
  - [8.3.1. **Creating a Custom Function**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#function)
  - [8.3.2. **Creating and using Custom Data Types**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#custom-data-type)
      - [8.3.2.1. **Using `CREATE TYPE`**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#1-create-type-statement)
      - [8.3.2.2. **Using `CREATE DOMAIN`**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#2-create-domain-statement)
  - [8.3.3. **Creating and using Custom Postgres Operators**](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/SGML/Sample-Ext.md#custom-postgres-operators)

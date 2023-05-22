To create a PostgreSQL extension, you need at least two files:

-   A control file, which tells PostgreSQL some basic information about the extension, such as its name, version, and schema.
-   A SQL script file, which contains the SQL commands to create the extension's objects.

## A Postgres extension using only a control file and an SQL file:

### Step 1: Define the Extension Control File (my_extension.control) 

-   Create a new text file named `extension_name.control`.
-   Open the file in a text editor.
-   Add the following lines to the control file:

```control
# my_extension.control

comment = 'My Extension'
default_version = '1.0'
module_pathname = '$libdir/my_extension'
relocatable = true

# Installation script for version 1.0
# 1.0
# my_extension--1.0.sql
```

<!-- Error: To resolve the error "extension 'my_extension' has no installation script nor update path for version '1.0'", you can follow these steps and use the provided code as an example:
 - Open the control file (my_extension.control) associated with your extension.
 - Update the control file to include the installation script and update path for version '1.0'. 
  - Replace `my_extension` with the actual name of your extension.
  - Provide a brief description of your extension in the comment field.
Old Code:
```control
comment = 'Description of your extension'
default_version = '1.0'
module_pathname = '$libdir/extension_name'
relocatable = true
```
-->


<!--Error: The syntax error in line 9 of your control file seems to be caused by the incorrect use of the double-dash (`--`) comment syntax. In the control file, comments should be preceded by a hash (`#`) symbol, not double-dashes.
Old Code:
```control
# my_extension.control

comment = 'My Extension'
default_version = '1.0'
module_pathname = '$libdir/my_extension'
relocatable = true

# Installation script for version 1.0
--1.0
-- my_extension--1.0.sql
```
-->


### Step 2: Define the Extension SQL File (my_extension--1.0.sql)

-   Create another text file named `my_extension--1.0.sql`.
-   Open the file in a text editor.
-   Add SQL statements to define the objects and functionality of your extension.
-   For example, you can include CREATE TABLE, CREATE FUNCTION, or any other SQL statements specific to your extension.

an example of how you can define the Extension SQL File (`extension_name.sql`):

```sql
-- my_extension--1.0.sql

-- Create necessary objects for version 1.0
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE FUNCTION my_function() RETURNS void AS $$
BEGIN
  -- Function logic goes here
END;
$$ LANGUAGE plpgsql;
```
-   Save the SQL file.

### Step 3: Create the Extension

-   Open a terminal or command prompt.
-   Navigate to the directory where you saved the control and SQL files.
To find the `libdir` directory where PostgreSQL looks for extension libraries, you can use the `pg_config` utility provided with your PostgreSQL installation.

1.  Open a terminal or command prompt.
    
2.  Run the following command to display the `libdir` value:
    ```bash
    pg_config --libdir
    ```
    This command will print the absolute path to the `lib` directory.
    

The `libdir` value obtained from `pg_config` can be used in your extension's control file to specify the correct directory for the shared library installation.

### Step 4: Start the PostgreSQL Command Line Interface (CLI)

-   Run the `psql` command to start the PostgreSQL CLI.
-   Provide the necessary credentials to connect to your PostgreSQL database.

### Step 5: Create the Extension

-   Run the following command in the PostgreSQL CLI:

```sql
CREATE EXTENSION my_extension;
```
<img width="584" alt="Screenshot 2023-05-21 at 5 34 26 PM" src="https://github.com/IshaanAdarsh/Postgres-extension-tutorial/assets/100434702/370b2c64-6f29-480b-b1de-7219a0981c18">


-   Replace `my_extension` with the actual name of your extension.

### Step 6: Verify the Extension

-   Run the following command to see a list of installed extensions:

```sql
SELECT * FROM pg_extension;
```
or
```sql
\dx
```
<img width="583" alt="Screenshot 2023-05-21 at 5 34 14 PM" src="https://github.com/IshaanAdarsh/Postgres-extension-tutorial/assets/100434702/59b4259e-c8e8-4e91-832f-83bbfc555808">


-   Verify that your extension is listed among the installed extensions.

### Step 7: Test the Extension

-   Run SQL queries or commands to test the functionality of your extension.
-   Use the objects and features defined in the SQL file to perform desired operations.

```sql
-- regress.sql

-- Create a sample table
CREATE TABLE test_table (
    id serial PRIMARY KEY,
    name text
);

-- Test the uppercase function
INSERT INTO test_table (name) VALUES ('hello');
SELECT name, uppercase(name) FROM test_table;
-- The expected result should be 'HELLO' for the name column

-- Cleanup
DROP TABLE test_table;
```

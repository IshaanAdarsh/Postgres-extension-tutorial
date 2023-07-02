## PGXN (PostgreSQL Extension Network):  
### Uploading the Extension on PGXN:
- It is a collaborative platform and centralized repository for PostgreSQL extensions. It provides a platform for developers to share, distribute, and collaborate on PostgreSQL extensions, enhancing the overall ecosystem and community support for PostgreSQL. 

To set up and use PGXN to publish and distribute your extension to other users, you can follow these steps: 

1.  **Set up a PGXN Account:** Visit the PGXN website (<https://pgxn.org/>) and create an account. This will allow you to manage your extensions and publish them on the PGXN repository. 

2.  **Prepare Your Extension:** Ensure that your extension is properly developed, tested, and ready for distribution. Make sure you have a well-documented README file, SQL scripts, and any necessary code files or dependencies. 

3.  **Create a PGXN Metadata File:** PGXN requires a metadata file that provides information about your extension. Create a file named `META.json` that includes details such as the extension name, version, author, description, dependencies, and other relevant information. Refer to the PGXN documentation for the required format and fields. 

#### Code for META.json file for my_extension:
```json
{
  "name": "my_extension",
  "abstract": "A basic PostgreSQL extension.",
  "version": "1.0.0",
  "maintainer": "Ishaan Adarsh <ishaanad9@gmail.com>",
  "license": "postgresql",
  "provides": {
    "my_extension": {
      "file": "my_extension--1.0.sql",
      "version": "1.0.0"
    }
  },
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}

```

#### README.md:
- Include a README file in your extension's repository that provides an overview of the extension, installation instructions, and basic usage examples. The README file serves as the starting point for users to understand your extension and its features. Here's an example structure for a README file:

```markdown
   # My Extension

   A brief description of your extension.

   ## Installation

   Steps to install the extension.

   ## Configuration

   Configuration options and their explanations.

   ## Usage

   Instructions on how to use the extension with code examples.

   ## Upgrading

   Notes on upgrading to a new version and any migration steps required.
```

4.  **Build a Distribution Package:** Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

5.  **Publish Your Extension:** Use the PGXN command-line tool or web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

### Updating an Extension on PGXN:
#### New Directory Hierarchy:
```
my_extension/
├── changes
├── META.json
├── README.md
├── my_extension--1.0.0.sql
├── my_extension--1.0.1.sql
├── expected/
│   └── my_extension--regress.out
├── sql/
│   └── my_extension--regress.sql
├── my_extension.control
├── results/
│   └── my_extension--regress.out
└── Makefile
```

#### Step 1: Update the Extension Control File:
- Open the "my_extension.control" file and update the following content:

```control
# my_extension.control
comment = 'Minimal Viable Product'
default_version = '1.0.1'
relocatable = true
```

#### Step 2: Create the new Extension SQL File:

- Create a file named `my_extension--1.0.1.sql`.

  - This file contains the new SQL statements for the extension.
  - The format for a PostgreSQL extension file name is `extension_name--version.sql`, where `extension_name` is the name of the extension, and `version` is the version number. The double-dash serves as a delimiter to indicate the separation between the extension name and the version number.

```bash
$ touch my_extension--1.0.1.sql
```

- Open the `my_extension--1.0.1.sql` file and add the following content:
  - The `complex_add` is a new function named complex_add that takes an array of integers as input. Inside the function, we use the unnest function to expand the array into individual elements and then calculate the sum using the SUM function. The result is returned as an integer.

```sql
-- Update path script for version 1.0.1
-- Create necessary objects for version 1.0.1
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Add 2 numbers using add function
CREATE FUNCTION add(a integer, b integer) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    RETURN a + b;

CREATE FUNCTION complex_add(integer[]) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    AS $$
        SELECT COALESCE(SUM(val), 0)
        FROM unnest($1) AS t(val)
    $$
;
```
### Step 3: Update the Makefile:

- In the given code, the changes made to the `Makefile` are related to the updated value of the `DATA` variable.

```makefile
EXTENSION = my_extension
DATA = my_extension--1.0.1.sql
REGRESS = my_extension--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

## Implementation of the Extension:
Once you have successfully implemented the `my_extension` in your PostgreSQL database, you can use the new funtion as follows:

### 1. Use the complex_add function to perform complex addition:
  ```sql
  SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);
  ```
#### Output:
```
 complex_add
-------------
          15
(1 row)
```

### Step 4: Update the Regression File:
-  Update the `my_extension--regress.sql` file to include the test for the new `complex_add function`
```sql
-- regression test script for my_extension

-- Create the extension
CREATE EXTENSION my_extension;

-- Verify the data in the my_table table
SELECT * FROM my_table;

-- Test the add function
SELECT add(1, 2) AS result;

-- Test the complex_add function
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]) AS result;
```

### Step 5: Run the `make installcheck`:
- After running a successful `make installcheck` command the output of the test will be:

```out
-- regression test script for my_extension
-- Create the extension
CREATE EXTENSION my_extension;
-- Verify the data in the my_table table
SELECT * FROM my_table;
 id | name 
----+------
(0 rows)

-- Test the add function
SELECT add(1, 2) AS result;
 result 
--------
      3
(1 row)

-- Test the complex_add function
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]) AS result;
 result 
--------
     15
(1 row)
```

### Step 6: Create a change file:
- A changelog is a file that provides a comprehensive and organized list of changes, enhancements, and bug fixes for each release of your PostgreSQL extension. It serves as a communication tool between you and the users, helping them understand the modifications made and the impact they may have on their existing installations. 

- Contents for the my_extension changelog:
```change
# Changelog for my_extension

## Version 1.0.1
- New Function: complex_add
  - Description: Added a new function called complex_add.
  - Usage: complex_add takes an array of integers as input and returns their sum.
  - Example: SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);

## Version 1.0.0
- Initial release of my_extension.
- Implemented basic functionality for data management and operations.
```

### Step 7: Update the `META.json`:
- Update the version number in the META.json file to "1.0.1" and ensure that all other information, such as the abstract, description, and maintainer, is accurate and up to date.

```json 
{
  "name": "my_extension",
  "abstract": "A Basic PostgreSQL extension",
  "description": "my_extension is a PostgreSQL extension that provides additional functionality for data management and operations.",
  "version": "1.0.1",
  "maintainer": [
    "Ishaan Adarsh <ishaanad9@gmail.com>"
  ],
  "license": "postgresql",
  "provides": {
    "my_extension": {
      "file": "my_extension--1.0.1.sql",
      "version": "1.0.1" 
    }
  },
  "generated_by": "Ishaan Adarsh",
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}
```
> The `meta-spec` must be version `1.0.0`.  That's referring to the version of the JSON specification, NOT your module version.  `1.0.0` is the only spec that exists.

### Step 8: Build a Distribution Package for the updated version:
- Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

### Step 9: Publish Your Upgraded Extension:
- Use the PGXN command-line tool or web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

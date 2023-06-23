A step-by-step tutorial on creating a sample PostgreSQL extension using JavaScript. This tutorial assumes you have a basic understanding of PostgreSQL and JavaScript.

Step 1: Set up your development environment
---------------------------------------------
1. Install PostgreSQL: Download and install PostgreSQL on your machine if you haven't already. Make sure it's properly configured and running.

2. Install Node.js: Install Node.js, which will allow us to write JavaScript code. You can download and install Node.js from the official website (https://nodejs.org).

Step 2: Create the extension structure
-------------------------------------
1. Create a new directory for your extension. Let's name it "sample_extension".

2. Inside the "sample_extension" directory, create the following files:
   - `sample_extension.js`: This will contain your JavaScript code.
   - `Makefile`: This file will help us build and install the extension.
   - `sample_extension.control`: This control file defines metadata for the extension.
   - `sample_extension.sql`: This SQL file will define the functions and objects provided by the extension.

Step 3: Write the JavaScript code
-------------------------------
Open the `sample_extension.js` file and add the following code:

```javascript
'use strict';

const { Client } = require('pg');

// Define the function that will be exposed by the extension
function getHelloWorld() {
  return 'Hello, World!';
}

// Register the function as a PostgreSQL extension
function registerExtension() {
  const client = new Client();
  client.connect();

  const query = `
    CREATE OR REPLACE FUNCTION hello_world()
    RETURNS TEXT
    AS $$
    BEGIN
      RETURN getHelloWorld();
    END;
    $$
    LANGUAGE plpgsql;
  `;

  client.query(query, (err, result) => {
    if (err) {
      console.error('Error creating function:', err);
    } else {
      console.log('Function created successfully!');
    }

    client.end();
  });
}

registerExtension();
```

The code above defines a simple JavaScript function `getHelloWorld()` that returns the string "Hello, World!". It also includes a function `registerExtension()` that connects to the PostgreSQL database, creates a new function `hello_world()`, and associates it with the `getHelloWorld()` JavaScript function.

Step 4: Create the control file
------------------------------
Open the `sample_extension.control` file and add the following content:

```
# sample_extension.control
comment = 'Sample PostgreSQL Extension'
default_version = '1.0'
module_pathname = '$libdir/sample_extension'
```

This control file provides metadata for the extension, including a comment, the default version, and the path to the JavaScript code file.

Step 5: Create the SQL file
---------------------------
Open the `sample_extension.sql` file and add the following content:

```sql
-- sample_extension.sql
CREATE EXTENSION IF NOT EXISTS plv8;

-- Load the JavaScript code and register the extension
CREATE OR REPLACE FUNCTION load_sample_extension()
  RETURNS void AS $$
  BEGIN
    load '$libdir/sample_extension';
  END;
  $$
  LANGUAGE plpgsql;

-- Call the function to load and register the extension
SELECT load_sample_extension();
```

In this SQL file, we first ensure that the `plv8` extension (which allows executing JavaScript code) is installed. Then, we define a function `load_sample_extension()` that loads the `sample_extension.js` file using the `load` function provided by `plv8`. Finally, we call the `load_sample_extension()` function to load and register the extension.

Step 6: Update the Makefile
---------------------------
Open the `Makefile` and update it with the following content:

```Makefile
EXT

ENSION = sample_extension
DATA = sample_extension--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

This Makefile sets the `EXTENSION` variable to "sample_extension" and specifies the SQL file to be installed (`sample_extension--1.0.sql`). It also includes the necessary PostgreSQL configuration.

Step 7: Build and install the extension
--------------------------------------
1. Open your terminal and navigate to the directory containing your extension files (`sample_extension`).

2. Run the following command to build the extension:

   ```
   make
   ```

   This command will compile the extension and generate the necessary object files.

3. Run the following command to install the extension:

   ```
   make install
   ```

   This command will copy the extension files to the appropriate PostgreSQL directories.

Step 8: Test the extension
-------------------------
1. Open a PostgreSQL client (e.g., `psql`) connected to your database.

2. Run the following command to load the extension:

   ```sql
   LOAD 'sample_extension';
   ```

   This command will load and register the extension in the current database.

3. Run the following command to test the extension function:

   ```sql
   SELECT hello_world();
   ```

   If everything is set up correctly, it should return the string "Hello, World!".

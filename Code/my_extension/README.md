# My Extension

My Extension is a basic PostgreSQL extension that provides additional functionality to enhance your database capabilities.

## Installation

To install the My Extension, follow these steps:

1. Make sure you have PostgreSQL installed on your system. You can download it from [PostgreSQL website](https://www.postgresql.org).

2. Clone the My Extension repository from [GitHub](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/tree/main/Code/my_extension).

3. Navigate to the extension directory.

4. Build the extension by running the following command:

   ```shell
   make
   ```

5. Install the extension by running:

   ```shell
   make install
   ```

6. Verify the installation by connecting to your PostgreSQL database and executing the following command:

   ```sql
   SELECT * FROM pg_extension WHERE extname = 'my_extension';
   ```

   If the extension is listed, the installation was successful.


## Usage

To use the My Extension in your PostgreSQL database, follow these steps:

1. Load the extension into your database by running the following SQL command:

   ```sql
   CREATE EXTENSION my_extension;
   ```

2. Once the extension is loaded, you can start using its functionality. Refer to the [official documentation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/Quick-Start%20%5BDA%5D/MVP/MVP%2BMakefile.md) for detailed usage instructions and code examples.

## Upgrading

When upgrading to a new version of My Extension, follow these steps:

1. Check the release notes and documentation for any specific instructions or migration steps required.

2. If necessary, uninstall the existing version of the extension by running:

   ```sql
   DROP EXTENSION my_extension;
   ```

3. Follow the installation steps mentioned earlier to install the new version of the extension.

4. Run any migration scripts or update your database schema as per the provided instructions.

5. Test your application thoroughly to ensure compatibility and functionality with the upgraded extension.

It is recommended to backup your database before performing any upgrades to ensure data integrity.

For more detailed information, refer to the [official documentation](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/blob/main/Quick-Start%20%5BDA%5D/MVP/MVP%2BMakefile.md).
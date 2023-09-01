# pg_cext PostgreSQL Extension

This is a PostgreSQL extension implemented in C that adds two numbers. It demonstrates how to create a simple extension for PostgreSQL using the C language.

## Installation

1. Ensure you have PostgreSQL installed on your system.
2. Clone or download the repository [pg_cext](https://github.com/IshaanAdarsh/pg_cext/tree/main) to your local machine.

3. Change to the extension directory:

```
$ cd pg_cext
```
### Build and Install

To build and install the extension, follow these steps:

```bash
$ make
$ sudo make install
```

This will compile the extension and install it into your PostgreSQL installation.

## Usage

After the extension is installed, you can use the `add_nums` function to add two numbers together.

```sql
-- Load the extension
CREATE EXTENSION pg_cext;

-- Use the add_nums function
SELECT add_nums(5, 3); -- Returns 8
```

## Uninstallation

To uninstall the extension, you can run the following SQL command:

```sql
DROP EXTENSION pg_cext;
```

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository [pg_cext](https://github.com/IshaanAdarsh/pg_cext/tree/main).

## License

This project is licensed under the [PostgreSQL License](LICENSE).

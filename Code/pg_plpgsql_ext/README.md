# pg_plpgsql_ext PostgreSQL Extension

**A PostgreSQL extension with a PL/pgSQL function to subtract numbers**

pg_plpgsql_ext is a simple PostgreSQL extension that demonstrates how to create a function using the PL/pgSQL language to subtract two numbers.

## Installation

1. Ensure you have PostgreSQL installed on your system.
2. Clone or download the repository [pg_plpgsql_ext](https://github.com/IshaanAdarsh/pg_plpgsql_ext/tree/main) to your local machine.
3. Change to the extension directory:

   ```bash
   $ cd pg_plpgsql_ext
   ```

### Build and Install

To build and install the extension, follow these steps:

```bash
$ make
$ sudo make install
```

This will compile the extension and install it into your PostgreSQL installation.

## Usage

After the extension is installed, you can use the `subtract_numbers` function to subtract two numbers using PL/pgSQL.

```sql
-- Load the extension
CREATE EXTENSION pg_plpgsql_ext;

-- Use the subtract_numbers function
SELECT subtract_numbers(10, 3); -- Returns 7
```

## Uninstallation

To uninstall the extension, you can run the following SQL command:

```sql
DROP EXTENSION pg_plpgsql_ext;
```

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository [pg_plpgsql_ext](https://github.com/IshaanAdarsh/pg_plpgsql_ext/tree/main).

## License

This project is licensed under the [PostgreSQL License](LICENSE).
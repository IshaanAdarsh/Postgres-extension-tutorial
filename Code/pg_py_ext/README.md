# pg_py_ext PostgreSQL Extension

**A PostgreSQL extension using PL/Python3U to add numbers**

pg_py_ext is a simple PostgreSQL extension that demonstrates how to create a function using the PL/Python3U language to add two numbers.

## Installation

1. Ensure you have PostgreSQL installed on your system.
2. Clone or download the repository [pg_py_ext](https://github.com/IshaanAdarsh/pg_py_ext) to your local machine.
3. Change to the extension directory:

   ```bash
   $ cd pg_py_ext
   ```

### Build and Install

To build and install the extension, follow these steps:

```bash
$ make
$ sudo make install
```

This will compile the extension and install it into your PostgreSQL installation.

## Usage

After the extension is installed, you can use the `add_numbers` function to add two numbers using PL/Python3U.

```sql
-- Load the extension
CREATE EXTENSION pg_py_ext;

-- Use the add_numbers function
SELECT add_numbers(5, 3); -- Returns 8
```

## Uninstallation

To uninstall the extension, you can run the following SQL command:

```sql
DROP EXTENSION pg_py_ext;
```

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository [pg_py_ext](https://github.com/IshaanAdarsh/pg_py_ext).

## License

This project is licensed under the [PostgreSQL License](LICENSE).
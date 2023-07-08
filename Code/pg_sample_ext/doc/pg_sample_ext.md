# pg_sample_ext

pg_sample_ext is a PostgreSQL extension that provides a sample function to demonstrate extending PostgreSQL's functionality. The extension includes a custom function to calculate the square of a number.

## Installation

1. Make sure you have PostgreSQL installed and running.

2. Clone or download the repository [pg_sample_ext]() to your local machine.

3. Change to the extension directory:
   ```
   $ cd pg_sample_ext
   ```

4. Build and install the extension:
   ```
   $ make
   $ make install
   ```

5. Connect to your PostgreSQL database as a superuser.

6. Enable the extension:
   ```
   CREATE EXTENSION pg_sample_ext;
   ```

## Usage

Once the `pg_sample_ext` extension is installed and enabled, you can use the included functions in your SQL queries.

### square

The `square` function calculates the square of a number.

```sql
SELECT square(5);  -- Returns 25
```

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on GitHub repository [pg_sample_ext]().

## License
This project is licensed under the [PostgreSQL License](LICENSE).
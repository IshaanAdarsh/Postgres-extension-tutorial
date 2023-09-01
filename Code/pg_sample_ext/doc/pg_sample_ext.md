# pg_sample_ext

pg_sample_ext is a PostgreSQL extension that provides a sample function to demonstrate extending PostgreSQL's functionality.

## Installation

1. Make sure you have PostgreSQL installed and running.

2. Clone or download the repository [pg_sample_ext](https://github.com/IshaanAdarsh/pg_sample_ext/tree/main) to your local machine.

3. Change to the extension directory:

```
$ cd pg_sample_ext
```

4. Build and install the extension:

    $ make
    $ make install

5. Enable the extension: 

`CREATE EXTENSION pg_sample_ext;`

## Usage

Once the `pg_sample_ext` extension is installed and upgraded to version 1.0.1, you can use the included functions and new features in your SQL queries.

### square

The `square` function calculates the square of a number.

```
SELECT square(5);  -- Returns 25
```

### Composite Type (person_type): 
- The extension now includes a composite type named `person_type` that represents a person's name and age. This allows for more structured data storage and retrieval.
- Insert a row with a value from the composite type

```
INSERT INTO my_table (person) VALUES (('John Doe', 30));
```


### Enumerated Type (status_type):
- A new enumerated type called `status_type` is introduced, which provides a predefined set of values for representing different statuses. This enhances data integrity and enables more meaningful data classification.
- Insert a row with a value from the enumerated type

```
INSERT INTO status_table (status) VALUES ('active');
```

### Domain Type (positive_integer): 
- The extension now includes a domain type called `positive_integer`, which is a specialized data type that represents positive integers. This allows for better constraint enforcement and data validation.
- Insert a row, ensuring the quantity is a positive integer

```
INSERT INTO quant_table (quantity) VALUES (10);
```

###  Custom Operator (@*):
- The extension introduces a custom operator `@*` that performs a custom operation, such as multiplication, on values of a specific type.
-- It multiplies two values of type my_type and returns a value of the same type.

```
SELECT ROW(2)::my_type @* ROW(3)::my_type AS result;
```

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository [pg_sample_ext](https://github.com/IshaanAdarsh/pg_sample_ext/tree/main).

## License

This project is licensed under the [PostgreSQL License](LICENSE).
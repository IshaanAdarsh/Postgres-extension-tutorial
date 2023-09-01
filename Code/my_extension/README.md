# my_extension

## Overview
`my_extension` is a basic PostgreSQL extension that provides additional functionality for efficient data manipulation and calculations.

## Features
- Create a custom table `my_table` with an auto-incrementing `id` column and a `name` column.
- Implement a function `add(a, b)` that returns the sum of two integers.
- Implement a function `complex_add(numbers)` that returns the sum of multiple integers provided as an array.
- Implement a function `multiply(a, b)` that returns the product of two integers. This function provides a new way to perform mathematical calculations in PostgreSQL.

## Installation

### Requirements
- PostgreSQL (version 9.6 or later)
- Git

### Steps

1. Clone the repository:
   ```
   git clone https://github.com/IshaanAdarsh/my_extension.git
   ```

2. Change to the extension directory:
   ```
   cd my_extension
   ```

3. Build and install the extension:
   ```
   make
   make install
   ```

4. Enable the extension in your PostgreSQL database:
   ```
   CREATE EXTENSION my_extension;
   ```

## Usage

### Creating a custom table
Table `my_table` is created automatically when the extension is enabled, with an auto-incrementing `id` column and a `name` column.

### Adding two numbers
To add two numbers using the `add` function, execute the following SQL query:

```
SELECT add(1, 2);
```

### Adding multiple numbers
To add multiple numbers using the `complex_add` function, provide an array of integers and execute the following SQL query:

```
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);
```

### Multiplying two numbers
To multiply two numbers using the `multiply` function, execute the following SQL query:

```
SELECT multiply(3, 4);
```

## Contributing
Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

## License
This project is licensed under the [PostgreSQL License](LICENSE).
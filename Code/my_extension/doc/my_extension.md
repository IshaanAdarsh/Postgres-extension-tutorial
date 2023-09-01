# my_extension

## Overview

`my_extension` is a PostgreSQL extension that enhances data management and operations with additional functionality. This extension provides features such as custom table creation, arithmetic calculations, and more.

## Features

### Creating a Custom Table

The `my_extension` extension allows you to create a custom table named `my_table`. This table consists of an auto-incrementing `id` column and a `name` column.

### Arithmetic Functions

#### `add(a, b)`

The `add` function takes two integer values, `a` and `b`, as input and returns their sum.

Example usage:
```
SELECT add(1, 2);
-- Result: 3
```

#### `complex_add(numbers)`

The `complex_add` function accepts an array of integers, `numbers`, as input and returns the sum of all the numbers in the array.

Example usage:
```
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]);
-- Result: 15
```

### New Functionality in Version 1.1.0

#### `multiply(a, b)`

The `multiply` function takes two integer values, `a` and `b`, as input and returns their product.

Example usage:
```
SELECT multiply(3, 4);
-- Result: 12
```

## Installation

To install the `my_extension` extension, follow these steps:

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

For more details and examples, refer to the official documentation.

## Contributing

Contributions to `my_extension` are welcome! If you encounter any issues, have suggestions, or want to contribute new features, please open an issue or submit a pull request on the [GitHub repository](https://github.com/IshaanAdarsh/my_extension).

## License

This project is licensed under the [PostgreSQL License](LICENSE).
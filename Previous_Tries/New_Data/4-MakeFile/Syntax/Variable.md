# Variables:
Variables in a Makefile allow you to define and use reusable values throughout the file. This makes it easier to configure and maintain your build process. Here's a quick start guide on using variables in a Makefile for a PostgreSQL extension:

```makefile

# Define variables for compiler and flags
CC = gcc
CFLAGS = -Wall -O2

# Define variables for file paths
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# Define variables for source and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Define the target for building the shared library
extension.so: $(OBJS)
$(CC) -shared -o $(BIN_DIR)/extension.so $(OBJS)

# Define the target for compiling the source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
$(CC) $(CFLAGS) -c $< -o $@

# Define a target to create the directories
directories:
mkdir -p $(OBJ_DIR) $(BIN_DIR)

# Define a target to clean the build artifacts
clean:
rm -rf $(OBJ_DIR) $(BIN_DIR)

# Define a target to install the extension
install:
cp $(BIN_DIR)/extension.so /path/to/postgresql/extensions

# Define a target to uninstall the extension
uninstall:
rm /path/to/postgresql/extensions/extension.so

```

In this example, we're using variables to define various aspects of the build process:

-   `CC` and `CFLAGS` variables define the compiler and its flags, respectively. You can modify these variables to suit your specific requirements.
    
-   `SRC_DIR`, `OBJ_DIR`, and `BIN_DIR` variables specify the directories for source files, object files, and the final binary (shared library).
    
-   `SRCS` variable uses the `wildcard` function to match all `.c` files in the `SRC_DIR` directory. This provides a list of source files.
    
-   `OBJS` variable uses the `patsubst` function to generate a list of object files corresponding to the source files.
    
-   The target `extension.so` depends on the `OBJS` variable, ensuring that the object files are built before creating the shared library. The variables are used to specify the input and output file paths.
    
-   The target `$(OBJ_DIR)/%.o` uses pattern matching to compile each source file into an object file. The `$<` and `$@` are automatic variables representing the source and target file names, respectively.
    
-   The `directories` target is used to create the required directories (`$(OBJ_DIR)` and `$(BIN_DIR)`) before building the extension.
    
-   The `clean` target removes the build artifacts (object files and the binary) by deleting the directories.
    
-   The `install` target copies the built shared library to the appropriate location in the PostgreSQL extensions directory.
    
-   The `uninstall` target removes the installed extension by deleting the shared library.
    

By using variables, you can easily modify the compiler flags, directory paths, or any other configuration options in a centralized manner. This improves the maintainability and flexibility of your Makefile for the PostgreSQL extension.

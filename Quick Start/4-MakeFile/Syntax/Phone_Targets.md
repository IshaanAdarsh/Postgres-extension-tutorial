Phony targets in a Makefile are used to define actions that are not associated with actual files. These targets are typically used for tasks such as cleaning up temporary files, running tests, installing or uninstalling the extension, or performing other non-file-related actions. Phony targets help separate these build actions from file targets and prevent conflicts with actual file names.


```makefile
# Define phony targets
.PHONY: all clean test install uninstall

# Define variables
CC = gcc
CFLAGS = -Wall -O2
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# Define source and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Define the default target
all: extension.so

# Rule for building the shared library
extension.so: $(OBJS)
$(CC) -shared -o $(BIN_DIR)/extension.so $(OBJS)

# Rule for compiling the source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
$(CC) $(CFLAGS) -c $< -o $@

# Rule for cleaning build artifacts
clean:
rm -rf $(OBJ_DIR) $(BIN_DIR)

# Rule for running tests
test:
# Run regression tests here

# Rule for installing the extension
install:
cp $(BIN_DIR)/extension.so /path/to/postgresql/extensions

# Rule for uninstalling the extension
uninstall:
rm /path/to/postgresql/extensions/extension.so

```

In this example, we have defined the phony targets using the `.PHONY` directive:

-   `all` is not defined as a phony target because it represents a file target (the `extension.so` shared library).
    
-   `clean` is a phony target used to clean up the build artifacts. It does not represent an actual file but triggers the execution of the associated commands to remove the object files and the `extension.so` shared library.
    
-   `test` is a phony target that can be used to run tests for the extension. You can place the commands for running regression tests or other tests specific to your extension in this target.
    
-   `install` is a phony target used to install the extension. It triggers the command to copy the `extension.so` shared library to the appropriate location in the PostgreSQL extensions directory.
    
-   `uninstall` is a phony target used to uninstall the extension. It triggers the command to remove the installed extension by deleting the `extension.so` shared library.
    

By marking these targets as phony, you ensure that the associated commands are always executed when the targets are invoked, regardless of whether there are files with the same names. This allows you to define and execute non-file-related actions alongside file targets in your Makefile.

# Rules and Commands:
In a Makefile, rules define how to build a target and specify the dependencies and commands associated with that target. Here's a detailed quick start guide on rules and commands in a Makefile for a PostgreSQL extension:

```makefile

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

# Rule for installing the extension
install:
cp $(BIN_DIR)/extension.so /path/to/postgresql/extensions

# Rule for uninstalling the extension
uninstall:
rm /path/to/postgresql/extensions/extension.so

```

In this example, we have several rules defined in the Makefile:

-   The `all` rule is the default target that will be built when you run `make` without specifying a target explicitly. In this case, it depends on the `extension.so` target.
    
-   The `extension.so` rule specifies that the target `extension.so` depends on the object files specified by `$(OBJS)`. The rule provides the command to link these object files into a shared library using the `$(CC)` compiler.
    
-   The `$(OBJ_DIR)/%.o` rule defines how to compile each source file into an object file. The rule specifies the dependencies, which are the corresponding source file, and provides the command to compile the source file into the object file using the `$(CC)` compiler.
    
-   The `clean` rule specifies the command to remove the build artifacts, which are the object files and the `extension.so` shared library.
    
-   The `install` rule provides the command to copy the `extension.so` shared library to the appropriate location in the PostgreSQL extensions directory.
    
-   The `uninstall` rule provides the command to remove the installed extension by deleting the `extension.so` shared library.
    

By using rules and commands, you define the relationships between targets and dependencies and specify the actions required to build those targets. The commands associated with each rule are executed when the dependencies are not up to date or when explicitly specified. This allows you to automate the build process and perform actions such as compiling, linking, copying, or cleaning based on the specified rules.

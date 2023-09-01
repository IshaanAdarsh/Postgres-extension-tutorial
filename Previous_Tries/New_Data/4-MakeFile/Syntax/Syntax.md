# Syntax of a Makefile:

1.  Targets: Targets represent files or actions that need to be built or executed. They are defined on the left side of a rule and are followed by a colon (:). For example:
    
2.  Dependencies: Dependencies are the prerequisites for building a target. They are listed after the colon (:), separated by spaces. Dependencies can be files or other targets. For example:
    
    ```makefile
    target_name: dependency1 dependency2
    ```
    
3.  Commands: Commands are the shell commands that are executed to build a target. They are indented with a tab character and are placed on the lines following the target and its dependencies. For example:
    
    ```php
    target_name: dependency1 dependency2
    <tab>command1
    <tab>command2
    ```
    
4.  Variables: Variables allow you to define reusable values in your Makefile. They are typically defined at the beginning of the Makefile and referenced using the syntax `$(variable_name)`. For example:
    
    ```makefile
    VARIABLE_NAME = value
    
    target_name:
    <tab>command $(VARIABLE_NAME)
    ```
    
5.  Phony Targets: Phony targets are used to define actions that are not associated with actual files. They are declared as prerequisites for targets, and they help separate build actions from file targets. Phony targets are typically declared using the `.PHONY` special target. For example:
    
    ```makefile
    .PHONY: phony_target
    
    target_name: dependency phony_target
    <tab>command
    ```
    
6.  Comments: Comments in Makefiles start with a hash symbol (#) and are used to provide explanatory notes. They can be placed on separate lines or at the end of a line. For example:
    
    ```bash
    # This is a comment
    
    target_name: dependency # This is also a comment
    <tab>command
    ```

These are the basic elements of a Makefile syntax. By combining targets, dependencies, commands, variables, and phony targets, you can create a Makefile to automate the build process for your PostgreSQL extension.

A basic Makefile example that demonstrates the usage of the elements we discussed:

```makefile
# Variables
CC = gcc
CFLAGS = -Wall -O2
SOURCES = main.c helper.c
OBJECTS = $(SOURCES:.c=.o)
EXECUTABLE = my_extension

# Phony target
.PHONY: all clean

# Default target
all: $(EXECUTABLE)

# Target to build the executable
$(EXECUTABLE): $(OBJECTS)
$(CC) $(CFLAGS) $(OBJECTS) -o $(EXECUTABLE)

# Target to compile C source files
%.o: %.c
$(CC) $(CFLAGS) -c $< -o $@

# Clean target
clean:
rm -f $(OBJECTS) $(EXECUTABLE)

```

In this example, we have:

-   Defined variables such as `CC` (compiler), `CFLAGS` (compiler flags), `SOURCES` (source code files), `OBJECTS` (object files), and `EXECUTABLE` (name of the final executable).
    
-   Created a phony target named `all` as the default target. It depends on the `$(EXECUTABLE)` target.
    
-   Defined a target `$(EXECUTABLE)` that depends on the `$(OBJECTS)` target. It compiles the object files into the final executable using the specified compiler and flags.
    
-   Created a pattern rule to compile C source files into object files.
    
-   Declared a phony target named `clean` that removes the object files and the executable.
    

You can customize this example by modifying the variables, adding more targets, or including additional rules based on your specific requirements.

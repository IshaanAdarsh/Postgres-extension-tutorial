# Makefile:
The main function of a Makefile in Postgres Extension Building is to automate the process of building the extension. The Makefile specifies the steps that need to be taken to build the extension, and the make command takes care of the rest. This can save you a lot of time and effort, especially if you are building the extension on a regular basis.

In addition to automating the build process, the Makefile can also be used to:

-   Track changes to the extension. The Makefile can be used to keep track of the changes that have been made to the extension, and to revert to previous versions if necessary.
-   Build the extension on different platforms. The Makefile can be used to build the extension on different platforms, such as Linux, Windows, and macOS.
-   Distribute the extension. The Makefile can be used to distribute the extension to other users.
-   Documenting the build process: The Makefile can be used to document the build process, which can be helpful for other developers who need to build the extension.
-   Ensuring a consistent build: The Makefile can be used to ensure that the extension is always built in the same way, regardless of who is building it. This can help to prevent errors and bugs.
-   Speeding up the build process: The Makefile can be used to speed up the build process by caching the results of previous builds.
-   Simplifying the build process: The Makefile can be used to simplify the build process by automating complex tasks.

Overall, the Makefile is a powerful tool that can help you to build, document, and distribute PostgreSQL extensions. If you are working on a PostgreSQL extension.

Here are some additional tips for using Makefiles:

-   Use a consistent naming convention for your targets. This will make it easier to find and understand the targets in your Makefile.
-   Use comments to document your Makefile. This will make it easier for other developers to understand how your Makefile works.
-   Use variables to store frequently used values. This will make your Makefile more concise and easier to read.
-   Use functions to group related tasks together. This will make your Makefile more modular and easier to maintain.

### Example Makefile: 
```sql
EXTENSION = myextension

OBJS = myextension.o

all: $(EXTENSION).so

$(EXTENSION).so: $(OBJS)
  $(CC) -shared -o $@ $(OBJS) -L/usr/lib/postgresql/13/lib -lpq

myextension.o: myextension.c
  $(CC) -c -o $@ $<

clean:
  rm -f $(OBJS) $(EXTENSION).so
```


- The `EXTENSION` variable specifies the name of the extension.
- The `OBJS` variable specifies the names of the object files that need to be compiled.
- The `all` target specifies the steps that need to be taken to build the extension.
- The `<span class="math-inline">\(EXTENSION\)\.so\` target specifies the steps that need to be taken to build the shared object file. The `(CC)`command is used to compile the object files into a shared object file. The`-shared`flag tells the`$(CC)`command to compile the object files into a shared object file. The`-o @'flagtellsthe'(CC)`command to output the shared object file to the specified file name. The`(OBJS)'variablespecifiesthenamesoftheobjectfilesthatneedtobecompiled.The'-L/usr/lib/postgresql/13/lib'flagtellsthe'(CC)`command to look for libraries in the specified directory. The`-lpq`flag tells the`$(CC)` command to link with the PostgreSQL libraries.
- The `myextension.o` target specifies the steps that need to be taken to build the object file for the `myextension` function. The `<span class="math-inline">\(CC\)\` command is used to compile the `myextension.c` file into an object file. The `-c` flag tells the `(CC)`command to compile the`myextension.c`file into an object file. The`-o @'flagtellsthe'(CC)`command to output the object file to the specified file name. The`$<` variable specifies the name of the input file.
- The clean target specifies the steps that need to be taken to clean up the build environment. The rm command is used to remove the object files and the shared object file. The -f flag tells the rm command to force the removal of the files, even if they are currently in use.


> Summary:
>  - The EXTENSION variable specifies the name of the extension. 
>  - The OBJS variable specifies the names of the object files that need to be compiled. 
>  - The all target specifies the steps that need to be taken to build the extension. 
>  - The $(EXTENSION).so target specifies the steps that need to be taken to build the shared object file. 
>  - The myextension.o target specifies the steps that need to be taken to build the object file for the myextension function. 
>  - The clean target specifies the steps that need to be taken to clean up the build environment.

## make command:
It is a utility that automates the process of building software often used to compile source code into an executable file, and to link libraries and other dependencies.
The make command works by reading a file called a Makefile. The Makefile contains a list of targets, and the steps that need to be taken to build each target. For example, a Makefile might have a target called "all", which specifies the steps that need to be taken to build the executable file. The Makefile might also have targets for building individual libraries or other dependencies.
When you run the make command, it reads the Makefile and determines which targets need to be built. It then takes the steps that are specified in the Makefile for each target. If any of the targets depend on other targets, the make command will build the dependent targets first.
```shell
make
```

The make command will build the `myextension.so` target. This will involve compiling the `myextension.c` file into an object file, and then linking the object file with the PostgreSQL libraries to create a shared object file.

Here are some of the benefits of using the make command:
-   It automates the process of building software, which can save you a lot of time.
-   It ensures that your software is always built in the same way, regardless of who is building it.
-   It can help you to track your changes and to revert to previous versions if necessary.
-   It can help you to find and fix bugs more quickly.


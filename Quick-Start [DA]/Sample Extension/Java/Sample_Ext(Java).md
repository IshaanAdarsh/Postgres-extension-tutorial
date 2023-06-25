A step-by-step guide to creating a sample Postgres Java extension:
---------------------------

Step 1: Install PostgreSQL and Java Development Kit (JDK)
Before you start, make sure you have PostgreSQL and a JDK installed on your system.

Step 2: Create a new directory for your extension
Create a new directory to hold your extension code. For example, let's call it "my_extension".

Step 3: Write the Java extension code
Create a new Java file with the extension logic. Let's call it "MyExtension.java". Here's an example of a simple extension that adds two integers:

```java
import org.postgresql.pljava.annotation.Function;
import org.postgresql.pljava.annotation.SQLType;

public class MyExtension {
    @Function
    public static int addIntegers(@SQLType("int") int a, @SQLType("int") int b) {
        return a + b;
    }
}
```

This example uses the PL/Java library to create the extension. Make sure to include the necessary dependencies in your project.

Step 4: Compile the Java code
Compile the Java code into bytecode (.class files). Use the `javac` command to compile the Java file:

```
javac -classpath path/to/postgresql.jar MyExtension.java
```

Make sure to replace "path/to/postgresql.jar" with the actual path to the PostgreSQL JDBC driver JAR file.

Step 5: Create the extension SQL file
Create an SQL file to define the extension in PostgreSQL. Let's call it "my_extension--1.0.sql". Here's an example:

```sql
CREATE EXTENSION IF NOT EXISTS my_extension;

-- Optional: Create a test function to verify the extension
CREATE OR REPLACE FUNCTION test_my_extension()
RETURNS int AS 'MyExtension.addIntegers' LANGUAGE java;
```

This SQL file creates the extension using the `CREATE EXTENSION` statement. It also includes an optional test function to verify the extension functionality.

Step 6: Package the extension
Create a directory structure for the extension package. Inside the "my_extension" directory, create a "META-INF" directory. Place the compiled Java bytecode (.class) files inside the "META-INF" directory.

The directory structure should look like this:

```
my_extension/
└── META-INF/
    ├── MyExtension.class
    └── ...
```

Step 7: Build the extension JAR file
Create a JAR file that contains the extension code and the "META-INF" directory. Use the `jar` command to create the JAR file:

```
jar cvf my_extension.jar -C my_extension/ .
```

Step 8: Install the extension in PostgreSQL
Copy the JAR file to the PostgreSQL extension directory. You can find the extension directory path using the following SQL query:

```sql
SHOW shared_preload_libraries;
```

Copy the JAR file to the extension directory:

```
cp my_extension.jar path/to/extension/directory/
```

Step 9: Register the extension in PostgreSQL
Register the extension in PostgreSQL by executing the following SQL query:

```sql
CREATE EXTENSION my_extension;
```

Step 10: Test the extension
You can now test the extension by executing the test function defined in the SQL file:

```sql
SELECT test_my_extension();
```

This should return the sum of two integers.

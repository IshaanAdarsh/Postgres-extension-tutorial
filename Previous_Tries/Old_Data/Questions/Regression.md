## What are Regression Tests?

Regression tests are automated tests that ensure your extension continues to work correctly as changes are made. They are typically run after each build or release to catch any bugs or regressions that may have been introduced.
## How to Write Regression Tests for a PostgreSQL Extension

To write regression tests for a PostgreSQL extension, you need to do the following: 
1. Set up a test environment: Create a test database and user that you will use for running your tests. You can create the test database using the `createdb` command:

```

createdb my_extension_test
```


1. Write the test cases: Create one or more SQL scripts that test your extension's functionality. These scripts should create any necessary tables or data, call the functions you want to test, and verify that the results are correct. For example:

```sql

-- test_my_function.sql
CREATE TABLE test_data (id INT, value TEXT);
INSERT INTO test_data (id, value) VALUES (1, 'foo'), (2, 'bar');

SELECT my_function(value) FROM test_data WHERE id = 1; -- should return 'FOO'
SELECT my_function(value) FROM test_data WHERE id = 2; -- should return 'BAR'
```

 
1. Create a regression test file: Create a file called `my_extension.sql` that includes all of your test cases. For example:

```css

-- my_extension.sql
\i test_my_function.sql
```

 
1. Add the regression test to the Makefile: In your extension's Makefile, add the name of your regression test file to the `REGRESS` variable. For example:

```makefile

MODULES = my_extension
DATA = my_extension--1.0.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
REGRESS = my_extension
include $(PGXS)
```

 
1. Run the regression test: Build and install your extension using the `make` command, then run the regression test using the `pg_regress` command:

```go

make
make install
pg_regress my_extension
```
This will run all of the tests in your `my_extension.sql` file and report any failures.

> https://www.postgresql.org/docs/current/regress.html -> Regression Test

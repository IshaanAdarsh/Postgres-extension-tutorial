-- regression test script for pg_sample_ext (version 1.0.2)

-- Create the extension
CREATE EXTENSION pg_sample_ext;

-- Test case 1: Verify the square function
SELECT square(5) AS result, 25 AS expected_result;

-- Test case 2: Verify the square function with a negative number
SELECT square(-4) AS result, 16 AS expected_result;


-- Test case 3: Verify the person_type composite type
CREATE TABLE my_table (
id serial PRIMARY KEY,
person person_type
);

INSERT INTO my_table (person)
VALUES (('John', 30));

SELECT * FROM my_table;

-- Test case 4: Verify the status_type enumerated type
CREATE TABLE status_table (
id serial PRIMARY KEY,
status status_type
);

INSERT INTO status_table (status)
VALUES ('active');

SELECT * FROM status_table;

-- Test case 5: Verify the positive_integer domain type
CREATE TABLE positive_integer_table (
id serial PRIMARY KEY,
value positive_integer
);

INSERT INTO positive_integer_table (value)
VALUES (42);

SELECT * FROM positive_integer_table;

-- Test case 6: Verify the @* operator
SELECT ROW(2)::my_type @* ROW(3)::my_type AS result;


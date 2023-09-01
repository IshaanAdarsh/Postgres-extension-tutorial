-- regression test script for my_extension

-- Create the extension
CREATE EXTENSION my_extension;

-- Verify the data in the my_table table
SELECT * FROM my_table;

-- Test the add function
SELECT add(1, 2) AS result;

-- Test the complex_add function
SELECT complex_add(ARRAY[1, 2, 3, 4, 5]) AS result;

-- Test the multiply function
SELECT multiply(3, 4) AS result;

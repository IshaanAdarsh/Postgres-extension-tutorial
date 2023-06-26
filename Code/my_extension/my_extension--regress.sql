-- regression test script for my_extension

-- Create the my_table table
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Test the my_function function
SELECT my_function();

-- Verify the data in the my_table table
SELECT * FROM my_table;

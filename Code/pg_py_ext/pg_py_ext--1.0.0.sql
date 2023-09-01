-- pg_py_ext--1.0.0.sql
-- Create the function that uses the Python script
CREATE OR REPLACE FUNCTION add_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpython3u
AS $$
def add_numbers(a, b):
    return a + b
return add_numbers(int(a), int(b))
$$;

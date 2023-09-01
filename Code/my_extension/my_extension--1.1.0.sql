-- Create necessary objects for version 1.0
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Add 2 numbers using add function
CREATE FUNCTION add(a integer, b integer) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    RETURN a + b;

-- Add multiple numbers using a complex addition function
CREATE FUNCTION complex_add(integer[]) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    AS $$
        SELECT COALESCE(SUM(val), 0)
        FROM unnest($1) AS t(val)
    $$
;

-- Multiply two numbers using a new function
CREATE FUNCTION multiply(a integer, b integer) RETURNS integer
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    RETURN a * b;

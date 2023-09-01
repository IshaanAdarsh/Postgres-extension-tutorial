-- Create a function to calculate the square of a number
CREATE OR REPLACE FUNCTION square(num integer)
RETURNS integer AS $$
BEGIN
  RETURN num * num;
END;
$$ LANGUAGE plpgsql;

-- Create necessary objects for version 1.0.1

-- Create a composite type named person_type
CREATE TYPE person_type AS (
  name text,
  age integer
);

-- Create an enumerated type named status_type
CREATE TYPE status_type AS ENUM ('active', 'inactive', 'pending');

-- Create a domain type for representing positive integers
CREATE DOMAIN positive_integer AS integer
   CHECK (VALUE > 0);

-- Create necessary objects for version 1.0.2

-- Custom Operator: @*
-- Description: Custom operator that multiplies two values of type my_type

-- Create a new type to use in our operator.
CREATE TYPE my_type AS (value int);

-- Create a SQL function that defines the behaviour of the custom operator.
-- This function multiplies the values of two my_type operands.
CREATE FUNCTION multiply_values(input1 my_type, input2 my_type) RETURNS my_type AS $$
    SELECT ROW(input1.value * input2.value)::my_type;
$$ LANGUAGE SQL IMMUTABLE;

-- Create a custom operator that multiplies two values of type my_type.
-- The operator symbol is @*.
-- It takes two operands of type my_type and returns a value of the same type.
-- The behaviour is defined by the SQL function multiply_values.
CREATE OPERATOR @* (
    PROCEDURE = multiply_values,
    LEFTARG = my_type,
    RIGHTARG = my_type
);
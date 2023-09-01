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
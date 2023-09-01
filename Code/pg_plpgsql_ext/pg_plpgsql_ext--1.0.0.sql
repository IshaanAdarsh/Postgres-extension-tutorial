-- pg_plpgsql_ext--1.0.0.sql
-- Create the function that uses PL/pgSQL
CREATE OR REPLACE FUNCTION subtract_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a - b;
END;
$$;
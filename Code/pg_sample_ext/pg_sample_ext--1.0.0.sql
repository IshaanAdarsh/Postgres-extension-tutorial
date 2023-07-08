-- Create a function to calculate the square of a number
CREATE OR REPLACE FUNCTION square(num integer)
RETURNS integer AS $$
BEGIN
  RETURN num * num;
END;
$$ LANGUAGE plpgsql;

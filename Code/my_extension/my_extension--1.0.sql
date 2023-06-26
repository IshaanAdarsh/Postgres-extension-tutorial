-- my_extension--1.0.sql

-- Create necessary objects for version 1.0
CREATE TABLE my_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE FUNCTION my_function() RETURNS void AS $$
INSERT INTO my_table (name) VALUES ('Example');
$$ LANGUAGE sql;


-- myext.sql
-- pgSQL extension control information
-- comment = 'My PostgreSQL pgSQL Extension'
-- default_version = '1.0'
-- module_pathname = '$libdir/extension_name'

-- Function definition
CREATE FUNCTION my_function() RETURNS text AS $$
BEGIN
    RETURN 'Hello, world!';
END;
$$ LANGUAGE plpgsql;
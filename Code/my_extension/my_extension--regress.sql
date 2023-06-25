-- Test case 1: Verify table creation
-- Check if the table 'my_table' exists
SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'my_table');


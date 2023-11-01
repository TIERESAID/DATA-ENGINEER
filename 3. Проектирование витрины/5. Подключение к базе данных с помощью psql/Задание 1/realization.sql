-- добавьте код сюда
-- Write a metadata table query that returns the number of tables in the 'public' schema

SELECT count(*)
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

--if you need more information about the structure and properties of the "main2" index or want to know which columns it covers, you can use the following query
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'user_activity_log' AND indexname = 'main2';

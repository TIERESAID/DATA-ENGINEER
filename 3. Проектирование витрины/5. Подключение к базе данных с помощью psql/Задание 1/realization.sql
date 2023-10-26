-- добавьте код сюда
-- Write a metadata table query that returns the number of tables in the 'public' schema

SELECT count(*)
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
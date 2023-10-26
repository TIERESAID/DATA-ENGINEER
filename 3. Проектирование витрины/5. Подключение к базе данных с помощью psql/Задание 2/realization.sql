-- добавьте код сюда
-- Write a query on the metadata table that returns the names of all indexes in the user_activity_log table.
SELECT indexname
FROM pg_indexes
WHERE tablename = 'user_activity_log';

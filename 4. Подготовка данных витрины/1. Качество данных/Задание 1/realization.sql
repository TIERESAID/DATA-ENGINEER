-- добавьте код сюда
-- Write a query on the user_attributes table to check for duplicates on the client_id field. The query should return two fields - total (number of records) and uniq (number of unique values):
SELECT
    COUNT(*) AS total,
    COUNT(DISTINCT  client_id) AS uniq
FROM
    user_attributes;


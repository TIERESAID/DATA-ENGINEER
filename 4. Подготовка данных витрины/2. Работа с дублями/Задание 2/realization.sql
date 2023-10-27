-- добавьте код сюда
-- Write a query on the user_contacts table that returns two fields: client_id and phone. Only one record with the maximum creation date created_at should be left for each client.
SELECT DISTINCT ON (client_id) client_id, phone
FROM user_contacts
ORDER BY client_id, created_at DESC;
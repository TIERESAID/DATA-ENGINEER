-- добавьте код сюда
-- Write a query on the user_contacts table that returns two fields: client_id and phone. Only one record with the maximum creation date created_at should be left for each client.
SELECT client_id, phone
FROM (
  SELECT client_id, phone, created_at,
         ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY created_at DESC) AS row_num
  FROM user_contacts
) AS subquery
WHERE row_num = 1;

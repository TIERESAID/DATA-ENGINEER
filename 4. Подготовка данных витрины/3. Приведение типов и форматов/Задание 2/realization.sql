-- добавьте код сюда
-- Write a query that leaves only numbers in the phone field.
SELECT REGEXP_REPLACE(phone, '[^0-9]', '', 'g') AS phone
FROM user_contacts;

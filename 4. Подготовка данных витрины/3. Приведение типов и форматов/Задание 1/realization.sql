-- добавьте код сюда
-- Write a query that removes extra characters from the phone field: brackets and spaces.
SELECT TRANSLATE(phone, '() ', '') AS phone
FROM user_contacts;
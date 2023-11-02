-- добавьте код сюда
-- round the dates in the updated_at text field to the first day of the month. Write a query that first converts the field to the timestamp type and then rounds the values to the first day of the month.
SELECT
 (TO_TIMESTAMP(updated_at, 'HH24:MI:SS DD-MM-YYYY') at time zone 'utc') AS update_time
FROM user_contacts;

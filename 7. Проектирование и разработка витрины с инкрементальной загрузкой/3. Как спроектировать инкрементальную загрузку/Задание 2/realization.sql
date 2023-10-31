-- добавьте код сюда.
/*
Now write a query that selects from the user_activity_log table
 all data with a date greater than the maximum value obtained
in the previous query. Create a date filter or write a subquery. With this query,
you will get only the portion of the data that is added.
*/

-- SELECT *
-- FROM user_activity_log ual
-- WHERE CASE WHEN hitdatetime > '2022-03-31' THEN true ELSE false END;


SELECT *
FROM user_activity_log
WHERE hitdatetime > (SELECT MAX("date") FROM Load_Dates);

-- добавьте код сюда
/*
Now write another query and group the data by date. 
Count the number of rows for each day in the user_activity_log table.
 Sort the set in ascending order of date. The query should
  contain two columns: date, number of rows.

This way you will know how many total rows there are
 in the table and how many records there are for each day.
  Estimate how many times there is less data for each day.
*/
SELECT
    date_trunc('day', hitdatetime) AS date,
    COUNT(*) AS number_of_rows
FROM
    user_activity_log
GROUP BY
    date
ORDER BY
    date;

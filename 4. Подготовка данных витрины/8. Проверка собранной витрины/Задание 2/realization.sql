-- добавьте код сюда
SELECT
    date_trunc('day', hitdatetime) AS date,
    COUNT(*) AS number_of_rows
FROM
    user_activity_log
GROUP BY
    date
ORDER BY
    date;

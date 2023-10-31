-- добавьте код сюда
/*
Check the depth of the data and if there are any gaps in the data. Write a query against the constructed clients_cluster_metrics_m showcase that returns two fields:
month - month of data from the showcase;
total_records - the total number of records in this month.
Sort the data by descending values of the month field.
*/
SELECT
    "month" AS month,
    COUNT(*) AS total_records
FROM clients_cluster_metrics_m
GROUP BY "month"
ORDER BY "month" DESC;

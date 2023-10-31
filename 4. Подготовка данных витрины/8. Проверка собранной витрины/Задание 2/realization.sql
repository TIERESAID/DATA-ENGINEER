-- добавьте код сюда
/*
Check the completeness of the rejects_share metric - what proportion of the amount of rejected payments is taken from the amount of successful payments by month.
Write a query that will return two fields:
month - the month of the data from the storefront;
rejects_share_empty_pct - percentage of cases when the rejects_share field is not filled. The expected format of the data in the field is a floating point number with 16 characters after the decimal point.
Sort the data by descending values of the month field and do not use CTE or subqueries.
*/
SELECT
    "month" AS month,
    (COUNT(CASE WHEN rejects_share IS NULL THEN 1 ELSE NULL END) * 100.0 / COUNT(*)) AS rejects_share_empty_pct
FROM clients_cluster_metrics_m
GROUP BY "month"
ORDER BY "month" DESC;


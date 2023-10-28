-- добавьте код сюда
/* Check if the values of the visit_events metric - the number of visit type events for each client per month from the user_activity_log table - are correct. The metric itself is already built in CTE. Complete the query by building the following statistics using aggregate functions:
visit_events_min - the minimum value of the metric;
visit_events_max - the maximum value of the metric;
visit_events_avg - average value of the metric;
visit_events_null - number of empty metric values;
visit_events_zero - number of zero values of the metric;
visit_events_zero_pct - percentage of zero values of the metric across the table;
visit_events_nonzero - number of non-zero values of the metric.
*/

WITH cte AS (
    SELECT client_id,
        CAST(DATE_TRUNC('Month', hitdatetime) AS date) "month",
        COUNT(CASE WHEN action = 'visit' THEN 1 END) visit_events
    FROM user_activity_log
    WHERE EXTRACT(YEAR FROM hitdatetime) = 2021
    GROUP BY client_id, CAST(DATE_TRUNC('Month', hitdatetime) AS date)
)
SELECT
    MIN(visit_events) AS visit_events_min,
    MAX(visit_events) AS visit_events_max,
    AVG(visit_events) AS visit_events_avg,
    COUNT(CASE WHEN visit_events IS NULL THEN 1 END) AS visit_events_null,
    COUNT(CASE WHEN visit_events = 0 THEN 1 END) AS visit_events_zero,
    (COUNT(CASE WHEN visit_events = 0 THEN 1 END) * 100.0) / COUNT(*) AS visit_events_zero_pct,
    COUNT(CASE WHEN visit_events > 0 THEN 1 END) AS visit_events_nonzero
FROM cte;


/* 
Histogram 
*/
WITH cte AS (
    SELECT client_id,
        CAST(DATE_TRUNC('Month',hitdatetime) AS date) "month",
        COUNT(CASE WHEN "action" = 'visit' THEN 1 END) visit_events
    FROM user_activity_log
    WHERE EXTRACT(YEAR FROM hitdatetime) = 2021
    GROUP BY client_id, CAST(DATE_TRUNC('Month',hitdatetime) AS date)
)
SELECT
    CASE
        WHEN visit_events >= 12 THEN '12+'
        WHEN visit_events >= 10 THEN '10_12'
        WHEN visit_events >= 5 THEN '05_10'
        WHEN visit_events >= 3 THEN '03_05'
        WHEN visit_events >= 2 THEN '02_03'
        WHEN visit_events = 1 THEN '01'
        WHEN visit_events = 0 THEN '00'
        END bucket,
    COUNT(*) records
FROM cte
GROUP BY bucket;

/* 
One of the required metrics in the showcase was visit_to_login_events, or the number of login type events after the visit event per month for each customer. The time interval between events is unlimited.
Write a SQL query over the user_activity_log table that returns three fields:
client_id - client id;
month - month of data (must be of type date);
visit_to_login_events - the number of login events that immediately follow the visit event for the month, without any intermediate events.
*/
WITH EventPairs AS (
  SELECT
    client_id,
    DATE_TRUNC('month', hitdatetime)::DATE AS month,
    action AS event1,
    LEAD(action) OVER (PARTITION BY client_id, DATE_TRUNC('month', hitdatetime) ORDER BY hitdatetime) AS event2
  FROM user_activity_log
)

SELECT
  client_id,
  month,
  COALESCE(SUM(CASE WHEN event1 = 'visit' AND event2 = 'login' THEN 1 ELSE 0 END), 0) AS visit_to_login_events
FROM EventPairs
GROUP BY client_id, month
ORDER BY client_id, month;
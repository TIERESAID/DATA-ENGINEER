-- добавьте код сюда
/* In the final showcase, several metrics represented the number of events of different types over the user_activity_log table. Write a SQL query over this table that returns 5 fields:
client_id - client id;
month - month of data (must be of date type);
visit_events - number of events with the visit type for the month;
registration_events - number of events with registration type for the month;
login_events - number of events with type login for a month. */

SELECT
  client_id,
  DATE_TRUNC('month', hitdatetime)::DATE AS month,
  SUM(CASE WHEN action = 'visit' THEN 1 ELSE 0 END) AS visit_events,
  SUM(CASE WHEN action = 'registration' THEN 1 ELSE 0 END) AS registration_events,
  SUM(CASE WHEN action = 'login' THEN 1 ELSE 0 END) AS login_events
FROM user_activity_log 
GROUP BY client_id, DATE_TRUNC('month', hitdatetime)
ORDER BY client_id, DATE_TRUNC('month', hitdatetime);

-- добавьте код сюда

/* Let's move on to the user_payment_log table. To get the timing of launching campaigns right, 
the business wants to know how many customers are active outside of daylight hours. 
Write a SQL query over the user_payment_log table that will return 2 fields:
client_id - client id;
daily_actions_pct - the percentage of client's actions performed between 12 and 18 hours (not including the right border of 18:00) of all client's actions in the table.
We assume that all clients are in the same time zone and the data in the database corresponds to this zone.
*/
SELECT
  client_id,
  (SUM(CASE WHEN EXTRACT(HOUR FROM hitdatetime) >= 12 AND EXTRACT(HOUR FROM hitdatetime) < 18 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS daily_actions_pct
FROM user_payment_log
GROUP BY client_id;
--f_activity
delete from mart.f_activity;

INSERT INTO mart.f_activity (activity_id, date_id, click_number)
...

--f_daily_sales
delete from mart.f_daily_sales;

INSERT INTO mart.f_daily_sales  (date_id, item_id, customer_id , price , quantity , payment_amount)
...
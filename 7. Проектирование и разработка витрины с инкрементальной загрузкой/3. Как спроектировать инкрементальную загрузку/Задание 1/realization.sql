-- добавьте код сюда
/*
The Load_Dates table is given.
 The Date column contains the date and time when the data
  from the user_activity_log table was loaded into the storefront.
  Write a query that selects the maximum value from Date. 
  */
select max(date)::DATE
from load_dates ld ;

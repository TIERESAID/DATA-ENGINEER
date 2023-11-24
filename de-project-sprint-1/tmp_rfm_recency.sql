-- Calculate Recency for each customer
SELECT
    user_id,
    ntile(5) over(partition by (extract(day from (max(order_ts) - min(order_ts))))) as recency
FROM
    production.orders
where status = 4 and order_ts >= '01.01.2022'::timestamp
group by user_id 
order by user_id ;

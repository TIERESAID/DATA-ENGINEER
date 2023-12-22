-- Populate d_city table
INSERT INTO d_city (city_id, city_name)
SELECT DISTINCT city_id, city_name
    FROM user_order_log;

-- Populate d_calendar table
INSERT INTO d_calendar (date, day_num, month_num, month_name, year_num)
SELECT
    date::date,
    EXTRACT(day FROM date) AS day_num,
    EXTRACT(month FROM date) AS month_num,
    TO_CHAR(date, 'Month') AS month_name,
    EXTRACT(year FROM date) AS year_num
FROM generate_series(
    '2020-01-01'::date,
    '2022-01-01'::date,
    interval '1 day'
) AS t(date);

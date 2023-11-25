SELECT
    user_id,
    count(o.*),
    NTILE(5) OVER (ORDER BY count(o.*)) AS "frequency"
FROM
    analysis.orders o
WHERE
    o.status = 4 
GROUP BY
    user_id
ORDER BY
    user_id;


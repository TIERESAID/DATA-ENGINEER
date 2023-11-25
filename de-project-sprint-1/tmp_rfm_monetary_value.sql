SELECT
    user_id,
    sum(o."payment"),
    NTILE(5) OVER (ORDER BY sum(o."payment")) AS "monetary"
FROM
    analysis.orders o
WHERE
    o.status = 4 
GROUP BY
    user_id
ORDER BY
    user_id;

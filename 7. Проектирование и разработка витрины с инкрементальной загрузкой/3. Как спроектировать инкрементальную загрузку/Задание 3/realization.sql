-- добавьте код сюда

-- SELECT
--     COALESCE(ci.client_id, c.client_id) AS client_id,
--     COALESCE(ci.client_firstname, c.client_firstname) AS client_firstname,
--     COALESCE(ci.client_lastname, c.client_lastname) AS client_lastname,
--     COALESCE(ci.client_email, c.client_email) AS client_email,
--     COALESCE(ci.client_phone, c.client_phone) AS client_phone,
--     COALESCE(ci.client_city, c.client_city) AS client_city,
--     COALESCE(ci.age, c.age) AS age,
--     CASE
--         WHEN c.client_id IS NULL THEN 'I'
--         WHEN ci.client_id IS NOT NULL
--             AND (ci.client_firstname != c.client_firstname
--                 OR ci.client_lastname != c.client_lastname
--                 OR ci.client_email != c.client_email
--                 OR ci.client_phone != c.client_phone
--                 OR ci.client_city != c.client_city
--                 OR ci.age != c.age) THEN 'U'
--         ELSE NULL
--     END AS action
-- FROM
--     clients_inc ci
-- LEFT OUTER JOIN
--     clients c ON ci.client_id = c.client_id;
SELECT
    ci.*,
    c.*,
    CASE
        WHEN c.client_id IS NULL THEN 'I'
        WHEN ci.client_id IS NOT NULL
            AND (ci.client_firstname != c.client_firstname
                OR ci.client_lastname != c.client_lastname
                OR ci.client_email != c.client_email
                OR ci.client_phone != c.client_phone
                OR ci.client_city != c.client_city
                OR ci.age != c.age) THEN 'U'
        ELSE 'None'
    END AS action
FROM
    clients_inc ci
LEFT JOIN
    clients c ON ci.client_id = c.client_id;

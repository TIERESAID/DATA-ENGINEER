-- добавьте код сюда
/*
There are two tables - clients and clients_inc. The clients_inc table already contains another increment, i.e. data that has not yet been loaded into the clients table.
Write a query that will compare all rows from clients_inc with rows from clients. Add an action field to the query that will take one of the values - U or I:
If the record exists in clients_inc but is not in clients, action takes the value I.
If the record exists in both tables, but the data in the fields are different, then action takes the value U.
This way you can evaluate which records are new and which have changed.
*/

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

-- добавьте код сюда
-- Then write a query that modifies the clients table so that it too has up-to-date information. The query should select all records by the condition action = 'I' and insert these records into the clients table.
-- добавьте код сюда
-- Then write a query that modifies the clients table so that it too has up-to-date information. The query should select all records by the condition action = 'I' and insert these records into the clients table.
WITH act AS (
    SELECT
        ci.*,
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
        clients c ON ci.client_id = c.client_id
)
INSERT INTO clients (client_id, client_firstname, client_lastname, client_email, client_phone, client_city, age)
SELECT
    act.client_id,
    act.client_firstname,
    act.client_lastname,
    act.client_email,
    act.client_phone,
    act.client_city,
    act.age
FROM act
WHERE act.action = 'I'

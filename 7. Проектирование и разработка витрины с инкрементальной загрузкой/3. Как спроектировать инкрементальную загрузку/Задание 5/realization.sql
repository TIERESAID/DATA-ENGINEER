-- добавьте код сюда
-- One last thing: write a query that will select all records under the condition action = 'U' and update those records in the clients table.
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
-- Select and update records in the clients table where action is 'U'
UPDATE clients AS c
SET
    client_id = a.client_id,
    client_firstname = a.client_firstname,
    client_lastname = a.client_lastname,
    client_email = a.client_email,
    client_phone = a.client_phone,
    client_city = a.client_city,
    age = a.age
FROM act AS a
WHERE c.client_id = a.client_id
    AND a.action = 'U';
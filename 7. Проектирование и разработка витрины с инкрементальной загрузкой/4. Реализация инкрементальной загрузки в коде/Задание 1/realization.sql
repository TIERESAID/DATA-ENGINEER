-- Create the 'client_cluster_metrics_m' table if it doesn't exist

CREATE TABLE client_cluster_metrics_m (
    "month" DATE,
    client_id INT,
    utm_campaign VARCHAR,
    reg_code VARCHAR,
    total_events INT,
    visit_events INT,
    registration_events INT,
    login_events INT,
    visit_to_login_events INT,
    total_pay_events INT,
    accepted_method_actions INT,
    avg_payment NUMERIC,
    made_payments INT,
    sum_payments NUMERIC,
    rejects_share NUMERIC
);
-- Ensure the 'client_cluster_metrics_m' table is empty by truncating it
-- очистка таблицы
truncate table clients_cluster_metrics_m;
-- загрузка данных в таблицу
-- Load new data into the 'client_cluster_metrics_m' table based on the specified logic
INSERT INTO clients_cluster_metrics_m (
    month,
    client_id,
    utm_campaign,
    reg_code,
    total_events,
    visit_events,
    registration_events,
    login_events,
    visit_to_login_events,
    total_pay_events,
    accepted_method_actions,
    avg_payment,
    made_payments,
    sum_payments,
    rejects_share
)
WITH activity_stats AS (
    -- Calculate activity statistics based on user activity logs
    SELECT
        date_trunc('month', hitdatetime)::date                                          AS "month",
        client_id                                                                       AS client_id,
        COUNT(1)                                                                        AS total_events,
        SUM(CASE WHEN "action" = 'visit' THEN 1 ELSE 0 END)                             AS visit_events,
        SUM(CASE WHEN "action" = 'registration' THEN 1 ELSE 0 END)                      AS registration_events,
        SUM(CASE WHEN "action" = 'login' THEN 1 ELSE 0 END)                             AS login_events,
        SUM(CASE WHEN "action" = 'login' AND prev_action = 'visit' THEN 1 ELSE 0 END)   AS visit_to_login_events
    FROM (
        SELECT 
            *,
            LAG("action") OVER (PARTITION BY client_id ORDER BY hitdatetime ASC) AS prev_action
        FROM user_activity_log
        WHERE 
            extract(year FROM hitdatetime) = 2021
            AND "action" != 'N/A'
        ) AS t
    GROUP BY 1,2
),
payment_stats AS (
    -- Calculate payment statistics based on user payment logs
    SELECT
        date_trunc('month',hitdatetime)::date AS "month",
        client_id AS client_id,
        count(1) AS total_pay_events,
        count(CASE WHEN "action" = 'accept-method' THEN 1 END) AS accepted_method_actions,
        count(CASE WHEN "action" = 'make-payment' THEN 1 END) AS made_payments,
        avg(CASE WHEN "action" = 'make-payment' THEN coalesce(payment_amount,0) ELSE 0 END) AS avg_payment,
        sum(CASE WHEN "action" = 'make-payment' THEN coalesce(payment_amount,0) ELSE 0 END) AS sum_payments,
        sum(CASE WHEN "action" = 'reject-payment' THEN coalesce(payment_amount, 0) ELSE 0 END)
            / nullif(sum(CASE WHEN "action" = 'make-payment' THEN coalesce(payment_amount,0) ELSE 0 END), 0)    AS rejects_share
    FROM user_payment_log
    WHERE extract(year FROM hitdatetime) = 2021
    GROUP BY 1,2
),
user_contacts_latest AS (
    -- Select the latest user contact information
    SELECT DISTINCT ON (client_id) 
        client_id,
	    SUBSTR(REGEXP_REPLACE(phone,'[^0123456789]','','g'),2,3) AS reg_code
    FROM user_contacts
    ORDER BY client_id ASC, created_at DESC 
)
SELECT
 -- Combine and select relevant columns from activity_stats, payment_stats, and user_attributes
    coalesce(a."month", p."month")          AS "month",
    ua.client_id                            AS client_id,
    ua.utm_campaign                         AS utm_campaign,
    contacts.reg_code                       AS reg_code,
    coalesce(a.total_events,0)              AS total_events,
    coalesce(a.visit_events,0)              AS visit_events,
    coalesce(a.registration_events, 0)      AS registration_events,
    coalesce(a.login_events, 0)             AS login_events,
    coalesce(a.visit_to_login_events, 0)    AS visit_to_login_events,
    coalesce(p.total_pay_events, 0)         AS total_pay_events,
    coalesce(p.accepted_method_actions, 0)  AS accepted_method_actions,
    coalesce(p.avg_payment, 0)              AS avg_payment,
    coalesce(p.made_payments, 0)            AS made_payments,
    coalesce(p.sum_payments, 0)             AS sum_payments,
    p.rejects_share                         AS rejects_share
FROM activity_stats AS a
    FULL JOIN payment_stats AS p 
        ON p."month" = a."month" AND p.client_id = a.client_id
    RIGHT JOIN user_attributes AS ua 
        ON ua.client_id = coalesce(a.client_id, p.client_id)
    LEFT JOIN user_contacts_latest AS contacts 
        ON contacts.client_id = ua.client_id
ORDER BY 1,2;

-- Incremental Loading for 2019 and 2020 Data into client_cluster_metrics_m

-- Create a temporary table to store the new metrics data
CREATE TEMP TABLE temp_metrics (
    "month" DATE,
    client_id INT,
    utm_campaign VARCHAR,
    reg_code VARCHAR,
    total_events INT,
    visit_events INT,
    registration_events INT,
    login_events INT,
    visit_to_login_events INT,
    total_pay_events INT,
    accepted_method_actions INT,
    avg_payment NUMERIC,
    made_payments INT,
    sum_payments NUMERIC,
    rejects_share NUMERIC
);

-- Load 2019 and 2020 data from user_payment_log_arch
INSERT INTO temp_metrics (
    "month",
    client_id,
    total_pay_events,
    accepted_method_actions,
    avg_payment,
    sum_payments,
    rejects_share
)
SELECT
    date_trunc('month', hitdatetime)::date AS "month",
    client_id AS client_id,
    COUNT(1) AS total_pay_events,
    COUNT(CASE WHEN "action" = 'accept-method' THEN 1 END) AS accepted_method_actions,
    AVG(CASE WHEN "action" = 'make-payment' THEN COALESCE(payment_amount, 0) ELSE 0 END) AS avg_payment,
    SUM(CASE WHEN "action" = 'make-payment' THEN COALESCE(payment_amount, 0) ELSE 0 END) AS sum_payments,
    SUM(CASE WHEN "action" = 'reject-payment' THEN COALESCE(payment_amount, 0) ELSE 0 END)
        / NULLIF(SUM(CASE WHEN "action" = 'make-payment' THEN COALESCE(payment_amount, 0) ELSE 0 END), 0) AS rejects_share
FROM user_payment_log_arch
WHERE EXTRACT(YEAR FROM hitdatetime) IN (2019, 2020)
GROUP BY 1, 2;

-- Load 2019 and 2020 data from user_activity_log_arch
INSERT INTO temp_metrics (
    "month",
    client_id,
    total_events,
    visit_events,
    registration_events,
    login_events,
    visit_to_login_events
)
SELECT
    date_trunc('month', hitdatetime)::date AS "month",
    client_id AS client_id,
    COUNT(1) AS total_events,
    SUM(CASE WHEN "action" = 'visit' THEN 1 ELSE 0 END) AS visit_events,
    SUM(CASE WHEN "action" = 'registration' THEN 1 ELSE 0 END) AS registration_events,
    SUM(CASE WHEN "action" = 'login' THEN 1 ELSE 0 END) AS login_events,
    SUM(CASE WHEN "action" = 'login' AND prev_action = 'visit' THEN 1 ELSE 0 END) AS visit_to_login_events
FROM (
    SELECT
        *,
        LAG("action") OVER (PARTITION BY client_id ORDER BY hitdatetime ASC) AS prev_action
    FROM user_activity_log_arch
    WHERE EXTRACT(YEAR FROM hitdatetime) IN (2019, 2020)
    AND "action" != 'N/A'
) AS t
GROUP BY 1, 2;

-- Update existing data in client_cluster_metrics_m with new data
UPDATE client_cluster_metrics_m c
SET
    total_events = COALESCE(total_events, 0) + COALESCE((SELECT total_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    visit_events = COALESCE(visit_events, 0) + COALESCE((SELECT visit_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    registration_events = COALESCE(registration_events, 0) + COALESCE((SELECT registration_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    login_events = COALESCE(login_events, 0) + COALESCE((SELECT login_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    visit_to_login_events = COALESCE(visit_to_login_events, 0) + COALESCE((SELECT visit_to_login_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    total_pay_events = COALESCE(total_pay_events, 0) + COALESCE((SELECT total_pay_events FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    accepted_method_actions = COALESCE(accepted_method_actions, 0) + COALESCE((SELECT accepted_method_actions FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    avg_payment = COALESCE(avg_payment, 0) + COALESCE((SELECT avg_payment FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    made_payments = COALESCE(made_payments, 0) + COALESCE((SELECT made_payments FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    sum_payments = COALESCE(sum_payments, 0) + COALESCE((SELECT sum_payments FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0),
    rejects_share = CASE
        WHEN COALESCE(rejects_share, 0) = 0 AND COALESCE((SELECT rejects_share FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0) <> 0 THEN COALESCE((SELECT rejects_share FROM temp_metrics t WHERE c.client_id = t.client_id AND c."month" = t."month"), 0)
        ELSE COALESCE(rejects_share, 0)
    END
WHERE (client_id, "month") IN (SELECT client_id, "month" FROM temp_metrics);

-- Insert new data into client_cluster_metrics_m
INSERT INTO client_cluster_metrics_m (
    "month",
    client_id,
    utm_campaign,
    reg_code,
    total_events,
    visit_events,
    registration_events,
    login_events,
    visit_to_login_events,
    total_pay_events,
    accepted_method_actions,
    avg_payment,
    made_payments,
    sum_payments,
    rejects_share
)
SELECT
    "month",
    client_id,
    utm_campaign,
    reg_code,
    total_events,
    visit_events,
    registration_events,
    login_events,
    visit_to_login_events,
    total_pay_events,
    accepted_method_actions,
    avg_payment,
    made_payments,
    sum_payments,
    rejects_share
FROM temp_metrics
WHERE (client_id, "month") NOT IN (SELECT client_id, "month" FROM client_cluster_metrics_m);

-- Clean up temporary table
DROP TABLE temp_metrics;

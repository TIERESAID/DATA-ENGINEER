-- добавьте код сюда
/*
Write a query with a CREATE TABLE statement and create a table named clients_cluster_metrics_m. Required data types:
date for the month field;
bigint for client_id and all integer metrics;
varchar(30) for utm_campaign;
varchar(3) for reg_code;
double precision for real metrics

*/

DROP TABLE IF EXISTS clients_cluster_metrics_m;
CREATE TABLE clients_cluster_metrics_m (
    month DATE,

    client_id BIGINT,
    total_events BIGINT,
    visit_events BIGINT,
    registration_events BIGINT,
    login_events BIGINT,
    visit_to_login_events BIGINT,
    total_pay_events BIGINT,
    accepted_method_actions BIGINT,
    made_payments BIGINT,

    utm_campaign VARCHAR(30),
    reg_code VARCHAR(3),

    sum_payments DOUBLE PRECISION,
    rejects_share DOUBLE PRECISION,
    avg_payment DOUBLE PRECISION
);

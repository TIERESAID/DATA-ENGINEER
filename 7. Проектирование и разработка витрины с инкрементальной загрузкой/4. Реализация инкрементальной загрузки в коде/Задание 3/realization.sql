-- добавьте код сюда
INSERT INTO load_dates (date)
SELECT MAX("month") FROM client_cluster_metrics_m;

-- добавьте код сюда
/* 
Create a constraint for the table clients_cluster_metrics_m: compound PRIMARY KEY named 
clients_cluster_metrics_m_month_client_id_pkey.
*/
ALTER TABLE clients_cluster_metrics_m
ADD CONSTRAINT clients_cluster_metrics_m_month_client_id_pkey
PRIMARY KEY (month, client_id);

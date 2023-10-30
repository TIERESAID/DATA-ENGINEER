-- добавьте код сюда
/*
You have created a primary key for the table, 
consisting of the client_id and month fields.
To make sure that the index is created in PostgreSQL automatically,
write a query to the pg_indexes metadata table in the pg_catalog schema,
 which will print the text of this index creation for the clients_cluster_metrics_m table.
*/
SELECT indexdef
FROM pg_indexes
WHERE tablename = 'clients_cluster_metrics_m' AND indexname = 'clients_cluster_metrics_m_month_client_id_pkey';

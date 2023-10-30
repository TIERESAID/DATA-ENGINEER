-- добавьте код сюда
/* 
Create a FOREIGN KEY constraint for the clients_cluster_metrics_m 
table named clients_cluster_metrics_m_client_id_fkey on the client_id field.
 The client identifiers in the client_id field can only be from the user_attributes table.
*/
ALTER TABLE clients_cluster_metrics_m
ADD CONSTRAINT clients_cluster_metrics_m_client_id_fkey
FOREIGN KEY (client_id)
REFERENCES user_attributes(client_id);

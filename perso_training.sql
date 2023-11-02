/*
To change the column name from client_id to user_id and make it NOT NULL, you can use an ALTER TABLE statement in PostgreSQL.
*/

-- First, drop the existing index on the client_id if it exists
DROP INDEX IF EXISTS idx__clients_cluster_metrics_m__client_id;

-- Rename the column from client_id to user_id
ALTER TABLE clients_cluster_metrics_m
RENAME COLUMN client_id TO user_id;

-- Change the user_id column to NOT NULL
ALTER TABLE clients_cluster_metrics_m
ALTER COLUMN user_id SET NOT NULL

-----------------------------------------------------------------------------------------------------------------------------------------
-- change data type 
ALTER TABLE user_contacts
ALTER COLUMN updated_at TYPE timestamp USING updated_at::timestamp;


ALTER TABLE user_contacts
ALTER COLUMN updated_at SET DATA TYPE timestamp;

-- he format "19:36:17 26/09/2021," and you want to convert them to the timestamp format "YYYY-MM-DD HH24:MI:SS.US
UPDATE user_contacts
SET updated_at = TO_TIMESTAMP(updated_at, 'HH24:MI:SS DD/MM/YYYY')::timestamp;

---------------------------------------------------------------------------------------------------------------------------
COPY user_activity_log (user_id, activity_type, activity_timestamp) FROM '/path/to/your/file.csv' CSV HEADER ;
----------------------------------------------------------------------------------------------------------------------------

pg_dump -h localhost --username jovyan --dbname de --table my_important_table --file pg_my_important_table_backup.sql

psql -h localhost --username jovyan --dbname de --table my_important_table

-- Rename the table
ALTER TABLE my_important_table RENAME TO my_important_table_old;

-- Rename the primary key constraint
ALTER TABLE my_important_table_old
RENAME CONSTRAINT my_important_table_pkey TO my_important_table_old_pkey;

psql -h localhost --username jovyan --dbname de --file pg_my_important_table_backup.sql

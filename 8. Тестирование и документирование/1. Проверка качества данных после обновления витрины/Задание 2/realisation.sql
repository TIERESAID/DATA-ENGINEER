-- Add the id column with a serial data type
ALTER TABLE lesson47.task4_user_events
ADD COLUMN id SERIAL;

-- Set the id column as the primary key
ALTER TABLE lesson47.task4_user_events
ADD CONSTRAINT pk_task4_user_events_id PRIMARY KEY (id);

-- To check the sum of all ids in the table
SELECT SUM(id) FROM lesson47.task4_user_events;

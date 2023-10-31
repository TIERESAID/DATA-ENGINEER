/*
You are given the table task4_user_events in the lesson47 schema. The table is a log of user actions. There are three fields in the table:
event_dttm - date and time of the event.
event_type - event type: visit, login, payment.
user_id - user ID.
There is no primary key in the table. You need to add the id column to the table and make it the primary key.
*/

-- Add the id column with a serial data type
ALTER TABLE lesson47.task4_user_events
ADD COLUMN id SERIAL;

-- Set the id column as the primary key
ALTER TABLE lesson47.task4_user_events
ADD CONSTRAINT pk_task4_user_events_id PRIMARY KEY (id);

-- To check the sum of all ids in the table
SELECT SUM(id) FROM lesson47.task4_user_events;

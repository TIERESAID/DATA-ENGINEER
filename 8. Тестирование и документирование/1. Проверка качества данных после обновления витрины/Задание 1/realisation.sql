/*
You are given the table task3_record_log in the lesson47 schema. The table is a log of records. There are two fields in the table - the identifier of the row in the log row_id and the date of record generation row_dttm.
It is inconvenient for analysts to use the table because the field with the date row_dttm contains a string data type.
The manager sets you the task to replace the row_dttm field type with timestamp indicating the Moscow time zone. You need to replace the data type while preserving the existing values.
To check the result, execute the SQL query below and copy the value in the row_dttm field after conversion and paste it into the form.
*/
-- Alter the data type of row_dttm to TIMESTAMP with time zone for Europe/Moscow time zone
ALTER TABLE lesson47.task3_record_log
ALTER COLUMN row_dttm TYPE TIMESTAMP WITH TIME ZONE;

-- Update the values in row_dttm column with the correct time zone and format
UPDATE lesson47.task3_record_log
SET row_dttm = TO_TIMESTAMP(row_dttm, 'YYYY-MM-DD HH24:MI:SS.US') AT TIME ZONE 'Europe/Moscow';

-- Verify the results
SELECT row_dttm FROM lesson47.task3_record_log;
-- Alter the data type of row_dttm to TIMESTAMP with time zone for Europe/Moscow time zone
ALTER TABLE lesson47.task3_record_log
ALTER COLUMN row_dttm TYPE TIMESTAMP WITH TIME ZONE;

-- Update the values in row_dttm column with the correct time zone and format
UPDATE lesson47.task3_record_log
SET row_dttm = TO_TIMESTAMP(row_dttm, 'YYYY-MM-DD HH24:MI:SS.US') AT TIME ZONE 'Europe/Moscow';

-- Verify the results
SELECT row_dttm FROM lesson47.task3_record_log;
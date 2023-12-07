/*
Implement a function called split_deduplication_str, which takes a string and a delimiter character.
The function must split the input string into several lines at the delimiter character and then remove duplicates in the resulting result.
Thus, a table of unique rows is obtained.
*/
-- Drop the existing function
DROP FUNCTION IF EXISTS split_deduplication_str(TEXT, CHAR);

CREATE OR REPLACE FUNCTION split_deduplication_str(input_str TEXT, delimiter CHAR)
RETURNS TABLE (result_table TEXT)
AS
$$
BEGIN
    RETURN QUERY
    SELECT DISTINCT val::TEXT
    FROM unnest(string_to_array(input_str, delimiter)) val;

    RETURN;
END;
$$
LANGUAGE plpgsql;

-- Example usage
SELECT split_deduplication_str('1:2:1:3:2:4:1', ':');

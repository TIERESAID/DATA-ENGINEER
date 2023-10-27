-- добавьте код сюда
-- Write a query that will output the client's region code in the reg_code field. Recall that this is the three-digit code of the phone number after the first digit 8.
/* The TRANSLATE function is used to remove parentheses, spaces, and hyphens from the phone column, leaving only digits.

TRANSLATE(phone, '() -', '') cleans the phone number by removing unwanted characters.

The POSITION('8' IN TRANSLATE(phone, '() -', '')) function finds the position of the first occurrence of the digit '8' in the cleaned phone number.

We add 1 to the position to start the SUBSTRING extraction after the first '8'. 
The 3 indicates that we want to extract three characters, which correspond to the region code
*/

SELECT
  SUBSTRING(
    TRANSLATE(phone, '() -', ''),
    POSITION('8' IN TRANSLATE(phone, '() -', '')) + 1,
    3
  ) AS reg_code
FROM user_contacts;


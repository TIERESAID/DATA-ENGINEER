-- добавьте код сюда
-- Add an FK constraint named user_contacts_client_client_id_fkey that restricts the client_id field in the user_contacts table to only client_id values from the user_attributes table. Write an ALTER TABLE expression
ALTER TABLE user_contacts
ADD CONSTRAINT user_contacts_client_client_id_fkey
FOREIGN KEY (client_id)
REFERENCES user_attributes(client_id);

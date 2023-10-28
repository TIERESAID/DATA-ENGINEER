-- добавьте код сюда
-- Adding an FK constraint on the client_id field in the user_contacts table does not guarantee that it cannot take the value NULL. Entries without a client_id in the client_contacts table make no sense at all.
Add a NOT NULL constraint on the client_id column in the user_contacts table. Write an ALTER TABLE expression.
ALTER TABLE user_contacts
ALTER COLUMN client_id SET NOT NULL;


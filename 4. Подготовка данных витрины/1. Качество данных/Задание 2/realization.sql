-- добавьте код сюда
-- Replace the omissions in the payment_amount field with 0 without changing the rest of the data.
SELECT COALESCE(payment_amount, 0) AS payment_amount
FROM user_payment_log;
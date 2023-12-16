-- Create shipping_transfer table
DROP TABLE IF EXISTS public.shipping_transfer CASCADE;
CREATE TABLE shipping_transfer
(
  transfer_id            SERIAL        PRIMARY KEY,
  transfer_type          TEXT          NOT NULL,
  transfer_model         TEXT          NOT NULL,
  shipping_transfer_rate NUMERIC(4,3)  NOT NULL
);
CREATE INDEX shipping_transfer_index ON public.shipping_transfer(transfer_id);

-- Insert data into shipping_transfer table
INSERT INTO public.shipping_transfer (transfer_type, transfer_model, shipping_transfer_rate)
SELECT 
    split_part(shipping_transfer_description, ':', 1) AS transfer_type, 
    split_part(shipping_transfer_description, ':', 2) AS transfer_model,
    CAST(shipping_transfer_rate AS NUMERIC(4,3)) AS shipping_transfer_rate
FROM shipping;

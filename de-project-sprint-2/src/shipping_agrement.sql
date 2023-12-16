DROP TABLE IF EXISTS public.shipping_agreement;
-- Create shipping_agreement table
CREATE TABLE shipping_agreement
(
  agreement_id          BIG INT        PRIMARY KEY,
  agreement_number      TEXT          NOT NULL,
  agreement_rate        NUMERIC(3,2)  NOT NULL,
  agreement_commission  NUMERIC(3,2)  NOT NULL
);
CREATE INDEX shipping_agreement_index ON public.shipping_agreement(agreement_id);

INSERT INTO  public.shipping_agreement (agreement_id, agreement_number, agreement_rate, agreement_commission)
SELECT DISTINCT
    CAST(split_part(vendor_agreement_description, ':', 1) AS BIGINT) AS agreement_id, 
    split_part(vendor_agreement_description, ':', 2) AS agreement_number, 
    CAST(split_part(vendor_agreement_description, ':', 3) AS NUMERIC(3,2)) AS agreement_rate, 
    CAST(split_part(vendor_agreement_description, ':', 4) AS NUMERIC(3,2)) AS agreement_commission
FROM shipping;


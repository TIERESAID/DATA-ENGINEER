drop table if EXISTS  public.shipping_info CASCADE;

-- Create shipping_info table
CREATE TABLE shipping_info
(
  shipping_id             BIGINT        PRIMARY KEY,
  agreement_id            BIGINT        NOT NULL,
  shipping_country_id     SERIAL        NOT NULL,
  transfer_id             BIGINT        NOT NULL,
  vendor_id               BIGINT        NOT NULL,
  shipping_plan_datetime  TIMESTAMP     NOT NULL,
  payment_amount          NUMERIC(14,3), -- Define the data type for payment_amount
  FOREIGN KEY (agreement_id) REFERENCES shipping_agreement(agreement_id) on update CASCADE,
  FOREIGN KEY (shipping_country_id) REFERENCES shipping_country_rates(shipping_country_id) on UPDATE CASCADE,
  FOREIGN KEY (transfer_id) REFERENCES shipping_transfer(transfer_id) on  UPDATE CASCADE
);
CREATE INDEX shipping_info_index ON public.shipping_info(shipping_id);

INSERT INTO public.shipping_info (
    shipping_id,
    vendor_id,
    shipping_plan_datetime,
    payment_amount,
    agreement_id,
    shipping_country_id,
    transfer_id
)
SELECT distinct  
    s.shippingid::BIGINT,
    s.vendorid::BIGINT,
    s.shipping_plan_datetime::TIMESTAMP,
    CAST(s.payment_amount AS NUMERIC(14,3)),
    CAST(split_part(vendor_agreement_description, ':', 1) AS BIGINT),
    scr.shipping_country_id,
    sa.transfer_id
FROM shipping s 
LEFT JOIN shipping_country_rates as scr ON s.shipping_country = scr.shipping_country
LEFT JOIN shipping_transfer  as sa ON sa.transfer_type = split_part(shipping_transfer_description, ':', 1);




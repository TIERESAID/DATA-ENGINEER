DROP TABLE IF EXISTS public.shipping_country_rates;
-- Create shipping_country_rates table
CREATE TABLE shipping_country_rates
(
  shipping_country_id       SERIAL        PRIMARY KEY,
  shipping_country           TEXT          NOT NULL,
  shipping_country_base_rate NUMERIC(4,3)
);
CREATE INDEX shipping_country_rates_index ON public.shipping_country_rates(shipping_country_id);


--migration
--shipping_country_rates
INSERT INTO public.shipping_country_rates 
    (shipping_country, shipping_country_base_rate)
SELECT DISTINCT 
    shipping_country, shipping_country_base_rate
FROM shipping; 
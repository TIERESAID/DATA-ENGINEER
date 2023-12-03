DROP TABLE IF EXISTS public.d_user_payment_log;
DROP TABLE IF EXISTS public.d_user_activity_log;
DROP TABLE IF EXISTS public.f_sales;
DROP TABLE IF EXISTS public.d_clients;
DROP TABLE IF EXISTS public.d_buckets;
DROP TABLE IF EXISTS public.d_orders;
-- drop d_products;
-- drop d_vendors;
-- drop d_categories;

--d_clients
CREATE TABLE public.d_clients(
   client_id    BIGINT ,
   first_name   text ,
   last_name    text ,
   utm_campaign VARCHAR(30),
   PRIMARY KEY  (client_id)
);
CREATE INDEX client_id_index ON public.d_clients(client_id);

--d_user_payment_log
CREATE TABLE public.d_user_payment_log(
   payment_log_id   BIGINT ,
   client_id      	BIGINT ,
   hit_date_time    TIMESTAMP ,
   action           VARCHAR(20),
   payment_amount   NUMERIC(14,2),
   PRIMARY KEY 		(payment_log_id),
   FOREIGN KEY 		(client_id) REFERENCES d_clients(client_id) ON UPDATE cascade
);
CREATE INDEX user_payment_log_id_index  ON public.d_user_payment_log (payment_log_id);

--d_user_activity_log
CREATE TABLE public.d_user_activity_log(
   activity_id    BIGINT ,
   client_id      BIGINT ,
   hit_date_time  TIMESTAMP ,
   action         VARCHAR(20),
   PRIMARY KEY  (activity_id),
   FOREIGN KEY  (client_id) REFERENCES d_clients(client_id) ON UPDATE cascade
);
CREATE INDEX user_activity_id_index ON public.d_user_activity_log (activity_id);

-- create d_vendors

-- create d_categories

-- create d_products

--d_orders
CREATE TABLE public.d_orders(
   order_id      BIGINT ,
   payment       NUMERIC(14,2),
   hit_date_time TIMESTAMP,
   PRIMARY KEY (order_id)
);
CREATE INDEX order_id_index ON public.d_orders (order_id);

--d_buckets
CREATE TABLE public.d_buckets(
   bucket_id    BIGINT ,
   order_id     BIGINT ,
   product_id   BIGINT ,
   num          NUMERIC(14,2),
   PRIMARY KEY (bucket_id),
   FOREIGN KEY (product_id) REFERENCES d_products(product_id) ON UPDATE CASCADE,
   FOREIGN KEY (order_id) REFERENCES d_orders(order_id) ON UPDATE CASCADE
);
CREATE INDEX bucket_id_index ON public.d_buckets (bucket_id);

--sales information
CREATE TABLE public.f_sales(
   sale_id        BIGINT ,
   order_id       BIGINT ,
   client_id      BIGINT ,
   promotion_id   BIGINT ,
   PRIMARY KEY (sale_id),
   FOREIGN KEY (order_id) REFERENCES d_orders(order_id) ON UPDATE cascade,
   FOREIGN KEY (client_id) REFERENCES d_clients(client_id) ON UPDATE cascade
);
CREATE INDEX sales_order_id_index ON public.f_sales (order_id);
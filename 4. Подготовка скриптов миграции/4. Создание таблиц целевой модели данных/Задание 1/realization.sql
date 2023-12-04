-- Drop table d_products and its dependent objects
DROP TABLE IF EXISTS public.d_products CASCADE;
DROP TABLE IF EXISTS public.d_categories CASCADE;
DROP TABLE IF EXISTS public.d_vendors CASCADE;
DROP TABLE IF EXISTS public.d_user_payment_log CASCADE;
DROP TABLE IF EXISTS public.d_user_activity_log CASCADE;
DROP TABLE IF EXISTS public.f_sales CASCADE;
DROP TABLE IF EXISTS public.d_clients CASCADE;
DROP TABLE IF EXISTS public.d_buckets CASCADE;
DROP TABLE IF EXISTS public.d_orders CASCADE;

--d_clients
CREATE TABLE public.d_clients(
   client_id    BIGINT ,
   first_name   text ,
   last_name    text ,
   utm_campaign VARCHAR(30),
   PRIMARY KEY  (client_id)
);

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

--d_user_activity_log
CREATE TABLE public.d_user_activity_log(
   activity_id    BIGINT ,
   client_id      BIGINT ,
   hit_date_time  TIMESTAMP ,
   action         VARCHAR(20),
   PRIMARY KEY  (activity_id),
   FOREIGN KEY  (client_id) REFERENCES d_clients(client_id) ON UPDATE cascade
);

-- Create table d_vendors
CREATE TABLE public.d_vendors (
    id  SERIAL,
    vendor_id  BIGINT PRIMARY KEY,
    name_vendor TEXT,
    description TEXT
);

-- create d_categories
CREATE TABLE public.d_categories (
    category_id BIGINT PRIMARY KEY,
    name_category TEXT,
    description TEXT
);

-- Create table d_products
CREATE TABLE public.d_products (
    product_id BIGINT PRIMARY KEY,
    category_id BIGINT REFERENCES public.d_categories(category_id) ON UPDATE CASCADE,
    vendor_id BIGINT REFERENCES public.d_vendors(vendor_id) ON UPDATE CASCADE,
    name_product TEXT,
    description TEXT,
    stock BOOLEAN
);

--d_orders
CREATE TABLE public.d_orders(
   order_id      BIGINT,
   payment       NUMERIC(14,2),
   hit_date_time TIMESTAMP,
   PRIMARY KEY (order_id)
);

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

-- Create indexes
CREATE INDEX order_id_index ON public.d_orders (order_id);
CREATE INDEX user_payment_log_id_index  ON public.d_user_payment_log (payment_log_id);
CREATE INDEX user_activity_id_index ON public.d_user_activity_log (activity_id);
CREATE INDEX bucket_id_index ON public.d_buckets (bucket_id);
CREATE INDEX client_id_index ON public.d_clients(client_id);
CREATE INDEX sales_order_id_index ON public.f_sales (order_id);
CREATE INDEX vendor_id_index ON public.d_vendors(vendor_id);
CREATE INDEX category_id_index ON public.d_categories(category_id);
CREATE INDEX product_id_index ON public.d_products(product_id);
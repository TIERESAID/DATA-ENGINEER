
INSERT INTO public.d_vendors
(vendor_id, name_vendor, description)
select distinct 
		vendorcode,
		name_vendor[2],
		description[2]
			from (select vendorcode,
						 (regexp_split_to_array(description , E'\\:+')) as name_vendor,
						 (regexp_split_to_array(category , E'\\:+')) as description
							from orders_attributes) as vendor_information;

-- проверяем, что таблица заполнилась
--select * from d_vendors limit 10;

-- insert into d_categories ...
-- Step 1: Create a new sequence for generating category_id
CREATE SEQUENCE d_categories_category_id_sequence START 1;

-- Step 2: Extract distinct category information from orders_attributes
CREATE TEMPORARY TABLE temp_categories AS
SELECT DISTINCT
    split_part(category, ':', 1) AS name_category,
    split_part(category, ':', 2) AS description
FROM orders_attributes;

-- Step 3: Remove duplicate category entries
CREATE TEMPORARY TABLE temp_categories_unique AS
SELECT DISTINCT name_category, description FROM temp_categories;

-- Step 4: Create a mapping between old and new category names
CREATE TEMPORARY TABLE temp_category_mapping AS
SELECT
    name_category,
    description,
    nextval('d_categories_category_id_sequence') AS category_id
FROM temp_categories_unique;

-- Step 5: Insert the cleaned and distinct category information into d_categories
INSERT INTO d_categories (category_id, name_category, description)
SELECT
    tm.category_id,
    tm.name_category,
    tm.description
FROM temp_categories tc
JOIN temp_category_mapping tm ON tc.name_category = tm.name_category AND tc.description = tm.description;

-- Step 6: Drop temporary tables and sequence
DROP TABLE IF EXISTS temp_categories, temp_categories_unique, temp_category_mapping;
DROP SEQUENCE IF EXISTS d_categories_category_id_sequence;


-- проверяем, что таблица заполнилась
-- select * from d_categories limit 10;


INSERT INTO public.d_products
(product_id, category_id, vendor_id, name_product, description, stock)
select distinct 
		ci.itemcode,
		dc.category_id                                  			as category_id,
        vendorcode                                                  as vendor_id,
        (regexp_split_to_array(ci.description, E'\\:+'))[1]         as name_product,
        concat(
        	(regexp_split_to_array(category, E'\\:+'))[1], ' ',
            (regexp_split_to_array(ci.description, E'\\:+'))[2], ' from ',
            (regexp_split_to_array(ci.description, E'\\:+'))[3]
        ) 															as description,
        ci.stock 													as stock
               from (select *, 
               				(regexp_split_to_array(category, E'\\:+'))[1] as name_category
                        		from orders_attributes oa
                    ) as ci
                        join d_categories dc on ci.name_category = dc.name_category;


-- проверяем, что таблица заполнилась
--select * from d_products limit 10;


INSERT INTO public.d_orders
(order_id, payment, hit_date_time)
select distinct 
	oa.order_id as order_id,
    oa.payment_amount,
    datetime::timestamp as hit_date_time
  		from orders_attributes oa
  			join d_products dp on dp.product_id = oa.itemcode;

-- проверяем, что таблица заполнилась
--select * from d_orders limit 10;



CREATE SEQUENCE bucket_id_sequence start 1;
INSERT INTO public.d_buckets
(bucket_id, order_id, product_id, num)
select   
	nextval('bucket_id_sequence') as bucket_id,
    order_id as order_id,
    itemcode as product_id,
    num
    from orders_attributes;

-- проверяем, что таблица заполнилась
select * from d_buckets limit 10;
DROP SEQUENCE bucket_id_sequence;



INSERT INTO public.d_clients
(client_id, first_name, last_name, utm_campaign)
select   
	client_id,
    first_name,
    last_name,
    utm_campaign
  from user_attributes ua;

-- проверяем, что таблица заполнилась
--select * from d_clients dc limit 10;



CREATE SEQUENCE activity_id_sequence start 1;
INSERT INTO public.d_user_activity_log
(activity_id, client_id, hit_date_time, "action")
select   
	nextval('activity_id_sequence') as activity_id,
    client_id,
    hitdatetime::timestamp,
    "action"
  from user_activity_log ual;
DROP SEQUENCE activity_id_sequence;

-- проверяем, что таблица заполнилась
--select * from d_user_activity_log limit 10;


CREATE SEQUENCE payment_log_id_sequence start 1;
INSERT INTO public.d_user_payment_log
(payment_log_id, client_id, hit_date_time, "action", payment_amount)
select   
	nextval('payment_log_id_sequence') as payment_log_id,
    client_id,
    hitdatetime::timestamp,
    "action",
    payment_amount
  from user_payment_log upl;
DROP SEQUENCE payment_log_id_sequence;

-- проверяем, что таблица заполнилась
--select * from d_user_payment_log limit 10;



CREATE SEQUENCE sale_id_sequence start 1;
INSERT INTO public.f_sales
(sale_id, order_id, client_id, promotion_id)
select 
	nextval('sale_id_sequence'), * from (select distinct
    										oa.order_id as order_id,
    										oa.client_id as client_id,
    										1 as promotion_id
    											from orders_attributes as oa) as ss;
DROP SEQUENCE sale_id_sequence;

-- проверяем, что таблица заполнилась
--select * from f_sales limit 10;


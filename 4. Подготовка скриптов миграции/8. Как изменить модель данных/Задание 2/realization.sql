-- Add a new column to store the dimension_id
-- ALTER TABLE public.d_products
-- ADD COLUMN dimension_id BIGINT;

-- Optionally, add a foreign key constraint
ALTER TABLE public.d_products
ADD CONSTRAINT fk_d_products_dimensions
FOREIGN KEY (dimension_id) REFERENCES public.d_product_dimensions(dimension_id);

-- Update d_products with corresponding dimension_ids
UPDATE public.d_products AS p
SET dimension_id = d.dimension_id
FROM public.d_product_dimensions AS d
WHERE d.product_id = p.product_id; 

-- Remove redundant columns from d_product_dimensions
ALTER TABLE public.d_product_dimensions
DROP COLUMN category_id,
DROP COLUMN vendor_id,
DROP COLUMN name_product,
DROP COLUMN vendor_description,
DROP COLUMN product_id;

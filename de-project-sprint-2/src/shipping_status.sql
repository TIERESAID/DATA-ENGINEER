DROP TABLE IF EXISTS public.shipping_status;

--shipping_status
CREATE TABLE public.shipping_status(
    shippingid BIGINT ,
    status text,
    state text,
    shipping_start_fact_datetime TIMESTAMP,
    shipping_end_fact_datetime TIMESTAMP,
    PRIMARY KEY (shippingid) )
;
CREATE INDEX shipping_status_shipping_id ON public.shipping_status(shippingid);

--shipping_status migration
with ship_max as (
    select shippingid,
            max(case when state = 'booked' then state_datetime else null end) as shipping_start_fact_datetime,
            max(case when state = 'recieved' then state_datetime else null end) as shipping_end_fact_datetime,
            max(state_datetime) as max_state_datetime
    from shipping
    group by shippingid
)
INSERT INTO public.shipping_status
(shippingid, status,state,shipping_start_fact_datetime,shipping_end_fact_datetime)
select sm.shippingid,
       s.status,
       s.state,
       sm.shipping_start_fact_datetime,
       sm.shipping_end_fact_datetime
from ship_max as sm
left join shipping as s on sm.shippingid = s.shippingid
and sm.max_state_datetime = s.state_datetime
order by shippingid;
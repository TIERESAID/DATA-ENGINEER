drop view if exists shipping_datamart;

create view shipping_datamart as
select ss.shippingid,
       si.vendorid,
       st.transfer_type,
       date_part('day',age(ss.shipping_end_fact_datetime, ss.shipping_start_fact_datetime)) as full_day_at_shipping,
       case when ss.shipping_end_fact_datetime > si.shipping_plan_datetime then 1 else 0 end as is_delay,
       case when ss.status = 'finished' then 1 else 0 end as is_shipping_finish,
       case when ss.shipping_end_fact_datetime > si.shipping_plan_datetime then date_part('day',age(ss.shipping_end_fact_datetime, si.shipping_plan_datetime))
       else 0 end as delay_day_at_shipping,
       si.payment_amount,
       si.payment_amount * (scr.shipping_country_base_rate + sa.agreement_rate + st.shipping_transfer_rate) as vat,
       si.payment_amount * sa.agreement_commission as profit
from м as ss
left join shipping_info si on ss.shippingid = si.shippingid
left join shipping_transfer st on si.shipping_transfer_id = st.id
left join shipping_country_rates scr on si.shipping_country_rate_id = scr.id
left join shipping_agremeent sa on si.shipping_agremeent_id = sa.agreementid;

select * from shipping_datamart;

-- (extract('day' from ship.shipping_end_fact_datetime-ship.shipping_plan_datetime))

-- select t1.shippingid as shippingid,
--        vendorid,
--        transfer_type,
--        full_day_at_shipping,
--        is_delay,
--        is_shipping_finish,
--        delay_day_at_shipping,
--        payment_amount,
--        vat,
--        profit
--  from table_1 t1
--  join table_2 t2 on t1.shippingid = t2.shippingid
--  join table_3 t3 on t1.shippingid = t3.shippingid
--  join table_4 t4 on t1.shippingid = t4.shippingid
--  join table_5 t5 on t1.shippingid = t5.shippingid
--  join table_6 t6 on t1.shippingid = t6.shippingid
--  join table_7 t7 on t1.shippingid = t7.shippingid
--  join table_8 t8 on t1.shippingid = t8.shippingid
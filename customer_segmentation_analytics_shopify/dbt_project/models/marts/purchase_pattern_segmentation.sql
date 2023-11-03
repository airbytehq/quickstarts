
with purchase_data as (
    select
        id,
        count(*) as total_purchases,
        sum(total_spent) as total_spent
    from transformed_data.stg_customers
    group by id
),
behavioral_segments as (
    select
        id,
        case
            when total_purchases >= 5 and total_spent >= 500 then 'High-Value Shoppers'
            when total_purchases < 5 and total_spent < 100 then 'Low-Value Shoppers'
            else 'Regular Shoppers'
        end as purchase_segment
    from purchase_data
)
select * from behavioral_segments

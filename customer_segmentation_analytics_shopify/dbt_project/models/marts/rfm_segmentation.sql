with rfm_data as (
    select
        user_id,
        max(created_at) as last_purchase_date,
        count(distinct order_id) as total_orders,
        sum(amount) as total_spent
    from transformed_data.stg_transactions
    group by user_id
),
rfm_segments as (
    select
        user_id,
        case
            when TIMESTAMP_DIFF(CAST(current_date AS TIMESTAMP), last_purchase_date, DAY) <= 30 then 'Active'
            when total_orders >= 5 then 'Loyal'
            when total_spent >= 500 then 'High-Spending'
            else 'Churned'
        end as rfm_segment
    from rfm_data
)
select * from rfm_segments

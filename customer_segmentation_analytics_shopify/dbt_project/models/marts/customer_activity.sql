
WITH customer_activity AS (
    SELECT
        id,
        orders_count,
        CASE
            WHEN orders_count >= 10 THEN 'Highly Active'
            WHEN orders_count >= 5 THEN 'Moderately Active'
            ELSE 'Low Activity'
        END AS activity_level
    FROM transformed_data.stg_customers
)
SELECT
    id,
    orders_count,
    activity_level
FROM customer_activity

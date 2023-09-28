SELECT 
  user_id,
  product_id,
  purchased_at,
  added_to_cart_at,
  TIMESTAMP_DIFF(purchased_at, added_to_cart_at, SECOND) AS time_to_purchase_seconds,
  returned_at
FROM {{ ref('stg_purchases') }}

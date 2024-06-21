/* As example csv data is typiclly flat,
  getting purchase patterns with a basic sql query and cleansing null */

WITH purchase_data AS (
  SELECT
    user_id,
    CASE WHEN category IS NULL THEN 'unknown' ELSE category END AS product_category,
    CASE WHEN brand IS NULL THEN 'unknown' ELSE brand END AS brand,
    purchased_at,
    added_to_cart_at,
    TIMESTAMP_DIFF(purchased_at, added_to_cart_at, SECOND) AS time_to_purchase_seconds,
    returned_at
  FROM {{ ref('stg_purchases') }}
)

SELECT
  user_id,
  product_category,
  brand,
  time_to_purchase_seconds,
  CASE WHEN description IS NULL THEN '' ELSE description END AS product_description
FROM purchase_data

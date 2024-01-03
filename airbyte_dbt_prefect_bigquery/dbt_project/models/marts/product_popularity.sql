WITH base AS (
  SELECT 
    product_id,
    COUNT(id) AS purchase_count
  FROM {{ ref('stg_purchases') }}
  GROUP BY 1
)

SELECT 
  p.id,
  p.make,
  p.model,
  b.purchase_count
FROM {{ ref('stg_products') }} p
LEFT JOIN base b ON p.id = b.product_id
ORDER BY b.purchase_count DESC

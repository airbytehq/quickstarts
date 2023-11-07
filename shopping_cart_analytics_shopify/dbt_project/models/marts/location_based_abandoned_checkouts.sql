WITH abandoned_checkouts AS (
  SELECT
    *,
    IF(billing_address IS NOT NULL, JSON_EXTRACT_SCALAR(billing_address, '$.country'), JSON_EXTRACT_SCALAR(shipping_address, '$.country')) AS checkout_country
  FROM
    transformed_data.stg_abandoned_checkouts
)
SELECT
  checkout_country,
  COUNTIF(completed_at IS NULL) AS abandoned_checkouts
FROM
  abandoned_checkouts
GROUP BY
  checkout_country
ORDER BY
  abandoned_checkouts DESC

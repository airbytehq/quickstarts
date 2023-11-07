SELECT
  COUNTIF(completed_at IS NULL) AS abandoned_checkouts,
  COUNT(*) AS total_checkouts,
  COUNTIF(completed_at IS NULL) / COUNT(*) AS abandonment_rate
FROM
  transformed_data.stg_abandoned_checkouts

SELECT
  EXTRACT(DAYOFWEEK FROM created_at) AS day_of_week,
  EXTRACT(HOUR FROM created_at) AS hour_of_day,
  COUNTIF(completed_at IS NULL) AS abandoned_checkouts
FROM
  transformed_data.stg_abandoned_checkouts
GROUP BY
  day_of_week,
  hour_of_day
ORDER BY
  day_of_week, hour_of_day

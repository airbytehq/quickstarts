SELECT
  TIMESTAMP_SECONDS(CAST(t / 1000 AS INT64)) AS date,
  (c - lag(c) OVER (ORDER BY t / 1000)) / lag(c) OVER (ORDER BY t / 1000) AS daily_return
FROM
  transformed_data.stg_stock_api

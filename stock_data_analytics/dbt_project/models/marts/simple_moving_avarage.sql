SELECT
  TIMESTAMP_SECONDS(CAST(t / 1000 AS INT64)) AS date,
  c AS close,
  AVG(c) OVER (ORDER BY t / 1000 ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS five_day_sma
FROM
  transformed_data.stg_stock_api
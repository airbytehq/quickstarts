SELECT
  date,
  predicted_label AS predicted_stock_price
FROM
  ML.PREDICT(MODEL transformed_data.predict_stock, (
    SELECT
      TIMESTAMP_SECONDS(CAST(t / 1000 AS INT64)) AS date,
      h AS high,
      l AS low,
      o AS open
    FROM
      transformed_data.stg_stock_api
  ))
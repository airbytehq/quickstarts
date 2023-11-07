SELECT
  JSON_EXTRACT_SCALAR(line_items, '$.title') AS product_title,
  COUNTIF(completed_at IS NULL) AS abandoned_checkouts
FROM
  transformed_data.stg_abandoned_checkouts
  CROSS JOIN UNNEST(JSON_EXTRACT_ARRAY(line_items)) AS items
GROUP BY
  product_title
ORDER BY
  abandoned_checkouts DESC

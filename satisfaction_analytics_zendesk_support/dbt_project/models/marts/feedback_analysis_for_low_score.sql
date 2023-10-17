SELECT
  reason,
  COUNT(*) AS count
FROM
  transformed_data.stg_satisfaction_ratings
WHERE
 CAST(score AS INT64) <= 2
  AND reason IS NOT NULL
GROUP BY
  reason
ORDER BY
  count DESC

SELECT
  DATE_TRUNC(created_at, DAY) AS date,
  AVG(CAST(score AS FLOAT64)) AS avg_satisfaction_score
FROM
  transformed_data.stg_satisfaction_ratings
WHERE
  score IS NOT NULL
GROUP BY
  date
ORDER BY
  date

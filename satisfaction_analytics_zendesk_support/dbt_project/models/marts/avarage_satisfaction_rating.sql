SELECT
  AVG(CAST(score AS FLOAT64)) AS avg_satisfaction_score
FROM
  transformed_data.stg_satisfaction_ratings
WHERE
  score IS NOT NULL


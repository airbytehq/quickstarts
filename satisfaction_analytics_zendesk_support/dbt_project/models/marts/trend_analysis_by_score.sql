SELECT
  score,
  COUNT(*) AS count
FROM
   transformed_data.stg_satisfaction_ratings
WHERE
  score IS NOT NULL
GROUP BY
  score
ORDER BY
  score

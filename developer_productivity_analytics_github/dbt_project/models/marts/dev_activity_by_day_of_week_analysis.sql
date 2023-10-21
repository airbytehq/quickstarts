SELECT
  EXTRACT(DAYOFWEEK FROM created_at) AS day_of_week,
  EXTRACT(HOUR FROM created_at) AS hour_of_day,
  JSON_EXTRACT_SCALAR(author, '$.login') AS developer_username,
  COUNT(*) AS num_commits
FROM
  transformed_data.stg_commits
GROUP BY
  day_of_week, hour_of_day, developer_username

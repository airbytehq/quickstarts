SELECT
  JSON_EXTRACT_SCALAR(author, '$.login') AS developer_username,
  COUNT(*) AS num_contributions
FROM
  transformed_data.stg_commits
GROUP BY
  developer_username

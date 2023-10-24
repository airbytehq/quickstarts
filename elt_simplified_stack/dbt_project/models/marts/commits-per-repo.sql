SELECT
  JSON_EXTRACT_SCALAR(author, '$.login') AS developer_username,
  repository,
  COUNT(*) AS num_commits
FROM
  transformed_data.stg_commits
GROUP BY
  developer_username, repository

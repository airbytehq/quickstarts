SELECT
  DATE(created_at) AS commit_date,
  JSON_EXTRACT_SCALAR(author, '$.login') AS developer_username,
  COUNT(*) AS num_commits
FROM
  transformed_data.stg_commits
WHERE
  JSON_EXTRACT_SCALAR(author, '$.login') = 'developer_username'
GROUP BY
  commit_date, developer_username
ORDER BY
  commit_date

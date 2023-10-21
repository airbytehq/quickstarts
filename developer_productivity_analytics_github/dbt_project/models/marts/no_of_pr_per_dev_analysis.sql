SELECT
  JSON_EXTRACT_SCALAR(user, '$.login') AS developer_username,
  COUNT(*) AS num_pull_requests_opened
FROM
  transformed_data.stg_pull_requests
GROUP BY
  developer_username
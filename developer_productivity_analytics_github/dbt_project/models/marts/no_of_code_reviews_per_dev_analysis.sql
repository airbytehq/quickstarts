SELECT
  JSON_EXTRACT_SCALAR(requested_reviewers, '$.users[0].login') AS developer_username,
  COUNT(*) AS num_reviews
FROM
  transformed_data.stg_pull_requests
WHERE
  JSON_EXTRACT_SCALAR(requested_reviewers, '$.users[0].login') IS NOT NULL
GROUP BY
  developer_username

SELECT
  JSON_EXTRACT_SCALAR(assignee, '$.login') AS developer_username,
  COUNT(*) AS num_issues_assigned
FROM
  transformed_data.stg_issues
GROUP BY
  developer_username

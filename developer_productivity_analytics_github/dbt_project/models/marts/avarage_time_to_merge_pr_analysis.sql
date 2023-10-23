SELECT
  AVG(TIMESTAMP_DIFF(merged_at, created_at, SECOND)) AS avg_merge_time_seconds
FROM
  transformed_data.stg_pull_requests
WHERE
  merged_at IS NOT NULL

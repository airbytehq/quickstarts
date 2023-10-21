WITH TopCollaborators AS (
  SELECT
    repository,
    JSON_EXTRACT_SCALAR(author, '$.login') AS developer_username,
    COUNT(*) AS num_commits
  FROM
    transformed_data.stg_commits
  GROUP BY
    repository, developer_username
)
SELECT
  repository,
  developer_username,
  num_commits
FROM (
  SELECT
    repository,
    developer_username,
    num_commits,
    ROW_NUMBER() OVER (PARTITION BY repository ORDER BY num_commits DESC) AS rn
  FROM
    TopCollaborators
)
WHERE
  rn <= 5  -- Adjust the number of top collaborators as needed

WITH Collaboration AS (
  SELECT
    JSON_EXTRACT_SCALAR(a.author, '$.login') AS developer1,
    JSON_EXTRACT_SCALAR(b.author, '$.login') AS developer2,
    COUNT(*) AS num_collaborations
  FROM
    transformed_data.stg_commits AS a
  JOIN
    transformed_data.stg_commits AS b
  ON
    a.repository = b.repository
    AND a.sha <> b.sha
  GROUP BY
    developer1, developer2
)
SELECT
  developer1,
  developer2,
  num_collaborations
FROM
  Collaboration
WHERE
  num_collaborations > 5  -- Adjust threshold as needed

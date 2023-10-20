SELECT
    JSON_EXTRACT_SCALAR(user, '$.login') AS username,
    SUM(CASE WHEN state = 'opened' THEN 1 ELSE 0 END) AS opened_prs,
    SUM(CASE WHEN state = 'closed' THEN 1 ELSE 0 END) AS closed_prs
FROM transformed_data.stg_pull_requests
GROUP BY username

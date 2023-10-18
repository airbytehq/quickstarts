SELECT
    DATE(log_timestamp) AS log_date,
    COUNT(log_id) AS total_errors
FROM {{ ref('stg_datadog_logs') }}
WHERE log_level_normalized = 'ERROR'
GROUP BY 1
ORDER BY 1 DESC

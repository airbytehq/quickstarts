SELECT
    TIMESTAMP_TRUNC(log_timestamp, HOUR) AS log_hour,
    source AS user_id,
    COUNT(log_id) AS activity_count
FROM {{ ref('stg_datadog_logs') }}
WHERE service = 'user_activity'
GROUP BY 1, 2
ORDER BY 1 DESC, 2

SELECT
    metric_id,
    TIMESTAMP(timestamp) AS metric_timestamp,
    metric_name,
    value
FROM {{ source('datadog', 'metrics') }}
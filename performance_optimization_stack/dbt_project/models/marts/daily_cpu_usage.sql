WITH daily_cpu AS (
    SELECT
        DATE(metric_timestamp) AS metric_date,
        AVG(value) AS avg_cpu_usage,
        MAX(value) AS max_cpu_usage,
        MIN(value) AS min_cpu_usage
    FROM {{ ref('stg_datadog_metrics') }}
    WHERE metric_name = 'cpu.usage'
    GROUP BY 1
)

SELECT
    metric_date,
    ROUND(avg_cpu_usage, 2) AS avg_cpu,
    ROUND(max_cpu_usage, 2) AS max_cpu,
    ROUND(min_cpu_usage, 2) AS min_cpu
FROM daily_cpu
ORDER BY metric_date
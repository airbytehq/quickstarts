WITH ticket_day_of_week_counts AS (
  SELECT
    EXTRACT(DAYOFWEEK FROM created_at) AS day_of_week,
    COUNT(*) AS ticket_count
  FROM {{ ref('stg_tickets') }}
  GROUP BY 1
)
SELECT * FROM ticket_day_of_week_counts
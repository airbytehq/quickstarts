{% set start_date = '2023-01-01' %}
{% set end_date = '2023-12-31' %}

SELECT
  JSON_EXTRACT_SCALAR(`current`, '$.location.name') AS location_name,
  JSON_EXTRACT_SCALAR(`current`, '$.current.temperature') AS temperature,
  DATE(JSON_EXTRACT_SCALAR(`current`, '$.current.observation_time')) AS date
FROM
  transformed_data.stg_current_weather
WHERE
    DATE(JSON_EXTRACT_SCALAR(`current`, '$.current.observation_time')) BETWEEN '{{ start_date }}' AND '{{ end_date }}'
ORDER BY
  date, location_name
select
  *
from {{ source('weatherstack', 'current_weather') }}
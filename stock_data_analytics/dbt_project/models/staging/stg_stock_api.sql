select
  *
from {{ source('polygon', 'stock_api') }}
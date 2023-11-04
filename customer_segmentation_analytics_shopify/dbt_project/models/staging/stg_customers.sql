select
  *
from {{ source('shopify', 'customers') }}

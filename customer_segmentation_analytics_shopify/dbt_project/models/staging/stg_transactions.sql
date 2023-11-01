select
  *
from {{ source('shopify', 'transactions') }}

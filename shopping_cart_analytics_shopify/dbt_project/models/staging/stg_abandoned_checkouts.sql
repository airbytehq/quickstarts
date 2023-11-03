select
  *
from {{ source('shopify', 'abandoned_checkouts') }}
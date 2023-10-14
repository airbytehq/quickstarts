select
   *
from {{ source('zendesk_support', 'brands') }}
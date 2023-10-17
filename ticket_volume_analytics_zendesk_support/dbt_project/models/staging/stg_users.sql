select
  *
from {{ source('zendesk_support', 'users') }}

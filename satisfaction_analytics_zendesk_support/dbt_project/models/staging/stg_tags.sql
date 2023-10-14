select
   *
from {{ source('zendesk_support', 'tags') }}
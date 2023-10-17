select
   *
from {{ source('zendesk_support', 'groups') }}
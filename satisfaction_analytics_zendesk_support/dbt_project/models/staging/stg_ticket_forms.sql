select
   *
from {{ source('zendesk_support', 'ticket_forms') }}
select
*
from {{ source('zendesk_support', 'tickets') }}

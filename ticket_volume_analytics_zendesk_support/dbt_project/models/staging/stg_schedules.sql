select
*
from {{ source('zendesk_support', 'schedules') }}
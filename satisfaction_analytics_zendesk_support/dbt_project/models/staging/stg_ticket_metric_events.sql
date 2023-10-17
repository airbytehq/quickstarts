select
   *
from {{ source('zendesk_support', 'ticket_metric_events') }}
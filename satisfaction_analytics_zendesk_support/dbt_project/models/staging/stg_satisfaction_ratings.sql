select
 *
from {{ source('zendesk_support', 'satisfaction_ratings') }}

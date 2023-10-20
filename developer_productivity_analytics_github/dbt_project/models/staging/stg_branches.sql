select
  *
from {{ source('github', 'branches') }}

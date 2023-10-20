select
  *
from {{ source('github', 'issues') }}
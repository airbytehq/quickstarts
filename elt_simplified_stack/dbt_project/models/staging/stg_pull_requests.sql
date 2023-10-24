select
  *
from {{ source('github', 'pull_requests') }}

select
  *
from {{ source('github', 'users') }}

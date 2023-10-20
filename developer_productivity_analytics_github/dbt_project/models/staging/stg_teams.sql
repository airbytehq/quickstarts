select
  *
from {{ source('github', 'teams') }}
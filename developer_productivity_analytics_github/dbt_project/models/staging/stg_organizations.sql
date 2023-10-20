select
  *
from {{ source('github', 'organizations') }}
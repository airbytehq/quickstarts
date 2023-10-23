select
  *
from {{ source('github', 'tags') }}
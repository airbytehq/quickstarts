select
  *
from {{ source('github', 'comments') }}
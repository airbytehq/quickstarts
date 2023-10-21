select
  *
from {{ source('github', 'repositories') }}
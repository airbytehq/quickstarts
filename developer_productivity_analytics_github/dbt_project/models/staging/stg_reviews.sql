select
  *
from {{ source('github', 'reviews') }}
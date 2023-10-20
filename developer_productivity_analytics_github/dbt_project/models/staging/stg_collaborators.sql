select
  *
from {{ source('github', 'collaborators') }}
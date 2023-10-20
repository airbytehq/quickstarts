select
  *
from {{ source('github', 'commits') }}
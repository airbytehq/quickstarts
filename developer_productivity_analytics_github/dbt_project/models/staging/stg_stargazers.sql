select
  *
from {{ source('github', 'stargazers') }}
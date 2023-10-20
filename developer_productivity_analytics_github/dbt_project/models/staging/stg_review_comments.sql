select
  *
from {{ source('github', 'review_comments') }}
select
   *
from {{ source('recreation', 'activities') }}
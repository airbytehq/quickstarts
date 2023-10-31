select
   *
from {{ source('recreation', 'campsites') }}
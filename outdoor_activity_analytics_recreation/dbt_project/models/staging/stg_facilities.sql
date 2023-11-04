select
   *
from {{ source('recreation', 'facilities') }}
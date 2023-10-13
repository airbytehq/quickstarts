select
    id,
    year,
    price,
    model,
    make,
    created_at,
    updated_at,
    _airbyte_extracted_at
from {{ source('faker', 'products') }}

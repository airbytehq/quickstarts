select
    id,
    year,
    price,
    model,
    make,
    created_at,
    updated_at,
    _airbyte_emitted_at,
    _airbyte_normalized_at
from {{ source('faker', 'products') }}

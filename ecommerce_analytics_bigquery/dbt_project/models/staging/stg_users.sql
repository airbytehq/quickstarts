select
    id,
    gender,
    academic_degree,
    title,
    nationality,
    age,
    name,
    email,
    created_at,
    updated_at,
    _airbyte_emitted_at,
    _airbyte_normalized_at
from {{ source('faker', 'users') }}
